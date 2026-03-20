/// Configures how a paywall is presented on each platform.
final class PaywallPresentationConfiguration {
  /// Optional iOS-specific presentation style.
  final IOSPaywallPresentationStyle? ios;

  /// Optional Android-specific presentation style.
  /// Android always presents full screen; this field exists for API symmetry
  /// and future use.
  final AndroidPaywallPresentationStyle? android;

  /// Full-screen presentation on all platforms.
  static const fullScreen = PaywallPresentationConfiguration(
    ios: IOSPaywallPresentationStyle.fullScreen,
    android: AndroidPaywallPresentationStyle.fullScreen,
  );

  /// Default platform behavior (sheet on iOS, full screen on Android).
  static const defaultConfiguration = PaywallPresentationConfiguration(
    ios: IOSPaywallPresentationStyle.sheet,
    android: AndroidPaywallPresentationStyle.fullScreen,
  );

  const PaywallPresentationConfiguration({this.ios, this.android});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaywallPresentationConfiguration &&
          ios == other.ios &&
          android == other.android;

  @override
  int get hashCode => Object.hash(ios, android);

  @override
  String toString() =>
      'PaywallPresentationConfiguration(ios: $ios, android: $android)';
}

/// Controls how the paywall is presented on iOS.
///
/// Uses a private constructor with static constants so that new values can
/// be added in the future without breaking existing code.
final class IOSPaywallPresentationStyle {
  final String _value;
  const IOSPaywallPresentationStyle._(this._value);

  /// Presents the paywall as a full-screen modal.
  /// Useful to avoid white areas in landscape orientation.
  static const fullScreen = IOSPaywallPresentationStyle._('fullScreen');

  /// Presents the paywall as a sheet (default iOS behavior).
  static const sheet = IOSPaywallPresentationStyle._('sheet');

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IOSPaywallPresentationStyle && _value == other._value;

  @override
  int get hashCode => _value.hashCode;

  @override
  String toString() => _value;
}

/// Controls how the paywall is presented on Android.
///
/// Uses a private constructor with static constants so that new values can
/// be added in the future without breaking existing code.
final class AndroidPaywallPresentationStyle {
  final String _value;
  const AndroidPaywallPresentationStyle._(this._value);

  /// Presents the paywall as a full-screen activity (default Android behavior).
  static const fullScreen = AndroidPaywallPresentationStyle._('fullScreen');

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AndroidPaywallPresentationStyle && _value == other._value;

  @override
  int get hashCode => _value.hashCode;

  @override
  String toString() => _value;
}
