import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_mobile_ads/src/ad_instance_manager.dart';
import 'package:purchases_admob_flutter/purchases_admob_flutter.dart';
import 'package:purchases_admob_flutter/src/tracker.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

const _gmaChannel = 'plugins.flutter.io/google_mobile_ads';
const _purchasesChannel = MethodChannel('purchases_flutter');

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final gmaLog = <MethodCall>[];
  final purchasesLog = <MethodCall>[];
  var configured = true;
  Map<String, dynamic> pollResult = {
    'failed': false,
    'reward': {'type': 'virtual_currency', 'code': 'GEM', 'amount': 3},
    'moreRewards': <dynamic>[],
  };

  List<Map<dynamic, dynamic>> purchasesCalls(String method) => purchasesLog
      .where((c) => c.method == method)
      .map((c) => c.arguments as Map<dynamic, dynamic>)
      .toList();

  Future<void> sendAdEvent(
    int adId,
    String eventName, [
    Map<String, dynamic>? extra,
  ]) async {
    final args = <String, dynamic>{'adId': adId, 'eventName': eventName};
    extra?.forEach((k, v) => args[k] = v);
    final data =
        instanceManager.channel.codec.encodeMethodCall(MethodCall('onAdEvent', args));
    await TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .handlePlatformMessage(_gmaChannel, data, (_) {});
    await pumpEventQueue();
  }

  ResponseInfo responseInfo(String id, {String adapter = 'com.google.Adapter'}) =>
      ResponseInfo(
        responseId: id,
        mediationAdapterClassName: 'MediationClass',
        loadedAdapterResponseInfo: AdapterResponseInfo(
          adapterClassName: adapter,
          latencyMillis: 1,
          description: 'd',
          adUnitMapping: const {},
          adSourceName: 'AdMob Network',
          adSourceId: 'src',
          adSourceInstanceName: 'inst',
          adSourceInstanceId: 'inst-id',
        ),
        responseExtras: const {},
      );

  setUp(() {
    gmaLog.clear();
    purchasesLog.clear();
    configured = true;
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    AdMobTracker.isConfigured = () => Purchases.isConfigured;
    instanceManager = AdInstanceManager(_gmaChannel);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(instanceManager.channel, (call) async {
      gmaLog.add(call);
      return null;
    });
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_purchasesChannel, (call) async {
      purchasesLog.add(call);
      switch (call.method) {
        case 'isConfigured':
          return configured;
        case 'generateRewardVerificationToken':
          return {
            'customData': 'custom-data',
            'clientTransactionId': 'ctx-1',
            'appUserID': 'user-1',
          };
        case 'pollRewardVerification':
          return pollResult;
        default:
          return null;
      }
    });
  });

  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
  });

  group('interstitial', () {
    test('tracks the full lifecycle with placement override at show time',
        () async {
      InterstitialAd? loaded;
      final userImpressions = <Ad>[];
      final userPaid = <double>[];
      await RevenueCatAdMob.loadAndTrackInterstitialAd(
        adUnitId: 'unit-1',
        request: const AdRequest(),
        placement: 'home',
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            loaded = ad;
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdImpression: userImpressions.add,
            );
            ad.onPaidEvent = (ad, v, p, c) => userPaid.add(v);
          },
          onAdFailedToLoad: (_) => fail('should not fail'),
        ),
      );
      await sendAdEvent(0, 'onAdLoaded', {'responseInfo': responseInfo('resp-1')});
      expect(loaded, isNotNull);

      final loadedCalls = purchasesCalls('trackAdLoaded');
      expect(loadedCalls, hasLength(1));
      expect(loadedCalls.first, {
        'networkName': 'com.google.Adapter',
        'mediatorName': 'AdMob',
        'adFormat': 'interstitial',
        'placement': 'home',
        'adUnitId': 'unit-1',
        'impressionId': 'resp-1',
        'captureMethod': 'flutter_admob_adapter',
      });

      await sendAdEvent(0, 'onAdImpression');
      expect(purchasesCalls('trackAdDisplayed').single['placement'], 'home');
      expect(userImpressions, [loaded]);

      await loaded!.showAndTrack(placement: 'home_retry');
      expect(gmaLog.map((c) => c.method), contains('showAdWithoutView'));
      await sendAdEvent(0, 'onAdImpression');
      expect(purchasesCalls('trackAdDisplayed').last['placement'], 'home_retry');
      expect(userImpressions, hasLength(2));

      await sendAdEvent(0, 'onAdClicked');
      final opened = purchasesCalls('trackAdOpened').single;
      expect(opened['impressionId'], 'resp-1');
      expect(opened['placement'], 'home_retry');

      await sendAdEvent(0, 'onPaidEvent', {
        'valueMicros': 1500000,
        'precision': 3,
        'currencyCode': 'USD',
      });
      final revenue = purchasesCalls('trackAdRevenue').single;
      expect(revenue['revenueMicros'], 1500000);
      expect(revenue['precision'], 'exact');
      expect(revenue['currency'], 'USD');
      expect(revenue['placement'], 'home_retry');
      expect(revenue['captureMethod'], 'flutter_admob_adapter');
      expect(userPaid, [1500000.0]);
    });

    test('tracks failed loads with the mediator error code', () async {
      LoadAdError? seen;
      await RevenueCatAdMob.loadAndTrackInterstitialAd(
        adUnitId: 'unit-1',
        request: const AdRequest(),
        placement: 'home',
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (_) => fail('should not load'),
          onAdFailedToLoad: (error) => seen = error,
        ),
      );
      await sendAdEvent(0, 'onAdFailedToLoad', {
        'loadAdError': LoadAdError(3, 'domain', 'no fill', null),
      });
      expect(seen?.code, 3);
      expect(purchasesCalls('trackAdFailedToLoad').single, {
        'mediatorName': 'AdMob',
        'adFormat': 'interstitial',
        'placement': 'home',
        'adUnitId': 'unit-1',
        'mediatorErrorCode': 3,
        'captureMethod': 'flutter_admob_adapter',
      });
    });

    test('heals a callback assigned directly after loading', () async {
      InterstitialAd? loaded;
      await RevenueCatAdMob.loadAndTrackInterstitialAd(
        adUnitId: 'unit-1',
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) => loaded = ad,
          onAdFailedToLoad: (_) {},
        ),
      );
      await sendAdEvent(0, 'onAdLoaded', {'responseInfo': responseInfo('resp-1')});

      final userImpressions = <Ad>[];
      loaded!.fullScreenContentCallback = FullScreenContentCallback(
        onAdImpression: userImpressions.add,
      );
      await sendAdEvent(0, 'onAdImpression');
      expect(purchasesCalls('trackAdDisplayed'), isEmpty);
      expect(userImpressions, hasLength(1));

      await loaded!.showAndTrack();
      await sendAdEvent(0, 'onAdImpression');
      expect(purchasesCalls('trackAdDisplayed'), hasLength(1));
      expect(userImpressions, hasLength(2));

      final replaced = <Ad>[];
      loaded!.setTrackingFullScreenContentCallback(
        FullScreenContentCallback(onAdImpression: replaced.add),
      );
      await sendAdEvent(0, 'onAdImpression');
      expect(purchasesCalls('trackAdDisplayed'), hasLength(2));
      expect(replaced, hasLength(1));
      expect(userImpressions, hasLength(2));
    });

    test('does not track while Purchases is not configured', () async {
      configured = false;
      await RevenueCatAdMob.loadAndTrackInterstitialAd(
        adUnitId: 'unit-1',
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (_) {},
          onAdFailedToLoad: (_) {},
        ),
      );
      await sendAdEvent(0, 'onAdLoaded', {'responseInfo': responseInfo('resp-1')});
      await sendAdEvent(0, 'onAdImpression');
      expect(purchasesCalls('trackAdLoaded'), isEmpty);
      expect(purchasesCalls('trackAdDisplayed'), isEmpty);
    });
  });

  group('iOS', () {
    test('maps iOS event names', () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      await RevenueCatAdMob.loadAndTrackAppOpenAd(
        adUnitId: 'unit-1',
        request: const AdRequest(),
        placement: 'launch',
        adLoadCallback: AppOpenAdLoadCallback(
          onAdLoaded: (_) {},
          onAdFailedToLoad: (_) {},
        ),
      );
      await sendAdEvent(0, 'onAdLoaded', {'responseInfo': responseInfo('resp-1')});
      expect(purchasesCalls('trackAdLoaded').single['adFormat'], 'app_open');

      await sendAdEvent(0, 'adDidRecordImpression');
      expect(purchasesCalls('trackAdDisplayed'), hasLength(1));
      await sendAdEvent(0, 'adDidRecordClick');
      expect(purchasesCalls('trackAdOpened'), hasLength(1));

      await sendAdEvent(0, 'onPaidEvent', {
        'valueMicros': 12500.0,
        'precision': 1,
        'currencyCode': 'EUR',
      });
      final revenue = purchasesCalls('trackAdRevenue').single;
      expect(revenue['revenueMicros'], 12500);
      expect(revenue['precision'], 'estimated');
    });

    test('revenue and precision mapping', () {
      expect(AdMobTracker.revenueMicrosFrom(1000000.4), 1000000);
      expect(
        AdMobTracker.precisionFrom(PrecisionType.publisherProvided),
        AdRevenuePrecision.publisherDefined,
      );
      expect(
        AdMobTracker.precisionFrom(PrecisionType.unknown),
        AdRevenuePrecision.unknown,
      );
    });
  });

  group('banner and native', () {
    test('banner refreshes report each new response id', () async {
      final userLoads = <Ad>[];
      final banner = RevenueCatAdMob.createBannerAd(
        adUnitId: 'banner-1',
        size: AdSize.banner,
        request: const AdRequest(),
        placement: 'bottom',
        listener: BannerAdListener(onAdLoaded: userLoads.add),
      );
      await banner.load();
      await sendAdEvent(0, 'onAdLoaded', {'responseInfo': responseInfo('r-1')});
      await sendAdEvent(0, 'onAdImpression');
      await sendAdEvent(0, 'onPaidEvent', {
        'valueMicros': 2000,
        'precision': 2,
        'currencyCode': 'USD',
      });
      await sendAdEvent(0, 'onAdLoaded', {'responseInfo': responseInfo('r-2')});
      await sendAdEvent(0, 'onAdClicked');

      expect(userLoads, hasLength(2));
      final loads = purchasesCalls('trackAdLoaded');
      expect(loads.map((m) => m['impressionId']), ['r-1', 'r-2']);
      expect(loads.first['adFormat'], 'banner');
      expect(purchasesCalls('trackAdDisplayed').single['impressionId'], 'r-1');
      final revenue = purchasesCalls('trackAdRevenue').single;
      expect(revenue['revenueMicros'], 2000);
      expect(revenue['precision'], 'publisher_defined');
      expect(purchasesCalls('trackAdOpened').single['impressionId'], 'r-2');
    });

    test('native listener wrapper tracks loads, impressions and failures',
        () async {
      final native = NativeAd(
        adUnitId: 'native-1',
        request: const AdRequest(),
        factoryId: 'factory',
        listener: RevenueCatAdMob.trackingNativeAdListener(placement: 'feed'),
      );
      await native.load();
      await sendAdEvent(0, 'onAdLoaded', {'responseInfo': responseInfo('n-1')});
      await sendAdEvent(0, 'onAdImpression');
      await sendAdEvent(0, 'onAdFailedToLoad', {
        'loadAdError': LoadAdError(2, 'domain', 'network', null),
      });
      expect(purchasesCalls('trackAdLoaded').single['adFormat'], 'native');
      expect(purchasesCalls('trackAdDisplayed').single['placement'], 'feed');
      final failed = purchasesCalls('trackAdFailedToLoad').single;
      expect(failed['adFormat'], 'native');
      expect(failed['mediatorErrorCode'], 2);
    });
  });

  group('reward verification', () {
    test('attaches SSV options and polls once the reward is earned', () async {
      RewardedInterstitialAd? loaded;
      await RevenueCatAdMob.loadAndTrackRewardedInterstitialAd(
        adUnitId: 'ri-1',
        request: const AdRequest(),
        placement: 'bonus',
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          onAdLoaded: (ad) => loaded = ad,
          onAdFailedToLoad: (_) {},
        ),
      );
      await sendAdEvent(0, 'onAdLoaded', {'responseInfo': responseInfo('ri-resp')});
      await loaded!.enableRewardVerification();

      expect(
        purchasesCalls('generateRewardVerificationToken').single,
        {'impressionId': 'ri-resp'},
      );
      final ssv = gmaLog.singleWhere(
        (c) => c.method == 'setServerSideVerificationOptions',
      );
      final options =
          (ssv.arguments as Map)['serverSideVerificationOptions'] as ServerSideVerificationOptions;
      expect(options.userId, 'user-1');
      expect(options.customData, 'custom-data');

      var started = 0;
      final results = <RewardVerificationResult>[];
      final rewards = <RewardItem>[];
      await loaded!.showWithRewardVerification(
        placement: 'bonus_shown',
        onUserEarnedReward: (_, item) => rewards.add(item),
        onRewardVerificationStarted: () => started++,
        onRewardVerificationCompleted: results.add,
      );
      await sendAdEvent(0, 'onRewardedInterstitialAdUserEarnedReward', {
        'rewardItem': RewardItem(1, 'coin'),
      });
      await sendAdEvent(0, 'onRewardedInterstitialAdUserEarnedReward', {
        'rewardItem': RewardItem(1, 'coin'),
      });

      expect(rewards, hasLength(2));
      expect(started, 2);
      expect(results, hasLength(1));
      expect(results.single.failed, isFalse);
      expect((results.single.reward! as VerifiedVirtualCurrencyReward).code, 'GEM');

      expect(purchasesCalls('trackAdRewardEarnedUnverified'), isEmpty);
      final poll = purchasesCalls('pollRewardVerification').first;
      expect(poll['clientTransactionId'], 'ctx-1');
      expect(poll['trackingMetadata'], {
        'networkName': 'com.google.Adapter',
        'mediatorName': 'AdMob',
        'adFormat': 'rewarded_interstitial',
        'placement': 'bonus_shown',
        'adUnitId': 'ri-1',
        'impressionId': 'ri-resp',
        'captureMethod': 'flutter_admob_adapter',
      });
    });

    test('tracks the earned reward itself when verification is not enabled',
        () async {
      RewardedAd? loaded;
      await RevenueCatAdMob.loadAndTrackRewardedAd(
        adUnitId: 'r-2',
        request: const AdRequest(),
        placement: 'bonus',
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) => loaded = ad,
          onAdFailedToLoad: (_) {},
        ),
      );
      await sendAdEvent(0, 'onAdLoaded', {'responseInfo': responseInfo('r2-resp')});
      final rewards = <RewardItem>[];
      await loaded!.showAndTrack(
        placement: 'bonus_shown',
        onUserEarnedReward: (_, item) => rewards.add(item),
      );
      await sendAdEvent(0, 'onRewardedAdUserEarnedReward', {
        'rewardItem': RewardItem(1, 'coin'),
      });

      expect(rewards, hasLength(1));
      expect(purchasesCalls('trackAdRewardEarnedUnverified').single, {
        'networkName': 'com.google.Adapter',
        'mediatorName': 'AdMob',
        'adFormat': 'rewarded',
        'placement': 'bonus_shown',
        'adUnitId': 'r-2',
        'impressionId': 'r2-resp',
        'captureMethod': 'flutter_admob_adapter',
      });
    });

    test('fails fast when verification was not enabled', () async {
      RewardedAd? loaded;
      await RevenueCatAdMob.loadAndTrackRewardedAd(
        adUnitId: 'r-1',
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) => loaded = ad,
          onAdFailedToLoad: (_) {},
        ),
      );
      await sendAdEvent(0, 'onAdLoaded', {'responseInfo': responseInfo('r-resp')});
      final results = <RewardVerificationResult>[];
      await loaded!.showWithRewardVerification(
        onRewardVerificationCompleted: results.add,
      );
      await sendAdEvent(0, 'onRewardedAdUserEarnedReward', {
        'rewardItem': RewardItem(1, 'coin'),
      });
      expect(results.single.failed, isTrue);
      expect(purchasesCalls('pollRewardVerification'), isEmpty);
    });

    test('reports a failed result when polling throws', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(_purchasesChannel, (call) async {
        purchasesLog.add(call);
        switch (call.method) {
          case 'isConfigured':
            return true;
          case 'generateRewardVerificationToken':
            return {
              'customData': 'c',
              'clientTransactionId': 'ctx-2',
              'appUserID': 'u',
            };
          case 'pollRewardVerification':
            throw PlatformException(code: 'unsupported');
          default:
            return null;
        }
      });
      RewardedAd? loaded;
      await RevenueCatAdMob.loadAndTrackRewardedAd(
        adUnitId: 'r-1',
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) => loaded = ad,
          onAdFailedToLoad: (_) {},
        ),
      );
      await sendAdEvent(0, 'onAdLoaded', {'responseInfo': responseInfo('r-resp')});
      await loaded!.enableRewardVerification();
      final results = <RewardVerificationResult>[];
      await loaded!.showWithRewardVerification(
        onRewardVerificationCompleted: results.add,
      );
      await sendAdEvent(0, 'onRewardedAdUserEarnedReward', {
        'rewardItem': RewardItem(1, 'coin'),
      });
      expect(results.single.failed, isTrue);
    });
  });
}
