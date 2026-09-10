package com.revenuecat.purchases.hybridcommon.ui

import com.revenuecat.purchases.PresentedOfferingContext
import com.revenuecat.purchases.Offering as PurchasesOffering

sealed class PaywallSource {
    class Offering(val value: PurchasesOffering) : PaywallSource() {
        internal val presentedOfferingContext: PresentedOfferingContext?
            get() = value.availablePackages.firstOrNull()?.presentedOfferingContext
    }
    object DefaultOffering : PaywallSource()

    @Deprecated(
        "Use OfferingIdentifierWithPresentedOfferingContext instead",
        ReplaceWith("OfferingIdentifierWithPresentedOfferingContext(value, PresentedOfferingContext(value))"),
    )
    class OfferingIdentifier(val value: String) : PaywallSource()
    class OfferingIdentifierWithPresentedOfferingContext(
        val offeringIdentifier: String,
        val presentedOfferingContext: PresentedOfferingContext,
    ) : PaywallSource()
}
