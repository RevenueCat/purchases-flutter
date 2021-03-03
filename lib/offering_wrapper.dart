import 'package:collection/collection.dart' show IterableExtension;
import 'package:purchases_flutter/object_wrappers.dart';

/// An offering is a collection of Packages (`Package`) available for the user
/// to purchase. For more info see https://docs.revenuecat.com/docs/entitlements
class Offering {
  /// Unique identifier defined in RevenueCat dashboard.
  final String identifier;

  /// Offering description defined in RevenueCat dashboard.
  final String serverDescription;

  /// Array of `Package` objects available for purchase.
  final List<Package> availablePackages;

  /// Lifetime package type configured in the RevenueCat dashboard, if available.
  final Package? lifetime;

  /// Annual package type configured in the RevenueCat dashboard, if available.
  final Package? annual;

  /// Six month package type configured in the RevenueCat dashboard, if available.
  final Package? sixMonth;

  /// Three month package type configured in the RevenueCat dashboard, if available.
  final Package? threeMonth;

  /// Two month package type configured in the RevenueCat dashboard, if available.
  final Package? twoMonth;

  /// Monthly package type configured in the RevenueCat dashboard, if available.
  final Package? monthly;

  /// Weekly package type configured in the RevenueCat dashboard, if available.
  final Package? weekly;

  /// Constructs an Offering from a JSON object.
  Offering.fromJson(Map<dynamic, dynamic> map)
      : identifier = map["identifier"],
        serverDescription = map['serverDescription'],
        availablePackages = (map['availablePackages'] as List<dynamic>)
            .map((item) => Package.fromJson(item))
            .toList(),
        lifetime =
            map['lifetime'] != null ? Package.fromJson(map['lifetime']) : null,
        annual = map['annual'] != null ? Package.fromJson(map["annual"]) : null,
        sixMonth =
            map['sixMonth'] != null ? Package.fromJson(map["sixMonth"]) : null,
        threeMonth = map['threeMonth'] != null
            ? Package.fromJson(map["threeMonth"])
            : null,
        twoMonth =
            map['twoMonth'] != null ? Package.fromJson(map["twoMonth"]) : null,
        monthly =
            map['monthly'] != null ? Package.fromJson(map["monthly"]) : null,
        weekly = map['weekly'] != null ? Package.fromJson(map["weekly"]) : null;

  /// Retrieves a specific package by identifier, use this to access custom
  /// package types configured in the RevenueCat dashboard.
  Package? getPackage(String identifier) {
    return availablePackages
        .firstWhereOrNull((package) => package.identifier == identifier);
  }

  @override
  String toString() {
    return 'Offering{identifier: $identifier, serverDescription: $serverDescription, availablePackages: $availablePackages, lifetime: $lifetime, annual: $annual, sixMonth: $sixMonth, threeMonth: $threeMonth, twoMonth: $twoMonth, monthly: $monthly, weekly: $weekly}';
  }
}
