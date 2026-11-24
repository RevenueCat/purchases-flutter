package com.revenuecat.purchases_ui_flutter

import com.revenuecat.purchases.hybridcommon.ui.CheckpointListener
import com.revenuecat.purchases.hybridcommon.ui.completePaywallPresentation
import com.revenuecat.purchases.hybridcommon.ui.detachCheckpoint
import com.revenuecat.purchases.hybridcommon.ui.presentCheckpoint
import com.revenuecat.purchases.hybridcommon.ui.resolveErrorDialog
import com.revenuecat.purchases.ui.revenuecatui.InviteOnlyCheckpointsAPI
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/** Owns checkpoint bridge callbacks independently of customer center callbacks. All calls run on the main thread. */
@OptIn(InviteOnlyCheckpointsAPI::class)
internal class CheckpointHandler(messenger: BinaryMessenger) : MethodChannel.MethodCallHandler {
    private val channel = MethodChannel(messenger, "com.revenuecat.purchasesui/Checkpoints")
    private var disposed = false
    private var generation = 0

    private val activeCalls = mutableSetOf<String>()
    private val paywallCallsByRequest = mutableMapOf<String, String>()

    init {
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "initialize" -> {
                generation++
                detachOwnedCalls()
            }
            "completePaywallPresentation" -> {
                val requestId = call.argument<String>("requestId")
                val outcome = call.argument<String>("result")
                if (requestId == null || outcome == null) {
                    result.error("BAD_ARGS", "Missing checkpoint presentation result", null)
                    return
                }
                completePaywall(requestId, outcome)
            }
            "resolveErrorDialog" -> {
                val requestId = call.argument<String>("requestId")
                if (requestId == null) {
                    result.error("BAD_ARGS", "Missing checkpoint error requestId", null)
                    return
                }
                resolveErrorDialog(requestId, call.argument<Map<String, Any?>>("outcome"))
            }
            "detachCheckpoint" -> {
                val callId = call.argument<String>("callId")
                if (callId == null) {
                    result.error("BAD_ARGS", "Missing checkpoint callId", null)
                    return
                }
                if (activeCalls.remove(callId)) {
                    val activeRequest = call.argument<String>("activePaywallRequestId")
                    paywallCallsByRequest.entries.removeAll { it.value == callId && it.key != activeRequest }
                    detachCheckpoint(callId, activeRequest)
                }
            }
            else -> {
                result.notImplemented()
                return
            }
        }
        result.success(null)
    }

    fun present(call: MethodCall, result: MethodChannel.Result) {
        val identifier = call.argument<String>("identifier")
        val callId = call.argument<String>("callId")
        if (identifier == null || callId == null) {
            result.error("BAD_ARGS", "Missing identifier or callId in checkpoint", null)
            return
        }
        val currentGeneration = generation
        activeCalls.add(callId)
        presentCheckpoint(
            identifier = identifier,
            callId = callId,
            customVariables = call.argument<Map<String, Any?>>("customVariables"),
            presentationMode = call.argument<String>("presentationMode"),
            useCustomPaywallPresenter = call.argument<Boolean>("useCustomPaywallPresenter") == true,
            hasErrorDialogFactory = call.argument<Boolean>("hasErrorDialogFactory") == true,
            listener = object : CheckpointListener {
                override fun onCheckpointPassed(value: Map<String, Any?>) {
                    activeCalls.remove(callId)
                    if (!disposed && generation == currentGeneration) result.success(value)
                }

                override fun onCheckpointError(code: String, message: String) {
                    activeCalls.remove(callId)
                    if (!disposed && generation == currentGeneration) result.error(code, message, null)
                }

                override fun onPaywallPresentationRequested(requestId: String, params: Map<String, Any?>) {
                    paywallCallsByRequest[requestId] = callId
                    send(
                        method = "onPaywallPresentation",
                        arguments = mapOf(
                            "callId" to callId,
                            "requestId" to requestId,
                            "params" to params,
                        ),
                        callGeneration = currentGeneration,
                        fallback = {
                            completePaywall(requestId, "NAVIGATED_BACK")
                        },
                    )
                }

                override fun onErrorDialogRequested(requestId: String, error: Map<String, Any?>) {
                    send(
                        method = "onErrorDialogRequested",
                        arguments = mapOf(
                            "callId" to callId,
                            "requestId" to requestId,
                            "error" to error,
                        ),
                        callGeneration = currentGeneration,
                        fallback = {
                            resolveErrorDialog(requestId = requestId, outcome = mapOf("type" to "useDefault"))
                        },
                    )
                }
            },
        )
    }

    private fun send(
        method: String,
        arguments: Map<String, Any?>,
        callGeneration: Int,
        fallback: () -> Unit,
    ) {
        if (disposed || generation != callGeneration) {
            fallback()
            return
        }
        channel.invokeMethod(method, arguments, object : MethodChannel.Result {
            override fun success(result: Any?) { /* Dart accepted the request; its completion is separate. */ }
            override fun error(code: String, message: String?, details: Any?) { fallback() }
            override fun notImplemented() { fallback() }
        })
    }

    private fun completePaywall(requestId: String, outcome: String) {
        val callId = paywallCallsByRequest.remove(requestId) ?: return
        if (outcome != "CLOSED" && outcome != "CONTINUED") activeCalls.remove(callId)
        completePaywallPresentation(requestId, outcome)
    }

    private fun detachOwnedCalls() {
        // A detached screen can still own a presented paywall until Dart completes it.
        val callIds = activeCalls + paywallCallsByRequest.values
        activeCalls.clear()
        paywallCallsByRequest.clear()
        callIds.forEach { detachCheckpoint(it, null) }
    }

    fun dispose() {
        disposed = true
        detachOwnedCalls()
        channel.setMethodCallHandler(null)
    }
}
