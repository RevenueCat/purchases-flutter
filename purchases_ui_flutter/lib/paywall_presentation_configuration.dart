/// Configures how a paywall is presented on each platform.
class PaywallPresentationConfiguration {
  /// Optional iOS-specific presentation style.
  final IOSPaywallPresentationStyle? ios;

  /// Optional Android-specific presentation style.
  /// Android always presents full screen; this field exists for API symmetry
  /// and future use.
  final AndroidPaywallPresentationStyle? android;

  const PaywallPresentationConfiguration({this.ios, this.android});
}

/// Controls how the paywall is presented on iOS.
///
/// Use private constructor + static const to allow adding new values
/// without breaking exhaustive switch statements.
class IOSPaywallPresentationStyle {
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
}

/// Controls how the paywall is presented on Android.
///
/// Android currently always presents full screen. This type exists for
/// API symmetry and potential future use.
class AndroidPaywallPresentationStyle {
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
}
