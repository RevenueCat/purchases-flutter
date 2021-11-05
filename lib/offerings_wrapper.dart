import 'object_wrappers.dart';

/// This class contains all the offerings configured in RevenueCat dashboard.
/// For more info see https://docs.revenuecat.com/docs/entitlements
class Offerings {
  /// Current offering configured in the RevenueCat dashboard.
  final Offering? current;

  /// Map of all Offerings [Offering] objects keyed by their identifier.
  final Map<String, Offering> all;

  /// Constructs an Offerings object from a JSON object.
  Offerings.fromJson(Map<String, dynamic> map)
      : current =
            map['current'] != null ? Offering.fromJson(map['current']) : null,
        all = (map['all'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(
            key,
            Offering.fromJson(value),
          ),
        );

  /// Retrieves an specific offering by its identifier.
  Offering? getOffering(String identifier) => all[identifier];

  @override
  String toString() => 'Offerings{current: $current, all: $all}';
}
