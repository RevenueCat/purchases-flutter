package com.revenuecat.purchases_ui_flutter.views

import android.content.Context
import android.view.View
import com.revenuecat.purchases.hybridcommon.ui.PaywallListenerWrapper
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
) : PlatformView, MethodCallHandler {

    private val methodChannel: MethodChannel
    private val nativePaywallView: NativePaywallView

    override fun getView(): View {
        return nativePaywallView
    }

    override fun dispose() {}

    init {
        methodChannel = MethodChannel(messenger, "com.revenuecat.purchasesui/PaywallView/$id")
        methodChannel.setMethodCallHandler(this)
        val offeringIdentifier = creationParams["offeringIdentifier"] as String?
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
        nativePaywallView.setOfferingId(offeringIdentifier)
    }

    // We currently don't have any communication in this channel from dart to native, so this can be empty.
    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        when (methodCall.method) {
            else -> result.notImplemented()
        }
    }
}
