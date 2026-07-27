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
  void _checkConstructor(Map<String, dynamic> map) {
    VerifiedReward reward = const VerifiedReward(
      type: 'virtual_currency',
      code: 'GOLD',
      amount: 100,
      identifier: 'premium',
      expiresAt: null,
    );
    VerifiedReward reward2 = VerifiedReward.fromMap(map);
  }

  void _checkProperties(VerifiedReward reward) {
    String type = reward.type;
    String? code = reward.code;
    int? amount = reward.amount;
    String? identifier = reward.identifier;
    DateTime? expiresAt = reward.expiresAt;
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
