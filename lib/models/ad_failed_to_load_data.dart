import 'ad_format.dart';
import 'ad_mediator_name.dart';

/// Data for tracking when an ad has failed to load.
///
/// Use with [Purchases.trackAdFailedToLoad].
class AdFailedToLoadData {
  /// The name of the mediation network.
  final AdMediatorName mediatorName;

  /// The format of the ad.
  final AdFormat adFormat;

  /// The placement identifier, if available.
  final String? placement;

  /// The ad unit identifier.
  final String adUnitId;

  /// The error code reported by the mediator, if available.
  final int? mediatorErrorCode;

  const AdFailedToLoadData({
    required this.mediatorName,
    required this.adFormat,
    this.placement,
    required this.adUnitId,
    this.mediatorErrorCode,
  });

  Map<String, dynamic> toMap() => {
        'mediatorName': mediatorName.value,
        'adFormat': adFormat.value,
        if (placement != null) 'placement': placement,
        'adUnitId': adUnitId,
        if (mediatorErrorCode != null) 'mediatorErrorCode': mediatorErrorCode,
      };
}
