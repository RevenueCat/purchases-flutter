import 'package:meta/meta.dart';

import 'ad_format.dart';
import 'ad_mediator_name.dart';
import 'ad_revenue_precision.dart';

@experimental
class AdRevenueData {
  final String? networkName;
  final AdMediatorName mediatorName;
  final AdFormat adFormat;
  final String? placement;
  final String adUnitId;
  final String impressionId;
  // e.g. 1000000 = $1.00
  final int revenueMicros;
  // ISO 4217, e.g. "USD"
  final String currency;
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
        'networkName': networkName,
        'mediatorName': mediatorName.value,
        'adFormat': adFormat.value,
        'placement': placement,
        'adUnitId': adUnitId,
        'impressionId': impressionId,
        'revenueMicros': revenueMicros,
        'currency': currency,
        'precision': precision.value,
      };
}
