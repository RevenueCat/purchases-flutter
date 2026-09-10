package com.revenuecat.purchases.hybridcommon.ui

import android.os.Build
import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import androidx.fragment.app.setFragmentResult
import com.revenuecat.purchases.InternalRevenueCatAPI
import com.revenuecat.purchases.PresentedOfferingContext
import com.revenuecat.purchases.Purchases
import com.revenuecat.purchases.ui.revenuecatui.CustomVariableValue
import com.revenuecat.purchases.ui.revenuecatui.ExperimentalPreviewRevenueCatUIPurchasesAPI
import com.revenuecat.purchases.ui.revenuecatui.activity.PaywallActivityLaunchIfNeededOptions
import com.revenuecat.purchases.ui.revenuecatui.activity.PaywallActivityLaunchOptions
import com.revenuecat.purchases.ui.revenuecatui.activity.PaywallActivityLauncher
import com.revenuecat.purchases.ui.revenuecatui.activity.PaywallDisplayCallback
import com.revenuecat.purchases.ui.revenuecatui.activity.PaywallResult
import com.revenuecat.purchases.ui.revenuecatui.activity.PaywallResultHandler
import com.revenuecat.purchases.ui.revenuecatui.fonts.CustomParcelizableFontProvider
import com.revenuecat.purchases.ui.revenuecatui.fonts.PaywallFontFamily

@OptIn(InternalRevenueCatAPI::class, ExperimentalPreviewRevenueCatUIPurchasesAPI::class)
internal class PaywallFragment : Fragment(), PaywallResultHandler {
    enum class ResultKey(val key: String) {
        PAYWALL_RESULT("paywall_result"),
    }

    companion object {
        enum class OptionKey(val key: String) {
            REQUEST_KEY("requestKey"),
            REQUIRED_ENTITLEMENT_IDENTIFIER("requiredEntitlementIdentifier"),
            SHOULD_DISPLAY_DISMISS_BUTTON("shouldDisplayDismissButton"),
            OFFERING_IDENTIFIER("offeringIdentifier"),
            PRESENTED_OFFERING_CONTEXT("presentedOfferingContext"),
            FONT_FAMILY("fontProvider"),
            CUSTOM_VARIABLES("customVariables"),
            HAS_NON_SERIALIZABLE_ARGS("hasNonSerializableArgs"),
        }

        private const val notPresentedPaywallResult = "NOT_PRESENTED"
        const val tag: String = "revenuecat-paywall-fragment"

        @Suppress("LongParameterList", "NestedBlockDepth")
        @JvmStatic
        fun newInstance(
            requestKey: String,
            requiredEntitlementIdentifier: String? = null,
            shouldDisplayDismissButton: Boolean? = null,
            paywallSource: PaywallSource,
            fontFamily: PaywallFontFamily? = null,
            customVariables: Map<String, Any?>? = null,
            hasNonSerializableArgs: Boolean = false,
        ): PaywallFragment {
            return PaywallFragment().apply {
                arguments = Bundle().apply {
                    putString(OptionKey.REQUEST_KEY.key, requestKey)
                    putString(OptionKey.REQUIRED_ENTITLEMENT_IDENTIFIER.key, requiredEntitlementIdentifier)
                    shouldDisplayDismissButton?.let { putBoolean(OptionKey.SHOULD_DISPLAY_DISMISS_BUTTON.key, it) }
                    @Suppress("DEPRECATION")
                    when (paywallSource) {
                        is PaywallSource.Offering -> {
                            putString(
                                OptionKey.OFFERING_IDENTIFIER.key,
                                paywallSource.value.identifier,
                            )
                            paywallSource.presentedOfferingContext?.let {
                                putParcelable(
                                    OptionKey.PRESENTED_OFFERING_CONTEXT.key,
                                    it,
                                )
                            }
                        }

                        is PaywallSource.OfferingIdentifier -> putString(
                            OptionKey.OFFERING_IDENTIFIER.key,
                            paywallSource.value,
                        )

                        is PaywallSource.OfferingIdentifierWithPresentedOfferingContext -> {
                            putString(OptionKey.OFFERING_IDENTIFIER.key, paywallSource.offeringIdentifier)
                            putParcelable(
                                OptionKey.PRESENTED_OFFERING_CONTEXT.key,
                                paywallSource.presentedOfferingContext,
                            )
                        }

                        is PaywallSource.DefaultOffering -> Unit
                    }
                    fontFamily?.let { putParcelable(OptionKey.FONT_FAMILY.key, it) }
                    customVariables?.let { putSerializable(OptionKey.CUSTOM_VARIABLES.key, HashMap(it)) }
                    putBoolean(OptionKey.HAS_NON_SERIALIZABLE_ARGS.key, hasNonSerializableArgs)
                }
            }
        }
    }

    private lateinit var launcher: PaywallActivityLauncher

    private val requestKey: String
        get() = arguments?.getString(OptionKey.REQUEST_KEY.key) ?: error("requestKey argument not provided")

    private val requiredEntitlementIdentifier: String?
        get() = arguments?.getString(OptionKey.REQUIRED_ENTITLEMENT_IDENTIFIER.key)

    private val presentedOfferingContextArg: PresentedOfferingContext?
        get() = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            arguments?.getParcelable(
                OptionKey.PRESENTED_OFFERING_CONTEXT.key,
                PresentedOfferingContext::class.java,
            )
        } else {
            @Suppress("DEPRECATION")
            arguments?.getParcelable(OptionKey.PRESENTED_OFFERING_CONTEXT.key)
        }

    private val shouldDisplayDismissButtonArg: Boolean?
        get() {
            return arguments?.let {
                if (it.containsKey(OptionKey.SHOULD_DISPLAY_DISMISS_BUTTON.key)) {
                    it.getBoolean(OptionKey.SHOULD_DISPLAY_DISMISS_BUTTON.key)
                } else {
                    null
                }
            }
        }

    private val fontFamily: PaywallFontFamily?
        get() = arguments?.takeIf { it.containsKey(OptionKey.FONT_FAMILY.key) }?.let {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                it.getParcelable(OptionKey.FONT_FAMILY.key, PaywallFontFamily::class.java)
            } else {
                @Suppress("DEPRECATION")
                it.getParcelable(OptionKey.FONT_FAMILY.key)
            }
        }

    private val offeringIdentifierArg: String?
        get() = arguments?.getString(OptionKey.OFFERING_IDENTIFIER.key)

    private val customVariablesArg: Map<String, Any?>?
        get() = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            @Suppress("UNCHECKED_CAST")
            arguments?.getSerializable(OptionKey.CUSTOM_VARIABLES.key, HashMap::class.java) as? Map<String, Any?>
        } else {
            @Suppress("DEPRECATION", "UNCHECKED_CAST")
            arguments?.getSerializable(OptionKey.CUSTOM_VARIABLES.key) as? Map<String, Any?>
        }

    private val hasNonSerializableArgsArg: Boolean
        get() = arguments?.getBoolean(OptionKey.HAS_NON_SERIALIZABLE_ARGS.key) ?: false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // This should normally never happen, but just in case, we don't want to try to present the paywall
        // if the SDK is not configured.
        if (!Purchases.isConfigured) {
            Log.e(
                "PaywallFragment",
                "Purchases is not configured. " +
                    "Make sure to call Purchases.configure() before launching the paywall. Dismissing.",
            )
            removeFragment()
            return
        }

        // When the system kills and restores the process, the Fragment is recreated from its saved
        // Bundle but PaywallFragmentNonSerializableArgsStore (in-memory) is cleared. If this
        // fragment was originally created with a purchaseLogic or paywallListener, those args are
        // now gone. Continuing would leave the paywall in a broken state (e.g. crash on purchase
        // when PurchasesAreCompletedBy.MY_APP is set). Dismiss instead.
        if (savedInstanceState != null &&
            hasNonSerializableArgsArg &&
            PaywallFragmentNonSerializableArgsStore.get(requestKey) == null
        ) {
            Log.w(
                "PaywallFragment",
                "Non-serializable paywall args (purchaseLogic/paywallListener) were lost after " +
                    "process death. Dismissing paywall to prevent a broken state.",
            )
            setFragmentResult("ERROR")
            removeFragment()
            return
        }

        launcher = PaywallActivityLauncher(
            this,
            this,
        )

        requiredEntitlementIdentifier?.let { requiredEntitlementIdentifier ->
            launchPaywallIfNeeded(requiredEntitlementIdentifier)
        } ?: launchPaywall()
    }

    override fun onActivityResult(result: PaywallResult) {
        setFragmentResult(result)
        removeFragment()
    }

    private fun removeFragment() {
        PaywallFragmentNonSerializableArgsStore.remove(requestKey)
        parentFragmentManager.beginTransaction().remove(this).commit()
    }

    private fun convertToCustomVariableValues(
        customVariables: Map<String, Any?>?,
    ): Map<String, CustomVariableValue>? {
        return customVariables
            ?.mapNotNull { (key, value) ->
                when (value) {
                    is String -> key to CustomVariableValue.String(value)
                    is Boolean -> key to CustomVariableValue.Boolean(value)
                    is Number -> key to CustomVariableValue.Number(value.toDouble())
                    null -> null
                    else -> {
                        Log.w(
                            "Purchases",
                            "Custom variable '$key' has unsupported type ${value::class.simpleName}. " +
                                "Only String, Number, and Boolean values are supported. This variable will be ignored.",
                        )
                        null
                    }
                }
            }
            ?.toMap()
            ?.takeIf { it.isNotEmpty() }
    }

    private fun launchPaywallIfNeeded(requiredEntitlementIdentifier: String) {
        val displayDismissButton = shouldDisplayDismissButtonArg
        val offering = offeringIdentifierArg
        val presentedOfferingContext = presentedOfferingContextArg ?: offering?.let { PresentedOfferingContext(it) }
        val fontProvider = fontFamily?.let { CustomParcelizableFontProvider(it) }
        val customVariables = convertToCustomVariableValues(customVariablesArg) ?: emptyMap()
        val nonSerializableArgs = PaywallFragmentNonSerializableArgsStore.get(requestKey)

        val paywallDisplayCallback = object : PaywallDisplayCallback {
            override fun onPaywallDisplayResult(wasDisplayed: Boolean) {
                if (!wasDisplayed) {
                    setFragmentResult(notPresentedPaywallResult)
                    removeFragment()
                }
            }
        }

        val optionsBuilder = PaywallActivityLaunchIfNeededOptions.Builder()
            .setRequiredEntitlementIdentifier(requiredEntitlementIdentifier)
            .setFontProvider(fontProvider)
            .setPaywallDisplayCallback(paywallDisplayCallback)
            .setCustomVariables(customVariables)

        if (displayDismissButton != null) {
            optionsBuilder.setShouldDisplayDismissButton(displayDismissButton)
        }

        if (offering != null && presentedOfferingContext != null) {
            optionsBuilder.setOfferingIdentifier(offering, presentedOfferingContext)
        }

        nonSerializableArgs?.paywallListener?.let { optionsBuilder.setListener(it) }
        nonSerializableArgs?.purchaseLogic?.let { optionsBuilder.setPurchaseLogic(it) }

        launcher.launchIfNeededWithOptions(optionsBuilder.build())
    }

    private fun launchPaywall() {
        val offering = offeringIdentifierArg
        val presentedOfferingContext = presentedOfferingContextArg ?: offering?.let { PresentedOfferingContext(it) }
        val displayDismissButton = shouldDisplayDismissButtonArg
        val fontProvider = fontFamily?.let { CustomParcelizableFontProvider(it) }
        val customVariables = convertToCustomVariableValues(customVariablesArg) ?: emptyMap()
        val nonSerializableArgs = PaywallFragmentNonSerializableArgsStore.get(requestKey)

        val optionsBuilder = PaywallActivityLaunchOptions.Builder()
            .setFontProvider(fontProvider)
            .setCustomVariables(customVariables)

        if (displayDismissButton != null) {
            optionsBuilder.setShouldDisplayDismissButton(displayDismissButton)
        }

        if (offering != null && presentedOfferingContext != null) {
            optionsBuilder.setOfferingIdentifier(offering, presentedOfferingContext)
        }

        nonSerializableArgs?.paywallListener?.let { optionsBuilder.setListener(it) }
        nonSerializableArgs?.purchaseLogic?.let { optionsBuilder.setPurchaseLogic(it) }

        launcher.launchWithOptions(optionsBuilder.build())
    }

    private fun setFragmentResult(paywallResult: PaywallResult) =
        setFragmentResult(paywallResult = paywallResult.name)

    private fun setFragmentResult(paywallResult: String) =
        setFragmentResult(
            requestKey = requestKey,
            result = Bundle().apply {
                putString(ResultKey.PAYWALL_RESULT.key, paywallResult)
            },
        )
}
