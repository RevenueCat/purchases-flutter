import 'package:purchases_flutter/purchases_flutter.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _ConfiguredAdRewardsApiTest {
  void _checkConstructors(Map<String, dynamic> map) {
    AdRewardConfiguration currency = const VirtualCurrencyRewardConfiguration(
      code: 'coins',
      amount: 10,
    );
    AdRewardConfiguration entitlement = const EntitlementRewardConfiguration(
      identifier: 'premium',
      duration: Duration(minutes: 30),
    );
    AdRewardConfiguration unsupported =
        const UnsupportedAdRewardConfiguration();
    AdRewardConfiguration mappedReward = AdRewardConfiguration.fromMap(map);
    ConfiguredAdRewards rewards = ConfiguredAdRewards(
      reward: currency,
      moreRewards: [entitlement, unsupported],
    );
    ConfiguredAdRewards noReward = ConfiguredAdRewards.noConfiguredReward;
    ConfiguredAdRewards mappedRewards = ConfiguredAdRewards.fromMap(map);
  }

  void _checkProperties(ConfiguredAdRewards rewards) {
    AdRewardConfiguration? reward = rewards.reward;
    List<AdRewardConfiguration> additional = rewards.moreRewards;
    if (reward is VirtualCurrencyRewardConfiguration) {
      String code = reward.code;
      int amount = reward.amount;
    } else if (reward is EntitlementRewardConfiguration) {
      String identifier = reward.identifier;
      Duration duration = reward.duration;
    }
  }
}
