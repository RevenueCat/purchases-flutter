package com.revenuecat.purchases.hybridcommon.mappers

import com.revenuecat.purchases.SubscriptionInfo

fun SubscriptionInfo.map(): Map<String, Any?> =
    mapOf(
        "productIdentifier" to productIdentifier,
        "purchaseDate" to purchaseDate.toIso8601(),
        "originalPurchaseDate" to originalPurchaseDate?.toIso8601(),
        "expiresDate" to expiresDate?.toIso8601(),
        "store" to store.name,
        "unsubscribeDetectedAt" to unsubscribeDetectedAt?.toIso8601(),
        "isSandbox" to isSandbox,
        "billingIssuesDetectedAt" to billingIssuesDetectedAt?.toIso8601(),
        "gracePeriodExpiresDate" to gracePeriodExpiresDate?.toIso8601(),
        "ownershipType" to ownershipType.name,
        "periodType" to periodType.name,
        "refundedAt" to refundedAt?.toIso8601(),
        "storeTransactionId" to storeTransactionId,
        "isActive" to isActive,
        "willRenew" to willRenew,
        "autoResumeDate" to autoResumeDate?.toIso8601(),
        "displayName" to displayName,
        "managementURL" to managementURL?.toString(),
        "productPlanIdentifier" to productPlanIdentifier,
    )
