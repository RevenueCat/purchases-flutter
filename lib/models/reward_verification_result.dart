import 'package:meta/meta.dart';

import 'verified_reward.dart';

/// Result delivered after reward verification polling for a rewarded ad.
@experimental
class RewardVerificationResult {
  /// True when verification did not complete successfully (rejected, timeout,
  /// network, etc.).
  final bool failed;

  /// The first granted reward, or null when verification failed.
  final VerifiedReward? reward;

  /// The remaining granted rewards. Empty for a single reward or on failure.
  final List<VerifiedReward> moreRewards;

  const RewardVerificationResult({
    required this.failed,
    this.reward,
    this.moreRewards = const [],
  });

  factory RewardVerificationResult.fromMap(Map<String, dynamic> map) {
    final rewardMap = map['reward'];
    final more = (map['moreRewards'] as List<dynamic>? ?? [])
        .map((e) => VerifiedReward.fromMap(Map<String, dynamic>.from(e as Map)))
        .toList();
    return RewardVerificationResult(
      failed: map['failed'] as bool? ?? true,
      reward: rewardMap is Map
          ? VerifiedReward.fromMap(Map<String, dynamic>.from(rewardMap))
          : null,
      moreRewards: more,
    );
  }
}
