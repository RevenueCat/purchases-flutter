package com.revenuecat.purchases.hybridcommon.ui

import java.util.concurrent.ConcurrentHashMap

internal data class PaywallFragmentNonSerializableArgs(
    val paywallListener: PaywallListenerWrapper? = null,
    val purchaseLogic: HybridPurchaseLogicBridge? = null,
)

internal object PaywallFragmentNonSerializableArgsStore {
    private val store = ConcurrentHashMap<String, PaywallFragmentNonSerializableArgs>()

    fun put(key: String, args: PaywallFragmentNonSerializableArgs) {
        store[key] = args
    }

    fun get(key: String): PaywallFragmentNonSerializableArgs? = store[key]

    fun remove(key: String) {
        store.remove(key)
    }
}
