package com.revenuecat.purchases_ui_flutter

import android.app.Activity
import android.content.Intent
import android.util.Log
import com.revenuecat.purchases.PurchasesErrorCode
import com.revenuecat.purchases.PresentedOfferingContext;
import com.revenuecat.purchases.hybridcommon.ui.PaywallResultListener
import com.revenuecat.purchases.hybridcommon.ui.PaywallSource
import com.revenuecat.purchases.hybridcommon.ui.PresentPaywallOptions
import com.revenuecat.purchases.hybridcommon.ui.presentPaywallFromFragment
import com.revenuecat.purchases.ui.revenuecatui.customercenter.ShowCustomerCenter
import com.revenuecat.purchases.hybridcommon.ui.CustomerCenterListenerWrapper
import com.revenuecat.purchases.Purchases
import com.revenuecat.purchases_ui_flutter.views.CustomerCenterViewFactory
import com.revenuecat.purchases_ui_flutter.views.PaywallFooterViewFactory
import com.revenuecat.purchases_ui_flutter.views.PaywallViewFactory
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry

class PurchasesUiFlutterPlugin: FlutterPlugin, MethodCallHandler, ActivityAware,
    PluginRegistry.ActivityResultListener {
    private val TAG = "PurchasesUIFlutter"

    private var activity: Activity? = null
    private var customerCenterListener: CustomerCenterListenerWrapper? = null

    private lateinit var channel : MethodChannel

    private var pendingResult: Result? = null

    companion object {
        private const val REQUEST_CODE_CUSTOMER_CENTER = 1001
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        flutterPluginBinding.platformViewRegistry.registerViewFactory(
            "com.revenuecat.purchasesui/PaywallView",
            PaywallViewFactory(flutterPluginBinding.binaryMessenger)
        )
        flutterPluginBinding.platformViewRegistry.registerViewFactory(
            "com.revenuecat.purchasesui/PaywallFooterView",
            PaywallFooterViewFactory(flutterPluginBinding.binaryMessenger)
        )
        flutterPluginBinding.platformViewRegistry.registerViewFactory(
            "com.revenuecat.purchasesui/CustomerCenterView",
            CustomerCenterViewFactory(flutterPluginBinding.binaryMessenger)
        )
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "purchases_ui_flutter")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "setCustomerCenterCallbacks" -> {
                ensureCustomerCenterListenerRegistered()
                result.success(null)
            }
            "clearCustomerCenterCallbacks" -> {
                clearCustomerCenterListener()
                result.success(null)
            }
            "presentPaywall" -> presentPaywall(
                result = result,
                requiredEntitlementIdentifier = null,
                offeringIdentifier = call.argument("offeringIdentifier"),
                presentedOfferingContext = call.argument("presentedOfferingContext"),
                displayCloseButton = call.argument("displayCloseButton"),
                customVariables = call.argument<Map<String, Any?>>("customVariables")?.mapNotNull { (k, v) -> v?.let { k to it.toString() } }?.toMap(),
            )
            "presentPaywallIfNeeded" -> {
                val requiredEntitlementIdentifier: String? = call.argument("requiredEntitlementIdentifier")
                val offeringIdentifier: String? = call.argument("offeringIdentifier")
                val presentedOfferingContext: Map<*, *>? = call.argument("presentedOfferingContext")
                val displayCloseButton: Boolean? = call.argument("displayCloseButton")
                val customVariables: Map<String, String>? = call.argument<Map<String, Any?>>("customVariables")?.mapNotNull { (k, v) -> v?.let { k to it.toString() } }?.toMap()
                presentPaywall(
                    result = result,
                    requiredEntitlementIdentifier = requiredEntitlementIdentifier,
                    presentedOfferingContext = presentedOfferingContext,
                    offeringIdentifier = offeringIdentifier,
                    displayCloseButton = displayCloseButton,
                    customVariables = customVariables,
                )
            }
            "presentCustomerCenter" -> presentCustomerCenter(
                result = result,
            )
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        clearCustomerCenterListener()
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivity() {
        activity = null
        clearCustomerCenterListener()
    }

    private fun presentPaywall(
        result: Result,
        requiredEntitlementIdentifier: String?,
        offeringIdentifier: String?,
        presentedOfferingContext: Map<*, *>?,
        displayCloseButton: Boolean?,
        customVariables: Map<String, String>?
    ) {
        val activity = getActivityFragment()
        if (activity != null) {

           presentPaywallFromFragment(
               activity,
               PresentPaywallOptions(
                   paywallSource = getPaywallSource(offeringIdentifier, presentedOfferingContext),
                   requiredEntitlementIdentifier = requiredEntitlementIdentifier,
                   shouldDisplayDismissButton = displayCloseButton,
                   customVariables = customVariables,
                   paywallResultListener = object : PaywallResultListener {
                       override fun onPaywallResult(paywallResult: String) {
                           result.success(paywallResult)
                       }
                   }
               )
           )
        } else {
            result.error(
                "PAYWALLS_MISSING_WRONG_ACTIVITY",
                "Make sure your MainActivity inherits from FlutterFragmentActivity",
                null
            )
        }
    }

    private fun presentCustomerCenter(
        result: Result,
    ) {
        activity?.let {
            pendingResult = result
            presentCustomerCenterFromActivity(it)
        } ?: run {
            result.error(
                "CUSTOMER_CENTER_MISSING_ACTIVITY",
                "Could not present Customer Center. There's no activity",
                null
            )
        }
    }

    private fun presentCustomerCenterFromActivity(activity: Activity) {
        // Set up customer center listener for callbacks before presenting
        ensureCustomerCenterListenerRegistered()

        val intent = ShowCustomerCenter()
            .createIntent(activity, Unit)
        activity.startActivityForResult(intent, REQUEST_CODE_CUSTOMER_CENTER)
    }

    private fun getActivityFragment(): FlutterFragmentActivity? {
        val activity: Activity? = this.activity
        return if (activity is FlutterFragmentActivity) {
            activity
        } else {
            Log.e(
                TAG,
                "Paywalls require your activity to subclass FlutterFragmentActivity"
            )
            null
        }
    }

    private fun getPaywallSource(
        offeringIdentifier: String?,
        presentedOfferingContextMap: Map<*, *>?
    ): PaywallSource {
        return offeringIdentifier?.let {
            val presentedOfferingContext = MapHelper.mapPresentedOfferingContext(
                presentedOfferingContextMap,
            ) ?: PresentedOfferingContext(offeringIdentifier)

            PaywallSource.OfferingIdentifierWithPresentedOfferingContext(
                it,
                presentedOfferingContext,
            )
        }
            ?: PaywallSource.DefaultOffering
    }

    private fun createCustomerCenterListener(): CustomerCenterListenerWrapper {
        return object : CustomerCenterListenerWrapper() {
            override fun onRestoreStartedWrapper() {
                channel.invokeMethod("onRestoreStarted", null)
            }

            override fun onRestoreCompletedWrapper(customerInfo: Map<String, Any?>) {
                channel.invokeMethod("onRestoreCompleted", customerInfo)
            }

            override fun onRestoreFailedWrapper(error: Map<String, Any?>) {
                channel.invokeMethod("onRestoreFailed", error)
            }

            override fun onShowingManageSubscriptionsWrapper() {
                channel.invokeMethod("onShowingManageSubscriptions", null)
            }

            override fun onFeedbackSurveyCompletedWrapper(feedbackSurveyOptionId: String) {
                channel.invokeMethod(
                    "onFeedbackSurveyCompleted",
                    mapOf(
                        "optionId" to feedbackSurveyOptionId
                    )
                )
            }

            override fun onManagementOptionSelectedWrapper(action: String, url: String?) {
                channel.invokeMethod(
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
                channel.invokeMethod(
                    "onCustomActionSelected",
                    mapOf(
                        "actionId" to actionId,
                        "purchaseIdentifier" to purchaseIdentifier
                    )
                )
            }
        }
    }

    private fun ensureCustomerCenterListenerRegistered() {
        val listener = customerCenterListener ?: createCustomerCenterListener().also {
            customerCenterListener = it
        }
        Purchases.sharedInstance.customerCenterListener = listener
    }

    private fun clearCustomerCenterListener() {
        customerCenterListener = null
        runCatching {
            Purchases.sharedInstance.customerCenterListener = null
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode == REQUEST_CODE_CUSTOMER_CENTER) {
            if (resultCode == Activity.RESULT_OK) {
                Log.d(TAG, "Customer Center closed successfully")
                // Send onDismiss callback
                channel.invokeMethod("onDismiss", null)
                pendingResult?.success("Customer Center closed successfully")
            } else {
                Log.d(TAG, "Customer Center closed with result code: $resultCode")
                pendingResult?.error(
                    "CUSTOMER_CENTER_ERROR",
                    "Customer Center closed with result code: $resultCode",
                    null
                )
            }
            pendingResult = null
            // Clean up the customer center listener after dismissal
            clearCustomerCenterListener()
            return true
        }
        return false
    }

}
