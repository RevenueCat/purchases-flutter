import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _AdMediatorNameApiTest {
  void _checkConstructor() {
    AdMediatorName custom = const AdMediatorName('MyNetwork');
    String value = custom.value;
  }

  void _checkPredefinedConstants() {
    AdMediatorName adMob = AdMediatorName.adMob;
    AdMediatorName appLovin = AdMediatorName.appLovin;
  }
}

class _AdFormatApiTest {
  void _checkConstructor() {
    AdFormat custom = const AdFormat('custom_format');
    String value = custom.value;
  }

  void _checkPredefinedConstants() {
    AdFormat other = AdFormat.other;
    AdFormat banner = AdFormat.banner;
    AdFormat interstitial = AdFormat.interstitial;
    AdFormat rewarded = AdFormat.rewarded;
    AdFormat rewardedInterstitial = AdFormat.rewardedInterstitial;
    AdFormat nativeAd = AdFormat.nativeAd;
    AdFormat appOpen = AdFormat.appOpen;
  }
}

class _AdRevenuePrecisionApiTest {
  void _checkConstructor() {
    AdRevenuePrecision custom = const AdRevenuePrecision('custom_precision');
    String value = custom.value;
  }

  void _checkPredefinedConstants() {
    AdRevenuePrecision exact = AdRevenuePrecision.exact;
    AdRevenuePrecision publisherDefined = AdRevenuePrecision.publisherDefined;
    AdRevenuePrecision estimated = AdRevenuePrecision.estimated;
    AdRevenuePrecision unknown = AdRevenuePrecision.unknown;
  }
}

class _AdDisplayedDataApiTest {
  void _checkConstructor() {
    AdDisplayedData data = const AdDisplayedData(
      mediatorName: AdMediatorName.adMob,
      adFormat: AdFormat.banner,
      adUnitId: 'unit-1',
      impressionId: 'imp-1',
    );
  }

  void _checkProperties(AdDisplayedData data) {
    String? networkName = data.networkName;
    AdMediatorName mediatorName = data.mediatorName;
    AdFormat adFormat = data.adFormat;
    String? placement = data.placement;
    String adUnitId = data.adUnitId;
    String impressionId = data.impressionId;
    Map<String, dynamic> map = data.toMap();
  }
}

class _AdOpenedDataApiTest {
  void _checkConstructor() {
    AdOpenedData data = const AdOpenedData(
      mediatorName: AdMediatorName.adMob,
      adFormat: AdFormat.interstitial,
      adUnitId: 'unit-1',
      impressionId: 'imp-1',
    );
  }

  void _checkProperties(AdOpenedData data) {
    String? networkName = data.networkName;
    AdMediatorName mediatorName = data.mediatorName;
    AdFormat adFormat = data.adFormat;
    String? placement = data.placement;
    String adUnitId = data.adUnitId;
    String impressionId = data.impressionId;
    Map<String, dynamic> map = data.toMap();
  }
}

class _AdLoadedDataApiTest {
  void _checkConstructor() {
    AdLoadedData data = const AdLoadedData(
      mediatorName: AdMediatorName.adMob,
      adFormat: AdFormat.rewarded,
      adUnitId: 'unit-1',
      impressionId: 'imp-1',
    );
  }

  void _checkProperties(AdLoadedData data) {
    String? networkName = data.networkName;
    AdMediatorName mediatorName = data.mediatorName;
    AdFormat adFormat = data.adFormat;
    String? placement = data.placement;
    String adUnitId = data.adUnitId;
    String impressionId = data.impressionId;
    Map<String, dynamic> map = data.toMap();
  }
}

class _AdRevenueDataApiTest {
  void _checkConstructor() {
    AdRevenueData data = const AdRevenueData(
      mediatorName: AdMediatorName.adMob,
      adFormat: AdFormat.banner,
      adUnitId: 'unit-1',
      impressionId: 'imp-1',
      revenueMicros: 1000000,
      currency: 'USD',
      precision: AdRevenuePrecision.exact,
    );
  }

  void _checkProperties(AdRevenueData data) {
    String? networkName = data.networkName;
    AdMediatorName mediatorName = data.mediatorName;
    AdFormat adFormat = data.adFormat;
    String? placement = data.placement;
    String adUnitId = data.adUnitId;
    String impressionId = data.impressionId;
    int revenueMicros = data.revenueMicros;
    String currency = data.currency;
    AdRevenuePrecision precision = data.precision;
    Map<String, dynamic> map = data.toMap();
  }
}

class _AdFailedToLoadDataApiTest {
  void _checkConstructor() {
    AdFailedToLoadData data = const AdFailedToLoadData(
      mediatorName: AdMediatorName.adMob,
      adFormat: AdFormat.banner,
      adUnitId: 'unit-1',
    );
  }

  void _checkProperties(AdFailedToLoadData data) {
    AdMediatorName mediatorName = data.mediatorName;
    AdFormat adFormat = data.adFormat;
    String? placement = data.placement;
    String adUnitId = data.adUnitId;
    int? mediatorErrorCode = data.mediatorErrorCode;
    Map<String, dynamic> map = data.toMap();
  }
}
