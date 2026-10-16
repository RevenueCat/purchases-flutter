import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

/// Per-ad bookkeeping kept in a weak side table, so the adapter never changes
/// the lifetime of the `google_mobile_ads` objects it tracks.
class TrackedAdState {
  TrackedAdState({
    required this.adFormat,
    required this.adUnitId,
    this.loadPlacement,
  });

  final AdFormat adFormat;
  final String adUnitId;

  /// Placement given when the ad was loaded. Load-time events keep it even if
  /// a show-time placement is set later.
  String? loadPlacement;

  /// Placement given at show time; overrides [loadPlacement] for displayed,
  /// opened, revenue and reward events.
  String? showPlacement;

  String impressionId = '';
  String? networkName;

  /// Set by `enableRewardVerification`; consumed when the reward fires.
  String? clientTransactionId;
  bool rewardVerificationDelivered = false;

  /// The callback objects this adapter installed, so a later re-install can
  /// tell the developer's callback apart from its own wrapper.
  Object? installedFullScreenCallback;
  Object? userFullScreenCallback;
  OnPaidEventCallback? installedPaidHandler;
  OnPaidEventCallback? userPaidHandler;

  String? get placement => showPlacement ?? loadPlacement;

  void updateFromResponse(ResponseInfo? info) {
    impressionId = info?.responseId ?? '';
    networkName = info?.loadedAdapterResponseInfo?.adapterClassName ??
        info?.mediationAdapterClassName;
  }

  RewardedAdTrackingMetadata get trackingMetadata => RewardedAdTrackingMetadata(
        networkName: networkName,
        mediatorName: AdMediatorName.adMob,
        adFormat: adFormat,
        placement: placement,
        adUnitId: adUnitId,
        impressionId: impressionId,
        captureMethod: AdCaptureMethod.flutterAdMobAdapter,
      );
}

final Expando<TrackedAdState> trackedAdStates =
    Expando<TrackedAdState>('purchases_admob_flutter');

/// Returns the state for [ad], creating it when the ad was not loaded through
/// the adapter (for example a banner whose listener was wrapped after the
/// fact).
TrackedAdState stateFor(Ad ad, AdFormat adFormat, String? placement) =>
    trackedAdStates[ad] ??= TrackedAdState(
      adFormat: adFormat,
      adUnitId: ad.adUnitId,
      loadPlacement: placement,
    )..updateFromResponse(ad.responseInfo);
