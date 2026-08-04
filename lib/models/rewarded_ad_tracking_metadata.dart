import 'package:meta/meta.dart';

import 'ad_format.dart';
import 'ad_mediator_name.dart';

/// Ad metadata for a rewarded ad, passed to [Purchases.pollRewardVerification]
/// to have the SDK automatically track reward-verification events for it.
@experimental
class RewardedAdTrackingMetadata {
  final String? networkName;
  final AdMediatorName mediatorName;
  final AdFormat adFormat;
  final String? placement;
  final String adUnitId;
  final String impressionId;

  const RewardedAdTrackingMetadata({
    this.networkName,
    required this.mediatorName,
    required this.adFormat,
    this.placement,
    required this.adUnitId,
    required this.impressionId,
  });

  Map<String, dynamic> toMap() => {
        'networkName': networkName,
        'mediatorName': mediatorName.value,
        'adFormat': adFormat.value,
        'placement': placement,
        'adUnitId': adUnitId,
        'impressionId': impressionId,
      };
}
