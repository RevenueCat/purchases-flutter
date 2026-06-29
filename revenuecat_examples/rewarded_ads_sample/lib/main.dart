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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Purchases.configure(PurchasesConfiguration(
    Platform.isIOS ? _appleApiKey : _googleApiKey,
  ));
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

    // 1. Generate a verification token for this impression. Forward its
    //    customData + appUserID to the ad network's SSV options; keep the
    //    clientTransactionId to poll for the verified reward later.
    final token = await Purchases.generateRewardVerificationToken(
      DateTime.now().microsecondsSinceEpoch.toString(),
    );
    _token = token;

    RewardedInterstitialAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (ad) async {
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
        _result = result.failed
            ? '❌ verification failed'
            : '✅ ${result.reward?.type} '
                '${result.reward?.identifier ?? result.reward?.code ?? ''} '
                '(+${result.moreRewards.length} more)';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: _ad != null ? _showAd : null,
              child: const Text('Watch ad to earn reward'),
            ),
          ],
        ),
      ),
    );
  }
}
