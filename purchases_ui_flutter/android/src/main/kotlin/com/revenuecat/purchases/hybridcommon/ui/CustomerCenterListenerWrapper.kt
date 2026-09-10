package com.revenuecat.purchases.hybridcommon.ui

import com.revenuecat.purchases.CustomerInfo
import com.revenuecat.purchases.InternalRevenueCatAPI
import com.revenuecat.purchases.PurchasesError
import com.revenuecat.purchases.customercenter.CustomerCenterListener
import com.revenuecat.purchases.customercenter.CustomerCenterManagementOption
import com.revenuecat.purchases.hybridcommon.mappers.map
import com.revenuecat.purchases.models.StoreTransaction

@OptIn(InternalRevenueCatAPI::class)
@SuppressWarnings("TooManyFunctions")
abstract class CustomerCenterListenerWrapper : CustomerCenterListener {

    override fun onFeedbackSurveyCompleted(feedbackSurveyOptionId: String) {
        this.onFeedbackSurveyCompletedWrapper(feedbackSurveyOptionId)
    }

    override fun onRestoreCompleted(customerInfo: CustomerInfo) {
        this.onRestoreCompletedWrapper(customerInfo.map())
    }

    override fun onRestoreFailed(error: PurchasesError) {
        this.onRestoreFailedWrapper(error = error.map().info)
    }

    override fun onRestoreStarted() {
        this.onRestoreStartedWrapper()
    }

    override fun onShowingManageSubscriptions() {
        this.onShowingManageSubscriptionsWrapper()
    }

    override fun onPromotionalOfferSucceeded(
        customerInfo: CustomerInfo,
        transaction: StoreTransaction,
    ) {
        val offerId = transaction.subscriptionOptionId?.substringAfter(":", missingDelimiterValue = "")
            ?.ifEmpty { null } ?: ""
        this.onPromotionalOfferSucceededWrapper(customerInfo.map(), transaction.map(), offerId)
    }

    override fun onManagementOptionSelected(action: CustomerCenterManagementOption) {
        if (action is CustomerCenterManagementOption.CustomUrl) {
            this.onManagementOptionSelectedWrapper(action.optionName, action.uri.toString())
        } else if (action is CustomerCenterManagementOption.CustomAction) {
            this.onCustomActionSelectedWrapper(
                actionId = action.actionIdentifier,
                purchaseIdentifier = action.purchaseIdentifier,
            )
            @Suppress("DEPRECATION")
            this.onManagementOptionSelectedWrapper(
                action.optionName,
                action.actionIdentifier,
                action.purchaseIdentifier,
            )
        } else {
            this.onManagementOptionSelectedWrapper(action.optionName, null)
        }
    }

    abstract fun onFeedbackSurveyCompletedWrapper(feedbackSurveyOptionId: String)
    abstract fun onRestoreCompletedWrapper(customerInfo: Map<String, Any?>)
    abstract fun onRestoreFailedWrapper(error: Map<String, Any?>)
    abstract fun onRestoreStartedWrapper()
    abstract fun onShowingManageSubscriptionsWrapper()
    abstract fun onManagementOptionSelectedWrapper(action: String, url: String?)

    @Deprecated("Use onCustomActionSelectedWrapper instead.")
    abstract fun onManagementOptionSelectedWrapper(action: String, customAction: String?, purchaseIdentifier: String?)

    abstract fun onCustomActionSelectedWrapper(actionId: String, purchaseIdentifier: String?)

    abstract fun onPromotionalOfferSucceededWrapper(
        customerInfo: Map<String, Any?>,
        transaction: Map<String, Any?>,
        offerId: String,
    )
}

private val CustomerCenterManagementOption.optionName: String
    get() {
        return when (this) {
            is CustomerCenterManagementOption.Cancel -> "cancel"
            is CustomerCenterManagementOption.MissingPurchase -> "missing_purchase"
            is CustomerCenterManagementOption.CustomUrl -> "custom_url"
            is CustomerCenterManagementOption.CustomAction -> "custom_action"
            else -> "unknown"
        }
    }
