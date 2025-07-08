import 'package:equatable/equatable.dart';

import 'offering_wrapper.dart';

/// This class contains all the offerings configured in RevenueCat dashboard.
/// For more info see https://docs.revenuecat.com/docs/entitlements
class Offerings extends Equatable {
  /// Map of all Offerings [Offering] objects keyed by their identifier.
  final Map<String, Offering> all;

  /// Current offering configured in the RevenueCat dashboard.
  final Offering? current;

  const Offerings(this.all, {this.current});

  /// Retrieves a specific offering by its identifier.
  Offering? getOffering(String identifier) => all[identifier];

  factory Offerings.fromJson(Map<String, dynamic> json) => Offerings(
        Map<String, dynamic>.from(json['all']).map(
          (k, v) =>
              MapEntry(k, Offering.fromJson(Map<String, dynamic>.from(v))),
        ),
        current: json['current'] != null
            ? Offering.fromJson(Map<String, dynamic>.from(json['current']))
            : null,
      );

  Map<String, dynamic> toJson() => {
        'all': all.map((k, v) => MapEntry(k, v.toJson())),
        'current': current?.toJson(),
      };

  @override
  List<Object?> get props => [
        all,
        current,
      ];
}
