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
    @JsonKey(name: 'identifier') String identifier,

    /// Offering description defined in RevenueCat dashboard.
    @JsonKey(name: 'serverDescription') String serverDescription,

    /// Array of [Package] objects available for purchase.
    @JsonKey(name: 'availablePackages') List<Package> availablePackages, {

    /// Lifetime package type configured in the RevenueCat dashboard, if available.
    @JsonKey(name: 'lifetime') Package? lifetime,

    /// Annual package type configured in the RevenueCat dashboard, if available.
    @JsonKey(name: 'annual') Package? annual,

    /// Six month package type configured in the RevenueCat dashboard, if available.
    @JsonKey(name: 'sixMonth') Package? sixMonth,

    /// Three month package type configured in the RevenueCat dashboard, if available.
    @JsonKey(name: 'threeMonth') Package? threeMonth,

    /// Two month package type configured in the RevenueCat dashboard, if available.
    @JsonKey(name: 'twoMonth') Package? twoMonth,

    /// Monthly package type configured in the RevenueCat dashboard, if available.
    @JsonKey(name: 'monthly') Package? monthly,

    /// Weekly package type configured in the RevenueCat dashboard, if available.
    @JsonKey(name: 'weekly') Package? weekly,
  }) = _Offering;

  /// Retrieves a specific package by identifier, use this to access custom
  /// package types configured in the RevenueCat dashboard.
  Package? getPackage(String identifier) => availablePackages
      .firstWhereOrNull((package) => package.identifier == identifier);

  factory Offering.fromJson(Map<String, dynamic> json) =>
      _$OfferingFromJson(json);
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
