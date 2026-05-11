import 'ad_format.dart';
import 'ad_mediator_name.dart';

/// Data for tracking when an ad is displayed to the user.
///
/// Use with [Purchases.trackAdDisplayed].
class AdDisplayedData {
  /// The name of the ad network that served the ad, if available.
  final String? networkName;

  /// The name of the mediation network.
  final AdMediatorName mediatorName;

  /// The format of the ad.
  final AdFormat adFormat;

  /// The placement identifier, if available.
  final String? placement;

  /// The ad unit identifier.
  final String adUnitId;

  /// A unique identifier for this ad impression.
  final String impressionId;

  const AdDisplayedData({
    this.networkName,
    required this.mediatorName,
    required this.adFormat,
    this.placement,
    required this.adUnitId,
    required this.impressionId,
  });

  Map<String, dynamic> toMap() => {
        if (networkName != null) 'networkName': networkName,
        'mediatorName': mediatorName.value,
        'adFormat': adFormat.value,
        if (placement != null) 'placement': placement,
        'adUnitId': adUnitId,
        'impressionId': impressionId,
      };
}
