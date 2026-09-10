package com.revenuecat.purchases.hybridcommon.mappers

import com.revenuecat.purchases.ExperimentalPreviewRevenueCatPurchasesAPI
import com.revenuecat.purchases.ads.rewardverification.RewardVerificationResult
import com.revenuecat.purchases.ads.rewardverification.RewardVerificationToken
import com.revenuecat.purchases.ads.rewardverification.VerifiedReward

@OptIn(ExperimentalPreviewRevenueCatPurchasesAPI::class)
fun RewardVerificationToken.map(): Map<String, Any> = mapOf(
    "customData" to customData,
    "clientTransactionId" to clientTransactionId,
    "appUserID" to appUserID,
)

@OptIn(ExperimentalPreviewRevenueCatPurchasesAPI::class)
fun RewardVerificationResult.map(): Map<String, Any> {
    val reward = verifiedReward ?: return mapOf(
        "failed" to true,
        "moreRewards" to emptyList<Map<String, Any>>(),
    )
    return mapOf(
        "failed" to false,
        "reward" to reward.map(),
        "moreRewards" to moreRewards.map { it.map() },
    )
}

@OptIn(ExperimentalPreviewRevenueCatPurchasesAPI::class)
fun VerifiedReward.map(): Map<String, Any> = when (this) {
    is VerifiedReward.VirtualCurrency -> mapOf(
        "type" to "virtual_currency",
        "code" to code,
        "amount" to amount,
    )
    is VerifiedReward.Entitlement -> mapOf(
        "type" to "entitlement",
        "identifier" to identifier,
        "expiresAt" to expiresAt.toIso8601(),
        "expiresAtMillis" to expiresAt.toMillis(),
    )
    VerifiedReward.NoReward -> mapOf("type" to "no_reward")
    else -> mapOf("type" to "unsupported_reward")
}
