package com.revenuecat.purchases.hybridcommon.ui

import android.app.Activity
import android.content.Intent
import com.revenuecat.purchases.Purchases
import com.revenuecat.purchases.ui.revenuecatui.presentPaywall

fun presentPaywall(
    intent: Intent,
    activity: Activity,
): Boolean {
    return Purchases.sharedInstance.presentPaywall(
        intent = intent,
        activity = activity,
    )
}
