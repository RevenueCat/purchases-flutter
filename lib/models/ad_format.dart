/// The format of an ad.
///
/// Use the predefined constants for common ad formats, or create a custom
/// value for other ad format types.
class AdFormat {
  /// The raw string value of the ad format.
  final String value;

  /// Creates an [AdFormat] with the given raw [value].
  const AdFormat(this.value);

  /// Ad format type not in the predefined list.
  static const other = AdFormat('other');

  /// Standard banner ad format.
  static const banner = AdFormat('banner');

  /// Full-screen interstitial ad format.
  static const interstitial = AdFormat('interstitial');

  /// Rewarded video ad format.
  static const rewarded = AdFormat('rewarded');

  /// Rewarded interstitial ad format.
  static const rewardedInterstitial = AdFormat('rewarded_interstitial');

  /// Native ad format that matches app design.
  static const nativeAd = AdFormat('native');

  /// App open ad format displayed at app launch.
  static const appOpen = AdFormat('app_open');

  @override
  bool operator ==(Object other) => other is AdFormat && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}
