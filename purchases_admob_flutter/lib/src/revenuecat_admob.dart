import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'full_screen_ads.dart';
import 'tracked_ad_state.dart';
import 'tracker.dart';

/// Entry point of the RevenueCat AdMob adapter.
///
/// Full-screen ads are loaded through the `loadAndTrack*` methods; banner and
/// native ads are tracked by wrapping their listener with
/// [trackingBannerAdListener] / [trackingNativeAdListener] (or by creating the
/// banner with [createBannerAd]).
///
/// Every method takes an optional `placement`, a free-form label for where in
/// your app the ad is shown. The `showAndTrack` extensions can override it at
/// show time.
class RevenueCatAdMob {
  RevenueCatAdMob._();

  static Future<void> loadAndTrackInterstitialAd({
    required String adUnitId,
    required AdRequest request,
    String? placement,
    required InterstitialAdLoadCallback adLoadCallback,
  }) =>
      InterstitialAd.load(
        adUnitId: adUnitId,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) => onFullScreenAdLoaded(
            ad,
            AdFormat.interstitial,
            placement,
            interstitialAccess,
            () => adLoadCallback.onAdLoaded(ad),
          ),
          onAdFailedToLoad: (error) {
            AdMobTracker.trackFailedToLoad(
              adUnitId: adUnitId,
              adFormat: AdFormat.interstitial,
              placement: placement,
              error: error,
            );
            adLoadCallback.onAdFailedToLoad(error);
          },
        ),
      );

  static Future<void> loadAndTrackAppOpenAd({
    required String adUnitId,
    required AdRequest request,
    String? placement,
    required AppOpenAdLoadCallback adLoadCallback,
  }) =>
      AppOpenAd.load(
        adUnitId: adUnitId,
        request: request,
        adLoadCallback: AppOpenAdLoadCallback(
          onAdLoaded: (ad) => onFullScreenAdLoaded(
            ad,
            AdFormat.appOpen,
            placement,
            appOpenAccess,
            () => adLoadCallback.onAdLoaded(ad),
          ),
          onAdFailedToLoad: (error) {
            AdMobTracker.trackFailedToLoad(
              adUnitId: adUnitId,
              adFormat: AdFormat.appOpen,
              placement: placement,
              error: error,
            );
            adLoadCallback.onAdFailedToLoad(error);
          },
        ),
      );

  static Future<void> loadAndTrackRewardedAd({
    required String adUnitId,
    required AdRequest request,
    String? placement,
    required RewardedAdLoadCallback rewardedAdLoadCallback,
  }) =>
      RewardedAd.load(
        adUnitId: adUnitId,
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) => onFullScreenAdLoaded(
            ad,
            AdFormat.rewarded,
            placement,
            rewardedAccess,
            () => rewardedAdLoadCallback.onAdLoaded(ad),
          ),
          onAdFailedToLoad: (error) {
            AdMobTracker.trackFailedToLoad(
              adUnitId: adUnitId,
              adFormat: AdFormat.rewarded,
              placement: placement,
              error: error,
            );
            rewardedAdLoadCallback.onAdFailedToLoad(error);
          },
        ),
      );

  static Future<void> loadAndTrackRewardedInterstitialAd({
    required String adUnitId,
    required AdRequest request,
    String? placement,
    required RewardedInterstitialAdLoadCallback
        rewardedInterstitialAdLoadCallback,
  }) =>
      RewardedInterstitialAd.load(
        adUnitId: adUnitId,
        request: request,
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          onAdLoaded: (ad) => onFullScreenAdLoaded(
            ad,
            AdFormat.rewardedInterstitial,
            placement,
            rewardedInterstitialAccess,
            () => rewardedInterstitialAdLoadCallback.onAdLoaded(ad),
          ),
          onAdFailedToLoad: (error) {
            AdMobTracker.trackFailedToLoad(
              adUnitId: adUnitId,
              adFormat: AdFormat.rewardedInterstitial,
              placement: placement,
              error: error,
            );
            rewardedInterstitialAdLoadCallback.onAdFailedToLoad(error);
          },
        ),
      );

  /// Creates a [BannerAd] whose listener reports to RevenueCat. Call `load()`
  /// on the result as usual.
  static BannerAd createBannerAd({
    required String adUnitId,
    required AdSize size,
    required AdRequest request,
    String? placement,
    BannerAdListener? listener,
  }) =>
      BannerAd(
        adUnitId: adUnitId,
        size: size,
        request: request,
        listener: trackingBannerAdListener(
          placement: placement,
          listener: listener,
        ),
      );

  /// Wraps [listener] so banner events are reported to RevenueCat. Pass the
  /// result as the `listener` of a [BannerAd].
  ///
  /// Banners refresh in place; each refresh reports a new loaded event with
  /// the new response id, and later events use that id.
  static BannerAdListener trackingBannerAdListener({
    String? placement,
    BannerAdListener? listener,
  }) =>
      BannerAdListener(
        onAdLoaded: (ad) {
          final state = stateFor(ad, AdFormat.banner, placement)
            ..updateFromResponse(ad.responseInfo);
          AdMobTracker.trackLoaded(state);
          listener?.onAdLoaded?.call(ad);
        },
        onAdFailedToLoad: (ad, error) {
          AdMobTracker.trackFailedToLoad(
            adUnitId: ad.adUnitId,
            adFormat: AdFormat.banner,
            placement: placement,
            error: error,
          );
          listener?.onAdFailedToLoad?.call(ad, error);
        },
        onAdImpression: (ad) {
          AdMobTracker.trackDisplayed(stateFor(ad, AdFormat.banner, placement));
          listener?.onAdImpression?.call(ad);
        },
        onAdClicked: (ad) {
          AdMobTracker.trackOpened(stateFor(ad, AdFormat.banner, placement));
          listener?.onAdClicked?.call(ad);
        },
        onPaidEvent: (ad, valueMicros, precision, currencyCode) {
          AdMobTracker.trackRevenue(
            stateFor(ad, AdFormat.banner, placement),
            valueMicros,
            precision,
            currencyCode,
          );
          listener?.onPaidEvent?.call(ad, valueMicros, precision, currencyCode);
        },
        onAdOpened: listener?.onAdOpened,
        onAdClosed: listener?.onAdClosed,
        onAdWillDismissScreen: listener?.onAdWillDismissScreen,
      );

  /// Wraps [listener] so native ad events are reported to RevenueCat. Pass the
  /// result as the `listener` of a [NativeAd].
  static NativeAdListener trackingNativeAdListener({
    String? placement,
    NativeAdListener? listener,
  }) =>
      NativeAdListener(
        onAdLoaded: (ad) {
          final state = stateFor(ad, AdFormat.nativeAd, placement)
            ..updateFromResponse(ad.responseInfo);
          AdMobTracker.trackLoaded(state);
          listener?.onAdLoaded?.call(ad);
        },
        onAdFailedToLoad: (ad, error) {
          AdMobTracker.trackFailedToLoad(
            adUnitId: ad.adUnitId,
            adFormat: AdFormat.nativeAd,
            placement: placement,
            error: error,
          );
          listener?.onAdFailedToLoad?.call(ad, error);
        },
        onAdImpression: (ad) {
          AdMobTracker.trackDisplayed(
            stateFor(ad, AdFormat.nativeAd, placement),
          );
          listener?.onAdImpression?.call(ad);
        },
        onAdClicked: (ad) {
          AdMobTracker.trackOpened(stateFor(ad, AdFormat.nativeAd, placement));
          listener?.onAdClicked?.call(ad);
        },
        onPaidEvent: (ad, valueMicros, precision, currencyCode) {
          AdMobTracker.trackRevenue(
            stateFor(ad, AdFormat.nativeAd, placement),
            valueMicros,
            precision,
            currencyCode,
          );
          listener?.onPaidEvent?.call(ad, valueMicros, precision, currencyCode);
        },
        onAdOpened: listener?.onAdOpened,
        onAdClosed: listener?.onAdClosed,
        onAdWillDismissScreen: listener?.onAdWillDismissScreen,
      );
}
