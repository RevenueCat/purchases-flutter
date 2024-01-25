package com.revenuecat.purchases_ui_flutter

import android.app.Activity
import android.util.Log
import com.revenuecat.purchases.PurchasesErrorCode
import com.revenuecat.purchases.hybridcommon.ui.PaywallResultListener
import com.revenuecat.purchases.hybridcommon.ui.PaywallSource
import com.revenuecat.purchases.hybridcommon.ui.PresentPaywallOptions
import com.revenuecat.purchases.hybridcommon.ui.presentPaywallFromFragment
import com.revenuecat.purchases.ui.revenuecatui.activity.PaywallResult
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class PurchasesUiFlutterPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
    private val TAG = "PurchasesUIFlutter"

    private var activity: Activity? = null

    private lateinit var channel : MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "purchases_ui_flutter")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "presentPaywall" -> presentPaywall(
                result = result,
                requiredEntitlementIdentifier = null,
                offeringIdentifier = call.argument("offeringIdentifier")
            )
            "presentPaywallIfNeeded" -> {
                val requiredEntitlementIdentifier: String? = call.argument("requiredEntitlementIdentifier")
                val offeringIdentifier: String? = call.argument("offeringIdentifier")
                presentPaywall(
                    result = result,
                    requiredEntitlementIdentifier = requiredEntitlementIdentifier,
                    offeringIdentifier = offeringIdentifier
                )
            }
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

    private fun presentPaywall(result: Result, requiredEntitlementIdentifier: String?, offeringIdentifier: String?) {
        val activity = getActivityFragment()
        if (activity != null) {
           presentPaywallFromFragment(
               activity,
               PresentPaywallOptions(
                   paywallSource = offeringIdentifier?.let { PaywallSource.OfferingIdentifier(it) }
                       ?: PaywallSource.DefaultOffering,
                   requiredEntitlementIdentifier = requiredEntitlementIdentifier,
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
