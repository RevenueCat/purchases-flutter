# AdMob adapter sample

Exercises every path of `purchases_admob_flutter`, the RevenueCat adapter for
`google_mobile_ads`: interstitial, rewarded, rewarded interstitial, app open
and banner ads are loaded through the adapter, which reports loaded,
failed-to-load, displayed, opened and revenue events to RevenueCat. The two
rewarded tabs additionally verify the earned reward server-side.

The whole app lives in [`lib/main.dart`](lib/main.dart). The interesting lines
per format are:

```dart
// Full-screen formats: swap `InterstitialAd.load` for the adapter's loader.
await RevenueCatAdMob.loadAndTrackInterstitialAd(
  adUnitId: adUnitId,
  request: const AdRequest(),
  placement: 'interstitial_tab',
  adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: ..., onAdFailedToLoad: ...),
);
await ad.showAndTrack(placement: 'interstitial_shown');

// Rewarded formats: enable verification after load, show with verification.
await ad.enableRewardVerification();
await ad.showWithRewardVerification(
  onRewardVerificationCompleted: (result) => ...,
);

// Banner: create it through the adapter so its listener is wrapped.
final banner = RevenueCatAdMob.createBannerAd(adUnitId: ..., size: AdSize.banner, request: ..., placement: 'banner_tab');
```

## Run (smoke test, no reward)

```sh
flutter pub get
flutter run --dart-define=RC_APPLE_API_KEY=appl_... --dart-define=RC_GOOGLE_API_KEY=goog_...
```

A Test Store key is fine. Out of the box the app uses Google's public test ad
units, so every format fills and every tracking event fires, but reward
verification returns `failed` because no reward is configured behind a test
unit. With `Purchases.setLogLevel(LogLevel.debug)` (already on) the RevenueCat
debug log shows each tracked event.

## Test a real grant

1. Create rewarded / rewarded interstitial ad units in AdMob with their
   **Server-side verification URL** pointed at RevenueCat, and put your AdMob
   app id in `ios/Runner/Info.plist` (`GADApplicationIdentifier`) and
   `android/app/src/main/AndroidManifest.xml`
   (`com.google.android.gms.ads.APPLICATION_ID`).
2. Configure a reward (virtual currency or entitlement) for those ad units in
   the RevenueCat dashboard.
3. Run with your real key and ad units:

```sh
flutter run \
  --dart-define=RC_APPLE_API_KEY=appl_... \
  --dart-define=ADMOB_IOS_REWARDED=ca-app-pub-.../... \
  --dart-define=ADMOB_IOS_REWARDED_INTERSTITIAL=ca-app-pub-.../...
```

The Android equivalents are `RC_GOOGLE_API_KEY`, `ADMOB_ANDROID_REWARDED` and
`ADMOB_ANDROID_REWARDED_INTERSTITIAL`; every format has an `ADMOB_<PLATFORM>_<FORMAT>`
define, see the top of `lib/main.dart`.
