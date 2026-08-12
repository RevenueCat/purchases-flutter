import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

/// Your RevenueCat public API key (https://app.revenuecat.com → Project settings → API keys).
/// One per platform; both can be a Test Store key while developing.
const _appleApiKey = 'appl_REPLACE_ME';
const _googleApiKey = 'goog_REPLACE_ME';

/// Google's official **test** rewarded-interstitial ad unit. Always fills with a
/// test ad and is safe to commit. Swap for your own AdMob unit (with its
/// server-side verification URL pointed at RevenueCat) to grant a real reward.
const _iosAdUnitId = 'ca-app-pub-3940256099942544/6978759866';
const _androidAdUnitId = 'ca-app-pub-3940256099942544/5354046379';

String get _adUnitId => Platform.isIOS ? _iosAdUnitId : _androidAdUnitId;

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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Purchases.configure(
    PurchasesConfiguration(Platform.isIOS ? _appleApiKey : _googleApiKey),
  );
  runApp(const MaterialApp(home: RewardedAdScreen()));
}

class RewardedAdScreen extends StatefulWidget {
  const RewardedAdScreen({super.key});

  @override
  State<RewardedAdScreen> createState() => _RewardedAdScreenState();
}

class _RewardedAdScreenState extends State<RewardedAdScreen> {
  RewardedInterstitialAd? _ad;
  RewardVerificationToken? _token;
  String _status = 'No ad loaded';
  String? _result;

  bool _busy = false;

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  Future<void> _loadAd() async {
    setState(() {
      _busy = true;
      _status = 'Loading ad…';
      _result = null;
    });

    RewardedInterstitialAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (ad) async {
          // 1. Use the loaded ad's response ID as the impression ID, then
          //    generate a verification token for it. Forward the token's
          //    customData + appUserID to the ad network's SSV options; keep the
          //    clientTransactionId to poll for the verified reward later.
          final token = await Purchases.generateRewardVerificationToken(
            ad.responseInfo?.responseId ?? '',
          );
          _token = token;

          // 2. Wire RevenueCat verification into AdMob's server-side verification.
          await ad.setServerSideOptions(
            ServerSideVerificationOptions(
              userId: token.appUserID,
              customData: token.customData,
            ),
          );
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              if (!mounted) return;
              setState(() {
                _ad = null;
                _busy = false;
              });
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              if (!mounted) return;
              setState(() {
                _ad = null;
                _busy = false;
                _status = 'Failed to show: $error';
              });
            },
          );
          if (!mounted) return;
          setState(() {
            _ad = ad;
            _busy = false;
            _status = 'Ad ready';
          });
        },
        onAdFailedToLoad: (error) {
          if (!mounted) return;
          setState(() {
            _busy = false;
            _status = 'Failed to load: $error';
          });
        },
      ),
    );
  }

  Future<void> _showAd() async {
    final ad = _ad;
    final token = _token;
    if (ad == null || token == null) return;
    setState(() => _busy = true);

    await ad.show(
      onUserEarnedReward: (ad, _) async {
        // 3. The ad was watched. AdMob fires its SSV callback to RevenueCat;
        //    poll until verification reaches a terminal state.
        setState(() => _status = 'Verifying reward…');
        final result = await Purchases.pollRewardVerification(
          token.clientTransactionId,
        );
        if (!mounted) return;
        setState(() {
          _status = 'Done';
          final reward = result.reward;
          _result = result.failed || reward == null
              ? '❌ verification failed'
              : '✅ ${_describeReward(reward)}'
                    '${result.moreRewards.isEmpty ? '' : ' (+${result.moreRewards.length} more)'}';
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ad = _ad;
    return Scaffold(
      appBar: AppBar(title: const Text('Rewarded Ad (SSV)')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_status),
            if (_result != null) ...[
              const SizedBox(height: 16),
              Text(_result!, style: Theme.of(context).textTheme.titleMedium),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _busy ? null : (ad != null ? _showAd : _loadAd),
              child: Text(ad != null ? 'Watch ad to earn reward' : 'Load ad'),
            ),
          ],
        ),
      ),
    );
  }
}
