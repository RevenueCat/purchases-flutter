package com.revenuecat.purchases.hybridcommon.ui

import com.revenuecat.purchases.ui.revenuecatui.activity.PaywallResult

interface PaywallResultListener {
    // Keeping for now to avoid a breaking change but will be unused.
    @Deprecated(
        "Use onPaywallResult(paywallResult: String) instead",
        ReplaceWith("onPaywallResult(paywallResult: String)"),
    )
    fun onPaywallResult(paywallResult: PaywallResult) {}

    // This is used by the hybrids with the result of presenting the paywall as a string. It's mapped to an enum
    // in the hybrids.
    fun onPaywallResult(paywallResult: String)
}
