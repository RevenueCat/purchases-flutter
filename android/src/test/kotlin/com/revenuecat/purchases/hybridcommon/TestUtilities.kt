package com.revenuecat.purchases.hybridcommon

import com.revenuecat.purchases.Offering
import com.revenuecat.purchases.Offerings
import com.revenuecat.purchases.Package
import com.revenuecat.purchases.PackageType
import com.revenuecat.purchases.PresentedOfferingContext
import com.revenuecat.purchases.ProductType
import com.revenuecat.purchases.models.InstallmentsInfo
import com.revenuecat.purchases.models.Period
import com.revenuecat.purchases.models.Price
import com.revenuecat.purchases.models.PricingPhase
import com.revenuecat.purchases.models.PurchaseType
import com.revenuecat.purchases.models.PurchasingData
import com.revenuecat.purchases.models.RecurrenceMode
import com.revenuecat.purchases.models.StoreProduct
import com.revenuecat.purchases.models.StoreTransaction
import com.revenuecat.purchases.models.SubscriptionOption
import com.revenuecat.purchases.models.SubscriptionOptions
import io.mockk.every
import io.mockk.mockk
import org.json.JSONObject

/**
 * Shared test utilities for creating mock objects and test data
 */
internal object TestUtilities {

    const val MICROS_MULTIPLIER = 1_000_000

    fun getOfferings(
        mockStoreProduct: StoreProduct,
        metadata: Map<String, Any> = emptyMap(),
        packageIdentifier: String = "packageIdentifier",
    ): Triple<String, Package, Offerings> {
        val offeringIdentifier = "offering"
        val packageToPurchase = Package(
            identifier = packageIdentifier,
            packageType = PackageType.ANNUAL,
            product = mockStoreProduct,
            presentedOfferingContext = PresentedOfferingContext(offeringIdentifier),
        )
        val mockOffering = mockk<Offering>(relaxed = true)
        every { mockOffering.identifier } returns offeringIdentifier
        every { mockOffering.availablePackages } returns listOf(packageToPurchase)
        every { mockOffering.metadata } returns metadata
        val mockOfferings = mockk<Offerings>(relaxed = true)
        every { mockOfferings[offeringIdentifier] } returns mockOffering
        return Triple(offeringIdentifier, packageToPurchase, mockOfferings)
    }

    @SuppressWarnings("EmptyFunctionBlock", "LongParameterList")
    fun stubStoreProduct(
        productId: String,
        description: String = "",
        title: String = "",
        name: String = "",
        type: ProductType = ProductType.SUBS,
        defaultOption: SubscriptionOption? = stubSubscriptionOption(
            "monthly_base_plan",
            productId,
            Period(1, Period.Unit.MONTH, "P1M"),
        ),
        subscriptionOptions: List<SubscriptionOption>? = defaultOption?.let { listOf(defaultOption) } ?: emptyList(),
        price: Price = subscriptionOptions?.firstOrNull()?.fullPricePhase!!.price,
        presentedOfferingContext: PresentedOfferingContext? = null,
        purchasingDataProductId: String? = null,
    ): StoreProduct = object : StoreProduct {
        override val id: String
            get() = productId
        override val type: ProductType
            get() = type
        override val price: Price
            get() = price
        override val title: String
            get() = title
        override val name: String
            get() = name
        override val description: String
            get() = description
        override val period: Period?
            get() = subscriptionOptions?.firstOrNull { it.isBasePlan }?.pricingPhases?.get(0)?.billingPeriod
        override val presentedOfferingContext: PresentedOfferingContext?
            get() = presentedOfferingContext
        override val presentedOfferingIdentifier: String?
            get() = presentedOfferingContext?.offeringIdentifier
        override val subscriptionOptions: SubscriptionOptions?
            get() = subscriptionOptions?.let { SubscriptionOptions(it) }
        override val defaultOption: SubscriptionOption?
            get() = defaultOption
        override val purchasingData: PurchasingData
            get() = StubPurchasingData(
                productId = purchasingDataProductId ?: productId.split(":").first(),
            )
        override val sku: String
            get() = productId
        override fun copyWithOfferingId(offeringId: String): StoreProduct {
            return copyWithPresentedOfferingContext(PresentedOfferingContext(offeringId))
        }
        override fun copyWithPresentedOfferingContext(
            presentedOfferingContext: PresentedOfferingContext?,
        ): StoreProduct {
            fun SubscriptionOption.applyOfferingContext(
                presentedOfferingContext: PresentedOfferingContext?,
            ): SubscriptionOption {
                return stubSubscriptionOption(
                    id,
                    productId,
                    presentedOfferingContext = presentedOfferingContext,
                )
            }

            return stubStoreProduct(
                productId,
                description,
                title,
                name,
                type,
                defaultOption?.let {
                    it.applyOfferingContext(presentedOfferingContext)
                },
                subscriptionOptions?.map {
                    it.applyOfferingContext(presentedOfferingContext)
                },
                price,
                presentedOfferingContext,
                purchasingDataProductId ?: productId.split(":").first(),
            )
        }
    }

    @SuppressWarnings("EmptyFunctionBlock")
    fun stubSubscriptionOption(
        id: String,
        productId: String,
        duration: Period = Period(1, Period.Unit.MONTH, "P1M"),
        pricingPhases: List<PricingPhase> = listOf(stubPricingPhase(billingPeriod = duration)),
        presentedOfferingContext: PresentedOfferingContext? = null,
    ): SubscriptionOption = object : SubscriptionOption {
        override val id: String
            get() = id
        override val presentedOfferingContext: PresentedOfferingContext?
            get() = presentedOfferingContext
        override val presentedOfferingIdentifier: String?
            get() = presentedOfferingContext?.offeringIdentifier
        override val pricingPhases: List<PricingPhase>
            get() = pricingPhases
        override val tags: List<String>
            get() = listOf("tag")
        override val purchasingData: PurchasingData
            get() = StubPurchasingData(
                productId = productId,
            )
        override val installmentsInfo: InstallmentsInfo?
            get() = null
    }

    @Suppress("LongParameterList")
    fun createMockTransaction(
        productIdentifier: String,
        transactionIdentifier: String = "1",
        purchaseDate: Long = 1000,
        purchaseType: PurchaseType = PurchaseType.GOOGLE_PURCHASE,
        purchaseToken: String = "google_purchase_token",
        signature: String? = "google_signature",
        originalJson: String = """{"orderId":"order_id"}""",
    ): StoreTransaction {
        val mockTransaction = mockk<StoreTransaction>()
        val mockOriginalJson = mockk<JSONObject>()
        every { mockOriginalJson.toString() } returns originalJson
        every {
            mockTransaction.productIds
        } returns ArrayList(listOf(productIdentifier, "other"))
        every {
            mockTransaction.orderId
        } returns transactionIdentifier
        every {
            mockTransaction.purchaseTime
        } returns purchaseDate
        every {
            mockTransaction.purchaseType
        } returns purchaseType
        every {
            mockTransaction.purchaseToken
        } returns purchaseToken
        every {
            mockTransaction.signature
        } returns signature
        every {
            mockTransaction.originalJson
        } returns mockOriginalJson

        return mockTransaction
    }

    fun createMockAmazonTransaction(
        productIdentifier: String,
        receiptId: String = "amazon_receipt_id",
        purchaseDate: Long = 1000,
        signature: String? = null,
        originalJson: String = """{"receiptId":"amazon_receipt_id"}""",
    ): StoreTransaction {
        val mockTransaction = mockk<StoreTransaction>()
        val mockOriginalJson = mockk<JSONObject>()
        every { mockOriginalJson.toString() } returns originalJson
        every {
            mockTransaction.productIds
        } returns ArrayList(listOf(productIdentifier, "other"))
        every {
            mockTransaction.orderId
        } returns null
        every {
            mockTransaction.purchaseTime
        } returns purchaseDate
        every {
            mockTransaction.purchaseType
        } returns PurchaseType.AMAZON_PURCHASE
        every {
            mockTransaction.purchaseToken
        } returns receiptId
        every {
            mockTransaction.signature
        } returns signature
        every {
            mockTransaction.originalJson
        } returns mockOriginalJson

        return mockTransaction
    }

    @SuppressWarnings("MatchingDeclarationName")
    private data class StubPurchasingData(
        override val productId: String,
    ) : PurchasingData {
        override val productType: ProductType
            get() = ProductType.SUBS
    }

    @Suppress("LongParameterList")
    fun stubPricingPhase(
        billingPeriod: Period = Period(1, Period.Unit.MONTH, "P1M"),
        priceCurrencyCodeValue: String = "USD",
        priceFormatted: String = "$4.99",
        price: Double = 4.99,
        recurrenceMode: RecurrenceMode = RecurrenceMode.INFINITE_RECURRING,
        billingCycleCount: Int = 0,
    ): PricingPhase = PricingPhase(
        billingPeriod,
        recurrenceMode,
        billingCycleCount,
        Price(
            priceFormatted,
            price.times(MICROS_MULTIPLIER).toLong(),
            priceCurrencyCodeValue,
        ),
    )
}
