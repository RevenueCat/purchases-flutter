/// RevenueCat adapter for the `google_mobile_ads` plugin.
///
/// Load ads through [RevenueCatAdMob] (or wrap your banner/native listeners
/// with it) and the adapter reports loaded, failed-to-load, displayed, opened
/// and revenue events to RevenueCat on your behalf. Rewarded and rewarded
/// interstitial ads additionally get server-side reward verification through
/// `enableRewardVerification()` and `showWithRewardVerification(...)`.
library;

export 'src/full_screen_ads.dart'
    show
        RevenueCatAdMobAppOpenAd,
        RevenueCatAdMobInterstitialAd,
        RevenueCatAdMobRewardedAd,
        RevenueCatAdMobRewardedInterstitialAd;
export 'src/revenuecat_admob.dart' show RevenueCatAdMob;
export 'src/reward_verification.dart'
    show RewardVerificationCompletedCallback, RewardVerificationStartedCallback;
