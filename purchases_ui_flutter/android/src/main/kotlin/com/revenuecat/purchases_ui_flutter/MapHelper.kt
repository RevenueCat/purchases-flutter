@file:JvmSynthetic

package com.revenuecat.purchases_ui_flutter

import com.revenuecat.purchases.PresentedOfferingContext
import com.revenuecat.purchases.hybridcommon.ui.PaywallSource

internal object MapHelper {

    @JvmSynthetic
    fun mapPresentedOfferingContext(
        presentedOfferingContextMap: Map<*, *>?
    ): PresentedOfferingContext? {
        val offeringId = presentedOfferingContextMap?.get("offeringIdentifier") as? String
        return offeringId?.let {
            val placementId = presentedOfferingContextMap.get("placementIdentifier") as? String
            val targetingContext = (presentedOfferingContextMap.get("targetingContext") as? Map<*, *>)?.let {
                val revision = it.get("revision") as? Int
                val ruleId = it.get("ruleId") as? String
                if (ruleId != null && revision != null) {
                    PresentedOfferingContext.TargetingContext(revision, ruleId)
                } else {
                    null
                }
            }

            PresentedOfferingContext(
                offeringIdentifier = offeringId,
                placementIdentifier = placementId,
                targetingContext = targetingContext,
            )
        }
    }
}
