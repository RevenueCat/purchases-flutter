package com.revenuecat.purchases.hybridcommon.mappers

import com.revenuecat.purchases.models.Transaction

fun Transaction.map(): Map<String, Any?> =
    mapOf(
        "transactionIdentifier" to this.transactionIdentifier,
        // Deprecated: Use transactionIdentifier in this map instead
        "revenueCatId" to this.transactionIdentifier,
        "productIdentifier" to this.productIdentifier,
        // Deprecated: Use productIdentifier in this map instead
        "productId" to this.productIdentifier,
        "purchaseDateMillis" to this.purchaseDate.toMillis(),
        "purchaseDate" to this.purchaseDate.toIso8601(),
    )
