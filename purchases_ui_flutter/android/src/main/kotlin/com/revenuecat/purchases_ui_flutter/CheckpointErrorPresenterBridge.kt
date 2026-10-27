package com.revenuecat.purchases_ui_flutter

import android.app.Activity
import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import android.view.View
import android.view.ViewGroup
import android.view.Window
import android.view.WindowManager
import androidx.activity.ComponentDialog
import androidx.activity.OnBackPressedCallback
import com.revenuecat.purchases.InternalRevenueCatAPI
import com.revenuecat.purchases.Purchases
import com.revenuecat.purchases.hybridcommon.mappers.map
import com.revenuecat.purchases.ui.revenuecatui.CustomVariableValue
import com.revenuecat.purchases.ui.revenuecatui.InviteOnlyCheckpointsAPI
import com.revenuecat.purchases.ui.revenuecatui.checkpoints.CheckpointFailureKind
import com.revenuecat.purchases.ui.revenuecatui.checkpoints.CheckpointParams
import com.revenuecat.purchases.ui.revenuecatui.checkpoints.ErrorPresenter
import com.revenuecat.purchases.ui.revenuecatui.checkpoints.FlowPresentationMode
import com.revenuecat.purchases.ui.revenuecatui.checkpoints.checkpoint
import io.flutter.embedding.android.FlutterTextureView
import io.flutter.embedding.android.FlutterView
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.renderer.FlutterUiDisplayListener
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.UUID

/** Per-call error channels. The SDK still owns presentation of the Android flow. */
@OptIn(InviteOnlyCheckpointsAPI::class, InternalRevenueCatAPI::class)
internal class CheckpointErrorPresenterBridge(
    private val messenger: BinaryMessenger,
    private val activity: () -> Activity?,
) {
    private val sessions = mutableMapOf<String, Session>()
    private var errorWindow: CheckpointErrorWindow? = null
    private var windowOwner: String? = null
    private var engine: FlutterEngine? = null

    private val engineListener = object : FlutterEngine.EngineLifecycleListener {
        override fun onPreEngineRestart() = cancelAll(notify = false)
        override fun onEngineWillDestroy() = cancelAll(notify = false)
    }

    fun start(call: MethodCall, result: MethodChannel.Result) {
        val callId = call.argument<String>("callId")
        val identifier = call.argument<String>("identifier")
        if (callId == null || identifier == null || sessions.containsKey(callId)) {
            result.error("BAD_ARGS", "Missing or duplicate checkpoint call id or identifier.", null)
            return
        }
        if (!Purchases.isConfigured) {
            result.error("NOT_CONFIGURED", "Configure Purchases before calling a checkpoint.", null)
            return
        }
        val currentActivity = activity()
        val flutterView = currentActivity?.window?.decorView?.let {
            findCheckpointFlutterView(it, messenger)
        }
        val currentEngine = flutterView?.attachedFlutterEngine
        if (currentActivity == null || currentEngine == null) {
            result.error("MISSING_ACTIVITY", "A Flutter activity is required for checkpoint error UI.", null)
            return
        }
        if (engine !== currentEngine) {
            engine?.removeEngineLifecycleListener(engineListener)
            engine = currentEngine
            currentEngine.addEngineLifecycleListener(engineListener)
        }
        val session = Session(callId)
        sessions[callId] = session
        session.channel.setMethodCallHandler { message, reply ->
            when (message.method) {
                "completeError" -> {
                    session.errors.remove(message.argument<String>("requestId"))?.complete()
                    reply.success(null)
                }
                "showErrorHost" -> {
                    try {
                        check(windowOwner == null || windowOwner == callId) {
                            "Another checkpoint owns error presentation."
                        }
                        if (errorWindow == null) {
                            val host = activity() ?: error("The Flutter activity was detached.")
                            val original = findCheckpointFlutterView(host.window.decorView, messenger)
                                ?: error("The Flutter view is unavailable.")
                            check(original.attachedFlutterEngine === currentEngine) {
                                "The checkpoint's Flutter engine is no longer attached."
                            }
                            errorWindow = CheckpointErrorWindow(host, original, currentEngine)
                            windowOwner = callId
                            errorWindow!!.show()
                        }
                        reply.success(null)
                    } catch (error: Exception) {
                        hideWindow(callId)
                        reply.error("ERROR_HOST_FAILED", error.message, null)
                    }
                }
                "hideErrorHost" -> {
                    hideWindow(callId)
                    reply.success(null)
                }
                "cancel" -> {
                    finish(session, notify = false)
                    reply.success(null)
                }
                else -> reply.notImplemented()
            }
        }
        val variables = call.argument<Map<String, Any?>>("customVariables").orEmpty()
            .mapNotNull { (key, value) ->
                val variable = when (value) {
                    is String -> CustomVariableValue.String(value)
                    is Boolean -> CustomVariableValue.Boolean(value)
                    is Number -> CustomVariableValue.Number(value.toDouble())
                    else -> null
                }
                variable?.let { key to it }
            }.toMap()
        val mode = when (call.argument<String>("presentationMode")) {
            "MODAL_FULL_SCREEN" -> FlowPresentationMode.MODAL_FULL_SCREEN
            "MODAL_SHEET" -> FlowPresentationMode.MODAL_SHEET
            else -> FlowPresentationMode.DEFAULT
        }
        val params = CheckpointParams.Builder()
            .setCustomVariables(variables)
            .setPresentationMode(mode)
            .setErrorPresenter(ErrorPresenter { error, completion ->
                if (sessions[callId] !== session) {
                    // Android has no public cancellation/end-of-flow handle. A
                    // detached caller must not leave a later native error blocked.
                    completion.complete()
                } else {
                    val requestId = UUID.randomUUID().toString()
                    session.errors[requestId] = completion
                    session.emit("error", mapOf(
                        "requestId" to requestId,
                        "kind" to when (error.kind) {
                            CheckpointFailureKind.FLOW_COULD_NOT_BE_SHOWN -> "flowCouldNotBeShown"
                            CheckpointFailureKind.FLOW_RESULT_SYNC_FAILED -> "flowResultSyncFailed"
                            else -> "flowActionFailed"
                        },
                        "error" to error.error.map().info,
                    ))
                }
            }).build()
        // Registration is complete before starting; native may call back immediately.
        result.success(null)
        Purchases.sharedInstance.checkpoint(identifier, params) { checkpointResult ->
            if (sessions[callId] !== session) return@checkpoint
            session.emit("passed", mapOf("result" to mapOf(
                "customer" to checkpointResult.customer.map(),
                "flow" to checkpointResult.flow?.let { flow -> mapOf(
                    "obtainedEntitlements" to flow.obtainedEntitlements
                        .sortedBy { it.entitlementInfo.identifier }
                        .map { mapOf("entitlementInfo" to it.entitlementInfo.map()) },
                    "obtainedProducts" to flow.obtainedProducts
                        .sortedBy { it.product.id }
                        .map { mapOf("product" to it.product.map()) },
                ) },
            )))
            finish(session, notify = false)
        }
    }

    fun cancelAll(notify: Boolean = true) {
        sessions.values.toList().forEach { finish(it, notify) }
        errorWindow?.close()
        errorWindow = null
        windowOwner = null
    }

    fun dispose() {
        cancelAll(notify = false)
        engine?.removeEngineLifecycleListener(engineListener)
        engine = null
    }

    private fun hideWindow(callId: String) {
        if (windowOwner != callId) return
        errorWindow?.close()
        errorWindow = null
        windowOwner = null
    }

    private fun finish(session: Session, notify: Boolean) {
        if (sessions.remove(session.id) !== session) return
        hideWindow(session.id)
        val pending = session.errors.values.toList()
        session.errors.clear()
        if (notify) session.emit("finished", emptyMap())
        session.channel.setMethodCallHandler(null)
        pending.forEach { it.complete() }
    }

    private inner class Session(val id: String) {
        val channel = MethodChannel(messenger, "com.revenuecat.purchasesui/Checkpoint/$id")
        val errors = mutableMapOf<String, ErrorPresenter.Completion>()

        fun emit(type: String, payload: Map<String, Any?>) {
            channel.invokeMethod(type, payload + mapOf("callId" to id, "type" to type),
                object : MethodChannel.Result {
                    override fun success(result: Any?) = Unit
                    override fun error(code: String, message: String?, details: Any?) =
                        finish(this@Session, notify = false)
                    override fun notImplemented() = finish(this@Session, notify = false)
                })
        }
    }
}

internal fun findCheckpointFlutterView(view: View, messenger: BinaryMessenger): FlutterView? {
    if (view is FlutterView) {
        val executor = view.attachedFlutterEngine?.dartExecutor
        // Plugin bindings expose DartExecutor itself on some Flutter versions,
        // and its delegate on others. Both belong to this exact engine.
        if (executor != null && (executor === messenger || executor.binaryMessenger === messenger)) {
            return view
        }
    }
    if (view is ViewGroup) {
        for (index in 0 until view.childCount) {
            findCheckpointFlutterView(view.getChildAt(index), messenger)?.let { return it }
        }
    }
    return null
}

/** Renders the same Dart isolate above the SDK's window, only while handling an error. */
private class CheckpointErrorWindow(
    activity: Activity,
    private val original: FlutterView,
    private val engine: FlutterEngine,
) {
    private val view = FlutterView(activity, FlutterTextureView(activity).apply { isOpaque = false })
    private val dialog = ComponentDialog(activity, android.R.style.Theme_Translucent_NoTitleBar)
    private var attached = false
    private val firstFrame = object : FlutterUiDisplayListener {
        override fun onFlutterUiDisplayed() { view.alpha = 1f }
        override fun onFlutterUiNoLongerDisplayed() = Unit
    }

    fun show() {
        dialog.requestWindowFeature(Window.FEATURE_NO_TITLE)
        dialog.setCancelable(false)
        dialog.window?.apply {
            setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT))
            clearFlags(WindowManager.LayoutParams.FLAG_DIM_BEHIND)
        }
        view.setBackgroundColor(Color.TRANSPARENT)
        view.alpha = 0f
        dialog.setContentView(view)
        dialog.onBackPressedDispatcher.addCallback(object : OnBackPressedCallback(true) {
            override fun handleOnBackPressed() {
                engine.navigationChannel.popRoute()
            }
        })
        original.detachFromFlutterEngine()
        attached = true
        view.addOnFirstFrameRenderedListener(firstFrame)
        view.attachToFlutterEngine(engine)
        dialog.show()
        dialog.window?.setLayout(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT)
    }

    fun close() {
        view.removeOnFirstFrameRenderedListener(firstFrame)
        if (attached) {
            attached = false
            view.detachFromFlutterEngine()
            original.attachToFlutterEngine(engine)
        }
        dialog.dismiss()
    }
}
