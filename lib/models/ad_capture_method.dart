/// Identifies the integration that emitted an ad event.
///
/// Reserved for the official RevenueCat ad-network adapters (for example
/// `purchases_admob_flutter`). Leave it unset when tracking ads manually: the
/// SDK then reports the events as manually captured.
class AdCaptureMethod {
  final String value;

  const AdCaptureMethod(this.value);

  /// Auto-captured by the official RevenueCat AdMob adapter for Flutter.
  static const flutterAdMobAdapter = AdCaptureMethod('flutter_admob_adapter');

  @override
  bool operator ==(Object other) =>
      other is AdCaptureMethod && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}
