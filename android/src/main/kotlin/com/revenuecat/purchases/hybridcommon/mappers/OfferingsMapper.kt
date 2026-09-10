package com.revenuecat.purchases.hybridcommon.mappers

import com.revenuecat.purchases.Offering
import com.revenuecat.purchases.Offerings
import com.revenuecat.purchases.Package
import com.revenuecat.purchases.PresentedOfferingContext
import com.revenuecat.purchases.hybridcommon.toPresentedOfferingContext
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

private fun Offerings.map(): Map<String, Any?> =
    mapOf(
        "all" to this.all.mapValues { it.value.map() },
        "current" to this.current?.map(),
    )

fun Offerings.mapAsync(
    callback: (Map<String, Any?>) -> Unit,
) {
    mainScope.launch {
        val map = withContext(mapperDispatcher) { map() }
        callback(map)
    }
}

fun createPresentedOfferingContextFromMap(map: Map<String, Any?>?): PresentedOfferingContext? {
    return map?.toPresentedOfferingContext()
}

private fun Offering.map(): Map<String, Any?> =
    mapOf(
        "identifier" to identifier,
        "serverDescription" to serverDescription,
        "metadata" to metadata,
        "availablePackages" to availablePackages.map { it.map() },
        "lifetime" to lifetime?.map(),
        "annual" to annual?.map(),
        "sixMonth" to sixMonth?.map(),
        "threeMonth" to threeMonth?.map(),
        "twoMonth" to twoMonth?.map(),
        "monthly" to monthly?.map(),
        "weekly" to weekly?.map(),
        "webCheckoutUrl" to webCheckoutURL?.toString(),
    )

fun Offering.mapAsync(
    callback: (Map<String, Any?>) -> Unit,
) {
    mainScope.launch {
        val map = withContext(mapperDispatcher) { map() }
        callback(map)
    }
}

fun Package.map(): Map<String, Any?> =
    mapOf(
        "identifier" to identifier,
        "packageType" to packageType.name,
        "product" to product.map(),
        "offeringIdentifier" to presentedOfferingContext.offeringIdentifier,
        "presentedOfferingContext" to presentedOfferingContext.map(),
        "webCheckoutUrl" to webCheckoutURL?.toString(),
    )

fun PresentedOfferingContext.map(): Map<String, Any?> =
    mapOf(
        "offeringIdentifier" to offeringIdentifier,
        "placementIdentifier" to placementIdentifier,
        "targetingContext" to targetingContext?.map(),
    )

fun PresentedOfferingContext.TargetingContext.map(): Map<String, Any> =
    mapOf(
        "revision" to revision,
        "ruleId" to ruleId,
    )
