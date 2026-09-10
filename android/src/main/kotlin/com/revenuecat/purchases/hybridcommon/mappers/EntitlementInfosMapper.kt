package com.revenuecat.purchases.hybridcommon.mappers

import com.revenuecat.purchases.EntitlementInfos

fun EntitlementInfos.map(): Map<String, Any> =
    mapOf(
        "all" to this.all.asIterable().associate { it.key to it.value.map() },
        "active" to this.active.asIterable().associate { it.key to it.value.map() },
        "verification" to this.verification.name,
    )
