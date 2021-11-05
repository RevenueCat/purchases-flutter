import 'package:freezed_annotation/freezed_annotation.dart';

import 'package_wrapper.dart';

part 'offering_wrapper.freezed.dart';
part 'offering_wrapper.g.dart';

@freezed

/// An offering is a collection of Packages (`Package`) available for the user
/// to purchase. For more info see https://docs.revenuecat.com/docs/entitlements
class Offering with _$Offering {
  const Offering._(); // Added constructor
  const factory Offering(
    /// Unique identifier defined in RevenueCat dashboard.
    final String identifier,

    /// Offering description defined in RevenueCat dashboard.
    final String serverDescription,

    /// Array of `Package` objects available for purchase.
    final List<Package> availablePackages, {

    /// Lifetime package type configured in the RevenueCat dashboard, if available.
    final Package? lifetime,

    /// Annual package type configured in the RevenueCat dashboard, if available.
    final Package? annual,

    /// Six month package type configured in the RevenueCat dashboard, if available.
    final Package? sixMonth,

    /// Three month package type configured in the RevenueCat dashboard, if available.
    final Package? threeMonth,

    /// Two month package type configured in the RevenueCat dashboard, if available.
    final Package? twoMonth,

    /// Monthly package type configured in the RevenueCat dashboard, if available.
    final Package? monthly,

    /// Weekly package type configured in the RevenueCat dashboard, if available.
    final Package? weekly,
  }) = _Offering;

  /// Retrieves a specific package by identifier, use this to access custom
  /// package types configured in the RevenueCat dashboard.
  Package? getPackage(String identifier) => availablePackages
      .firstWhereOrNull((package) => package.identifier == identifier);

  factory Offering.fromJson(Map<String, dynamic> json) =>
      _$OfferingFromJson(json);
}
