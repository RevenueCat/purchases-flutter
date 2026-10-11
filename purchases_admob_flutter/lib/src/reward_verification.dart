import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'log.dart';
import 'tracked_ad_state.dart';
import 'tracker.dart';

/// Called as soon as the user earned the reward, before verification starts.
typedef RewardVerificationStartedCallback = void Function();

/// Called exactly once with the verification outcome.
typedef RewardVerificationCompletedCallback = void Function(
  RewardVerificationResult result,
);

const _failedResult = RewardVerificationResult(failed: true);

/// Generates a RevenueCat verification token for the loaded [ad] and attaches
/// it to AdMob's server-side verification options through [setOptions].
Future<void> enableRewardVerificationFor(
  AdWithoutView ad,
  AdFormat adFormat,
  Future<void> Function(ServerSideVerificationOptions options) setOptions,
) async {
  var configured = false;
  try {
    configured = await AdMobTracker.isConfigured();
  } catch (e) {
    logWarning('Could not check whether Purchases is configured: $e');
  }
  if (!configured) {
    logWarning(
      'Purchases is not configured; reward verification was not enabled.',
    );
    return;
  }

  final state = stateFor(ad, adFormat, null);
  if (state.impressionId.isEmpty) {
    logWarning(
      'The loaded ad has no responseId; reward verification will use an '
      'empty impression id.',
    );
  }
  try {
    final token =
        await Purchases.generateRewardVerificationToken(state.impressionId);
    await setOptions(
      ServerSideVerificationOptions(
        userId: token.appUserID,
        customData: token.customData,
      ),
    );
    state
      ..clientTransactionId = token.clientTransactionId
      ..rewardVerificationDelivered = false;
  } catch (e) {
    logWarning('Could not enable reward verification: $e');
  }
}

/// Wraps the developer's reward callback so the reward is verified with
/// RevenueCat when AdMob reports it as earned.
OnUserEarnedRewardCallback rewardVerifyingHandler({
  required TrackedAdState? state,
  required OnUserEarnedRewardCallback? onUserEarnedReward,
  required RewardVerificationStartedCallback? onRewardVerificationStarted,
  required RewardVerificationCompletedCallback onRewardVerificationCompleted,
}) =>
    (ad, reward) {
      onUserEarnedReward?.call(ad, reward);
      onRewardVerificationStarted?.call();

      final clientTransactionId = state?.clientTransactionId;
      if (state == null || clientTransactionId == null) {
        logWarning(
          'Reward earned but reward verification was not enabled for this ad. '
          'Call enableRewardVerification() after the ad loads.',
        );
        onRewardVerificationCompleted(_failedResult);
        return;
      }

      void deliver(RewardVerificationResult result) {
        if (state.rewardVerificationDelivered) return;
        state.rewardVerificationDelivered = true;
        onRewardVerificationCompleted(result);
      }

      Purchases.pollRewardVerification(
        clientTransactionId,
        trackingMetadata: state.trackingMetadata,
      ).then(deliver).catchError((Object e) {
        logWarning('Reward verification failed: $e');
        deliver(_failedResult);
      });
    };
