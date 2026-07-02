import 'package:meta/meta.dart';

/// Ties a loaded rewarded ad to its server-side reward verification.
///
/// Produced by [Purchases.generateRewardVerificationToken]. Forward [customData]
/// and [appUserID] to your ad network's server-side verification options, and
/// keep [clientTransactionId] to correlate the reward callback with
/// [Purchases.pollRewardVerification].
@experimental
class RewardVerificationToken {
  final String customData;
  final String clientTransactionId;
  final String appUserID;

  const RewardVerificationToken({
    required this.customData,
    required this.clientTransactionId,
    required this.appUserID,
  });

  factory RewardVerificationToken.fromMap(Map<String, dynamic> map) =>
      RewardVerificationToken(
        customData: map['customData'] as String,
        clientTransactionId: map['clientTransactionId'] as String,
        appUserID: map['appUserID'] as String,
      );
}
