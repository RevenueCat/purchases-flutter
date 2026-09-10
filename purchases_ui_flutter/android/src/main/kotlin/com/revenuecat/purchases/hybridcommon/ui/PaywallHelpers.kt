package com.revenuecat.purchases.hybridcommon.ui

import android.util.Log
import androidx.fragment.app.FragmentActivity
import androidx.lifecycle.Lifecycle
import com.revenuecat.purchases.Offering
import com.revenuecat.purchases.ui.revenuecatui.fonts.PaywallFontFamily

@JvmOverloads
@Deprecated(
    message = "Use presentPaywallFromFragment with Options instead",
    replaceWith = ReplaceWith(
        expression = "presentPaywallFromFragment(fragment, options)",
        imports = ["com.revenuecat.purchases.hybridcommon.ui.presentPaywallFromFragment"],
    ),
)
fun presentPaywallFromFragment(
    activity: FragmentActivity,
    paywallResultListener: PaywallResultListener,
    requiredEntitlementIdentifier: String? = null,
    shouldDisplayDismissButton: Boolean? = null,
    offering: Offering? = null,
) {
    presentPaywallFromFragment(
        activity,
        PresentPaywallOptions(
            requiredEntitlementIdentifier = requiredEntitlementIdentifier,
            paywallResultListener = paywallResultListener,
            shouldDisplayDismissButton = shouldDisplayDismissButton,
            paywallSource = offering?.let { PaywallSource.Offering(it) } ?: PaywallSource.DefaultOffering,
        ),
    )
}

fun presentPaywallFromFragment(
    activity: FragmentActivity,
    options: PresentPaywallOptions,
) {
    with(options) {
        val requestKey = System.identityHashCode(paywallResultListener).toString()

        if (paywallListener != null || purchaseLogic != null) {
            PaywallFragmentNonSerializableArgsStore.put(
                requestKey,
                PaywallFragmentNonSerializableArgs(
                    paywallListener = paywallListener,
                    purchaseLogic = purchaseLogic,
                ),
            )
        }

        activity.runOnUiThread {
            activity.supportFragmentManager.setFragmentResultListener(requestKey, activity) { _, result ->
                val paywallResult = result.getString(PaywallFragment.ResultKey.PAYWALL_RESULT.key)
                    ?: error("PaywallResult not found in result bundle.")
                paywallResultListener.onPaywallResult(paywallResult)
                activity.supportFragmentManager.clearFragmentResultListener(requestKey)
            }

            if (activity.lifecycle.currentState.isAtLeast(Lifecycle.State.STARTED)) {
                activity
                    .supportFragmentManager
                    .beginTransaction()
                    .add(
                        PaywallFragment.newInstance(
                            requestKey,
                            requiredEntitlementIdentifier,
                            shouldDisplayDismissButton,
                            paywallSource,
                            fontFamily,
                            customVariables,
                            hasNonSerializableArgs = paywallListener != null || purchaseLogic != null,
                        ),
                        PaywallFragment.tag,
                    )
                    .commit()
            } else {
                Log.w(
                    "Purchases",
                    "Tried to present a paywall while the activity was paused or finished. Not presenting.",
                )
                options.paywallResultListener.onPaywallResult("ERROR")
            }
        }
    }
}

data class PresentPaywallOptions @JvmOverloads constructor(
    val paywallResultListener: PaywallResultListener,
    val paywallSource: PaywallSource = PaywallSource.DefaultOffering,
    val requiredEntitlementIdentifier: String? = null,
    val shouldDisplayDismissButton: Boolean? = null,
    val fontFamily: PaywallFontFamily? = null,
    val customVariables: Map<String, Any?>? = null,
    val paywallListener: PaywallListenerWrapper? = null,
    val purchaseLogic: HybridPurchaseLogicBridge? = null,
)
