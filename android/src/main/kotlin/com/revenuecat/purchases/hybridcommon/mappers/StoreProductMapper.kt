package com.revenuecat.purchases.hybridcommon.mappers

import androidx.annotation.VisibleForTesting
import com.revenuecat.purchases.ProductType
import com.revenuecat.purchases.amazon.AmazonStoreProduct
import com.revenuecat.purchases.models.InstallmentsInfo
import com.revenuecat.purchases.models.Period
import com.revenuecat.purchases.models.Price
import com.revenuecat.purchases.models.PricingPhase
import com.revenuecat.purchases.models.StoreProduct
import com.revenuecat.purchases.models.SubscriptionOption
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

val StoreProduct.priceAmountMicros: Long
    get() = this.price.amountMicros
val StoreProduct.priceString: String
    get() = this.price.formatted
val StoreProduct.priceCurrencyCode: String
    get() = this.price.currencyCode

val StoreProduct.googleFreeTrialPeriod: Period?
    get() = this.defaultOption?.freePhase?.billingPeriod
val StoreProduct.googleFreeTrialCycles: Int?
    get() = this.defaultOption?.freePhase?.billingCycleCount

private val StoreProduct.googleIntroductoryPhase: PricingPhase?
    get() = this.defaultOption?.introPhase
val StoreProduct.googleIntroductoryPrice: String?
    get() = this.googleIntroductoryPhase?.price?.formatted
val StoreProduct.googleIntroductoryPricePeriod: Period?
    get() = this.googleIntroductoryPhase?.billingPeriod
val StoreProduct.googleIntroductoryPriceAmountMicros: Long
    get() = this.googleIntroductoryPhase?.price?.amountMicros ?: 0
val StoreProduct.googleIntroductoryPriceCycles: Int
    get() = this.googleIntroductoryPhase?.billingCycleCount ?: 0

private const val DAYS_PER_WEEK = 7
private const val MICROS_CONVERSION_METRIC = 1_000_000.0

fun StoreProduct.map(): Map<String, Any?> =
    mapOf(
        "identifier" to id,
        "description" to description,
        "title" to title,
        "price" to priceAmountMicros / MICROS_CONVERSION_METRIC,
        "priceString" to priceString,
        "currencyCode" to priceCurrencyCode,
        "introPrice" to mapIntroPrice(),
        "discounts" to null,
        "pricePerWeek" to (pricePerWeek()?.amountMicros?.let { it / MICROS_CONVERSION_METRIC }),
        "pricePerMonth" to (pricePerMonth()?.amountMicros?.let { it / MICROS_CONVERSION_METRIC }),
        "pricePerYear" to (pricePerYear()?.amountMicros?.let { it / MICROS_CONVERSION_METRIC }),
        "pricePerWeekString" to pricePerWeek()?.formatted,
        "pricePerMonthString" to pricePerMonth()?.formatted,
        "pricePerYearString" to pricePerYear()?.formatted,
        "productCategory" to mapProductCategory().value,
        "productType" to mapProductType(),
        "subscriptionPeriod" to period?.iso8601,
        "defaultOption" to defaultOption?.mapSubscriptionOption(this),
        "subscriptionOptions" to subscriptionOptions?.map { it.mapSubscriptionOption(this) },
        "presentedOfferingIdentifier" to presentedOfferingContext?.offeringIdentifier,
        "presentedOfferingContext" to presentedOfferingContext?.map(),
    )

private fun List<StoreProduct>.map(): List<Map<String, Any?>> = this.map { it.map() }

fun List<StoreProduct>.mapAsync(
    callback: (List<Map<String, Any?>>) -> Unit,
) {
    mainScope.launch {
        val map = withContext(mapperDispatcher) { map() }
        callback(map)
    }
}

@VisibleForTesting(otherwise = VisibleForTesting.PRIVATE)
internal enum class MappedProductCategory(val value: String) {
    SUBSCRIPTION("SUBSCRIPTION"),
    NON_SUBSCRIPTION("NON_SUBSCRIPTION"),
    UNKNOWN("UNKNOWN"),
    ;

    val toProductType: ProductType
        get() = when (this) {
            NON_SUBSCRIPTION -> ProductType.INAPP
            SUBSCRIPTION -> ProductType.SUBS
            UNKNOWN -> ProductType.UNKNOWN
        }
}

@VisibleForTesting(otherwise = VisibleForTesting.PRIVATE)
internal fun StoreProduct.mapProductCategory(): MappedProductCategory {
    return when (type) {
        ProductType.INAPP -> MappedProductCategory.NON_SUBSCRIPTION
        ProductType.SUBS -> MappedProductCategory.SUBSCRIPTION
        ProductType.UNKNOWN -> MappedProductCategory.UNKNOWN
    }
}

@VisibleForTesting(otherwise = VisibleForTesting.PRIVATE)
internal fun StoreProduct.mapProductType(): String {
    return when (type) {
        ProductType.INAPP -> "CONSUMABLE"
        ProductType.SUBS -> {
            if (defaultOption?.isPrepaid == true) {
                "PREPAID_SUBSCRIPTION"
            } else {
                "AUTO_RENEWABLE_SUBSCRIPTION"
            }
        }
        ProductType.UNKNOWN -> "UNKNOWN"
    }
}

@VisibleForTesting(otherwise = VisibleForTesting.PRIVATE)
internal fun StoreProduct.mapIntroPrice(): Map<String, Any?>? {
    return when (this) {
        is AmazonStoreProduct -> freeTrialPeriod?.mapPeriodForStoreProduct()?.let { periodFields ->
            mapOf(
                "price" to 0,
                "priceString" to formatUsingDeviceLocale(priceCurrencyCode, 0),
                "period" to freeTrialPeriod?.iso8601,
                "cycles" to 1,
            ) + periodFields
        }
        else -> when {
            googleFreeTrialPeriod != null -> {
                // Check freeTrialPeriod first to give priority to trials
                // Format using device locale. iOS will format using App Store locale, but there's no way
                // to figure out how the price in the SKUDetails is being formatted.
                googleFreeTrialPeriod?.mapPeriodForStoreProduct()?.let { periodFields ->
                    mapOf(
                        "price" to 0,
                        "priceString" to formatUsingDeviceLocale(priceCurrencyCode, 0),
                        "period" to googleFreeTrialPeriod?.iso8601,
                        "cycles" to (googleFreeTrialCycles ?: 1),
                    ) + periodFields
                }
            }
            googleIntroductoryPrice != null -> {
                googleIntroductoryPricePeriod?.mapPeriodForStoreProduct()?.let { periodFields ->
                    mapOf(
                        "price" to googleIntroductoryPriceAmountMicros / MICROS_CONVERSION_METRIC,
                        "priceString" to googleIntroductoryPrice,
                        "period" to googleIntroductoryPricePeriod?.iso8601,
                        "cycles" to googleIntroductoryPriceCycles,
                    ) + periodFields
                }
            }
            else -> {
                null
            }
        }
    }
}

private fun Period.mapPeriodForStoreProduct(): Map<String, Any?> {
    return when (this.unit) {
        Period.Unit.DAY -> mapOf(
            "periodUnit" to "DAY",
            "periodNumberOfUnits" to this.value,
        )
        // WEEK was added in Android V6 but converting to days for backwards compatibility
        Period.Unit.WEEK -> mapOf(
            "periodUnit" to "DAY",
            "periodNumberOfUnits" to this.value * DAYS_PER_WEEK,
        )
        Period.Unit.MONTH -> mapOf(
            "periodUnit" to "MONTH",
            "periodNumberOfUnits" to this.value,
        )
        Period.Unit.YEAR -> mapOf(
            "periodUnit" to "YEAR",
            "periodNumberOfUnits" to this.value,
        )
        Period.Unit.UNKNOWN -> mapOf(
            "periodUnit" to "DAY",
            "periodNumberOfUnits" to 0,
        )
    }
}

private fun Period.mapPeriod(): Map<String, Any?>? {
    return when (this.unit) {
        Period.Unit.DAY -> mapOf(
            "unit" to "DAY",
            "value" to this.value,
        )
        // WEEK was added in Android V6 but converting to days for backwards compatibility
        Period.Unit.WEEK -> mapOf(
            "unit" to "DAY",
            "value" to this.value * DAYS_PER_WEEK,
        )
        Period.Unit.MONTH -> mapOf(
            "unit" to "MONTH",
            "value" to this.value,
        )
        Period.Unit.YEAR -> mapOf(
            "unit" to "YEAR",
            "value" to this.value,
        )
        Period.Unit.UNKNOWN -> mapOf(
            "unit" to "DAY",
            "value" to 0,
        )
    } + mapOf("iso8601" to this.iso8601)
}

private fun SubscriptionOption.mapSubscriptionOption(storeProduct: StoreProduct): Map<String, Any?> {
    return mapOf(
        // For Google subscriptions, <basePlanId>:<offerId>
        // For Google and Amazon INAPPs, <productId>
        // For Amazon subscriptions, <termSku>
        "id" to id,

        // For Google subscriptions, <productId>:<basePlanId>
        // For Google and Amazon INAPPs, <productId>
        // For Amazon subscriptions, <termSku>
        "storeProductId" to storeProduct.id,

        // For Google subscriptions, <productId>
        // For Google and Amazon INAPPs, <productId>
        // For Amazon subscriptions, <termSku>
        "productId" to storeProduct.purchasingData.productId,

        "pricingPhases" to pricingPhases.map { it.mapPricingPhase() },
        "tags" to tags,
        "isBasePlan" to isBasePlan,
        "billingPeriod" to billingPeriod?.mapPeriod(),
        "isPrepaid" to isPrepaid,
        "fullPricePhase" to fullPricePhase?.mapPricingPhase(),
        "freePhase" to freePhase?.mapPricingPhase(),
        "introPhase" to introPhase?.mapPricingPhase(),
        "presentedOfferingIdentifier" to presentedOfferingContext?.offeringIdentifier,
        "presentedOfferingContext" to presentedOfferingContext?.map(),
        "installmentsInfo" to installmentsInfo?.map(),
    )
}

private fun PricingPhase.mapPricingPhase(): Map<String, Any?> {
    return mapOf(
        "billingPeriod" to billingPeriod?.mapPeriod(),
        "recurrenceMode" to recurrenceMode.identifier,
        "billingCycleCount" to billingCycleCount,
        "price" to price.mapPrice(),
        "offerPaymentMode" to offerPaymentMode?.toString(),
    )
}

private fun Price.mapPrice(): Map<String, Any?> {
    return mapOf(
        "formatted" to formatted,
        "amountMicros" to amountMicros,
        "currencyCode" to currencyCode,
    )
}

private fun InstallmentsInfo.map(): Map<String, Any?> {
    return mapOf(
        "commitmentPaymentsCount" to commitmentPaymentsCount,
        "renewalCommitmentPaymentsCount" to renewalCommitmentPaymentsCount,
    )
}
