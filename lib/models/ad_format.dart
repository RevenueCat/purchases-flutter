import 'package:meta/meta.dart';

/// Use the predefined constants for common ad formats, or create a custom
/// value for other ad format types.
@experimental
class AdFormat {
  final String value;

  const AdFormat(this.value);

  static const other = AdFormat('other');
  static const banner = AdFormat('banner');
  static const interstitial = AdFormat('interstitial');
  static const rewarded = AdFormat('rewarded');
  static const rewardedInterstitial = AdFormat('rewarded_interstitial');
  static const nativeAd = AdFormat('native');
  static const appOpen = AdFormat('app_open');

  @override
  bool operator ==(Object other) => other is AdFormat && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}
