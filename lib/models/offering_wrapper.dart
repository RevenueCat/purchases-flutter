import 'package:equatable/equatable.dart';

import 'package_wrapper.dart';

class Offering extends Equatable {
  /// Unique identifier defined in RevenueCat dashboard.
  final String identifier;

  /// Offering description defined in RevenueCat dashboard.
  final String serverDescription;

  /// Offering metadata defined in RevenueCat dashboard.
  final Map<String, Object> metadata;

  /// Array of [Package] objects available for purchase.
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

  const Offering(
    this.identifier,
    this.serverDescription,
    this.metadata,
    this.availablePackages, {
    this.lifetime,
    this.annual,
    this.sixMonth,
    this.threeMonth,
    this.twoMonth,
    this.monthly,
    this.weekly,
  });

  /// Retrieves a specific package by identifier, use this to access custom
  /// package types configured in the RevenueCat dashboard.
  Package? getPackage(String identifier) => availablePackages
      .firstWhereOrNull((package) => package.identifier == identifier);

  factory Offering.fromJson(Map<String, dynamic> json) => Offering(
    json['identifier'] as String,
    json['serverDescription'] as String,
    Map<String, Object>.from(json['metadata']),
    (json['availablePackages'] as List)
        .map((e) => Package.fromJson(Map<String, dynamic>.from(e)))
        .toList(),
    lifetime: json['lifetime'] != null ? Package.fromJson(Map<String, dynamic>.from(json['lifetime'])) : null,
    annual: json['annual'] != null ? Package.fromJson(Map<String, dynamic>.from(json['annual'])) : null,
    sixMonth: json['sixMonth'] != null ? Package.fromJson(Map<String, dynamic>.from(json['sixMonth'])) : null,
    threeMonth: json['threeMonth'] != null ? Package.fromJson(Map<String, dynamic>.from(json['threeMonth'])) : null,
    twoMonth: json['twoMonth'] != null ? Package.fromJson(Map<String, dynamic>.from(json['twoMonth'])) : null,
    monthly: json['monthly'] != null ? Package.fromJson(Map<String, dynamic>.from(json['monthly'])) : null,
    weekly: json['weekly'] != null ? Package.fromJson(Map<String, dynamic>.from(json['weekly'])) : null,
  );

  @override
  List<Object?> get props => [
    identifier,
    serverDescription,
    metadata,
    availablePackages,
    lifetime,
    annual,
    sixMonth,
    threeMonth,
    twoMonth,
    monthly,
    weekly,
  ];
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
