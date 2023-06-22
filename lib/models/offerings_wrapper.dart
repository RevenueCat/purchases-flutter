import 'package:freezed_annotation/freezed_annotation.dart';

import 'offering_wrapper.dart';

part 'offerings_wrapper.freezed.dart';
part 'offerings_wrapper.g.dart';

@freezed

/// This class contains all the offerings configured in RevenueCat dashboard.
/// For more info see https://docs.revenuecat.com/docs/entitlements
class Offerings with _$Offerings {
  const Offerings._();
  const factory Offerings(
    /// Map of all Offerings [Offering] objects keyed by their identifier.
    Map<String, Offering> all, {

    /// Current offering configured in the RevenueCat dashboard.
    Offering? current,
  }) = _Offerings;

  /// Retrieves an specific offering by its identifier.
  Offering? getOffering(String identifier) => all[identifier];

  factory Offerings.fromJson(Map<String, dynamic> json) =>
      _$OfferingsFromJson(json);
}
