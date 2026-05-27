import 'package:meta/meta.dart';

/// Use the predefined constants for common precision types, or create a custom
/// value for other precision types.
@experimental
class AdRevenuePrecision {
  final String value;

  const AdRevenuePrecision(this.value);

  static const exact = AdRevenuePrecision('exact');
  static const publisherDefined = AdRevenuePrecision('publisher_defined');
  static const estimated = AdRevenuePrecision('estimated');
  static const unknown = AdRevenuePrecision('unknown');

  @override
  bool operator ==(Object other) =>
      other is AdRevenuePrecision && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}
