import 'package:equatable/equatable.dart';

import 'ad_reward_configuration.dart';

/// The rewards configured for a rewarded ad unit.
///
/// A null accessor result means configuration is unavailable or malformed.
/// [noConfiguredReward] means configuration resolved successfully, but the ad
/// unit has no configured reward.
class ConfiguredAdRewards extends Equatable {
  /// Configuration resolved successfully with no reward for this ad unit.
  static const noConfiguredReward = ConfiguredAdRewards._();

  /// The primary configured reward, or null for [noConfiguredReward].
  final AdRewardConfiguration? reward;

  /// Additional configured rewards, in configuration order.
  ///
  /// Always empty when [reward] is null. This list cannot be modified.
  final List<AdRewardConfiguration> moreRewards;

  /// Creates configured rewards with a required primary reward.
  ConfiguredAdRewards({
    required AdRewardConfiguration reward,
    List<AdRewardConfiguration> moreRewards = const [],
  }) : this._(reward: reward, moreRewards: List.unmodifiable(moreRewards));

  const ConfiguredAdRewards._({this.reward, this.moreRewards = const []});

  /// Creates configured rewards from their native SDK representation.
  ///
  /// Throws [FormatException] if additional rewards have no primary reward.
  /// The native SDK resolves malformed ad-unit entries to a null result before
  /// mapping, and normalizes `no_reward` to a null primary or an omitted
  /// additional reward.
  factory ConfiguredAdRewards.fromMap(Map<String, dynamic> map) {
    final rewardMap = map['reward'];
    final moreRewards = (map['moreRewards'] as List<dynamic>? ?? [])
        .map(
          (e) => AdRewardConfiguration.fromMap(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
    if (rewardMap == null) {
      if (moreRewards.isNotEmpty) {
        throw const FormatException(
          'Additional rewards require a primary reward',
        );
      }
      return noConfiguredReward;
    }
    return ConfiguredAdRewards(
      reward: AdRewardConfiguration.fromMap(
        Map<String, dynamic>.from(rewardMap as Map),
      ),
      moreRewards: moreRewards,
    );
  }

  @override
  List<Object?> get props => [reward, moreRewards];
}
