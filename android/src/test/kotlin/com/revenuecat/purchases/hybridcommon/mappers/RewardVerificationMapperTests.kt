package com.revenuecat.purchases.hybridcommon.mappers

import com.revenuecat.purchases.ExperimentalPreviewRevenueCatPurchasesAPI
import com.revenuecat.purchases.InternalRevenueCatAPI
import com.revenuecat.purchases.ads.rewardverification.RewardVerificationResult
import com.revenuecat.purchases.ads.rewardverification.RewardVerificationToken
import com.revenuecat.purchases.ads.rewardverification.VerifiedReward
import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test
import java.util.Date

@OptIn(ExperimentalPreviewRevenueCatPurchasesAPI::class)
class RewardVerificationMapperTests {

    @Test
    fun `RewardVerificationToken maps to expected map`() {
        val token = RewardVerificationToken(
            customData = "custom-data",
            clientTransactionId = "client-transaction-id",
            appUserID = "app-user-id",
        )

        val map = token.map()

        assertThat(map.size).isEqualTo(3)
        assertThat(map["customData"]).isEqualTo("custom-data")
        assertThat(map["clientTransactionId"]).isEqualTo("client-transaction-id")
        assertThat(map["appUserID"]).isEqualTo("app-user-id")
    }

    @Test
    fun `failed RewardVerificationResult maps to expected map`() {
        val map = RewardVerificationResult.failed.map()

        assertThat(map.size).isEqualTo(2)
        assertThat(map["failed"]).isEqualTo(true)
        assertThat(map["moreRewards"]).isEqualTo(emptyList<Map<String, Any>>())
    }

    @OptIn(InternalRevenueCatAPI::class)
    @Test
    fun `verified RewardVerificationResult maps to expected map`() {
        val reward = VerifiedReward.VirtualCurrency(code = "GLD", amount = 100)
        val moreReward = VerifiedReward.NoReward
        val result = RewardVerificationResult.verified(reward = reward, moreRewards = listOf(moreReward))

        val map = result.map()

        assertThat(map.size).isEqualTo(3)
        assertThat(map["failed"]).isEqualTo(false)
        assertThat(map["reward"]).isEqualTo(reward.map())
        assertThat(map["moreRewards"]).isEqualTo(listOf(moreReward.map()))
    }

    @Test
    fun `VirtualCurrency reward maps to expected map`() {
        val reward = VerifiedReward.VirtualCurrency(code = "GLD", amount = 100)

        val map = reward.map()

        assertThat(map.size).isEqualTo(3)
        assertThat(map["type"]).isEqualTo("virtual_currency")
        assertThat(map["code"]).isEqualTo("GLD")
        assertThat(map["amount"]).isEqualTo(100)
    }

    @Test
    fun `Entitlement reward maps to expected map`() {
        val expiresAt = Date()
        val reward = VerifiedReward.Entitlement(identifier = "premium", expiresAt = expiresAt)

        val map = reward.map()

        assertThat(map.size).isEqualTo(4)
        assertThat(map["type"]).isEqualTo("entitlement")
        assertThat(map["identifier"]).isEqualTo("premium")
        assertThat(map["expiresAt"]).isEqualTo(expiresAt.toIso8601())
        assertThat(map["expiresAtMillis"]).isEqualTo(expiresAt.toMillis())
    }

    @Test
    fun `NoReward maps to expected map`() {
        val map = VerifiedReward.NoReward.map()

        assertThat(map.size).isEqualTo(1)
        assertThat(map["type"]).isEqualTo("no_reward")
    }

    @Test
    fun `UnsupportedReward maps to expected map`() {
        val map = VerifiedReward.UnsupportedReward.map()

        assertThat(map.size).isEqualTo(1)
        assertThat(map["type"]).isEqualTo("unsupported_reward")
    }
}
