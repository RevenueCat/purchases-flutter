import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:purchases_admob_flutter/purchases_admob_flutter.dart';
import 'package:purchases_flutter/models/reward_verification_result.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _PurchasesAdMobFlutterApiTest {
  void _checkLoadAndTrackInterstitialAd() async {
    Future<void> f1 = RevenueCatAdMob.loadAndTrackInterstitialAd(
      adUnitId: '',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {},
        onAdFailedToLoad: (LoadAdError error) {},
      ),
    );
    Future<void> f2 = RevenueCatAdMob.loadAndTrackInterstitialAd(
      adUnitId: '',
      request: const AdRequest(),
      placement: 'placement',
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {},
        onAdFailedToLoad: (LoadAdError error) {},
      ),
    );
  }

  void _checkLoadAndTrackAppOpenAd() async {
    Future<void> f1 = RevenueCatAdMob.loadAndTrackAppOpenAd(
      adUnitId: '',
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (AppOpenAd ad) {},
        onAdFailedToLoad: (LoadAdError error) {},
      ),
    );
    Future<void> f2 = RevenueCatAdMob.loadAndTrackAppOpenAd(
      adUnitId: '',
      request: const AdRequest(),
      placement: 'placement',
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (AppOpenAd ad) {},
        onAdFailedToLoad: (LoadAdError error) {},
      ),
    );
  }

  void _checkLoadAndTrackRewardedAd() async {
    Future<void> f1 = RevenueCatAdMob.loadAndTrackRewardedAd(
      adUnitId: '',
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {},
        onAdFailedToLoad: (LoadAdError error) {},
      ),
    );
    Future<void> f2 = RevenueCatAdMob.loadAndTrackRewardedAd(
      adUnitId: '',
      request: const AdRequest(),
      placement: 'placement',
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {},
        onAdFailedToLoad: (LoadAdError error) {},
      ),
    );
  }

  void _checkLoadAndTrackRewardedInterstitialAd() async {
    Future<void> f1 = RevenueCatAdMob.loadAndTrackRewardedInterstitialAd(
      adUnitId: '',
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (RewardedInterstitialAd ad) {},
        onAdFailedToLoad: (LoadAdError error) {},
      ),
    );
    Future<void> f2 = RevenueCatAdMob.loadAndTrackRewardedInterstitialAd(
      adUnitId: '',
      request: const AdRequest(),
      placement: 'placement',
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (RewardedInterstitialAd ad) {},
        onAdFailedToLoad: (LoadAdError error) {},
      ),
    );
  }

  void _checkCreateBannerAd() {
    BannerAd b1 = RevenueCatAdMob.createBannerAd(
      adUnitId: '',
      size: AdSize.banner,
      request: const AdRequest(),
    );
    BannerAd b2 = RevenueCatAdMob.createBannerAd(
      adUnitId: '',
      size: AdSize.banner,
      request: const AdRequest(),
      placement: 'placement',
      listener: const BannerAdListener(),
    );
  }

  void _checkTrackingListeners() {
    BannerAdListener l1 = RevenueCatAdMob.trackingBannerAdListener();
    BannerAdListener l2 = RevenueCatAdMob.trackingBannerAdListener(
      placement: 'placement',
      listener: const BannerAdListener(),
    );
    NativeAdListener n1 = RevenueCatAdMob.trackingNativeAdListener();
    NativeAdListener n2 = RevenueCatAdMob.trackingNativeAdListener(
      placement: 'placement',
      listener: NativeAdListener(),
    );
  }

  void _checkInterstitialAd(InterstitialAd ad) async {
    Future<void> f1 = ad.showAndTrack();
    Future<void> f2 = ad.showAndTrack(placement: 'placement');
    ad.setTrackingFullScreenContentCallback(null);
    ad.setTrackingFullScreenContentCallback(
      const FullScreenContentCallback<InterstitialAd>(),
    );
  }

  void _checkAppOpenAd(AppOpenAd ad) async {
    Future<void> f1 = ad.showAndTrack();
    Future<void> f2 = ad.showAndTrack(placement: 'placement');
    ad.setTrackingFullScreenContentCallback(null);
    ad.setTrackingFullScreenContentCallback(
      const FullScreenContentCallback<AppOpenAd>(),
    );
  }

  void _checkRewardedAd(RewardedAd ad) async {
    Future<void> f1 = ad.showAndTrack(
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {},
    );
    Future<void> f2 = ad.showAndTrack(
      placement: 'placement',
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {},
    );
    Future<void> f3 = ad.enableRewardVerification();
    Future<void> f4 = ad.showWithRewardVerification(
      onRewardVerificationCompleted: (RewardVerificationResult result) {},
    );
    Future<void> f5 = ad.showWithRewardVerification(
      placement: 'placement',
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {},
      onRewardVerificationStarted: () {},
      onRewardVerificationCompleted: (RewardVerificationResult result) {},
    );
    ad.setTrackingFullScreenContentCallback(null);
    ad.setTrackingFullScreenContentCallback(
      const FullScreenContentCallback<RewardedAd>(),
    );
  }

  void _checkRewardedInterstitialAd(RewardedInterstitialAd ad) async {
    Future<void> f1 = ad.showAndTrack(
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {},
    );
    Future<void> f2 = ad.showAndTrack(
      placement: 'placement',
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {},
    );
    Future<void> f3 = ad.enableRewardVerification();
    Future<void> f4 = ad.showWithRewardVerification(
      onRewardVerificationCompleted: (RewardVerificationResult result) {},
    );
    Future<void> f5 = ad.showWithRewardVerification(
      placement: 'placement',
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {},
      onRewardVerificationStarted: () {},
      onRewardVerificationCompleted: (RewardVerificationResult result) {},
    );
    ad.setTrackingFullScreenContentCallback(null);
    ad.setTrackingFullScreenContentCallback(
      const FullScreenContentCallback<RewardedInterstitialAd>(),
    );
  }

  void _checkCallbackTypes(
    RewardVerificationStartedCallback started,
    RewardVerificationCompletedCallback completed,
  ) {
    void Function() s = started;
    void Function(RewardVerificationResult) c = completed;
  }
}
