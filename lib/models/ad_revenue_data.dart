import 'ad_format.dart';
import 'ad_mediator_name.dart';
import 'ad_revenue_precision.dart';

/// Data for tracking ad revenue events.
///
/// Use with [Purchases.trackAdRevenue].
class AdRevenueData {
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

  /// The revenue generated from the ad in micros (e.g. 1000000 = $1.00).
  final int revenueMicros;

  /// The ISO 4217 currency code (e.g. "USD").
  final String currency;

  /// The precision of the revenue value.
  final AdRevenuePrecision precision;

  const AdRevenueData({
    this.networkName,
    required this.mediatorName,
    required this.adFormat,
    this.placement,
    required this.adUnitId,
    required this.impressionId,
    required this.revenueMicros,
    required this.currency,
    required this.precision,
  });

  Map<String, dynamic> toMap() => {
        if (networkName != null) 'networkName': networkName,
        'mediatorName': mediatorName.value,
        'adFormat': adFormat.value,
        if (placement != null) 'placement': placement,
        'adUnitId': adUnitId,
        'impressionId': impressionId,
        'revenueMicros': revenueMicros,
        'currency': currency,
        'precision': precision.value,
      };
}
