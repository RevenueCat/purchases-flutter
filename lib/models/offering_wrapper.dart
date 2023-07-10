import 'package:freezed_annotation/freezed_annotation.dart';

import 'package_wrapper.dart';

part 'offering_wrapper.freezed.dart';
part 'offering_wrapper.g.dart';

@freezed

/// An offering is a collection of [Package] available for the user
/// to purchase. For more info see https://docs.revenuecat.com/docs/entitlements
class Offering with _$Offering {
  const Offering._(); // Added constructor
  const factory Offering(
    /// Unique identifier defined in RevenueCat dashboard.
    String identifier,

    /// Offering description defined in RevenueCat dashboard.
    String serverDescription,

    /// Offering metadata defined in RevenueCat dashboard.
    Map<String, Object> metadata,

    /// Array of [Package] objects available for purchase.
    List<Package> availablePackages, {
    /// Lifetime package type configured in the RevenueCat dashboard, if available.
    Package? lifetime,

    /// Annual package type configured in the RevenueCat dashboard, if available.
    Package? annual,

    /// Six month package type configured in the RevenueCat dashboard, if available.
    Package? sixMonth,

    /// Three month package type configured in the RevenueCat dashboard, if available.
    Package? threeMonth,

    /// Two month package type configured in the RevenueCat dashboard, if available.
    Package? twoMonth,

    /// Monthly package type configured in the RevenueCat dashboard, if available.
    Package? monthly,

    /// Weekly package type configured in the RevenueCat dashboard, if available.
    Package? weekly,
  }) = _Offering;

  /// Retrieves a specific package by identifier, use this to access custom
  /// package types configured in the RevenueCat dashboard.
  Package? getPackage(String identifier) => availablePackages
      .firstWhereOrNull((package) => package.identifier == identifier);

  factory Offering.fromJson(Map<String, dynamic> json) =>
      _$OfferingFromJson(json);
}

extension OfferingX on Offering {
  /// Returns the [metadata] value associated to [key] for the expected [String] type
  /// or [defaultValue] if not found, or it's not the expected [String] type.
  ///
  /// [key] The metadata key to lookup
  ///
  /// [defaultValue] The default value if a key isn't found or if not
  /// the expected String type
  String getMetadataString(String key, String defaultValue) {
    final value = metadata[key];
    if (value != null && value is String) {
      return value;
    }
    return defaultValue;
  }
}

// Extension needed because this was a deprecation from freezed 1.x that
// was removed in 2.x. Freezed is no longer including package:collection
extension PackageListX on List<Package> {
  Package? firstWhereOrNull(bool Function(Package element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
