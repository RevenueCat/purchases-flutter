package com.revenuecat.purchases_ui_flutter.views

import android.content.Context
import android.view.View
import com.revenuecat.purchases.hybridcommon.ui.HybridPurchaseLogicBridge
import com.revenuecat.purchases.hybridcommon.ui.PaywallListenerWrapper
import com.revenuecat.purchases.ui.revenuecatui.CustomVariableValue
import com.revenuecat.purchases_ui_flutter.MapHelper
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.platform.PlatformView
import com.revenuecat.purchases.ui.revenuecatui.views.PaywallView as NativePaywallView

internal class PaywallView(
    context: Context,
    id: Int,
    messenger: BinaryMessenger,
    creationParams: Map<String?, Any?>
) : BasePaywallView(context), MethodCallHandler {

    private val methodChannel: MethodChannel
    private val nativePaywallView: NativePaywallView
    private var purchaseLogicBridge: HybridPurchaseLogicBridge? = null

    override fun getView(): View {
        return nativePaywallView
    }

    override fun dispose() {
        purchaseLogicBridge?.cancelPending()
    }

    init {
        methodChannel = MethodChannel(messenger, "com.revenuecat.purchasesui/PaywallView/$id")
        methodChannel.setMethodCallHandler(this)
        val offeringIdentifier = creationParams["offeringIdentifier"] as String?
        val presentedOfferingContext = (creationParams["presentedOfferingContext"] as? Map<*, *>)?.let {
            MapHelper.mapPresentedOfferingContext(it)
        }
        val displayCloseButton = creationParams["displayCloseButton"] as Boolean?
        nativePaywallView = NativePaywallView(
            context = context,
            shouldDisplayDismissButton = displayCloseButton,
            dismissHandler = { methodChannel.invokeMethod("onDismiss", null) }
        )
        nativePaywallView.setPaywallListener(object : PaywallListenerWrapper() {
            override fun onPurchaseStarted(rcPackage: Map<String, Any?>) {
                methodChannel.invokeMethod("onPurchaseStarted", rcPackage)
            }

            override fun onPurchaseCompleted(customerInfo: Map<String, Any?>, storeTransaction: Map<String, Any?>) {
                methodChannel.invokeMethod(
                    "onPurchaseCompleted",
                    mapOf("customerInfo" to customerInfo, "storeTransaction" to storeTransaction)
                )
            }

            override fun onPurchaseCancelled() {
                methodChannel.invokeMethod("onPurchaseCancelled", null)
            }

            override fun onPurchaseError(error: Map<String, Any?>) {
                methodChannel.invokeMethod("onPurchaseError", error)
            }

            override fun onRestoreCompleted(customerInfo: Map<String, Any?>) {
                methodChannel.invokeMethod("onRestoreCompleted", customerInfo)
            }

            override fun onRestoreError(error: Map<String, Any?>) {
                methodChannel.invokeMethod("onRestoreError", error)
            }
        })
        // Custom variables must be set before setting the offering to ensure they're applied
        val customVariables = creationParams["customVariables"] as? Map<String, Any?>
        if (customVariables != null) {
            val convertedVariables = customVariables.mapNotNull { (key, value) ->
                value?.let { key to CustomVariableValue.String(it.toString()) }
            }.toMap()
            nativePaywallView.setCustomVariables(convertedVariables)
        }
        nativePaywallView.setOfferingId(offeringIdentifier, presentedOfferingContext)

        val hasPurchaseLogic = creationParams["hasPurchaseLogic"] as? Boolean ?: false
        if (hasPurchaseLogic) {
            val bridge = HybridPurchaseLogicBridge(
                onPerformPurchase = { eventData ->
                    methodChannel.invokeMethod("onPerformPurchase", eventData)
                },
                onPerformRestore = { eventData ->
                    methodChannel.invokeMethod("onPerformRestore", eventData)
                }
            )
            purchaseLogicBridge = bridge
            nativePaywallView.setPurchaseLogic(bridge)
        }
    }

    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        when (methodCall.method) {
            "resolvePurchaseLogicResult" -> {
                val args = methodCall.arguments as? Map<*, *>
                val requestId = args?.get("requestId") as? String
                val resultString = args?.get("result") as? String
                val errorMessage = args?.get("errorMessage") as? String
                if (requestId != null && resultString != null) {
                    HybridPurchaseLogicBridge.resolveResult(requestId, resultString, errorMessage)
                }
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }
}
