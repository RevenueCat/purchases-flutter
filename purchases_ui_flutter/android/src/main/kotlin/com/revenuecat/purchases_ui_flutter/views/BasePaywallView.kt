package com.revenuecat.purchases_ui_flutter.views

import android.app.Activity
import android.content.Context
import android.content.ContextWrapper
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.plugin.platform.PlatformView

internal abstract class BasePaywallView(
    context: Context
) : PlatformView {
    
    init {
        checkActivityType(context)
    }
    
    private fun checkActivityType(context: Context) {
        val activity = context.activity()
        if (activity == null) {
            return
        }
        
        // Check if the MainActivity is a subclass of FlutterFragmentActivity, and if not throw an error.
        val isFlutterFragmentActivity = FlutterFragmentActivity::class.java.isAssignableFrom(activity.javaClass)
        if (!isFlutterFragmentActivity) {
            val errorMessage = "Implementation Error: PaywallView requires the MainActivity to extend FlutterFragmentActivity in order for the paywall to be displayed correctly.\n" +
                    "Please change your MainActivity to extend FlutterFragmentActivity instead. See https://rev.cat/flutter-paywall-installation for more information."
            throw RuntimeException(errorMessage)
        }
    }

    private tailrec fun Context.activity(): Activity? = when (this) {
        is Activity -> this
        is ContextWrapper -> baseContext.activity()
        else -> null
    }
}

