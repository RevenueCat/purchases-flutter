package com.revenuecat.purchases_ui_flutter

import com.revenuecat.purchases.hybridcommon.ui.PaywallListenerWrapper
import io.flutter.plugin.common.MethodChannel

internal fun forwardingPaywallListener(channel: MethodChannel): PaywallListenerWrapper =
    object : PaywallListenerWrapper() {
        override fun onPurchaseStarted(rcPackage: Map<String, Any?>) {
            channel.invokeMethod("onPurchaseStarted", rcPackage)
        }

        override fun onPurchaseCompleted(customerInfo: Map<String, Any?>, storeTransaction: Map<String, Any?>) {
            channel.invokeMethod(
                "onPurchaseCompleted",
                mapOf("customerInfo" to customerInfo, "storeTransaction" to storeTransaction)
            )
        }

        override fun onPurchaseCancelled() {
            channel.invokeMethod("onPurchaseCancelled", null)
        }

        override fun onPurchaseError(error: Map<String, Any?>) {
            channel.invokeMethod("onPurchaseError", error)
        }

        override fun onRestoreCompleted(customerInfo: Map<String, Any?>) {
            channel.invokeMethod("onRestoreCompleted", customerInfo)
        }

        override fun onRestoreError(error: Map<String, Any?>) {
            channel.invokeMethod("onRestoreError", error)
        }

        override fun onWebCheckoutOpened() {
            channel.invokeMethod("onWebCheckoutOpened", null)
        }

        override fun onUrlOpened(url: String) {
            channel.invokeMethod("onUrlOpened", mapOf("url" to url))
        }

        override fun onInteraction(event: Map<String, Any>) {
            channel.invokeMethod("onInteraction", event)
        }
    }
