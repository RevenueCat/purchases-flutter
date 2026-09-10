package com.revenuecat.purchases.hybridcommon.mappers

import com.revenuecat.purchases.virtualcurrencies.VirtualCurrency

fun VirtualCurrency.map(): Map<String, Any?> =
    mapOf(
        "balance" to this.balance,
        "name" to this.name,
        "code" to this.code,
        "serverDescription" to this.serverDescription,
    )
