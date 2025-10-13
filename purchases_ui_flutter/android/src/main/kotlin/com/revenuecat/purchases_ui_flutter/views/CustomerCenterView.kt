package com.revenuecat.purchases_ui_flutter.views

import android.content.Context
import android.view.View
import com.revenuecat.purchases.hybridcommon.ui.CustomerCenterListenerWrapper
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.platform.PlatformView
import com.revenuecat.purchases.ui.revenuecatui.views.CustomerCenterView as NativeCustomerCenterView

internal class CustomerCenterView(
    context: Context,
    id: Int,
    messenger: BinaryMessenger,
    creationParams: Map<String?, Any?>,
) : PlatformView, MethodCallHandler {

    private val methodChannel: MethodChannel
    private val nativeCustomerCenterView: NativeCustomerCenterView

    init {
        methodChannel = MethodChannel(messenger, "com.revenuecat.purchasesui/CustomerCenterView/$id")
        methodChannel.setMethodCallHandler(this)

        nativeCustomerCenterView = NativeCustomerCenterView(context) {
            methodChannel.invokeMethod("onDismiss", null)
        }
        // Note: shouldShowCloseButton parameter is not supported on Android - close button is always shown
        // The Android native CustomerCenterView doesn't provide an API to hide the close button
        nativeCustomerCenterView.setCustomerCenterListener(createCustomerCenterListener())
    }

    override fun getView(): View = nativeCustomerCenterView

    override fun dispose() {
        methodChannel.setMethodCallHandler(null)
    }

    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        result.notImplemented()
    }

    private fun createCustomerCenterListener(): CustomerCenterListenerWrapper {
        return object : CustomerCenterListenerWrapper() {
            override fun onRestoreStartedWrapper() {
                methodChannel.invokeMethod("onRestoreStarted", null)
            }

            override fun onRestoreCompletedWrapper(customerInfo: Map<String, Any?>) {
                methodChannel.invokeMethod("onRestoreCompleted", customerInfo)
            }

            override fun onRestoreFailedWrapper(error: Map<String, Any?>) {
                methodChannel.invokeMethod("onRestoreFailed", error)
            }

            override fun onShowingManageSubscriptionsWrapper() {
                methodChannel.invokeMethod("onShowingManageSubscriptions", null)
            }

            override fun onFeedbackSurveyCompletedWrapper(feedbackSurveyOptionId: String) {
                methodChannel.invokeMethod("onFeedbackSurveyCompleted", feedbackSurveyOptionId)
            }

            override fun onManagementOptionSelectedWrapper(action: String, url: String?) {
                methodChannel.invokeMethod(
                    "onManagementOptionSelected",
                    mapOf(
                        "optionId" to action,
                        "url" to url
                    )
                )
            }

            override fun onManagementOptionSelectedWrapper(
                action: String,
                customAction: String?,
                purchaseIdentifier: String?
            ) {
                // DEPRECATED: This method is deprecated and replaced by onCustomActionSelectedWrapper
                // No-op implementation to maintain compatibility
            }

            override fun onCustomActionSelectedWrapper(
                actionId: String,
                purchaseIdentifier: String?
            ) {
                methodChannel.invokeMethod(
                    "onCustomActionSelected",
                    mapOf(
                        "actionId" to actionId,
                        "purchaseIdentifier" to purchaseIdentifier
                    )
                )
            }
        }
    }

}
