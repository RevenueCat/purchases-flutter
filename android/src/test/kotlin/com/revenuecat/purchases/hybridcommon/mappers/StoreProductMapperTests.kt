package com.revenuecat.purchases.hybridcommon.mappers

import com.revenuecat.purchases.PresentedOfferingContext
import com.revenuecat.purchases.ProductType
import com.revenuecat.purchases.hybridcommon.TestUtilities
import com.revenuecat.purchases.models.OfferPaymentMode
import com.revenuecat.purchases.models.Period
import com.revenuecat.purchases.models.Price
import com.revenuecat.purchases.models.RecurrenceMode
import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test

internal class StoreProductMapperTests {

    val exptectedProductId = "expected_product_identifier"

    @Test
    fun `maps product identifier correctly`() {
        TestUtilities.stubStoreProduct(productId = exptectedProductId).map().let {
            assertThat(it["identifier"]).isEqualTo(exptectedProductId)
        }
    }

    // TODO Fix stubs for all of these tests
    @Test
    fun `maps product description correctly`() {
        val expected = "Expected Description"
        TestUtilities.stubStoreProduct(
            productId = exptectedProductId,
            description = expected,
        ).map().let {
            assertThat(it["description"]).isEqualTo(expected)
        }
    }

    @Test
    fun `maps product title correctly`() {
        val expected = "Expected Title"
        TestUtilities.stubStoreProduct(
            productId = exptectedProductId,
            title = expected,
        ).map().let {
            assertThat(it["title"]).isEqualTo(expected)
        }
    }

    @Test
    fun `maps product price correctly`() {
        val duration = Period(1, Period.Unit.MONTH, "P1M")

        val expected = 2.0
        val expectedFormatted = "$2.00"
        val expectedCurrencyCode = "USD"
        TestUtilities.stubStoreProduct(
            productId = exptectedProductId,
            defaultOption = TestUtilities.stubSubscriptionOption(
                "monthly_base_plan",
                exptectedProductId,
                duration,
                pricingPhases = listOf(
                    TestUtilities.stubPricingPhase(
                        billingPeriod = duration,
                        priceCurrencyCodeValue = expectedCurrencyCode,
                        priceFormatted = expectedFormatted,
                        price = expected,
                    ),
                ),
            ),
        ).map().let {
            assertThat(it["price"]).isEqualTo(expected)
            assertThat(it["priceString"]).isEqualTo(expectedFormatted)
            assertThat(it["currencyCode"]).isEqualTo(expectedCurrencyCode)
        }
    }

    @Test
    fun `maps free introPrice correctly`() {
        val freeTrialDuration = Period(1, Period.Unit.MONTH, "P7D")
        val duration = Period(1, Period.Unit.MONTH, "P1M")

        TestUtilities.stubStoreProduct(
            productId = exptectedProductId,
            defaultOption = TestUtilities.stubSubscriptionOption(
                "monthly_base_plan",
                exptectedProductId,
                duration,
                pricingPhases = listOf(
                    TestUtilities.stubPricingPhase(
                        billingPeriod = freeTrialDuration,
                        priceFormatted = "$0.00",
                        price = 0.0,
                    ),
                    TestUtilities.stubPricingPhase(
                        billingPeriod = duration,
                    ),
                ),
            ),
        ).map().let {
            @Suppress("UNCHECKED_CAST")
            val introPriceMap: Map<String, Any> = it["introPrice"] as Map<String, Any>
            assertThat(introPriceMap["period"]).isNotNull
        }
        // Testing for the intro price mapping is performed in StoreProductIntroPriceMapperTest
    }

    @Test
    fun `maps null introPrice correctly`() {
        TestUtilities.stubStoreProduct(
            productId = exptectedProductId,
            defaultOption = TestUtilities.stubSubscriptionOption(
                "monthly_base_plan",
                exptectedProductId,
            ),
        ).map().let {
            assertThat(it["introPrice"]).isNull()
        }
    }

    @Test
    fun `maps null discounts correctly`() {
        TestUtilities.stubStoreProduct(
            productId = exptectedProductId,
            defaultOption = TestUtilities.stubSubscriptionOption(
                "monthly_base_plan",
                exptectedProductId,
            ),
        ).map().let {
            assertThat(it["discounts"]).isNull()
        }
    }

    @Test
    fun `maps product category correctly`() {
        TestUtilities.stubStoreProduct(
            productId = exptectedProductId,
            type = ProductType.SUBS,
        ).map().let {
            assertThat(it["productCategory"]).isEqualTo("SUBSCRIPTION")
        }
        TestUtilities.stubStoreProduct(
            productId = exptectedProductId,
            type = ProductType.INAPP,
        ).map().let {
            assertThat(it["productCategory"]).isEqualTo("NON_SUBSCRIPTION")
        }
        TestUtilities.stubStoreProduct(
            productId = exptectedProductId,
            type = ProductType.UNKNOWN,
        ).map().let {
            assertThat(it["productCategory"]).isEqualTo("UNKNOWN")
        }
    }

    @Test
    fun `maps product type correctly`() {
        val duration = Period(1, Period.Unit.MONTH, "P1M")

        TestUtilities.stubStoreProduct(
            productId = exptectedProductId,
            type = ProductType.SUBS,
        ).map().let {
            assertThat(it["productType"]).isEqualTo("AUTO_RENEWABLE_SUBSCRIPTION")

            val defaultOption = it["defaultOption"] as Map<String, Any>
            assertThat(defaultOption["isPrepaid"]).isEqualTo(false)
        }
        TestUtilities.stubStoreProduct(
            productId = exptectedProductId,
            type = ProductType.SUBS,
            defaultOption = TestUtilities.stubSubscriptionOption(
                "monthly_base_plan",
                exptectedProductId,
                duration,
                pricingPhases = listOf(
                    TestUtilities.stubPricingPhase(
                        billingPeriod = duration,
                        recurrenceMode = RecurrenceMode.NON_RECURRING,
                    ),
                ),
            ),
        ).map().let {
            assertThat(it["productType"]).isEqualTo("PREPAID_SUBSCRIPTION")

            val defaultOption = it["defaultOption"] as Map<String, Any>
            assertThat(defaultOption["isPrepaid"]).isEqualTo(true)
        }
        TestUtilities.stubStoreProduct(
            productId = exptectedProductId,
            type = ProductType.INAPP,
        ).map().let {
            assertThat(it["productType"]).isEqualTo("CONSUMABLE")

            val defaultOption = it["defaultOption"] as Map<String, Any>
            assertThat(defaultOption["isPrepaid"]).isEqualTo(false)
        }
        TestUtilities.stubStoreProduct(
            productId = exptectedProductId,
            type = ProductType.UNKNOWN,
        ).map().let {
            assertThat(it["productType"]).isEqualTo("UNKNOWN")

            val defaultOption = it["defaultOption"] as Map<String, Any>
            assertThat(defaultOption["isPrepaid"]).isEqualTo(false)
        }
    }

    @Test
    fun `maps subscription period correctly`() {
        TestUtilities.stubStoreProduct(
            productId = exptectedProductId,
            type = ProductType.INAPP,
            defaultOption = null,
            subscriptionOptions = emptyList(),
            price = Price("$1.99", 19900000, "USD"),
        ).map().let {
            assertThat(it["subscriptionPeriod"]).isNull()
        }
        TestUtilities.stubStoreProduct(
            productId = exptectedProductId,
            defaultOption = TestUtilities.stubSubscriptionOption(
                "monthly_base_plan",
                exptectedProductId,
                Period(1, Period.Unit.MONTH, "P1M"),
            ),
        ).map().let {
            assertThat(it["subscriptionPeriod"]).isEqualTo("P1M")
        }
        TestUtilities.stubStoreProduct(
            productId = exptectedProductId,
            defaultOption = TestUtilities.stubSubscriptionOption(
                "monthly_base_plan",
                exptectedProductId,
                Period(1, Period.Unit.MONTH, "P1Y"),
            ),
        ).map().let {
            assertThat(it["subscriptionPeriod"]).isEqualTo("P1Y")
        }
    }

    @Test
    fun `map has correct size`() {
        TestUtilities.stubStoreProduct("monthly_product").map().let {
            assertThat(it.size).isEqualTo(21)
        }
    }

    @Test
    fun `map has default option as base plan`() {
        TestUtilities.stubStoreProduct(
            productId = exptectedProductId,
            defaultOption = TestUtilities.stubSubscriptionOption(
                "monthly_base_plan",
                exptectedProductId,
            ),
        ).map().let {
            val defaultOption = it["defaultOption"] as Map<String, Any?>
            testBasePlanOption(defaultOption)
        }
    }

    @Test
    fun `map has default option with free trial and intro trial`() {
        val freeTrialDuration = Period(7, Period.Unit.DAY, "P7D")
        val introTrialDuration = Period(1, Period.Unit.MONTH, "P1M")
        val duration = Period(1, Period.Unit.MONTH, "P1M")

        val basePlan = TestUtilities.stubSubscriptionOption(
            "monthly_base_plan",
            exptectedProductId,
            duration,
            pricingPhases = listOf(
                TestUtilities.stubPricingPhase(
                    billingPeriod = duration,
                ),
            ),
        )
        val multiPricingPhaseOption = TestUtilities.stubSubscriptionOption(
            "monthly_base_plan",
            exptectedProductId,
            duration,
            pricingPhases = listOf(
                TestUtilities.stubPricingPhase(
                    billingPeriod = freeTrialDuration,
                    priceFormatted = "$0.00",
                    price = 0.0,
                    recurrenceMode = RecurrenceMode.FINITE_RECURRING,
                    billingCycleCount = 1,
                ),
                TestUtilities.stubPricingPhase(
                    billingPeriod = introTrialDuration,
                    priceFormatted = "$2.99",
                    price = 2.99,
                    recurrenceMode = RecurrenceMode.FINITE_RECURRING,
                    billingCycleCount = 1,
                ),
                TestUtilities.stubPricingPhase(
                    billingPeriod = duration,
                ),
            ),
        )

        TestUtilities.stubStoreProduct(
            productId = exptectedProductId,
            defaultOption = multiPricingPhaseOption,
            subscriptionOptions = listOf(basePlan, multiPricingPhaseOption),
        ).map().let {
            val defaultOption = it["defaultOption"] as Map<String, Any?>
            testMultiPhaseOption(defaultOption)

            val subscriptionOptions = it["subscriptionOptions"] as List<Map<String, Any?>>
            testBasePlanOption(subscriptionOptions[0])
            testMultiPhaseOption(subscriptionOptions[1])
        }
    }

    @Test
    fun `map presentedOfferingIdentifier correctly when null`() {
        TestUtilities.stubStoreProduct(
            productId = exptectedProductId,
            presentedOfferingContext = null,
        ).map().let {
            assertThat(it["presentedOfferingIdentifier"]).isNull()
        }
    }

    @Test
    fun `map presentedOfferingIdentifier correctly when not null`() {
        val expectedPresentedOfferingContext = PresentedOfferingContext("mainoffer")

        TestUtilities.stubStoreProduct(
            productId = exptectedProductId,
            presentedOfferingContext = expectedPresentedOfferingContext,
        ).map().let {
            assertThat(it["presentedOfferingIdentifier"]).isEqualTo(expectedPresentedOfferingContext.offeringIdentifier)
        }
    }

    @Test
    fun `OfferPaymentMode maps to correct string value`() {
        assertThat(OfferPaymentMode.FREE_TRIAL.toString()).isEqualTo("FREE_TRIAL")
        assertThat(OfferPaymentMode.SINGLE_PAYMENT.toString()).isEqualTo("SINGLE_PAYMENT")
        assertThat(OfferPaymentMode.DISCOUNTED_RECURRING_PAYMENT.toString()).isEqualTo("DISCOUNTED_RECURRING_PAYMENT")
    }

    private fun testBasePlanOption(option: Map<String, Any?>) {
        val billingPeriod = mapOf(
            "unit" to "MONTH",
            "value" to 1,
            "iso8601" to "P1M",
        )

        assertThat(option).isNotNull
        assertThat(option["tags"]).isEqualTo(listOf("tag"))
        assertThat(option["isBasePlan"]).isEqualTo(true)

        assertThat(option["billingPeriod"]).isEqualTo(billingPeriod)
        assertThat(option["fullPricePhase"]).isEqualTo(
            mapOf(
                "billingPeriod" to billingPeriod,
                "recurrenceMode" to 1,
                "billingCycleCount" to 0,
                "price" to mapOf(
                    "formatted" to "$4.99",
                    "amountMicros" to (4.99 * TestUtilities.MICROS_MULTIPLIER).toLong(),
                    "currencyCode" to "USD",
                ),
                "offerPaymentMode" to null,
            ),
        )
        assertThat(option["freePhase"]).isNull()
        assertThat(option["introPhase"]).isNull()
    }

    @Suppress("LongMethod")
    private fun testMultiPhaseOption(option: Map<String, Any?>) {
        val billingPeriod = mapOf(
            "unit" to "MONTH",
            "value" to 1,
            "iso8601" to "P1M",
        )
        val freeBillingPeriod = mapOf(
            "unit" to "DAY",
            "value" to 7,
            "iso8601" to "P7D",
        )
        val introBillingPeriod = mapOf(
            "unit" to "MONTH",
            "value" to 1,
            "iso8601" to "P1M",
        )

        assertThat(option).isNotNull
        assertThat(option["tags"]).isEqualTo(listOf("tag"))
        assertThat(option["isBasePlan"]).isEqualTo(false)

        assertThat(option["billingPeriod"]).isEqualTo(billingPeriod)
        assertThat(option["fullPricePhase"]).isEqualTo(
            mapOf(
                "billingPeriod" to billingPeriod,
                "recurrenceMode" to 1,
                "billingCycleCount" to 0,
                "price" to mapOf(
                    "formatted" to "$4.99",
                    "amountMicros" to (4.99 * TestUtilities.MICROS_MULTIPLIER).toLong(),
                    "currencyCode" to "USD",
                ),
                "offerPaymentMode" to null,
            ),
        )
        assertThat(option["freePhase"]).isEqualTo(
            mapOf(
                "billingPeriod" to freeBillingPeriod,
                "recurrenceMode" to 2,
                "billingCycleCount" to 1,
                "price" to mapOf(
                    "formatted" to "$0.00",
                    "amountMicros" to 0L,
                    "currencyCode" to "USD",
                ),
                "offerPaymentMode" to "FREE_TRIAL",
            ),
        )
        assertThat(option["introPhase"]).isEqualTo(
            mapOf(
                "billingPeriod" to introBillingPeriod,
                "recurrenceMode" to 2,
                "billingCycleCount" to 1,
                "price" to mapOf(
                    "formatted" to "$2.99",
                    "amountMicros" to (2.99 * TestUtilities.MICROS_MULTIPLIER).toLong(),
                    "currencyCode" to "USD",
                ),
                "offerPaymentMode" to "SINGLE_PAYMENT",
            ),
        )
    }
}
