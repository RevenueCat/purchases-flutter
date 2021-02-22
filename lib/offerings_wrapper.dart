import 'package:purchases_flutter/object_wrappers.dart';

/// This class contains all the offerings configured in RevenueCat dashboard.
/// For more info see https://docs.revenuecat.com/docs/entitlements
class Offerings {
  /// Current offering configured in the RevenueCat dashboard.
  final Offering? current;

  /// Map of all Offerings [Offering] objects keyed by their identifier.
  final Map<String, Offering> all;

  /// Constructs an Offerings object from a JSON object.
  Offerings.fromJson(Map<dynamic, dynamic> map)
      : current =
            map['current'] != null ? Offering.fromJson(map['current']) : null,
        all = (map['all'] as Map<dynamic, dynamic>).map(
            (key, value) => MapEntry(key as String, Offering.fromJson(value)));

  /// Retrieves an specific offering by its identifier.
  Offering? getOffering(String identifier) {
    return all[identifier];
  }

  @override
  String toString() {
    return 'Offerings{current: $current, all: $all}';
  }
}
