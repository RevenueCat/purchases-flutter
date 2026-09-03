import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _RewardVerificationTokenApiTest {
  void _checkConstructor(Map<String, dynamic> map) {
    RewardVerificationToken token = const RewardVerificationToken(
      customData: 'custom-data',
      clientTransactionId: 'client-transaction-id',
      appUserID: 'app-user-id',
    );
    RewardVerificationToken token2 = RewardVerificationToken.fromMap(map);
  }

  void _checkProperties(RewardVerificationToken token) {
    String customData = token.customData;
    String clientTransactionId = token.clientTransactionId;
    String appUserID = token.appUserID;
  }
}

class _VerifiedRewardApiTest {
  void _checkConstructors(Map<String, dynamic> map) {
    VerifiedReward currency = const VerifiedVirtualCurrencyReward(
      code: 'GOLD',
      amount: 100,
    );
    VerifiedReward entitlement = const VerifiedEntitlementReward(
      identifier: 'premium',
      expiresAt: null,
    );
    VerifiedReward noReward = const VerifiedNoReward();
    VerifiedReward unsupported = const VerifiedUnsupportedReward();
    VerifiedReward fromMap = VerifiedReward.fromMap(map);
  }

  void _checkProperties(VerifiedReward reward) {
    if (reward is VerifiedVirtualCurrencyReward) {
      String code = reward.code;
      int amount = reward.amount;
    } else if (reward is VerifiedEntitlementReward) {
      String identifier = reward.identifier;
      DateTime? expiresAt = reward.expiresAt;
    }
  }
}

class _RewardVerificationResultApiTest {
  void _checkConstructor(VerifiedReward reward, Map<String, dynamic> map) {
    RewardVerificationResult result = RewardVerificationResult(
      failed: false,
      reward: reward,
      moreRewards: [reward],
    );
    RewardVerificationResult result2 = RewardVerificationResult.fromMap(map);
  }

  void _checkProperties(RewardVerificationResult result) {
    bool failed = result.failed;
    VerifiedReward? reward = result.reward;
    List<VerifiedReward> moreRewards = result.moreRewards;
  }
}

class _RewardedAdTrackingMetadataApiTest {
  void _checkConstructor() {
    RewardedAdTrackingMetadata data = const RewardedAdTrackingMetadata(
      mediatorName: AdMediatorName.adMob,
      adFormat: AdFormat.rewarded,
      adUnitId: 'unit-1',
      impressionId: 'imp-1',
    );
  }

  void _checkProperties(RewardedAdTrackingMetadata data) {
    String? networkName = data.networkName;
    AdMediatorName mediatorName = data.mediatorName;
    AdFormat adFormat = data.adFormat;
    String? placement = data.placement;
    String adUnitId = data.adUnitId;
    String impressionId = data.impressionId;
    Map<String, dynamic> map = data.toMap();
  }
}
