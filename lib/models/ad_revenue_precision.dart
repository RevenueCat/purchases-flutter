/// The precision of a reported ad revenue value.
///
/// Use the predefined constants for common precision types, or create a custom
/// value for other precision types.
class AdRevenuePrecision {
  /// The raw string value of the precision type.
  final String value;

  /// Creates an [AdRevenuePrecision] with the given raw [value].
  const AdRevenuePrecision(this.value);

  /// Revenue value is exact and confirmed.
  static const exact = AdRevenuePrecision('exact');

  /// Revenue value is defined by the publisher.
  static const publisherDefined = AdRevenuePrecision('publisher_defined');

  /// Revenue value is an estimate.
  static const estimated = AdRevenuePrecision('estimated');

  /// Revenue value accuracy cannot be determined.
  static const unknown = AdRevenuePrecision('unknown');

  @override
  bool operator ==(Object other) =>
      other is AdRevenuePrecision && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}
