import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'log.dart';
import 'tracked_ad_state.dart';

/// Builds RevenueCat ad events from adapter state and forwards them to
/// `Purchases.adTracker`, skipping them while the SDK is not configured.
///
/// AdMob callbacks can fire before `Purchases.configure` (for example an app
/// open ad on a cold start), and the native SDKs treat tracking calls on an
/// unconfigured instance as a programming error. Skipping with a warning keeps
/// that from surfacing as a crash inside a Google callback.
class AdMobTracker {
  AdMobTracker._();

  static const captureMethod = AdCaptureMethod.flutterAdMobAdapter;

  /// Overridable for tests. Production reads `Purchases.isConfigured`.
  static Future<bool> Function() isConfigured = () => Purchases.isConfigured;

  static Future<void> _ifConfigured(
    String event,
    Future<void> Function() track,
  ) async {
    var configured = false;
    try {
      configured = await isConfigured();
    } catch (e) {
      logWarning('Could not check whether Purchases is configured: $e');
    }
    if (!configured) {
      logWarning('Purchases is not configured; not tracking $event.');
      return;
    }
    try {
      await track();
    } catch (e) {
      logWarning('Failed to track $event: $e');
    }
  }

  static Future<void> trackLoaded(TrackedAdState state) => _ifConfigured(
        'ad loaded',
        () => Purchases.adTracker.trackAdLoaded(
          AdLoadedData(
            networkName: state.networkName,
            mediatorName: AdMediatorName.adMob,
            adFormat: state.adFormat,
            placement: state.loadPlacement,
            adUnitId: state.adUnitId,
            impressionId: state.impressionId,
            captureMethod: captureMethod,
          ),
        ),
      );

  static Future<void> trackFailedToLoad({
    required String adUnitId,
    required AdFormat adFormat,
    required String? placement,
    required LoadAdError error,
  }) =>
      _ifConfigured(
        'ad failed to load',
        () => Purchases.adTracker.trackAdFailedToLoad(
          AdFailedToLoadData(
            mediatorName: AdMediatorName.adMob,
            adFormat: adFormat,
            placement: placement,
            adUnitId: adUnitId,
            mediatorErrorCode: error.code,
            captureMethod: captureMethod,
          ),
        ),
      );

  static Future<void> trackDisplayed(TrackedAdState state) => _ifConfigured(
        'ad displayed',
        () => Purchases.adTracker.trackAdDisplayed(
          AdDisplayedData(
            networkName: state.networkName,
            mediatorName: AdMediatorName.adMob,
            adFormat: state.adFormat,
            placement: state.placement,
            adUnitId: state.adUnitId,
            impressionId: state.impressionId,
            captureMethod: captureMethod,
          ),
        ),
      );

  static Future<void> trackOpened(TrackedAdState state) => _ifConfigured(
        'ad opened',
        () => Purchases.adTracker.trackAdOpened(
          AdOpenedData(
            networkName: state.networkName,
            mediatorName: AdMediatorName.adMob,
            adFormat: state.adFormat,
            placement: state.placement,
            adUnitId: state.adUnitId,
            impressionId: state.impressionId,
            captureMethod: captureMethod,
          ),
        ),
      );

  static Future<void> trackRewardEarnedUnverified(TrackedAdState state) =>
      _ifConfigured(
        'reward earned',
        () => Purchases.adTracker.trackAdRewardEarnedUnverified(
          AdRewardEarnedUnverifiedData(
            networkName: state.networkName,
            mediatorName: AdMediatorName.adMob,
            adFormat: state.adFormat,
            placement: state.placement,
            adUnitId: state.adUnitId,
            impressionId: state.impressionId,
            captureMethod: captureMethod,
          ),
        ),
      );

  static Future<void> trackRevenue(
    TrackedAdState state,
    double valueMicros,
    PrecisionType precision,
    String currencyCode,
  ) =>
      _ifConfigured(
        'ad revenue',
        () => Purchases.adTracker.trackAdRevenue(
          AdRevenueData(
            networkName: state.networkName,
            mediatorName: AdMediatorName.adMob,
            adFormat: state.adFormat,
            placement: state.placement,
            adUnitId: state.adUnitId,
            impressionId: state.impressionId,
            revenueMicros: revenueMicrosFrom(valueMicros),
            currency: currencyCode,
            precision: precisionFrom(precision),
            captureMethod: captureMethod,
          ),
        ),
      );

  static int revenueMicrosFrom(double valueMicros) => valueMicros.round();

  static AdRevenuePrecision precisionFrom(PrecisionType precision) {
    switch (precision) {
      case PrecisionType.precise:
        return AdRevenuePrecision.exact;
      case PrecisionType.estimated:
        return AdRevenuePrecision.estimated;
      case PrecisionType.publisherProvided:
        return AdRevenuePrecision.publisherDefined;
      case PrecisionType.unknown:
        return AdRevenuePrecision.unknown;
    }
  }
}
