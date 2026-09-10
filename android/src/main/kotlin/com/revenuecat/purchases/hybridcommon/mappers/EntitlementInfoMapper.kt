package com.revenuecat.purchases.hybridcommon.mappers

import com.revenuecat.purchases.EntitlementInfo

fun EntitlementInfo.map(): Map<String, Any?> =
    mapOf(
        "identifier" to this.identifier,
        "isActive" to this.isActive,
        "willRenew" to this.willRenew,
        "periodType" to this.periodType.name,
        "latestPurchaseDateMillis" to this.latestPurchaseDate.toMillis(),
        "latestPurchaseDate" to this.latestPurchaseDate.toIso8601(),
        "originalPurchaseDateMillis" to this.originalPurchaseDate.toMillis(),
        "originalPurchaseDate" to this.originalPurchaseDate.toIso8601(),
        "expirationDateMillis" to this.expirationDate?.toMillis(),
        "expirationDate" to this.expirationDate?.toIso8601(),
        "store" to this.store.name,
        "productIdentifier" to this.productIdentifier,
        "productPlanIdentifier" to this.productPlanIdentifier,
        "isSandbox" to this.isSandbox,
        "unsubscribeDetectedAt" to this.unsubscribeDetectedAt?.toIso8601(),
        "unsubscribeDetectedAtMillis" to this.unsubscribeDetectedAt?.toMillis(),
        "billingIssueDetectedAt" to this.billingIssueDetectedAt?.toIso8601(),
        "billingIssueDetectedAtMillis" to this.billingIssueDetectedAt?.toMillis(),
        "ownershipType" to this.ownershipType.name,
        "verification" to this.verification.name,
    )
