import 'package:meta/meta.dart';

/// Use the predefined constants for common mediators, or create a custom
/// value for other mediation networks.
@experimental
class AdMediatorName {
  final String value;

  const AdMediatorName(this.value);

  static const adMob = AdMediatorName('AdMob');
  static const appLovin = AdMediatorName('AppLovin');

  @override
  bool operator ==(Object other) =>
      other is AdMediatorName && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}
