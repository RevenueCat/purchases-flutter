package com.revenuecat.purchases_flutter_ui

import android.app.Activity
import android.util.Log
import com.revenuecat.purchases.PurchasesErrorCode
import com.revenuecat.purchases.hybridcommon.ui.PaywallResultListener
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

class PurchasesFlutterUiPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
    private val TAG = "PurchasesFlutterUI"

    private var activity: Activity? = null

    private lateinit var channel : MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "purchases_flutter_ui")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "presentPaywall" -> presentPaywall(result, null)
            "presentPaywallIfNeeded" -> {
                val requiredEntitlementIdentifier: String? = call.argument("requiredEntitlementIdentifier")
                presentPaywall(result, requiredEntitlementIdentifier)
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

    private fun presentPaywall(result: Result, requiredEntitlementIdentifier: String?) {
        val activity = getActivityFragment()
        if (activity != null) {
            presentPaywallFromFragment(
                activity,
                requiredEntitlementIdentifier,
            )
            result.success(null)
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
