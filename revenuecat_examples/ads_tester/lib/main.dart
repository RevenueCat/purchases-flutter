import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:purchases_admob_flutter/purchases_admob_flutter.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

/// Configuration can be overridden at build time, for example:
///
/// ```sh
/// flutter run --dart-define=RC_APPLE_API_KEY=appl_... \
///   --dart-define=ADMOB_IOS_REWARDED=ca-app-pub-.../...
/// ```
///
/// Out of the box the app uses a placeholder RevenueCat key and Google's public
/// test ad units, which always fill but never grant a reward.
const _appleApiKey =
    String.fromEnvironment('RC_APPLE_API_KEY', defaultValue: 'appl_REPLACE_ME');
const _googleApiKey =
    String.fromEnvironment('RC_GOOGLE_API_KEY', defaultValue: 'goog_REPLACE_ME');

class _AdUnits {
  const _AdUnits({
    required this.interstitial,
    required this.rewarded,
    required this.rewardedInterstitial,
    required this.appOpen,
    required this.banner,
  });

  final String interstitial;
  final String rewarded;
  final String rewardedInterstitial;
  final String appOpen;
  final String banner;
}

const _iosAdUnits = _AdUnits(
  interstitial: String.fromEnvironment(
    'ADMOB_IOS_INTERSTITIAL',
    defaultValue: 'ca-app-pub-3940256099942544/4411468910',
  ),
  rewarded: String.fromEnvironment(
    'ADMOB_IOS_REWARDED',
    defaultValue: 'ca-app-pub-3940256099942544/1712485313',
  ),
  rewardedInterstitial: String.fromEnvironment(
    'ADMOB_IOS_REWARDED_INTERSTITIAL',
    defaultValue: 'ca-app-pub-3940256099942544/6978759866',
  ),
  appOpen: String.fromEnvironment(
    'ADMOB_IOS_APP_OPEN',
    defaultValue: 'ca-app-pub-3940256099942544/5575463023',
  ),
  banner: String.fromEnvironment(
    'ADMOB_IOS_BANNER',
    defaultValue: 'ca-app-pub-3940256099942544/2435281174',
  ),
);

const _androidAdUnits = _AdUnits(
  interstitial: String.fromEnvironment(
    'ADMOB_ANDROID_INTERSTITIAL',
    defaultValue: 'ca-app-pub-3940256099942544/1033173712',
  ),
  rewarded: String.fromEnvironment(
    'ADMOB_ANDROID_REWARDED',
    defaultValue: 'ca-app-pub-3940256099942544/5224354917',
  ),
  rewardedInterstitial: String.fromEnvironment(
    'ADMOB_ANDROID_REWARDED_INTERSTITIAL',
    defaultValue: 'ca-app-pub-3940256099942544/5354046379',
  ),
  appOpen: String.fromEnvironment(
    'ADMOB_ANDROID_APP_OPEN',
    defaultValue: 'ca-app-pub-3940256099942544/9257395921',
  ),
  banner: String.fromEnvironment(
    'ADMOB_ANDROID_BANNER',
    defaultValue: 'ca-app-pub-3940256099942544/6300978111',
  ),
);

_AdUnits get _adUnits => Platform.isIOS ? _iosAdUnits : _androidAdUnits;

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

String _describeResult(RewardVerificationResult result) {
  final reward = result.reward;
  if (result.failed || reward == null) return '❌ verification failed';
  final more = result.moreRewards.isEmpty
      ? ''
      : ' (+${result.moreRewards.length} more)';
  return '✅ ${_describeReward(reward)}$more';
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Purchases.setLogLevel(LogLevel.debug);
  await Purchases.configure(
    PurchasesConfiguration(Platform.isIOS ? _appleApiKey : _googleApiKey),
  );
  runApp(const AdsTesterApp());
}

class AdsTesterApp extends StatelessWidget {
  const AdsTesterApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: DefaultTabController(
          length: 5,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('RevenueCat AdMob adapter'),
              bottom: const TabBar(
                isScrollable: true,
                tabs: [
                  Tab(text: 'Interstitial'),
                  Tab(text: 'Rewarded'),
                  Tab(text: 'Rewarded Int.'),
                  Tab(text: 'App Open'),
                  Tab(text: 'Banner'),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                InterstitialScreen(),
                RewardedScreen(),
                RewardedInterstitialScreen(),
                AppOpenScreen(),
                BannerScreen(),
              ],
            ),
          ),
        ),
      );
}

/// Shared load/show scaffolding so each format screen only wires its ad type.
abstract class _AdScreenState<T extends StatefulWidget> extends State<T> {
  String status = 'No ad loaded';
  String? result;
  bool busy = false;
  bool get ready;

  void setStatus(String value) {
    if (!mounted) return;
    setState(() => status = value);
  }

  Future<void> load();
  Future<void> show();

  Widget buildBody(BuildContext context, {List<Widget> extra = const []}) =>
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(status, textAlign: TextAlign.center),
            if (result != null) ...[
              const SizedBox(height: 16),
              Text(result!, style: Theme.of(context).textTheme.titleMedium),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: busy ? null : (ready ? show : load),
              child: Text(ready ? 'Show' : 'Load'),
            ),
            ...extra,
          ],
        ),
      );
}

FullScreenContentCallback<T> _dismissCallback<T extends AdWithoutView>(
  _AdScreenState state,
  void Function() clear,
) =>
    FullScreenContentCallback<T>(
      onAdImpression: (_) => state.setStatus('Impression recorded'),
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        clear();
        state.setStatus('Dismissed');
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        clear();
        state.setStatus('Failed to show: $error');
      },
    );

class InterstitialScreen extends StatefulWidget {
  const InterstitialScreen({super.key});

  @override
  State<InterstitialScreen> createState() => _InterstitialScreenState();
}

class _InterstitialScreenState extends _AdScreenState<InterstitialScreen> {
  InterstitialAd? _ad;

  @override
  bool get ready => _ad != null;

  @override
  Future<void> load() async {
    setState(() {
      busy = true;
      status = 'Loading…';
    });
    await RevenueCatAdMob.loadAndTrackInterstitialAd(
      adUnitId: _adUnits.interstitial,
      request: const AdRequest(),
      placement: 'interstitial_tab',
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = _dismissCallback<InterstitialAd>(
            this,
            () => setState(() => _ad = null),
          );
          setState(() {
            _ad = ad;
            busy = false;
            status = 'Ad ready (${ad.responseInfo?.responseId})';
          });
        },
        onAdFailedToLoad: (error) => setState(() {
          busy = false;
          status = 'Failed to load: $error';
        }),
      ),
    );
  }

  @override
  Future<void> show() => _ad!.showAndTrack(placement: 'interstitial_shown');

  @override
  Widget build(BuildContext context) => buildBody(context);
}

class AppOpenScreen extends StatefulWidget {
  const AppOpenScreen({super.key});

  @override
  State<AppOpenScreen> createState() => _AppOpenScreenState();
}

class _AppOpenScreenState extends _AdScreenState<AppOpenScreen> {
  AppOpenAd? _ad;

  @override
  bool get ready => _ad != null;

  @override
  Future<void> load() async {
    setState(() {
      busy = true;
      status = 'Loading…';
    });
    await RevenueCatAdMob.loadAndTrackAppOpenAd(
      adUnitId: _adUnits.appOpen,
      request: const AdRequest(),
      placement: 'app_open_tab',
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = _dismissCallback<AppOpenAd>(
            this,
            () => setState(() => _ad = null),
          );
          setState(() {
            _ad = ad;
            busy = false;
            status = 'Ad ready (${ad.responseInfo?.responseId})';
          });
        },
        onAdFailedToLoad: (error) => setState(() {
          busy = false;
          status = 'Failed to load: $error';
        }),
      ),
    );
  }

  @override
  Future<void> show() => _ad!.showAndTrack();

  @override
  Widget build(BuildContext context) => buildBody(context);
}

class RewardedScreen extends StatefulWidget {
  const RewardedScreen({super.key});

  @override
  State<RewardedScreen> createState() => _RewardedScreenState();
}

class _RewardedScreenState extends _AdScreenState<RewardedScreen> {
  RewardedAd? _ad;

  @override
  bool get ready => _ad != null;

  @override
  Future<void> load() async {
    setState(() {
      busy = true;
      status = 'Loading…';
      result = null;
    });
    await RevenueCatAdMob.loadAndTrackRewardedAd(
      adUnitId: _adUnits.rewarded,
      request: const AdRequest(),
      placement: 'rewarded_tab',
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) async {
          ad.fullScreenContentCallback = _dismissCallback<RewardedAd>(
            this,
            () => setState(() => _ad = null),
          );
          await ad.enableRewardVerification();
          setState(() {
            _ad = ad;
            busy = false;
            status = 'Ad ready (${ad.responseInfo?.responseId})';
          });
        },
        onAdFailedToLoad: (error) => setState(() {
          busy = false;
          status = 'Failed to load: $error';
        }),
      ),
    );
  }

  @override
  Future<void> show() => _ad!.showWithRewardVerification(
        onRewardVerificationStarted: () => setStatus('Verifying reward…'),
        onRewardVerificationCompleted: (verification) => setState(() {
          status = 'Done';
          result = _describeResult(verification);
        }),
      );

  @override
  Widget build(BuildContext context) => buildBody(context);
}

class RewardedInterstitialScreen extends StatefulWidget {
  const RewardedInterstitialScreen({super.key});

  @override
  State<RewardedInterstitialScreen> createState() =>
      _RewardedInterstitialScreenState();
}

class _RewardedInterstitialScreenState
    extends _AdScreenState<RewardedInterstitialScreen> {
  RewardedInterstitialAd? _ad;

  @override
  bool get ready => _ad != null;

  @override
  Future<void> load() async {
    setState(() {
      busy = true;
      status = 'Loading…';
      result = null;
    });
    await RevenueCatAdMob.loadAndTrackRewardedInterstitialAd(
      adUnitId: _adUnits.rewardedInterstitial,
      request: const AdRequest(),
      placement: 'rewarded_interstitial_tab',
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (ad) async {
          ad.fullScreenContentCallback =
              _dismissCallback<RewardedInterstitialAd>(
            this,
            () => setState(() => _ad = null),
          );
          await ad.enableRewardVerification();
          setState(() {
            _ad = ad;
            busy = false;
            status = 'Ad ready (${ad.responseInfo?.responseId})';
          });
        },
        onAdFailedToLoad: (error) => setState(() {
          busy = false;
          status = 'Failed to load: $error';
        }),
      ),
    );
  }

  @override
  Future<void> show() => _ad!.showWithRewardVerification(
        onRewardVerificationStarted: () => setStatus('Verifying reward…'),
        onRewardVerificationCompleted: (verification) => setState(() {
          status = 'Done';
          result = _describeResult(verification);
        }),
      );

  @override
  Widget build(BuildContext context) => buildBody(context);
}

class BannerScreen extends StatefulWidget {
  const BannerScreen({super.key});

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  BannerAd? _banner;
  bool _loaded = false;
  String _status = 'No banner loaded';

  @override
  void dispose() {
    _banner?.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    _banner?.dispose();
    setState(() {
      _loaded = false;
      _status = 'Loading…';
    });
    final banner = RevenueCatAdMob.createBannerAd(
      adUnitId: _adUnits.banner,
      size: AdSize.banner,
      request: const AdRequest(),
      placement: 'banner_tab',
      listener: BannerAdListener(
        onAdLoaded: (ad) => setState(() {
          _loaded = true;
          _status = 'Loaded (${ad.responseInfo?.responseId})';
        }),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          setState(() => _status = 'Failed to load: $error');
        },
        onAdImpression: (_) => setState(() => _status = 'Impression recorded'),
        onPaidEvent: (_, value, precision, currency) =>
            setState(() => _status = 'Paid: $value $currency ($precision)'),
      ),
    );
    _banner = banner;
    await banner.load();
  }

  @override
  Widget build(BuildContext context) {
    final banner = _banner;
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_status, textAlign: TextAlign.center),
                const SizedBox(height: 24),
                ElevatedButton(onPressed: _load, child: const Text('Load')),
              ],
            ),
          ),
        ),
        if (banner != null && _loaded)
          SizedBox(
            width: banner.size.width.toDouble(),
            height: banner.size.height.toDouble(),
            child: AdWidget(ad: banner),
          ),
      ],
    );
  }
}
