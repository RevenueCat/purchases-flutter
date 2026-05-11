/// The name of an ad mediation network.
///
/// Use the predefined constants for common mediators, or create a custom
/// value for other mediation networks.
class AdMediatorName {
  /// The raw string value of the mediator name.
  final String value;

  /// Creates an [AdMediatorName] with the given raw [value].
  const AdMediatorName(this.value);

  /// Google AdMob mediation network.
  static const adMob = AdMediatorName('AdMob');

  /// AppLovin MAX mediation network.
  static const appLovin = AdMediatorName('AppLovin');

  @override
  bool operator ==(Object other) =>
      other is AdMediatorName && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}
