<p align="center">
  <img src="https://uploads-ssl.webflow.com/5e2613cf294dc30503dcefb7/5e752025f8c3a31d56a51408_logo_red%20(1).svg" width="350" alt="RevenueCat"/>
<br>

[![pub package](https://img.shields.io/pub/v/purchases_admob_flutter.svg)](https://pub.dartlang.org/packages/purchases_admob_flutter)

## purchases_admob_flutter

*purchases_admob_flutter* connects the [google_mobile_ads](https://pub.dev/packages/google_mobile_ads) plugin to [RevenueCat](https://www.revenuecat.com/)'s ad tracking and reward verification. Load your ads through the adapter and it reports loaded, failed-to-load, displayed, opened, revenue and earned-reward events for you; rewarded ads can additionally have their rewards verified server-side. See the [AdMob integration docs](https://www.revenuecat.com/docs/ad-monetization/admob) for the full picture.

## Installation

Add `purchases_flutter`, `google_mobile_ads` and `purchases_admob_flutter` as dependencies in your `pubspec.yaml`. Configure `Purchases` and initialize `MobileAds` as you normally would; the adapter only tracks while `Purchases` is configured.

## Tracking full-screen ads

Replace `InterstitialAd.load(...)` (and the rewarded, rewarded interstitial and app open equivalents) with the matching `RevenueCatAdMob.loadAndTrack...` call. The callbacks are the same ones you already use; `placement` is a free-form label for where the ad is shown.

```dart
await RevenueCatAdMob.loadAndTrackInterstitialAd(
  adUnitId: adUnitId,
  request: const AdRequest(),
  placement: 'level_complete',
  adLoadCallback: InterstitialAdLoadCallback(
    onAdLoaded: (ad) {
      ad.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) => ad.dispose(),
      );
      _interstitial = ad;
    },
    onAdFailedToLoad: (error) => debugPrint('$error'),
  ),
);

// Later. The placement given here overrides the load-time one for this impression.
await _interstitial.showAndTrack(placement: 'level_complete_retry');
```

Setting `fullScreenContentCallback` or `onPaidEvent` inside `onAdLoaded` is fine: the adapter wraps whatever you set there. If you assign `fullScreenContentCallback` later, use `setTrackingFullScreenContentCallback(...)` instead so tracking survives.

## Tracking banner and native ads

Banner and native ads take their listener at construction time, so wrap it:

```dart
final banner = RevenueCatAdMob.createBannerAd(
  adUnitId: adUnitId,
  size: AdSize.banner,
  request: const AdRequest(),
  placement: 'home_bottom',
  listener: BannerAdListener(onAdLoaded: (ad) => setState(() {})),
)..load();

final native = NativeAd(
  adUnitId: adUnitId,
  request: const AdRequest(),
  nativeTemplateStyle: NativeTemplateStyle(templateType: TemplateType.medium),
  listener: RevenueCatAdMob.trackingNativeAdListener(placement: 'feed'),
)..load();
```

## Reward verification

For `RewardedAd` and `RewardedInterstitialAd`, call `enableRewardVerification()` once the ad has loaded and show it with `showWithRewardVerification(...)`. The adapter attaches a RevenueCat token to AdMob's server-side verification options and polls RevenueCat for the verified reward when the user earns it.

```dart
RevenueCatAdMob.loadAndTrackRewardedAd(
  adUnitId: adUnitId,
  request: const AdRequest(),
  placement: 'extra_life',
  rewardedAdLoadCallback: RewardedAdLoadCallback(
    onAdLoaded: (ad) async {
      await ad.enableRewardVerification();
      _rewarded = ad;
    },
    onAdFailedToLoad: (error) => debugPrint('$error'),
  ),
);

await _rewarded.showWithRewardVerification(
  onRewardVerificationStarted: () => showSpinner(),
  onRewardVerificationCompleted: (result) {
    if (result.failed) return showError();
    grant(result.reward);
  },
);
```

The ad unit's server-side verification URL must point at RevenueCat and a reward must be configured for it in the RevenueCat dashboard; see the [rewards docs](https://www.revenuecat.com/docs/ad-monetization/rewards).

## Requirements

* iOS 15.0+ (ad tracking is unavailable below that; calls are ignored with a warning)
* `google_mobile_ads` 8.x
* `purchases_flutter` 10.17.0+
