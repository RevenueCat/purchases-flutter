package com.revenuecat.purchases_ui_flutter.views

import android.content.Context
import android.view.View
import com.revenuecat.purchases.Purchases
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
    private val customerCenterListener: CustomerCenterListenerWrapper

    init {
        methodChannel = MethodChannel(messenger, "com.revenuecat.purchasesui/CustomerCenterView/$id")
        methodChannel.setMethodCallHandler(this)

        customerCenterListener = createCustomerCenterListener()
        registerCustomerCenterListener()

        nativeCustomerCenterView = NativeCustomerCenterView(context) {
            methodChannel.invokeMethod("onDismiss", null)
        }
        nativeCustomerCenterView.applyCreationParams(creationParams)
    }

    override fun getView(): View = nativeCustomerCenterView

    override fun dispose() {
        methodChannel.setMethodCallHandler(null)
        unregisterCustomerCenterListener()
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

            override fun onManagementOptionSelectedWrapper(option: String, url: String?) {
                methodChannel.invokeMethod(
                    "onManagementOptionSelected",
                    mapOf(
                        "optionId" to option,
                        "url" to url
                    )
                )
            }

            override fun onManagementOptionSelectedWrapper(
                option: String,
                actionIdentifier: String?,
                purchaseIdentifier: String?
            ) {
                methodChannel.invokeMethod(
                    "onManagementOptionSelected",
                    mapOf(
                        "optionId" to option,
                        "url" to null
                    )
                )
                if (actionIdentifier != null) {
                    methodChannel.invokeMethod(
                        "onCustomActionSelected",
                        mapOf(
                            "actionId" to actionIdentifier,
                            "purchaseIdentifier" to purchaseIdentifier
                        )
                    )
                }
            }
        }
    }

    private fun registerCustomerCenterListener() {
        Purchases.sharedInstance.customerCenterListener = customerCenterListener
    }

    private fun unregisterCustomerCenterListener() {
        val purchases = Purchases.sharedInstance
        if (purchases.customerCenterListener === customerCenterListener) {
            purchases.customerCenterListener = null
        }
    }
}

@Suppress("UNUSED_PARAMETER")
private fun NativeCustomerCenterView.applyCreationParams(creationParams: Map<String?, Any?>) {
    // Currently there are no Android specific configuration options.
    // This extension is reserved for future parameters to keep init tidy.
}
