import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'log.dart';
import 'reward_verification.dart';
import 'tracked_ad_state.dart';
import 'tracker.dart';

/// The four full-screen ad classes each declare their own typed
/// `fullScreenContentCallback` field, so the shared wrapping code reaches it
/// through these accessors instead of a common supertype.
class FullScreenAccess<T extends AdWithoutView> {
  const FullScreenAccess({required this.get, required this.set});

  final FullScreenContentCallback<T>? Function(T ad) get;
  final void Function(T ad, FullScreenContentCallback<T>? callback) set;
}

const interstitialAccess = FullScreenAccess<InterstitialAd>(
  get: _getInterstitial,
  set: _setInterstitial,
);
const appOpenAccess = FullScreenAccess<AppOpenAd>(
  get: _getAppOpen,
  set: _setAppOpen,
);
const rewardedAccess = FullScreenAccess<RewardedAd>(
  get: _getRewarded,
  set: _setRewarded,
);
const rewardedInterstitialAccess = FullScreenAccess<RewardedInterstitialAd>(
  get: _getRewardedInterstitial,
  set: _setRewardedInterstitial,
);

FullScreenContentCallback<InterstitialAd>? _getInterstitial(
  InterstitialAd ad,
) =>
    ad.fullScreenContentCallback;
void _setInterstitial(
  InterstitialAd ad,
  FullScreenContentCallback<InterstitialAd>? callback,
) =>
    ad.fullScreenContentCallback = callback;
FullScreenContentCallback<AppOpenAd>? _getAppOpen(AppOpenAd ad) =>
    ad.fullScreenContentCallback;
void _setAppOpen(AppOpenAd ad, FullScreenContentCallback<AppOpenAd>? callback) =>
    ad.fullScreenContentCallback = callback;
FullScreenContentCallback<RewardedAd>? _getRewarded(RewardedAd ad) =>
    ad.fullScreenContentCallback;
void _setRewarded(
  RewardedAd ad,
  FullScreenContentCallback<RewardedAd>? callback,
) =>
    ad.fullScreenContentCallback = callback;
FullScreenContentCallback<RewardedInterstitialAd>? _getRewardedInterstitial(
  RewardedInterstitialAd ad,
) =>
    ad.fullScreenContentCallback;
void _setRewardedInterstitial(
  RewardedInterstitialAd ad,
  FullScreenContentCallback<RewardedInterstitialAd>? callback,
) =>
    ad.fullScreenContentCallback = callback;

/// Records the load, lets the developer's `onAdLoaded` run (it usually sets
/// `fullScreenContentCallback` and `onPaidEvent`), then wraps whatever it set.
void onFullScreenAdLoaded<T extends AdWithoutView>(
  T ad,
  AdFormat adFormat,
  String? placement,
  FullScreenAccess<T> access,
  void Function() userOnAdLoaded,
) {
  final state = TrackedAdState(
    adFormat: adFormat,
    adUnitId: ad.adUnitId,
    loadPlacement: placement,
  )..updateFromResponse(ad.responseInfo);
  trackedAdStates[ad] = state;
  AdMobTracker.trackLoaded(state);
  userOnAdLoaded();
  installFullScreenTracking(ad, state, access);
}

/// Installs (or re-installs) the tracking wrappers around the callbacks
/// currently set on [ad]. Safe to call repeatedly: a wrapper this adapter
/// installed earlier is recognized and not wrapped twice.
void installFullScreenTracking<T extends AdWithoutView>(
  T ad,
  TrackedAdState state,
  FullScreenAccess<T> access,
) {
  final current = access.get(ad);
  final user = identical(current, state.installedFullScreenCallback)
      ? state.userFullScreenCallback as FullScreenContentCallback<T>?
      : current;
  final wrapper = FullScreenContentCallback<T>(
    onAdShowedFullScreenContent: user?.onAdShowedFullScreenContent,
    onAdImpression: (ad) {
      AdMobTracker.trackDisplayed(state);
      user?.onAdImpression?.call(ad);
    },
    onAdClicked: (ad) {
      AdMobTracker.trackOpened(state);
      user?.onAdClicked?.call(ad);
    },
    onAdWillDismissFullScreenContent: user?.onAdWillDismissFullScreenContent,
    onAdDismissedFullScreenContent: user?.onAdDismissedFullScreenContent,
    onAdFailedToShowFullScreenContent: user?.onAdFailedToShowFullScreenContent,
  );
  state
    ..userFullScreenCallback = user
    ..installedFullScreenCallback = wrapper;
  access.set(ad, wrapper);

  final currentPaid = ad.onPaidEvent;
  final userPaid = identical(currentPaid, state.installedPaidHandler)
      ? state.userPaidHandler
      : currentPaid;
  void paidWrapper(
    Ad ad,
    double valueMicros,
    PrecisionType precision,
    String currencyCode,
  ) {
    AdMobTracker.trackRevenue(state, valueMicros, precision, currencyCode);
    userPaid?.call(ad, valueMicros, precision, currencyCode);
  }

  state
    ..userPaidHandler = userPaid
    ..installedPaidHandler = paidWrapper;
  ad.onPaidEvent = paidWrapper;
}

/// Applies a show-time placement and heals the wrappers if the developer
/// assigned `fullScreenContentCallback` directly after loading.
TrackedAdState? prepareShow<T extends AdWithoutView>(
  T ad,
  String? placement,
  FullScreenAccess<T> access,
) {
  final state = trackedAdStates[ad];
  if (state == null) {
    logWarning(
      'This ad was not loaded through RevenueCatAdMob; it will not be tracked.',
    );
    return null;
  }
  if (placement != null) state.showPlacement = placement;
  installFullScreenTracking(ad, state, access);
  return state;
}

void setTrackingCallback<T extends AdWithoutView>(
  T ad,
  FullScreenContentCallback<T>? callback,
  FullScreenAccess<T> access,
) {
  final state = trackedAdStates[ad];
  if (state == null) {
    access.set(ad, callback);
    return;
  }
  state
    ..userFullScreenCallback = callback
    ..installedFullScreenCallback = null;
  access.set(ad, callback);
  installFullScreenTracking(ad, state, access);
}

extension RevenueCatAdMobInterstitialAd on InterstitialAd {
  /// Shows the ad. A [placement] given here overrides the load-time placement
  /// for the displayed, opened and revenue events of this impression.
  Future<void> showAndTrack({String? placement}) {
    prepareShow(this, placement, interstitialAccess);
    return show();
  }

  /// Sets your own [FullScreenContentCallback] without losing RevenueCat
  /// tracking. Assigning `fullScreenContentCallback` directly after
  /// loading would replace the adapter's wrapper.
  void setTrackingFullScreenContentCallback(
    FullScreenContentCallback<InterstitialAd>? callback,
  ) =>
      setTrackingCallback(this, callback, interstitialAccess);
}

extension RevenueCatAdMobAppOpenAd on AppOpenAd {
  /// Shows the ad. A [placement] given here overrides the load-time placement
  /// for the displayed, opened and revenue events of this impression.
  Future<void> showAndTrack({String? placement}) {
    prepareShow(this, placement, appOpenAccess);
    return show();
  }

  /// Sets your own [FullScreenContentCallback] without losing RevenueCat
  /// tracking.
  void setTrackingFullScreenContentCallback(
    FullScreenContentCallback<AppOpenAd>? callback,
  ) =>
      setTrackingCallback(this, callback, appOpenAccess);
}

extension RevenueCatAdMobRewardedAd on RewardedAd {
  /// Shows the ad. A [placement] given here overrides the load-time placement
  /// for the displayed, opened and revenue events of this impression.
  Future<void> showAndTrack({
    String? placement,
    required OnUserEarnedRewardCallback onUserEarnedReward,
  }) {
    prepareShow(this, placement, rewardedAccess);
    return show(onUserEarnedReward: onUserEarnedReward);
  }

  /// Sets your own [FullScreenContentCallback] without losing RevenueCat
  /// tracking.
  void setTrackingFullScreenContentCallback(
    FullScreenContentCallback<RewardedAd>? callback,
  ) =>
      setTrackingCallback(this, callback, rewardedAccess);

  /// Attaches a RevenueCat reward-verification token to this ad's server-side
  /// verification options. Call after the ad has loaded and before showing it.
  Future<void> enableRewardVerification() => enableRewardVerificationFor(
        this,
        AdFormat.rewarded,
        setServerSideOptions,
      );

  /// Shows the ad and verifies the earned reward with RevenueCat.
  ///
  /// [onRewardVerificationCompleted] is called exactly once. When
  /// [enableRewardVerification] was not called for this ad, it receives a
  /// failed result.
  Future<void> showWithRewardVerification({
    String? placement,
    OnUserEarnedRewardCallback? onUserEarnedReward,
    RewardVerificationStartedCallback? onRewardVerificationStarted,
    required RewardVerificationCompletedCallback onRewardVerificationCompleted,
  }) {
    final state = prepareShow(this, placement, rewardedAccess);
    return show(
      onUserEarnedReward: rewardVerifyingHandler(
        state: state,
        onUserEarnedReward: onUserEarnedReward,
        onRewardVerificationStarted: onRewardVerificationStarted,
        onRewardVerificationCompleted: onRewardVerificationCompleted,
      ),
    );
  }
}

extension RevenueCatAdMobRewardedInterstitialAd on RewardedInterstitialAd {
  /// Shows the ad. A [placement] given here overrides the load-time placement
  /// for the displayed, opened and revenue events of this impression.
  Future<void> showAndTrack({
    String? placement,
    required OnUserEarnedRewardCallback onUserEarnedReward,
  }) {
    prepareShow(this, placement, rewardedInterstitialAccess);
    return show(onUserEarnedReward: onUserEarnedReward);
  }

  /// Sets your own [FullScreenContentCallback] without losing RevenueCat
  /// tracking.
  void setTrackingFullScreenContentCallback(
    FullScreenContentCallback<RewardedInterstitialAd>? callback,
  ) =>
      setTrackingCallback(this, callback, rewardedInterstitialAccess);

  /// Attaches a RevenueCat reward-verification token to this ad's server-side
  /// verification options. Call after the ad has loaded and before showing it.
  Future<void> enableRewardVerification() => enableRewardVerificationFor(
        this,
        AdFormat.rewardedInterstitial,
        setServerSideOptions,
      );

  /// Shows the ad and verifies the earned reward with RevenueCat.
  ///
  /// [onRewardVerificationCompleted] is called exactly once. When
  /// [enableRewardVerification] was not called for this ad, it receives a
  /// failed result.
  Future<void> showWithRewardVerification({
    String? placement,
    OnUserEarnedRewardCallback? onUserEarnedReward,
    RewardVerificationStartedCallback? onRewardVerificationStarted,
    required RewardVerificationCompletedCallback onRewardVerificationCompleted,
  }) {
    final state = prepareShow(this, placement, rewardedInterstitialAccess);
    return show(
      onUserEarnedReward: rewardVerifyingHandler(
        state: state,
        onUserEarnedReward: onUserEarnedReward,
        onRewardVerificationStarted: onRewardVerificationStarted,
        onRewardVerificationCompleted: onRewardVerificationCompleted,
      ),
    );
  }
}
