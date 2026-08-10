import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'constant.dart';

String get _rewardedAdUnitId =>
    Platform.isIOS ? iosRewardedAdUnitId : androidRewardedAdUnitId;

/// Renders a granted reward. Each [VerifiedReward] subtype carries only the
/// fields relevant to it, so we branch on the concrete type.
String _describeReward(VerifiedReward reward) {
  if (reward is VerifiedVirtualCurrencyReward) {
    return '+${reward.amount} ${reward.code}';
  } else if (reward is VerifiedEntitlementReward) {
    return 'entitlement "${reward.identifier}"';
  } else if (reward is VerifiedNoReward) {
    return 'no reward';
  }
  return 'unsupported reward';
}

class AdRewardsTestingScreen extends StatefulWidget {
  const AdRewardsTestingScreen({Key? key}) : super(key: key);

  @override
  State<AdRewardsTestingScreen> createState() => _AdRewardsTestingScreenState();
}

class _AdRewardsTestingScreenState extends State<AdRewardsTestingScreen> {
  RewardedAd? _ad;
  RewardVerificationToken? _token;
  String? _impressionId;
  String _status = 'Loading ad…';
  String? _result;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  Future<void> _loadAd() async {
    setState(() => _status = 'Loading ad…');

    RewardedAd.load(
      adUnitId: _rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) async {
          // 1. Use the loaded ad's response ID as the impression ID, then
          //    generate a verification token for it. Forward the token's
          //    customData + appUserID to the ad network's SSV options; keep the
          //    clientTransactionId to poll for the verified reward later.
          final impressionId = ad.responseInfo?.responseId ?? '';
          final token =
              await Purchases.generateRewardVerificationToken(impressionId);
          _token = token;

          // 2. Wire RevenueCat verification into AdMob's server-side verification.
          await ad.setServerSideOptions(ServerSideVerificationOptions(
            userId: token.appUserID,
            customData: token.customData,
          ));
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _ad = null;
              _loadAd();
            },
          );
          if (!mounted) return;
          setState(() {
            _ad = ad;
            _impressionId = impressionId;
            _status = 'Ad ready';
          });
        },
        onAdFailedToLoad: (error) {
          if (!mounted) return;
          setState(() => _status = 'Failed to load: $error');
        },
      ),
    );
  }

  Future<void> _showAd() async {
    final ad = _ad;
    final token = _token;
    if (ad == null || token == null) return;
    _ad = null;

    await ad.show(onUserEarnedReward: (ad, _) async {
      // 3. The ad was watched. AdMob fires its SSV callback to RevenueCat;
      //    poll until verification reaches a terminal state.
      setState(() => _status = 'Verifying reward…');
      final result =
          await Purchases.pollRewardVerification(token.clientTransactionId);
      if (!mounted) return;
      setState(() {
        _status = 'Done';
        final reward = result.reward;
        _result = result.failed || reward == null
            ? '❌ verification failed'
            : '✅ ${_describeReward(reward)}'
                '${result.moreRewards.isEmpty ? '' : ' (+${result.moreRewards.length} more)'}';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ad Rewards Testing')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_status),
            if (_impressionId != null) ...[
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'impressionId: ${_impressionId!}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
            if (_result != null) ...[
              const SizedBox(height: 16),
              Text(_result!, style: Theme.of(context).textTheme.titleMedium),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _ad != null ? _showAd : null,
              child: const Text('Watch ad to earn reward'),
            ),
          ],
        ),
      ),
    );
  }
}
