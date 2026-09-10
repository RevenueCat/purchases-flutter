package com.revenuecat.purchases.hybridcommon.mappers

import com.revenuecat.purchases.virtualcurrencies.VirtualCurrencies

fun VirtualCurrencies.map(): Map<String, Any?> =
    mapOf(
        "all" to this.all.mapValues { (_, virtualCurrency) -> virtualCurrency.map() },
    )
