package com.revenuecat.purchases_ui_flutter

import android.app.Activity
import android.util.Log
import com.revenuecat.purchases.PurchasesErrorCode
import com.revenuecat.purchases.hybridcommon.ui.PaywallResultListener
import com.revenuecat.purchases.hybridcommon.ui.PaywallSource
import com.revenuecat.purchases.hybridcommon.ui.PresentPaywallOptions
import com.revenuecat.purchases.hybridcommon.ui.presentPaywallFromFragment
import com.revenuecat.purchases.ui.revenuecatui.ExperimentalPreviewRevenueCatUIPurchasesAPI
import com.revenuecat.purchases.ui.revenuecatui.customercenter.ShowCustomerCenter
import com.revenuecat.purchases_ui_flutter.views.CustomerCenterViewFactory
import com.revenuecat.purchases_ui_flutter.views.PaywallFooterViewFactory
import com.revenuecat.purchases_ui_flutter.views.PaywallViewFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

@OptIn(ExperimentalPreviewRevenueCatUIPurchasesAPI::class)
class PurchasesUiFlutterPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
    private val TAG = "PurchasesUIFlutter"

    private var activity: Activity? = null

    private lateinit var channel : MethodChannel

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
            "presentPaywall" -> presentPaywall(
                result = result,
                requiredEntitlementIdentifier = null,
                offeringIdentifier = call.argument("offeringIdentifier"),
                displayCloseButton = call.argument("displayCloseButton"),
            )
            "presentPaywallIfNeeded" -> {
                val requiredEntitlementIdentifier: String? = call.argument("requiredEntitlementIdentifier")
                val offeringIdentifier: String? = call.argument("offeringIdentifier")
                val displayCloseButton: Boolean? = call.argument("displayCloseButton")
                presentPaywall(
                    result = result,
                    requiredEntitlementIdentifier = requiredEntitlementIdentifier,
                    offeringIdentifier = offeringIdentifier,
                    displayCloseButton = displayCloseButton,
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
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    private fun presentPaywall(
        result: Result,
        requiredEntitlementIdentifier: String?,
        offeringIdentifier: String?,
        displayCloseButton: Boolean?
    ) {
        val activity = getActivityFragment()
        if (activity != null) {
           presentPaywallFromFragment(
               activity,
               PresentPaywallOptions(
                   paywallSource = offeringIdentifier?.let { PaywallSource.OfferingIdentifier(it) }
                       ?: PaywallSource.DefaultOffering,
                   requiredEntitlementIdentifier = requiredEntitlementIdentifier,
                   shouldDisplayDismissButton = displayCloseButton,
                   paywallResultListener = object : PaywallResultListener {
                       override fun onPaywallResult(paywallResult: String) {
                           result.success(paywallResult)
                       }
                   }
               )
           )
        } else {
            result.error(PurchasesErrorCode.UnknownError.code.toString(),
                "Make sure your MainActivity inherits from FlutterFragmentActivity",
                null
            )
        }
    }

    private fun presentCustomerCenter(
        result: Result,
    ) {
        activity?.let {
            presentCustomerCenterFromActivity(it)
            result.success(null)
        } ?: run {
            result.error(PurchasesErrorCode.UnknownError.code.toString(),
                "Could not present Customer Center. There's no activity",
                null
            )
        }
    }

    private fun presentCustomerCenterFromActivity(activity: Activity) {
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

}
