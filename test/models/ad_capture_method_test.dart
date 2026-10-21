import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/ad_capture_method.dart';
import 'package:purchases_flutter/models/ad_failed_to_load_data.dart';
import 'package:purchases_flutter/models/ad_format.dart';
import 'package:purchases_flutter/models/ad_mediator_name.dart';
import 'package:purchases_flutter/models/ad_revenue_data.dart';
import 'package:purchases_flutter/models/ad_revenue_precision.dart';
import 'package:purchases_flutter/models/rewarded_ad_tracking_metadata.dart';

void main() {
  test('captureMethod is omitted from the map when unset', () {
    const data = AdFailedToLoadData(
      mediatorName: AdMediatorName.adMob,
      adFormat: AdFormat.banner,
      adUnitId: 'unit',
    );
    expect(data.toMap().containsKey('captureMethod'), isFalse);
  });

  test('captureMethod is serialized by its wire value when set', () {
    const data = AdRevenueData(
      mediatorName: AdMediatorName.adMob,
      adFormat: AdFormat.rewarded,
      adUnitId: 'unit',
      impressionId: 'imp',
      revenueMicros: 10,
      currency: 'USD',
      precision: AdRevenuePrecision.exact,
      captureMethod: AdCaptureMethod.flutterAdMobAdapter,
    );
    expect(data.toMap()['captureMethod'], 'flutter_admob_adapter');
  });

  test('tracking metadata carries captureMethod', () {
    const metadata = RewardedAdTrackingMetadata(
      mediatorName: AdMediatorName.adMob,
      adFormat: AdFormat.rewardedInterstitial,
      adUnitId: 'unit',
      impressionId: 'imp',
      captureMethod: AdCaptureMethod.flutterAdMobAdapter,
    );
    expect(metadata.toMap()['captureMethod'], AdCaptureMethod.flutterAdMobAdapter.value);
  });
}
