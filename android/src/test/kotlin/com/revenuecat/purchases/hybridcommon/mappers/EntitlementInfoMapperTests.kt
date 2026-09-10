package com.revenuecat.purchases.hybridcommon.mappers

import com.revenuecat.purchases.EntitlementInfo
import com.revenuecat.purchases.OwnershipType
import com.revenuecat.purchases.PeriodType
import com.revenuecat.purchases.Store
import com.revenuecat.purchases.VerificationResult
import org.assertj.core.api.Assertions.assertThat
import org.json.JSONObject
import org.junit.jupiter.api.Test
import java.time.Instant
import java.util.Date

class EntitlementInfoMapperTests {

    private val storeDictionaryKey = "store"

    @Test
    fun `EntitlementInfo maps to expected map`() {
        val mockEntitlementInfo = generateMockEntitlementInfo(store = Store.PLAY_STORE)
        val resultMap = mockEntitlementInfo.map()
        assertThat(resultMap.size).isEqualTo(20)
        assertThat(resultMap["identifier"]).isEqualTo("entitlement_id")
        assertThat(resultMap["isActive"]).isEqualTo(true)
        assertThat(resultMap["willRenew"]).isEqualTo(true)
        assertThat(resultMap["periodType"]).isEqualTo("NORMAL")
        assertThat(resultMap["latestPurchaseDateMillis"]).isEqualTo(mockEntitlementInfo.latestPurchaseDate.toMillis())
        assertThat(resultMap["latestPurchaseDate"]).isEqualTo(mockEntitlementInfo.latestPurchaseDate.toIso8601())
        assertThat(resultMap["originalPurchaseDateMillis"]).isEqualTo(
            mockEntitlementInfo.originalPurchaseDate.toMillis(),
        )
        assertThat(resultMap["originalPurchaseDate"]).isEqualTo(mockEntitlementInfo.originalPurchaseDate.toIso8601())
        assertThat(resultMap["expirationDateMillis"]).isEqualTo(mockEntitlementInfo.expirationDate?.toMillis())
        assertThat(resultMap["expirationDate"]).isEqualTo(mockEntitlementInfo.expirationDate?.toIso8601())
        assertThat(resultMap[storeDictionaryKey]).isEqualTo("PLAY_STORE")
        assertThat(resultMap["productIdentifier"]).isEqualTo("product_id")
        assertThat(resultMap["productPlanIdentifier"]).isEqualTo("test_plan_identifier")
        assertThat(resultMap["isSandbox"]).isEqualTo(false)
        assertThat(resultMap["unsubscribeDetectedAt"]).isNull()
        assertThat(resultMap["unsubscribeDetectedAtMillis"]).isNull()
        assertThat(resultMap["billingIssueDetectedAt"]).isNull()
        assertThat(resultMap["billingIssueDetectedAtMillis"]).isNull()
        assertThat(resultMap["ownershipType"]).isEqualTo("PURCHASED")
        assertThat(resultMap["verification"]).isEqualTo("VERIFIED")
    }

    @Test
    fun `EntitlementInfo Store is correctly added to the dictionary`() {
        val expectations = arrayOf(
            Pair(Store.APP_STORE, "APP_STORE"),
            Pair(Store.MAC_APP_STORE, "MAC_APP_STORE"),
            Pair(Store.PLAY_STORE, "PLAY_STORE"),
            Pair(Store.STRIPE, "STRIPE"),
            Pair(Store.PROMOTIONAL, "PROMOTIONAL"),
            Pair(Store.UNKNOWN_STORE, "UNKNOWN_STORE"),
            Pair(Store.AMAZON, "AMAZON"),
            Pair(Store.RC_BILLING, "RC_BILLING"),
            Pair(Store.EXTERNAL, "EXTERNAL"),
            Pair(Store.PADDLE, "PADDLE"),
            Pair(Store.TEST_STORE, "TEST_STORE"),
            Pair(Store.GALAXY, "GALAXY"),
        )

        for (expectation in expectations) {
            val (store, expectedDictionaryValue) = expectation
            val dictionary = generateMockEntitlementInfo(store = store).map()

            assertThat(dictionary[storeDictionaryKey])
                .`as`(
                    "Expected the dictionary's \"store\" value to equal \"$expectedDictionaryValue\" " +
                        "for the store value $store, but instead found \"${dictionary[storeDictionaryKey]}\".",
                )
                .isEqualTo(expectedDictionaryValue)
        }
    }

    private fun generateMockEntitlementInfo(store: Store): EntitlementInfo {
        val purchaseDate = Date.from(Instant.EPOCH)

        return EntitlementInfo(
            identifier = "entitlement_id",
            isActive = true,
            willRenew = true,
            periodType = PeriodType.NORMAL,
            latestPurchaseDate = purchaseDate,
            originalPurchaseDate = purchaseDate,
            expirationDate = Date.from(Instant.ofEpochSecond(253370768400)), // Jan 1, 9999 @ 00:00:00UTC
            store = store,
            productIdentifier = "product_id",
            productPlanIdentifier = "test_plan_identifier",
            isSandbox = false,
            unsubscribeDetectedAt = null,
            billingIssueDetectedAt = null,
            ownershipType = OwnershipType.PURCHASED,
            jsonObject = JSONObject(),
            verification = VerificationResult.VERIFIED,
        )
    }
}
