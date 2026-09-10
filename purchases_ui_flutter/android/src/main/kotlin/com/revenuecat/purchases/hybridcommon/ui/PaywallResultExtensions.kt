package com.revenuecat.purchases.hybridcommon.ui

import com.revenuecat.purchases.ui.revenuecatui.activity.PaywallResult

val PaywallResult.name: String
    get() = when (this) {
        PaywallResult.Cancelled -> "CANCELLED"
        is PaywallResult.Error -> "ERROR"
        is PaywallResult.Purchased -> "PURCHASED"
        is PaywallResult.Restored -> "RESTORED"
    }
