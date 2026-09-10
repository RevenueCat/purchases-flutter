package com.revenuecat.purchases.hybridcommon.mappers

import com.revenuecat.purchases.models.PurchaseType
import com.revenuecat.purchases.models.StoreTransaction
import java.util.Date

fun StoreTransaction.map(): Map<String, Any?> =
    mapOf(
        "transactionIdentifier" to this.transactionIdentifierValue(),
        "productIdentifier" to this.productIds.first(),
        "purchaseDateMillis" to this.purchaseTime,
        "purchaseDate" to Date(this.purchaseTime).toIso8601(),
        "purchaseToken" to this.purchaseToken,
        "originalJson" to this.originalJson.toString(),
        "signature" to this.signature,
    )

/**
 * Returns the appropriate transaction identifier based on the store.
 *
 * For Google purchases, this returns [StoreTransaction.orderId].
 * For Amazon purchases, [StoreTransaction.orderId] is always null, so this falls back to
 * [StoreTransaction.purchaseToken] which holds the Amazon receiptId.
 */
private fun StoreTransaction.transactionIdentifierValue(): String? =
    this.orderId ?: if (this.purchaseType == PurchaseType.AMAZON_PURCHASE) this.purchaseToken else null
