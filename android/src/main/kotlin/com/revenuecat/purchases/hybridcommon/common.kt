package com.revenuecat.purchases.hybridcommon

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.util.Log
import androidx.annotation.VisibleForTesting
import com.revenuecat.purchases.AmazonLWAConsentStatus
import com.revenuecat.purchases.CustomerInfo
import com.revenuecat.purchases.DangerousSettings
import com.revenuecat.purchases.DebugEventListener
import com.revenuecat.purchases.EntitlementVerificationMode
import com.revenuecat.purchases.ExperimentalPreviewRevenueCatPurchasesAPI
import com.revenuecat.purchases.InternalRevenueCatAPI
import com.revenuecat.purchases.LogLevel
import com.revenuecat.purchases.Offerings
import com.revenuecat.purchases.Package
import com.revenuecat.purchases.PresentedOfferingContext
import com.revenuecat.purchases.ProductType
import com.revenuecat.purchases.PurchaseParams
import com.revenuecat.purchases.Purchases
import com.revenuecat.purchases.PurchasesAreCompletedBy
import com.revenuecat.purchases.PurchasesConfiguration
import com.revenuecat.purchases.PurchasesError
import com.revenuecat.purchases.PurchasesErrorCode
import com.revenuecat.purchases.PurchasesException
import com.revenuecat.purchases.Store
import com.revenuecat.purchases.TrackedEventListener
import com.revenuecat.purchases.WebPurchaseRedemption
import com.revenuecat.purchases.ads.events.types.AdDisplayedData
import com.revenuecat.purchases.ads.events.types.AdFailedToLoadData
import com.revenuecat.purchases.ads.events.types.AdFormat
import com.revenuecat.purchases.ads.events.types.AdLoadedData
import com.revenuecat.purchases.ads.events.types.AdMediatorName
import com.revenuecat.purchases.ads.events.types.AdOpenedData
import com.revenuecat.purchases.ads.events.types.AdRevenueData
import com.revenuecat.purchases.ads.events.types.AdRevenuePrecision
import com.revenuecat.purchases.ads.rewardverification.RewardedAdTrackingMetadata
import com.revenuecat.purchases.common.PlatformInfo
import com.revenuecat.purchases.galaxy.GalaxyBillingMode
import com.revenuecat.purchases.getAmazonLWAConsentStatusWith
import com.revenuecat.purchases.getCustomerInfoWith
import com.revenuecat.purchases.getOfferingsWith
import com.revenuecat.purchases.getProductsWith
import com.revenuecat.purchases.getStorefrontCountryCodeWith
import com.revenuecat.purchases.getVirtualCurrenciesWith
import com.revenuecat.purchases.hybridcommon.mappers.LogHandlerWithMapping
import com.revenuecat.purchases.hybridcommon.mappers.MappedProductCategory
import com.revenuecat.purchases.hybridcommon.mappers.map
import com.revenuecat.purchases.hybridcommon.mappers.mapAsync
import com.revenuecat.purchases.hybridcommon.mappers.toMap
import com.revenuecat.purchases.interfaces.RedeemWebPurchaseListener
import com.revenuecat.purchases.interfaces.SyncAttributesAndOfferingsCallback
import com.revenuecat.purchases.logInWith
import com.revenuecat.purchases.logOutWith
import com.revenuecat.purchases.models.BillingFeature
import com.revenuecat.purchases.models.GoogleReplacementMode
import com.revenuecat.purchases.models.InAppMessageType
import com.revenuecat.purchases.models.StoreProduct
import com.revenuecat.purchases.models.StoreReplacementMode
import com.revenuecat.purchases.models.StoreTransaction
import com.revenuecat.purchases.models.SubscriptionOption
import com.revenuecat.purchases.models.googleProduct
import com.revenuecat.purchases.paywalls.events.CustomPaywallImpressionParams
import com.revenuecat.purchases.purchaseWith
import com.revenuecat.purchases.restorePurchasesWith
import com.revenuecat.purchases.syncAttributesAndOfferingsIfNeededWith
import com.revenuecat.purchases.syncPurchasesWith
import com.revenuecat.purchases.virtualcurrencies.VirtualCurrencies
import java.net.URL

@Deprecated(
    "Replaced with configuration in the RevenueCat dashboard",
    ReplaceWith("configure through the RevenueCat dashboard"),
)
fun setAllowSharingAppStoreAccount(
    allowSharingAppStoreAccount: Boolean,
) {
    Purchases.sharedInstance.allowSharingPlayStoreAccount = allowSharingAppStoreAccount
}

fun getOfferings(
    onResult: OnResult,
) {
    Purchases.sharedInstance.getOfferingsWith(onError = { onResult.onError(it.map()) }) { offerings ->
        offerings.mapAsync { map -> onResult.onReceived(map) }
    }
}

fun getCurrentOfferingForPlacement(
    placementIdentifier: String,
    onResult: OnNullableResult,
) {
    Purchases.sharedInstance.getOfferingsWith(onError = { onResult.onError(it.map()) }) {
        val offering = it.getCurrentOfferingForPlacement(placementIdentifier)

        if (offering != null) {
            offering.mapAsync { map -> onResult.onReceived(map) }
        } else {
            onResult.onReceived(null)
        }
    }
}

fun syncAttributesAndOfferingsIfNeeded(
    onResult: OnResult,
) {
    Purchases.sharedInstance.syncAttributesAndOfferingsIfNeededWith(onError = { onResult.onError(it.map()) }) {
        it.mapAsync { map -> onResult.onReceived(map) }
    }
}

fun setAppstackAttributionParams(
    data: Map<String, Any>,
    onResult: OnResult,
) {
    val stringData = data.mapValues { it.value.toString() }
    Purchases.sharedInstance.setAppstackAttributionParams(
        stringData,
        object : SyncAttributesAndOfferingsCallback {
            override fun onSuccess(offerings: Offerings) {
                offerings.mapAsync { map -> onResult.onReceived(map) }
            }
            override fun onError(error: PurchasesError) {
                onResult.onError(error.map())
            }
        },
    )
}

fun getProductInfo(
    productIDs: List<String>,
    type: String,
    onResult: OnResultList,
) {
    val onError: (PurchasesError) -> Unit = { onResult.onError(it.map()) }
    val onReceived: (List<StoreProduct>) -> Unit = { it.mapAsync { list -> onResult.onReceived(list) } }

    if (mapStringToProductType(type) == ProductType.SUBS) {
        Purchases.sharedInstance.getProductsWith(productIDs, ProductType.SUBS, onError, onReceived)
    } else {
        Purchases.sharedInstance.getProductsWith(productIDs, ProductType.INAPP, onError, onReceived)
    }
}

fun purchase(
    activity: Activity?,
    options: Map<String, Any?>,
    onResult: OnResult,
) {
    val purchaseParams = validatePurchaseParams(options).onFailure {
        onResult.onError((it as PurchasesException).error.map())
    }.getOrNull() ?: return
    when (val purchasableItem = purchaseParams.purchasableItem) {
        is PurchasableItem.Product -> purchaseProduct(
            activity = activity,
            productIdentifier = purchasableItem.productIdentifier,
            type = purchasableItem.type,
            googleBasePlanId = purchasableItem.googleBasePlanId,
            googleOldProductId = purchaseParams.googleOldProductId,
            googleReplacementModeInt = purchaseParams.googleReplacementMode,
            googleIsPersonalizedPrice = purchaseParams.googleIsPersonalizedPrice,
            storeReplacementModeString = purchaseParams.storeReplacementMode,
            presentedOfferingContext = purchaseParams.presentedOfferingContext,
            onResult = onResult,
            addOnStoreProducts = purchaseParams.addOnStoreProducts,
            addOnSubscriptionOptions = purchaseParams.addOnSubscriptionOptions,
            addOnPackages = purchaseParams.addOnPackages,
        )

        is PurchasableItem.Package -> purchasePackage(
            activity = activity,
            packageIdentifier = purchasableItem.packageIdentifier,
            presentedOfferingContext = purchaseParams.presentedOfferingContext
                ?: emptyMap(),
            googleOldProductId = purchaseParams.googleOldProductId,
            googleReplacementModeInt = purchaseParams.googleReplacementMode,
            googleIsPersonalizedPrice = purchaseParams.googleIsPersonalizedPrice,
            storeReplacementModeString = purchaseParams.storeReplacementMode,
            onResult = onResult,
            addOnStoreProducts = purchaseParams.addOnStoreProducts,
            addOnSubscriptionOptions = purchaseParams.addOnSubscriptionOptions,
            addOnPackages = purchaseParams.addOnPackages,
        )

        is PurchasableItem.SubscriptionOption -> purchaseSubscriptionOption(
            activity = activity,
            productIdentifier = purchasableItem.productIdentifier,
            optionIdentifier = purchasableItem.optionIdentifier,
            googleOldProductId = purchaseParams.googleOldProductId,
            googleReplacementModeInt = purchaseParams.googleReplacementMode,
            googleIsPersonalizedPrice = purchaseParams.googleIsPersonalizedPrice,
            storeReplacementModeString = purchaseParams.storeReplacementMode,
            presentedOfferingContext = purchaseParams.presentedOfferingContext,
            onResult = onResult,
            addOnStoreProducts = purchaseParams.addOnStoreProducts,
            addOnSubscriptionOptions = purchaseParams.addOnSubscriptionOptions,
            addOnPackages = purchaseParams.addOnPackages,
        )
    }
}

private sealed interface PurchasableItem {
    data class Product(
        val productIdentifier: String,
        val type: String,
        val googleBasePlanId: String?,
    ) : PurchasableItem

    data class Package(
        val packageIdentifier: String,
    ) : PurchasableItem

    data class SubscriptionOption(
        val productIdentifier: String,
        val optionIdentifier: String,
    ) : PurchasableItem
}

private data class CommonPurchaseParams(
    val purchasableItem: PurchasableItem,
    val googleOldProductId: String?,
    val googleReplacementMode: Int?,
    val googleIsPersonalizedPrice: Boolean?,
    val storeReplacementMode: String?,
    val presentedOfferingContext: Map<String, Any?>?,
    val addOnStoreProducts: List<Map<String, Any?>>?,
    val addOnSubscriptionOptions: List<Map<String, Any?>>?,
    val addOnPackages: List<Map<String, Any?>>?,
)

private fun validatePurchaseParams(
    options: Map<String, Any?>,
): Result<CommonPurchaseParams> {
    val packageIdentifier = options["packageIdentifier"] as? String
    val productIdentifier = options["productIdentifier"] as? String
    val subscriptionOptionIdentifier = options["optionIdentifier"] as? String

    val googleOldProductId = options["googleOldProductId"] as? String
    val googleReplacementMode = options["googleReplacementMode"] as? Int
    val googleIsPersonalizedPrice = options["googleIsPersonalizedPrice"] as? Boolean
    val storeReplacementMode = options["storeReplacementMode"] as? String
    val presentedOfferingContext = castWildcardMapToStringToOptionalAnyMap(
        options["presentedOfferingContext"] as? Map<*, *>,
    )

    val type = options["type"] as? String
    val addOnStoreProducts = castWildcardListToListOfStringToAnyMaps(
        options["addOnStoreProducts"] as? List<*>,
    )
    val addOnSubscriptionOptions = castWildcardListToListOfStringToAnyMaps(
        options["addOnSubscriptionOptions"] as? List<*>,
    )
    val addOnPackages = castWildcardListToListOfStringToAnyMaps(
        options["addOnPackages"] as? List<*>,
    )

    val purchasableItem = when {
        packageIdentifier != null -> {
            PurchasableItem.Package(packageIdentifier)
        }
        subscriptionOptionIdentifier != null && productIdentifier != null -> {
            PurchasableItem.SubscriptionOption(productIdentifier, subscriptionOptionIdentifier)
        }
        productIdentifier != null && type != null -> {
            val googleBasePlanId = options["googleBasePlanId"] as? String
            PurchasableItem.Product(productIdentifier, type, googleBasePlanId)
        }
        else -> null
    }

    return if (purchasableItem != null) {
        Result.success(
            CommonPurchaseParams(
                purchasableItem = purchasableItem,
                googleOldProductId = googleOldProductId,
                googleReplacementMode = googleReplacementMode,
                googleIsPersonalizedPrice = googleIsPersonalizedPrice,
                storeReplacementMode = storeReplacementMode,
                presentedOfferingContext = presentedOfferingContext,
                addOnStoreProducts = addOnStoreProducts,
                addOnSubscriptionOptions = addOnSubscriptionOptions,
                addOnPackages = addOnPackages,
            ),
        )
    } else {
        Result.failure(
            PurchasesException(
                PurchasesError(
                    PurchasesErrorCode.PurchaseInvalidError,
                    "Invalid purchase parameters provided: $options",
                ),
            ),
        )
    }
}

@JvmOverloads
@OptIn(ExperimentalPreviewRevenueCatPurchasesAPI::class)
@Suppress("LongParameterList", "LongMethod", "NestedBlockDepth", "CyclomaticComplexMethod")
fun purchaseProduct(
    activity: Activity?,
    productIdentifier: String,
    type: String,
    googleBasePlanId: String?,
    googleOldProductId: String?,
    googleReplacementModeInt: Int?,
    googleIsPersonalizedPrice: Boolean?,
    presentedOfferingContext: Map<String, Any?>?,
    onResult: OnResult,
    addOnStoreProducts: List<Map<String, Any?>>? = null,
    addOnSubscriptionOptions: List<Map<String, Any?>>? = null,
    addOnPackages: List<Map<String, Any?>>? = null,
    storeReplacementModeString: String? = null,
) {
    val storeReplacementMode: StoreReplacementMode? = try {
        getStoreReplacementMode(
            googleReplacementModeInt = googleReplacementModeInt,
            storeReplacementModeString = storeReplacementModeString,
        )
    } catch (e: InvalidReplacementModeException) {
        onResult.onError(
            PurchasesError(
                PurchasesErrorCode.UnknownError,
                "Invalid google replacement mode passed to purchaseProduct.",
            ).map(),
        )
        return
    }

    val productType = mapStringToProductType(type)

    if (activity != null) {
        val onReceiveStoreProducts: (List<StoreProduct>) -> Unit = { storeProducts ->

            val productToBuy = storeProductForProductId(
                productId = productIdentifier,
                type = productType,
                basePlanId = googleBasePlanId,
                storeProducts = storeProducts,
            )

            if (productToBuy != null) {
                val purchaseParams = PurchaseParams.Builder(activity, productToBuy)

                presentedOfferingContext?.toPresentedOfferingContext()?.let {
                    purchaseParams.presentedOfferingContext(it)
                }

                // Product upgrade
                if (googleOldProductId != null && googleOldProductId.isNotBlank()) {
                    purchaseParams.oldProductId(googleOldProductId)
                    if (storeReplacementMode != null) {
                        purchaseParams.replacementMode(storeReplacementMode)
                    }
                }

                // Personalized price
                googleIsPersonalizedPrice?.let {
                    purchaseParams.isPersonalizedPrice(googleIsPersonalizedPrice)
                }

                // Add ons
                createAddOnStoreProducts(
                    rawAddOnStoreProducts = addOnStoreProducts,
                    storeProducts = storeProducts,
                )
                    .takeUnless { it.isNullOrEmpty() }
                    ?.let { typedAddOnStoreProducts ->
                        purchaseParams.addOnStoreProducts(addOnStoreProducts = typedAddOnStoreProducts)
                    }

                createAddOnSubscriptionOptions(
                    rawAddOnSubscriptionOptions = addOnSubscriptionOptions,
                    storeProducts = storeProducts,
                )
                    .takeUnless { it.isNullOrEmpty() }
                    ?.let { typedAddOnSubscriptionOptions ->
                        purchaseParams.addOnSubscriptionOptions(
                            addOnSubscriptionOptions = typedAddOnSubscriptionOptions,
                        )
                    }
                if (addOnPackages.isNullOrEmpty()) {
                    // Perform purchase
                    Purchases.sharedInstance.purchaseWith(
                        purchaseParams.build(),
                        onError = getPurchaseErrorFunction(onResult),
                        onSuccess = getPurchaseCompletedFunction(onResult),
                    )
                } else {
                    // Fetch packages
                    Purchases.sharedInstance.getOfferingsWith(
                        { onResult.onError(it.map()) },
                        { offerings ->
                            val context = presentedOfferingContext?.toPresentedOfferingContext()
                            if (context == null) {
                                onResult.onError(
                                    PurchasesError(
                                        PurchasesErrorCode.PurchaseInvalidError,
                                        "There is no or invalid presented offering context " +
                                            "data provided to make this purchase",
                                    ).map(),
                                )
                                return@getOfferingsWith
                            }

                            try {
                                createAddOnPackages(
                                    rawAddOnPackages = addOnPackages,
                                    offerings = offerings,
                                )
                                    .takeUnless { it.isNullOrEmpty() }
                                    ?.let {
                                        purchaseParams.addOnPackages(addOnPackages = it)
                                    }
                            } catch (e: IllegalArgumentException) {
                                onResult.onError(
                                    PurchasesError(
                                        PurchasesErrorCode.PurchaseInvalidError,
                                        e.localizedMessage,
                                    ).map(),
                                )
                                return@getOfferingsWith
                            }

                            Purchases.sharedInstance.purchaseWith(
                                purchaseParams.build(),
                                onError = getPurchaseErrorFunction(onResult),
                                onSuccess = getPurchaseCompletedFunction(onResult),
                            )
                        },
                    )
                }
            } else {
                onResult.onError(
                    PurchasesError(
                        PurchasesErrorCode.ProductNotAvailableForPurchaseError,
                        "Couldn't find product $productIdentifier",
                    ).map(),
                )
            }
        }
        if (productType == ProductType.SUBS) {
            // The "productIdentifier"
            val baseProductIdWithoutBasePlanId = productIdentifier.split(":").first()
            val addOnProductIdsToFetch = addOnProductIdsToFetch(
                addOnStoreProducts = addOnStoreProducts,
                addOnSubscriptionOptions = addOnSubscriptionOptions,
            )

            val productIdsToFetch = listOf(baseProductIdWithoutBasePlanId) + addOnProductIdsToFetch

            Purchases.sharedInstance.getProductsWith(
                productIdsToFetch,
                ProductType.SUBS,
                { onResult.onError(it.map()) },
                onReceiveStoreProducts,
            )
        } else {
            Purchases.sharedInstance.getProductsWith(
                listOf(productIdentifier),
                ProductType.INAPP,
                { onResult.onError(it.map()) },
                onReceiveStoreProducts,
            )
        }
    } else {
        onResult.onError(
            PurchasesError(
                PurchasesErrorCode.PurchaseInvalidError,
                "There is no current Activity",
            ).map(),
        )
    }
}

@JvmOverloads
@OptIn(ExperimentalPreviewRevenueCatPurchasesAPI::class)
@Suppress("LongMethod", "LongParameterList", "CyclomaticComplexMethod")
fun purchasePackage(
    activity: Activity?,
    packageIdentifier: String,
    presentedOfferingContext: Map<String, Any?>,
    googleOldProductId: String?,
    googleReplacementModeInt: Int?,
    googleIsPersonalizedPrice: Boolean?,
    onResult: OnResult,
    addOnStoreProducts: List<Map<String, Any?>>? = null,
    addOnSubscriptionOptions: List<Map<String, Any?>>? = null,
    addOnPackages: List<Map<String, Any?>>? = null,
    storeReplacementModeString: String? = null,
) {
    val storeReplacementMode: StoreReplacementMode? = try {
        getStoreReplacementMode(
            googleReplacementModeInt = googleReplacementModeInt,
            storeReplacementModeString = storeReplacementModeString,
        )
    } catch (e: InvalidReplacementModeException) {
        onResult.onError(
            PurchasesError(
                PurchasesErrorCode.UnknownError,
                "Invalid google replacement mode passed to purchasePackage.",
            ).map(),
        )
        return
    }

    if (activity != null) {
        Purchases.sharedInstance.getOfferingsWith(
            { onResult.onError(it.map()) },
            { offerings ->
                val context = presentedOfferingContext.toPresentedOfferingContext()
                if (context == null) {
                    onResult.onError(
                        PurchasesError(
                            PurchasesErrorCode.PurchaseInvalidError,
                            "There is no or invalid presented offering context data provided to make this purchase",
                        ).map(),
                    )
                    return@getOfferingsWith
                }

                val packageToBuy =
                    offerings[context.offeringIdentifier]?.availablePackages?.firstOrNull {
                        it.identifier.equals(packageIdentifier, ignoreCase = true)
                    }
                if (packageToBuy != null) {
                    val purchaseParams = PurchaseParams.Builder(activity, packageToBuy)

                    purchaseParams.presentedOfferingContext(context)

                    // Product upgrade
                    if (googleOldProductId != null && googleOldProductId.isNotBlank()) {
                        purchaseParams.oldProductId(googleOldProductId)
                        if (storeReplacementMode != null) {
                            purchaseParams.replacementMode(storeReplacementMode)
                        }
                    }

                    // Personalized price
                    googleIsPersonalizedPrice?.let {
                        purchaseParams.isPersonalizedPrice(googleIsPersonalizedPrice)
                    }

                    // Add ons
                    if (!addOnStoreProducts.isNullOrEmpty() ||
                        !addOnSubscriptionOptions.isNullOrEmpty() ||
                        !addOnPackages.isNullOrEmpty()
                    ) {
                        fetchAddOnStoreProductsAndSubscriptionOptions(
                            addOnStoreProducts = addOnStoreProducts,
                            addOnSubscriptionOptions = addOnSubscriptionOptions,
                            onError = { onResult.onError(it.map()) },
                            onResult = { addOnStoreProducts, addOnSubscriptionOptions ->
                                addOnStoreProducts
                                    .takeUnless { it.isNullOrEmpty() }
                                    ?.let {
                                        purchaseParams.addOnStoreProducts(addOnStoreProducts = it)
                                    }

                                addOnSubscriptionOptions
                                    .takeUnless { it.isNullOrEmpty() }
                                    ?.let {
                                        purchaseParams.addOnSubscriptionOptions(addOnSubscriptionOptions = it)
                                    }

                                try {
                                    createAddOnPackages(
                                        rawAddOnPackages = addOnPackages,
                                        offerings = offerings,
                                    )
                                        .takeUnless { it.isNullOrEmpty() }
                                        ?.let {
                                            purchaseParams.addOnPackages(addOnPackages = it)
                                        }
                                } catch (e: IllegalArgumentException) {
                                    onResult.onError(
                                        PurchasesError(
                                            PurchasesErrorCode.PurchaseInvalidError,
                                            e.message,
                                        ).map(),
                                    )
                                    return@fetchAddOnStoreProductsAndSubscriptionOptions
                                }

                                Purchases.sharedInstance.purchaseWith(
                                    purchaseParams.build(),
                                    onError = getPurchaseErrorFunction(onResult),
                                    onSuccess = getPurchaseCompletedFunction(onResult),
                                )
                            },
                        )
                    } else {
                        // Perform purchase
                        Purchases.sharedInstance.purchaseWith(
                            purchaseParams.build(),
                            onError = getPurchaseErrorFunction(onResult),
                            onSuccess = getPurchaseCompletedFunction(onResult),
                        )
                    }
                } else {
                    onResult.onError(
                        PurchasesError(
                            PurchasesErrorCode.ProductNotAvailableForPurchaseError,
                            "Couldn't find product for package $packageIdentifier",
                        ).map(),
                    )
                }
            },
        )
    } else {
        onResult.onError(
            PurchasesError(
                PurchasesErrorCode.PurchaseInvalidError,
                "There is no current Activity",
            ).map(),
        )
    }
}

@JvmOverloads
@OptIn(ExperimentalPreviewRevenueCatPurchasesAPI::class)
@Suppress("LongParameterList", "LongMethod", "NestedBlockDepth", "CyclomaticComplexMethod")
fun purchaseSubscriptionOption(
    activity: Activity?,
    productIdentifier: String,
    optionIdentifier: String,
    googleOldProductId: String?,
    googleReplacementModeInt: Int?,
    googleIsPersonalizedPrice: Boolean?,
    presentedOfferingContext: Map<String, Any?>?,
    onResult: OnResult,
    addOnStoreProducts: List<Map<String, Any?>>? = null,
    addOnSubscriptionOptions: List<Map<String, Any?>>? = null,
    addOnPackages: List<Map<String, Any?>>? = null,
    storeReplacementModeString: String? = null,
) {
    if (Purchases.sharedInstance.store != Store.PLAY_STORE) {
        onResult.onError(
            PurchasesError(
                PurchasesErrorCode.UnknownError,
                "purchaseSubscriptionOption() is only supported on the Play Store.",
            ).map(),
        )
        return
    }

    val storeReplacementMode: StoreReplacementMode? = try {
        getStoreReplacementMode(
            googleReplacementModeInt = googleReplacementModeInt,
            storeReplacementModeString = storeReplacementModeString,
        )
    } catch (e: InvalidReplacementModeException) {
        onResult.onError(
            PurchasesError(
                PurchasesErrorCode.UnknownError,
                "Invalid google replacement mode passed to purchaseSubscriptionOption.",
            ).map(),
        )
        return
    }

    if (activity != null) {
        val onReceiveStoreProducts: (List<StoreProduct>) -> Unit = { storeProducts ->
            val optionToPurchase = subscriptionOptionForIdentifiers(
                productIdentifier = productIdentifier,
                optionIdentifier = optionIdentifier,
                storeProducts = storeProducts,
            )

            if (optionToPurchase != null) {
                val purchaseParams = PurchaseParams.Builder(activity, optionToPurchase)

                presentedOfferingContext?.toPresentedOfferingContext()?.let {
                    purchaseParams.presentedOfferingContext(it)
                }

                // Product upgrade
                googleOldProductId.takeUnless { it.isNullOrBlank() }?.let {
                    purchaseParams.oldProductId(it)
                    if (storeReplacementMode != null) {
                        purchaseParams.replacementMode(storeReplacementMode)
                    }
                }

                // Personalized price
                googleIsPersonalizedPrice?.let {
                    purchaseParams.isPersonalizedPrice(googleIsPersonalizedPrice)
                }

                // Add ons
                createAddOnStoreProducts(
                    rawAddOnStoreProducts = addOnStoreProducts,
                    storeProducts = storeProducts,
                )
                    .takeUnless { it.isNullOrEmpty() }
                    ?.let { typedAddOnStoreProducts ->
                        purchaseParams.addOnStoreProducts(addOnStoreProducts = typedAddOnStoreProducts)
                    }

                createAddOnSubscriptionOptions(
                    rawAddOnSubscriptionOptions = addOnSubscriptionOptions,
                    storeProducts = storeProducts,
                )
                    .takeUnless { it.isNullOrEmpty() }
                    ?.let { typedAddOnSubscriptionOptions ->
                        purchaseParams.addOnSubscriptionOptions(
                            addOnSubscriptionOptions = typedAddOnSubscriptionOptions,
                        )
                    }

                if (addOnPackages.isNullOrEmpty()) {
                    Purchases.sharedInstance.purchaseWith(
                        purchaseParams.build(),
                        onError = getPurchaseErrorFunction(onResult),
                        onSuccess = getPurchaseCompletedFunction(onResult),
                    )
                } else {
                    Purchases.sharedInstance.getOfferingsWith(
                        { onResult.onError(it.map()) },
                        { offerings ->
                            val context = presentedOfferingContext?.toPresentedOfferingContext()
                            if (context == null) {
                                onResult.onError(
                                    PurchasesError(
                                        PurchasesErrorCode.PurchaseInvalidError,
                                        "There is no or invalid presented offering context " +
                                            "data provided to make this purchase",
                                    ).map(),
                                )
                                return@getOfferingsWith
                            }

                            try {
                                createAddOnPackages(
                                    rawAddOnPackages = addOnPackages,
                                    offerings = offerings,
                                )
                                    .takeUnless { it.isNullOrEmpty() }
                                    ?.let {
                                        purchaseParams.addOnPackages(addOnPackages = it)
                                    }
                            } catch (e: IllegalArgumentException) {
                                onResult.onError(
                                    PurchasesError(
                                        PurchasesErrorCode.PurchaseInvalidError,
                                        e.message,
                                    ).map(),
                                )
                                return@getOfferingsWith
                            }

                            Purchases.sharedInstance.purchaseWith(
                                purchaseParams.build(),
                                onError = getPurchaseErrorFunction(onResult),
                                onSuccess = getPurchaseCompletedFunction(onResult),
                            )
                        },
                    )
                }
            } else {
                onResult.onError(
                    PurchasesError(
                        PurchasesErrorCode.ProductNotAvailableForPurchaseError,
                        "Couldn't find product $productIdentifier:$optionIdentifier",
                    ).map(),
                )
            }
        }

        val addOnProductIdsToFetch = addOnProductIdsToFetch(
            addOnStoreProducts = addOnStoreProducts,
            addOnSubscriptionOptions = addOnSubscriptionOptions,
        )
        val productIdsToFetch = listOf(productIdentifier) + addOnProductIdsToFetch

        Purchases.sharedInstance.getProductsWith(
            productIdsToFetch,
            ProductType.SUBS,
            { onResult.onError(it.map()) },
            onReceiveStoreProducts,
        )
    } else {
        onResult.onError(
            PurchasesError(
                PurchasesErrorCode.PurchaseInvalidError,
                "There is no current Activity",
            ).map(),
        )
    }
}

fun getAppUserID() = Purchases.sharedInstance.appUserID

fun getStorefront(
    callback: (Map<String, Any>?) -> Unit,
) = Purchases.sharedInstance.getStorefrontCountryCodeWith(
    onError = { callback(null) },
    onSuccess = { callback(mapOf("countryCode" to it)) },
)

fun restorePurchases(
    onResult: OnResult,
) {
    Purchases.sharedInstance.restorePurchasesWith(onError = { onResult.onError(it.map()) }) { customerInfo ->
        customerInfo.mapAsync { map -> onResult.onReceived(map) }
    }
}

fun logIn(
    appUserID: String,
    onResult: OnResult,
) {
    Purchases.sharedInstance.logInWith(
        appUserID,
        onError = { onResult.onError(it.map()) },
        onSuccess = { customerInfo, created ->
            customerInfo.mapAsync { map ->
                val resultMap: Map<String, Any?> = mapOf(
                    "customerInfo" to map,
                    "created" to created,
                )

                onResult.onReceived(resultMap)
            }
        },
    )
}

fun logOut(onResult: OnResult) {
    Purchases.sharedInstance.logOutWith(onError = { onResult.onError(it.map()) }) { customerInfo ->
        customerInfo.mapAsync { map -> onResult.onReceived(map) }
    }
}

@Deprecated(message = "Use setLogLevel instead")
fun setDebugLogsEnabled(
    enabled: Boolean,
) {
    Purchases.debugLogsEnabled = enabled
}

fun setLogLevel(level: String) {
    try {
        Purchases.logLevel = LogLevel.valueOf(level)
    } catch (e: IllegalArgumentException) {
        warnLog("Unrecognized log level: $level")
    }
}

/**
 * Sets a log handler and forwards all logs to completion function.
 *
 * @param callback Gets a map with two keys, a `logLevel` which  is one of the ``LogLevel`` name uppercased,
 * and a `message`, with the log message.
 */
fun setLogHandler(callback: (logDetails: Map<String, String>) -> Unit) {
    Purchases.logHandler = LogHandlerWithMapping(callback)
}

/**
 * Sets a log handler and forwards all logs to completion function. Accepts an OnResult so it can be used from
 * SDKs that don't have Kotlin configured, since they would error because Kotlin's Function1 would not be found.
 * Function1 is what Kotlin lambdas are converted to. It has a different name than setLogHandler because naming it
 * the same also gives errors due of missing Function1.
 *
 * @param onResult Gets a map with two keys, a `logLevel` which  is one of the ``LogLevel`` name uppercased,
 * and a `message`, with the log message. The onError of OnResult will never be called.
 */
fun setLogHandlerWithOnResult(onResult: OnResult) {
    setLogHandler { logDetails ->
        onResult.onReceived(logDetails)
    }
}

fun setProxyURLString(proxyURLString: String?) {
    Purchases.proxyURL = if (proxyURLString != null) URL(proxyURLString) else null
}

fun getProxyURLString(): String? {
    return Purchases.proxyURL.toString()
}

fun getCustomerInfo(
    onResult: OnResult,
) {
    Purchases.sharedInstance.getCustomerInfoWith(onError = { onResult.onError(it.map()) }) { customerInfo ->
        customerInfo.mapAsync { map -> onResult.onReceived(map) }
    }
}

fun syncPurchases() {
    Purchases.sharedInstance.syncPurchases()
}

fun syncPurchases(
    onResult: OnResult,
) {
    Purchases.sharedInstance.syncPurchasesWith(onError = { onResult.onError(it.map()) }) { customerInfo ->
        customerInfo.mapAsync { map -> onResult.onReceived(map) }
    }
}

fun isAnonymous(): Boolean {
    return Purchases.sharedInstance.isAnonymous
}

fun setPurchasesAreCompletedBy(
    purchasesAreCompletedBy: String,
) {
    purchasesAreCompletedBy.toPurchasesAreCompletedBy()?.let {
        Purchases.sharedInstance.purchasesAreCompletedBy = it
    }
}

// Returns Unknown for all since it's not available in Android
fun checkTrialOrIntroductoryPriceEligibility(
    productIdentifiers: List<String>,
): Map<String, Map<String, Any>> {
    // INTRO_ELIGIBILITY_STATUS_UNKNOWN = 0
    return productIdentifiers.map {
        it to mapOf("status" to 0, "description" to "Status indeterminate.")
    }.toMap()
}

fun invalidateCustomerInfoCache() {
    Purchases.sharedInstance.invalidateCustomerInfoCache()
}

fun overridePreferredLocale(locale: String?) {
    Purchases.sharedInstance.overridePreferredUILocale(locale)
}

fun canMakePayments(
    context: Context,
    features: List<Int>,
    onResult: OnResultAny<Boolean>,
) {
    val billingFeatures = mutableListOf<BillingFeature>()
    try {
        val billingFeatureEnumValues = BillingFeature.values()
        billingFeatures.addAll(features.map { billingFeatureEnumValues[it] })
    } catch (e: IndexOutOfBoundsException) {
        onResult.onError(
            PurchasesError(
                PurchasesErrorCode.UnknownError,
                "Invalid feature type passed to canMakePayments.",
            ).map(),
        )
        return
    }

    Purchases.canMakePayments(context, billingFeatures) {
        onResult.onReceived(it)
    }
}

fun getAmazonLWAConsentStatus(onResult: OnResultAny<Boolean>) {
    Purchases.sharedInstance.getAmazonLWAConsentStatusWith(onSuccess = {
        onResult.onReceived(
            when (it) {
                AmazonLWAConsentStatus.CONSENTED -> true
                AmazonLWAConsentStatus.UNAVAILABLE -> false
            },
        )
    }, onError = {
        onResult.onError(it.map())
    })
}

@JvmOverloads
fun showInAppMessagesIfNeeded(activity: Activity?, inAppMessageTypes: List<InAppMessageType>? = null) {
    if (activity == null) {
        errorLog("showInAppMessages called with null activity")
        return
    }
    if (inAppMessageTypes == null) {
        Purchases.sharedInstance.showInAppMessagesIfNeeded(activity)
    } else {
        Purchases.sharedInstance.showInAppMessagesIfNeeded(activity, inAppMessageTypes)
    }
}

@OptIn(ExperimentalPreviewRevenueCatPurchasesAPI::class)
@Suppress("LongParameterList")
@JvmOverloads
fun configure(
    context: Context,
    apiKey: String,
    appUserID: String?,
    purchasesAreCompletedBy: String? = null,
    platformInfo: PlatformInfo,
    store: Store = Store.PLAY_STORE,
    dangerousSettings: DangerousSettings = DangerousSettings(autoSyncPurchases = true),
    shouldShowInAppMessagesAutomatically: Boolean? = null,
    verificationMode: String? = null,
    pendingTransactionsForPrepaidPlansEnabled: Boolean? = null,
    diagnosticsEnabled: Boolean? = null,
    automaticDeviceIdentifierCollectionEnabled: Boolean? = null,
    preferredLocale: String? = null,
    galaxyBillingMode: String? = null,
) {
    Purchases.platformInfo = platformInfo

    PurchasesConfiguration.Builder(context, apiKey)
        .appUserID(appUserID)
        .store(store)
        .dangerousSettings(dangerousSettings)
        .apply {
            purchasesAreCompletedBy?.toPurchasesAreCompletedBy()?.let { purchasesAreCompletedBy(it) }
            shouldShowInAppMessagesAutomatically?.let { showInAppMessagesAutomatically(it) }
            verificationMode?.let { verificationMode ->
                try {
                    entitlementVerificationMode(EntitlementVerificationMode.valueOf(verificationMode))
                } catch (e: IllegalArgumentException) {
                    warnLog("Attempted to configure with unknown verification mode: $verificationMode.")
                }
            }
            pendingTransactionsForPrepaidPlansEnabled?.let { pendingTransactionsForPrepaidPlansEnabled(it) }
            diagnosticsEnabled?.let { diagnosticsEnabled(it) }
            automaticDeviceIdentifierCollectionEnabled?.let { automaticDeviceIdentifierCollectionEnabled(it) }
            preferredLocale?.let { preferredUILocaleOverride(it) }
            configureGalaxyBillingModeIfNeeded(store, galaxyBillingMode)
        }.also { Purchases.configure(it.build()) }
}

@OptIn(ExperimentalPreviewRevenueCatPurchasesAPI::class)
private fun PurchasesConfiguration.Builder.configureGalaxyBillingModeIfNeeded(
    store: Store,
    galaxyBillingMode: String?,
) {
    if (store != Store.GALAXY) {
        return
    }

    when (galaxyBillingMode) {
        null, "PRODUCTION" -> galaxyBillingMode(GalaxyBillingMode.PRODUCTION)
        "TEST" -> galaxyBillingMode(GalaxyBillingMode.TEST)
        "ALWAYS_FAIL" -> galaxyBillingMode(GalaxyBillingMode.ALWAYS_FAIL)
        else -> {
            warnLog("Attempted to configure with unknown Galaxy billing mode: $galaxyBillingMode.")
            galaxyBillingMode(GalaxyBillingMode.PRODUCTION)
        }
    }
}

/**
 * Sets a listener for tracked feature events. This is a debug API for monitoring
 * events tracked by RevenueCatUI.
 *
 * @param callback Called when a feature event is tracked, with a map containing event details.
 */
@OptIn(InternalRevenueCatAPI::class)
fun setTrackedEventListener(callback: (Map<String, Any?>) -> Unit) {
    Purchases.sharedInstance.trackedEventListener = TrackedEventListener { event ->
        callback(event.toMap())
    }
}

@OptIn(InternalRevenueCatAPI::class)
fun setDebugEventListener(callback: (Map<String, Any?>) -> Unit) {
    Purchases.sharedInstance.debugEventListener = DebugEventListener { event ->
        callback(event.toMap())
    }
}

fun getPromotionalOffer(): ErrorContainer {
    return ErrorContainer(
        PurchasesErrorCode.UnsupportedError.code,
        "Android platform doesn't support promotional offers",
        emptyMap(),
    )
}

@OptIn(ExperimentalPreviewRevenueCatPurchasesAPI::class)
fun isWebPurchaseRedemptionURL(urlString: String): Boolean {
    return urlString.toWebPurchaseRedemption() != null
}

@OptIn(ExperimentalPreviewRevenueCatPurchasesAPI::class)
fun redeemWebPurchase(
    urlString: String,
    onResult: OnResult,
) {
    val webPurchaseRedemption: WebPurchaseRedemption? = urlString.toWebPurchaseRedemption()
    if (webPurchaseRedemption == null) {
        onResult.onError(
            ErrorContainer(
                PurchasesErrorCode.UnsupportedError.code,
                "Invalid URL for web purchase redemption",
                emptyMap(),
            ),
        )
        return
    }

    Purchases.sharedInstance.redeemWebPurchase(webPurchaseRedemption) { result ->
        when (result) {
            is RedeemWebPurchaseListener.Result.Success -> result.customerInfo.mapAsync { map ->
                onResult.onReceived(
                    mutableMapOf(
                        "result" to result.toResultName(),
                        "customerInfo" to map,
                    ),
                )
            }

            is RedeemWebPurchaseListener.Result.Error -> onResult.onReceived(
                mutableMapOf(
                    "result" to result.toResultName(),
                    "error" to result.error.map().info,
                ),
            )

            is RedeemWebPurchaseListener.Result.Expired -> onResult.onReceived(
                mutableMapOf(
                    "result" to result.toResultName(),
                    "obfuscatedEmail" to result.obfuscatedEmail,
                ),
            )

            RedeemWebPurchaseListener.Result.PurchaseBelongsToOtherUser,
            RedeemWebPurchaseListener.Result.InvalidToken,
            -> onResult.onReceived(
                mutableMapOf(
                    "result" to result.toResultName(),
                ),
            )
        }
    }
}

fun getVirtualCurrencies(
    onResult: OnResult,
) {
    Purchases.sharedInstance.getVirtualCurrenciesWith(
        onError = { error: PurchasesError -> onResult.onError(error.map()) },
        onSuccess = { virtualCurrencies: VirtualCurrencies -> onResult.onReceived(virtualCurrencies.map()) },
    )
}

fun invalidateVirtualCurrenciesCache() {
    Purchases.sharedInstance.invalidateVirtualCurrenciesCache()
}

fun getCachedVirtualCurrencies(): Map<String, Any?>? = Purchases.sharedInstance.cachedVirtualCurrencies?.map()

// region Ad Tracking

@OptIn(ExperimentalPreviewRevenueCatPurchasesAPI::class)
@Suppress("ComplexCondition")
fun trackAdDisplayed(adData: Map<String, Any?>) {
    val networkName = adData["networkName"] as? String
    val mediatorNameString = adData["mediatorName"] as? String
    val adFormatString = adData["adFormat"] as? String
    val adUnitId = adData["adUnitId"] as? String
    val impressionId = adData["impressionId"] as? String

    if (mediatorNameString == null ||
        adFormatString == null ||
        adUnitId == null ||
        impressionId == null
    ) {
        errorLog(
            "trackAdDisplayed: Missing required parameters - " +
                "mediatorName, adFormat, adUnitId, or impressionId",
        )
        return
    }

    val placement = adData["placement"] as? String
    val displayedData = AdDisplayedData(
        networkName = networkName,
        mediatorName = AdMediatorName.fromString(mediatorNameString),
        adFormat = AdFormat.fromString(adFormatString),
        placement = placement,
        adUnitId = adUnitId,
        impressionId = impressionId,
    )

    Purchases.sharedInstance.adTracker.trackAdDisplayed(displayedData)
}

@OptIn(ExperimentalPreviewRevenueCatPurchasesAPI::class)
@Suppress("ComplexCondition")
fun trackAdOpened(adData: Map<String, Any?>) {
    val networkName = adData["networkName"] as? String
    val mediatorNameString = adData["mediatorName"] as? String
    val adFormatString = adData["adFormat"] as? String
    val adUnitId = adData["adUnitId"] as? String
    val impressionId = adData["impressionId"] as? String

    if (mediatorNameString == null ||
        adFormatString == null ||
        adUnitId == null ||
        impressionId == null
    ) {
        errorLog(
            "trackAdOpened: Missing required parameters - " +
                "mediatorName, adFormat, adUnitId, or impressionId",
        )
        return
    }

    val placement = adData["placement"] as? String
    val openedData = AdOpenedData(
        networkName = networkName,
        mediatorName = AdMediatorName.fromString(mediatorNameString),
        adFormat = AdFormat.fromString(adFormatString),
        placement = placement,
        adUnitId = adUnitId,
        impressionId = impressionId,
    )

    Purchases.sharedInstance.adTracker.trackAdOpened(openedData)
}

@OptIn(ExperimentalPreviewRevenueCatPurchasesAPI::class)
@Suppress("ComplexCondition")
fun trackAdRevenue(adData: Map<String, Any?>) {
    val networkName = adData["networkName"] as? String
    val mediatorNameString = adData["mediatorName"] as? String
    val adFormatString = adData["adFormat"] as? String
    val adUnitId = adData["adUnitId"] as? String
    val impressionId = adData["impressionId"] as? String
    val revenueMicros = (adData["revenueMicros"] as? Number)?.toLong()
    val currency = adData["currency"] as? String
    val precisionString = adData["precision"] as? String

    if (mediatorNameString == null ||
        adFormatString == null ||
        adUnitId == null ||
        impressionId == null ||
        revenueMicros == null ||
        currency == null ||
        precisionString == null
    ) {
        errorLog(
            "trackAdRevenue: Missing required parameters - " +
                "mediatorName, adFormat, adUnitId, impressionId, revenueMicros, currency, or precision",
        )
        return
    }

    val placement = adData["placement"] as? String
    val revenueData = AdRevenueData(
        networkName = networkName,
        mediatorName = AdMediatorName.fromString(mediatorNameString),
        adFormat = AdFormat.fromString(adFormatString),
        placement = placement,
        adUnitId = adUnitId,
        impressionId = impressionId,
        revenueMicros = revenueMicros,
        currency = currency,
        precision = AdRevenuePrecision.fromString(precisionString),
    )

    Purchases.sharedInstance.adTracker.trackAdRevenue(revenueData)
}

@OptIn(ExperimentalPreviewRevenueCatPurchasesAPI::class)
@Suppress("ComplexCondition")
fun trackAdLoaded(adData: Map<String, Any?>) {
    val networkName = adData["networkName"] as? String
    val mediatorNameString = adData["mediatorName"] as? String
    val adFormatString = adData["adFormat"] as? String
    val adUnitId = adData["adUnitId"] as? String
    val impressionId = adData["impressionId"] as? String

    if (mediatorNameString == null ||
        adFormatString == null ||
        adUnitId == null ||
        impressionId == null
    ) {
        errorLog(
            "trackAdLoaded: Missing required parameters - " +
                "mediatorName, adFormat, adUnitId, or impressionId",
        )
        return
    }

    val placement = adData["placement"] as? String
    val loadedData = AdLoadedData(
        networkName = networkName,
        mediatorName = AdMediatorName.fromString(mediatorNameString),
        adFormat = AdFormat.fromString(adFormatString),
        placement = placement,
        adUnitId = adUnitId,
        impressionId = impressionId,
    )

    Purchases.sharedInstance.adTracker.trackAdLoaded(loadedData)
}

@OptIn(ExperimentalPreviewRevenueCatPurchasesAPI::class)
@Suppress("ComplexCondition")
fun trackAdFailedToLoad(adData: Map<String, Any?>) {
    val mediatorNameString = adData["mediatorName"] as? String
    val adFormatString = adData["adFormat"] as? String
    val adUnitId = adData["adUnitId"] as? String

    if (mediatorNameString == null ||
        adFormatString == null ||
        adUnitId == null
    ) {
        errorLog(
            "trackAdFailedToLoad: Missing required parameters - " +
                "mediatorName, adFormat, or adUnitId",
        )
        return
    }

    val placement = adData["placement"] as? String
    val mediatorErrorCode = (adData["mediatorErrorCode"] as? Number)?.toInt()
    val failedToLoadData = AdFailedToLoadData(
        mediatorName = AdMediatorName.fromString(mediatorNameString),
        adFormat = AdFormat.fromString(adFormatString),
        placement = placement,
        adUnitId = adUnitId,
        mediatorErrorCode = mediatorErrorCode,
    )

    Purchases.sharedInstance.adTracker.trackAdFailedToLoad(failedToLoadData)
}

// endregion

// region Custom Paywall Tracking

@OptIn(InternalRevenueCatAPI::class)
fun trackCustomPaywallImpression(data: Map<String, Any?>) {
    val paywallId = data["paywallId"] as? String
    val offeringId = data["offeringId"] as? String
    val presentedOfferingContext = castWildcardMapToStringToOptionalAnyMap(
        data["presentedOfferingContext"] as? Map<*, *>,
    )?.toPresentedOfferingContext()
    val params = CustomPaywallImpressionParams(
        paywallId = paywallId,
        offeringId = offeringId,
        presentedOfferingContext = presentedOfferingContext,
    )
    Purchases.sharedInstance.trackCustomPaywallImpression(params)
}

// endregion

// region private functions

private fun storeProductForProductId(
    productId: String,
    type: ProductType,
    basePlanId: String?,
    storeProducts: List<StoreProduct>,
): StoreProduct? {
    return storeProducts.firstOrNull {
        // Comparison for when productIdentifier is "subId:basePlanId"
        val foundByProductIdContainingBasePlan = (it.id == productId && it.type == type)

        // Comparison for when productIdentifier is "subId" and googleBasePlanId is "basePlanId"
        val foundByProductIdAndGoogleBasePlanId = (
            it.purchasingData.productId == productId &&
                it.googleProduct?.basePlanId == basePlanId &&
                it.type == type
            )

        // Finding the matching StoreProduct two different ways:
        // 1) When productIdentifier is "subId:basePlanId" format (for backwards compatibility with hybrids)
        // 2) When productIdentifier is "subId" and googleBasePlanId is "basePlanId"
        foundByProductIdContainingBasePlan || foundByProductIdAndGoogleBasePlanId
    }
}

private fun subscriptionOptionForIdentifiers(
    productIdentifier: String,
    optionIdentifier: String,
    storeProducts: List<StoreProduct>,
): SubscriptionOption? {
    // Iterates over StoreProducts and SubscriptionOptions to find
    // the first matching product id and subscription option id
    return storeProducts.firstNotNullOfOrNull { storeProduct ->
        storeProduct.subscriptionOptions?.firstOrNull { subscriptionOption ->
            storeProduct.purchasingData.productId == productIdentifier &&
                subscriptionOption.id == optionIdentifier
        }
    }
}

private fun createAddOnSubscriptionOptions(
    rawAddOnSubscriptionOptions: List<Map<String, Any?>>?,
    storeProducts: List<StoreProduct>,
): List<SubscriptionOption>? {
    if (!rawAddOnSubscriptionOptions.isNullOrEmpty()) {
        return rawAddOnSubscriptionOptions.mapNotNull { addOnMap ->
            val addOnProductIdentifier = addOnMap["productIdentifier"] as? String ?: return@mapNotNull null
            val addOnOptionIdentifier = addOnMap["optionIdentifier"] as? String ?: return@mapNotNull null

            // We intentionally ignore the presented offering context since the backend only considers
            // presented offering contexts for the base item
            return@mapNotNull subscriptionOptionForIdentifiers(
                productIdentifier = addOnProductIdentifier,
                optionIdentifier = addOnOptionIdentifier,
                storeProducts = storeProducts,
            )
        }
    } else {
        return null
    }
}

@Suppress("ThrowsCount")
@Throws(IllegalArgumentException::class)
private fun createAddOnPackages(
    rawAddOnPackages: List<Map<String, Any?>>?,
    offerings: Offerings,
): List<Package>? {
    if (!rawAddOnPackages.isNullOrEmpty()) {
        return rawAddOnPackages.mapNotNull { addOnMap ->
            val addOnPackageIdentifier = addOnMap["packageIdentifier"] as? String ?: return@mapNotNull null
            val presentedOfferingContext = (addOnMap["presentedOfferingContext"] as? Map<*, *>)
                ?.mapNotNull { (key, value) -> (key as? String)?.let { it to value } }
                ?.toMap()
                ?: throw IllegalArgumentException(
                    "Missing presentedOfferingContext for add-on " +
                        "package $addOnPackageIdentifier",
                )

            val offeringIdentifier = presentedOfferingContext["offeringIdentifier"] as? String
                ?: throw IllegalArgumentException(
                    "Missing offeringIdentifier for add-on " +
                        "package $addOnPackageIdentifier",
                )

            val offering = offerings[offeringIdentifier]
                ?: throw IllegalArgumentException(
                    "Could not find offering with identifier $offeringIdentifier " +
                        "for add-on package $addOnPackageIdentifier",
                )

            try {
                val addOnPackage = offering.getPackage(identifier = addOnPackageIdentifier)
                return@mapNotNull addOnPackage
            } catch (_: NoSuchElementException) {
                throw IllegalArgumentException(
                    "Could not find package with identifier $addOnPackageIdentifier" +
                        " in offering with identifier $offeringIdentifier",
                )
            }
        }
    } else {
        return null
    }
}

private fun createAddOnStoreProducts(
    rawAddOnStoreProducts: List<Map<String, Any?>>?,
    storeProducts: List<StoreProduct>,
): List<StoreProduct>? {
    if (!rawAddOnStoreProducts.isNullOrEmpty()) {
        return rawAddOnStoreProducts.mapNotNull { addOnMap ->
            val addOnProductIdentifier = addOnMap["productIdentifier"] as? String ?: return@mapNotNull null
            val rawType = addOnMap["type"] as? String ?: return@mapNotNull null
            val addOnType = mapStringToProductType(rawType)

            // We intentionally ignore the presented offering context since the backend only considers
            // presented offering contexts for the base item
            return@mapNotNull storeProductForProductId(
                productId = addOnProductIdentifier,
                type = addOnType,
                basePlanId = null,
                storeProducts = storeProducts,
            )
        }
    } else {
        return null
    }
}

@OptIn(ExperimentalPreviewRevenueCatPurchasesAPI::class)
private fun RedeemWebPurchaseListener.Result.toResultName(): String {
    return when (this) {
        is RedeemWebPurchaseListener.Result.Success -> "SUCCESS"
        is RedeemWebPurchaseListener.Result.Error -> "ERROR"
        RedeemWebPurchaseListener.Result.PurchaseBelongsToOtherUser -> "PURCHASE_BELONGS_TO_OTHER_USER"
        RedeemWebPurchaseListener.Result.InvalidToken -> "INVALID_TOKEN"
        is RedeemWebPurchaseListener.Result.Expired -> "EXPIRED"
    }
}

@OptIn(ExperimentalPreviewRevenueCatPurchasesAPI::class)
private fun String.toWebPurchaseRedemption(): WebPurchaseRedemption? {
    try {
        // Replace this with parseAsWebPurchaseRedemption overload
        // accepting strings once it's available.
        val intent = Intent(Intent.ACTION_VIEW, Uri.parse(this))
        return Purchases.parseAsWebPurchaseRedemption(intent)
    } catch (@Suppress("TooGenericExceptionCaught") e: Throwable) {
        errorLog("Error parsing WebPurchaseRedemption from URL: $this. Error: $e")
        return null
    }
}

private fun String.toPurchasesAreCompletedBy(): PurchasesAreCompletedBy? {
    return try {
        enumValueOf<PurchasesAreCompletedBy>(this)
    } catch (e: IllegalArgumentException) {
        null
    }
}

@VisibleForTesting(otherwise = VisibleForTesting.PRIVATE)
internal fun mapStringToProductType(type: String): ProductType {
    MappedProductCategory.values()
        .firstOrNull { it.value.equals(type, ignoreCase = true) }
        ?.let {
            return it.toProductType
        }

    // Maps strings used in deprecated hybrid methods to native ProductType enum
    // "subs" and "inapp" are legacy purchase types used in v4 and below
    return when (type.lowercase()) {
        "subs" -> ProductType.SUBS
        "inapp" -> ProductType.INAPP
        else -> {
            warnLog("Unrecognized product type: $type... Defaulting to INAPP")
            ProductType.INAPP
        }
    }
}

private fun castWildcardMapToStringToOptionalAnyMap(
    wildCardMap: Map<*, *>?,
): Map<String, Any?>? {
    val result = wildCardMap?.let { map ->
        if (map.keys.all { it is String }) {
            map.mapKeys { it.key as String }
        } else {
            null
        }
    }
    return result
}

private fun castWildcardListToListOfStringToAnyMaps(
    wildCardList: List<*>?,
): List<Map<String, Any?>>? {
    val result = wildCardList?.mapNotNull { element ->
        (element as? Map<*, *>)?.let { map ->
            if (map.keys.all { it is String }) {
                map.mapKeys { it.key as String }
            } else {
                null
            }
        }
    }
    return result
}

/**
 * Helper function to fetch products and build the add-on StoreProducts and
 * SubscriptionOptions if needed.
 */
private fun fetchAddOnStoreProductsAndSubscriptionOptions(
    addOnStoreProducts: List<Map<String, Any?>>?,
    addOnSubscriptionOptions: List<Map<String, Any?>>?,
    onError: (error: PurchasesError) -> Unit,
    onResult: (
        addOnStoreProducts: List<StoreProduct>?,
        addOnSubscriptionOptions: List<SubscriptionOption>?,
    ) -> Unit,
) {
    val addOnProductIdsToFetch = addOnProductIdsToFetch(
        addOnStoreProducts = addOnStoreProducts,
        addOnSubscriptionOptions = addOnSubscriptionOptions,
    )

    if (addOnProductIdsToFetch.isNotEmpty()) {
        Purchases.sharedInstance.getProductsWith(
            productIds = addOnProductIdsToFetch,
            type = ProductType.SUBS,
            onError = { onError(it) },
            onGetStoreProducts = { storeProducts ->
                val typedAddOnStoreProducts = createAddOnStoreProducts(
                    rawAddOnStoreProducts = addOnStoreProducts,
                    storeProducts = storeProducts,
                )

                val typedAddOnSubscriptionOptions = createAddOnSubscriptionOptions(
                    rawAddOnSubscriptionOptions = addOnSubscriptionOptions,
                    storeProducts = storeProducts,
                )

                onResult(
                    typedAddOnStoreProducts,
                    typedAddOnSubscriptionOptions,
                )
            },
        )
    } else {
        onResult(null, null)
    }
}

private fun addOnProductIdsToFetch(
    addOnStoreProducts: List<Map<String, Any?>>?,
    addOnSubscriptionOptions: List<Map<String, Any?>>?,
): List<String> {
    val productIdsForAddOnStoreProducts = addOnStoreProducts?.mapNotNull {
        val rawProductId = it["productIdentifier"] as? String ?: return@mapNotNull null
        rawProductId.split(":").first() // Don't include any base plan IDs
    }.orEmpty()
    val productIdsForAddOnSubscriptionOptions = addOnSubscriptionOptions?.mapNotNull {
        val rawProductId = it["productIdentifier"] as? String ?: return@mapNotNull null
        rawProductId.split(":").first() // Don't include any base plan IDs
    }.orEmpty()

    return productIdsForAddOnStoreProducts + productIdsForAddOnSubscriptionOptions
}

@VisibleForTesting(otherwise = VisibleForTesting.PRIVATE)
@Throws(InvalidReplacementModeException::class)
private fun getStoreReplacementMode(
    googleReplacementModeInt: Int?,
    storeReplacementModeString: String?,
): StoreReplacementMode? {
    if (storeReplacementModeString != null && googleReplacementModeInt != null) {
        warnLog(
            "Both a googleReplacementMode and a storeReplacementMode were provided. " +
                "Ignoring the googleReplacementMode and using the storeReplacementMode.",
        )
    }

    val storeReplacementMode = getStoreReplacementMode(storeReplacementModeString = storeReplacementModeString)
    if (storeReplacementMode != null) {
        return storeReplacementMode
    }
    return getStoreReplacementMode(googleReplacementModeInt = googleReplacementModeInt)
}

@VisibleForTesting(otherwise = VisibleForTesting.PRIVATE)
internal class InvalidReplacementModeException : Exception()

@VisibleForTesting(otherwise = VisibleForTesting.PRIVATE)
@Throws(InvalidReplacementModeException::class)
internal fun getGoogleReplacementMode(replacementModeInt: Int?): GoogleReplacementMode? {
    return replacementModeInt
        ?.let {
            GoogleReplacementMode.values().find { replacementMode ->
                replacementMode.playBillingClientMode == it
            } ?: run {
                throw InvalidReplacementModeException()
            }
        }
}

@VisibleForTesting(otherwise = VisibleForTesting.PRIVATE)
@Throws(InvalidReplacementModeException::class)
internal fun getStoreReplacementMode(storeReplacementModeString: String?): StoreReplacementMode? {
    return storeReplacementModeString
        ?.let {
            when (storeReplacementModeString) {
                "WITHOUT_PRORATION" -> StoreReplacementMode.WITHOUT_PRORATION
                "WITH_TIME_PRORATION" -> StoreReplacementMode.WITH_TIME_PRORATION
                "CHARGE_FULL_PRICE" -> StoreReplacementMode.CHARGE_FULL_PRICE
                "CHARGE_PRORATED_PRICE" -> StoreReplacementMode.CHARGE_PRORATED_PRICE
                "DEFERRED" -> StoreReplacementMode.DEFERRED
                else -> throw InvalidReplacementModeException()
            }
        }
}

@VisibleForTesting(otherwise = VisibleForTesting.PRIVATE)
@Throws(InvalidReplacementModeException::class)
internal fun getStoreReplacementMode(googleReplacementModeInt: Int?): StoreReplacementMode? {
    val googleReplacementMode = googleReplacementModeInt
        ?.let {
            GoogleReplacementMode.values().find { replacementMode ->
                replacementMode.playBillingClientMode == it
            } ?: run {
                throw InvalidReplacementModeException()
            }
        }

    if (googleReplacementMode == null) {
        return null
    }
    return when (googleReplacementMode) {
        GoogleReplacementMode.WITHOUT_PRORATION -> StoreReplacementMode.WITHOUT_PRORATION
        GoogleReplacementMode.WITH_TIME_PRORATION -> StoreReplacementMode.WITH_TIME_PRORATION
        GoogleReplacementMode.CHARGE_FULL_PRICE -> StoreReplacementMode.CHARGE_FULL_PRICE
        GoogleReplacementMode.CHARGE_PRORATED_PRICE -> StoreReplacementMode.CHARGE_PRORATED_PRICE
        GoogleReplacementMode.DEFERRED -> StoreReplacementMode.DEFERRED
    }
}

private fun getPurchaseErrorFunction(onResult: OnResult): (PurchasesError, Boolean) -> Unit {
    return { error, userCancelled -> onResult.onError(error.map(mapOf("userCancelled" to userCancelled))) }
}

private fun getPurchaseCompletedFunction(onResult: OnResult): (StoreTransaction?, CustomerInfo) -> Unit {
    return { transaction, customerInfo ->
        transaction?.let {
            customerInfo.mapAsync { map ->
                onResult.onReceived(
                    mapOf(
                        "productIdentifier" to transaction.productIds[0],
                        "customerInfo" to map,
                        "transaction" to transaction.map(),
                    ),
                )
            }
        } ?: run {
            // TODO Figure out how to properly handle a null StoreTransaction (doing this for now
            onResult.onError(
                ErrorContainer(
                    PurchasesErrorCode.UnsupportedError.code,
                    "Error purchasing. Null transaction returned from a successful non-upgrade purchase.",
                    emptyMap(),
                ),
            )
        }
    }
}

data class ErrorContainer(
    val code: Int,
    val message: String,
    val info: Map<String, Any?>,
)

internal fun warnLog(message: String) {
    if (Purchases.logLevel <= LogLevel.WARN) {
        Log.w("PurchasesHybridCommon", message)
    }
}

internal fun errorLog(message: String) {
    if (Purchases.logLevel <= LogLevel.ERROR) {
        Log.e("PurchasesHybridCommon", message)
    }
}

internal fun Map<String, Any?>.toPresentedOfferingContext(): PresentedOfferingContext? {
    val offeringIdentifier = this["offeringIdentifier"] as? String

    return offeringIdentifier?.let {
        val placementIdentifier = this["placementIdentifier"] as? String
        val targetingContext = (this["targetingContext"] as? Map<*, *>)?.let { contextMap ->
            val targetingRevision = convertToInt(contextMap["revision"])
            val targetingRuleId = contextMap["ruleId"] as? String

            if (targetingRevision != null && targetingRuleId != null) {
                PresentedOfferingContext.TargetingContext(targetingRevision, targetingRuleId)
            } else {
                null
            }
        }

        PresentedOfferingContext(it, placementIdentifier, targetingContext)
    } ?: run {
        null
    }
}

internal fun convertToInt(value: Any?): Int? {
    return when (value) {
        is Int -> value
        is Double -> value.toInt()
        else -> null
    }
}

// region Reward verification

@OptIn(ExperimentalPreviewRevenueCatPurchasesAPI::class)
fun generateRewardVerificationToken(impressionId: String): Map<String, Any> {
    return Purchases.sharedInstance.generateRewardVerificationToken(impressionId).map()
}

@JvmOverloads
@OptIn(ExperimentalPreviewRevenueCatPurchasesAPI::class)
@Suppress("ComplexCondition")
fun pollRewardVerification(
    clientTransactionId: String,
    onResult: OnResult,
    trackingMetadata: Map<String, Any?>? = null,
) {
    val metadata = trackingMetadata?.let { data ->
        val mediatorNameString = data["mediatorName"] as? String
        val adFormatString = data["adFormat"] as? String
        val adUnitId = data["adUnitId"] as? String
        val impressionId = data["impressionId"] as? String

        if (mediatorNameString == null ||
            adFormatString == null ||
            adUnitId == null ||
            impressionId == null
        ) {
            errorLog(
                "pollRewardVerification: Missing required trackingMetadata parameters - " +
                    "mediatorName, adFormat, adUnitId, or impressionId",
            )
            null
        } else {
            RewardedAdTrackingMetadata(
                networkName = data["networkName"] as? String,
                mediatorName = AdMediatorName.fromString(mediatorNameString),
                adFormat = AdFormat.fromString(adFormatString),
                placement = data["placement"] as? String,
                adUnitId = adUnitId,
                impressionId = impressionId,
            )
        }
    }

    Purchases.sharedInstance.pollRewardVerification(
        clientTransactionId = clientTransactionId,
        callback = { result -> onResult.onReceived(result.map()) },
        trackingMetadata = metadata,
    )
}

// endregion
