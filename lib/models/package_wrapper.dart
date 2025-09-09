import 'package:equatable/equatable.dart';

import '../object_wrappers.dart';

/// Enumeration of all possible Package types.
enum PackageType {
  /// A package that was defined with a custom identifier.
  unknown,

  /// A package that was defined with a custom identifier.
  custom,

  /// A package configured with the predefined lifetime identifier.
  lifetime,

  /// A package configured with the predefined annual identifier.
  annual,

  /// A package configured with the predefined six month identifier.
  sixMonth,

  /// A package configured with the predefined three month identifier.
  threeMonth,

  /// A package configured with the predefined two month identifier.
  twoMonth,

  /// A package configured with the predefined monthly identifier.
  monthly,

  /// A package configured with the predefined weekly identifier.
  weekly
}

class Package extends Equatable {
  /// Unique identifier for this package. Can be one a predefined package type or a custom one.
  final String identifier;

  /// Package type for the product. Will be one of [PackageType].
  final PackageType packageType;

  /// StoreProduct assigned to this package.
  final StoreProduct storeProduct;

  /// Offering context this package belongs to.
  final PresentedOfferingContext presentedOfferingContext;

  const Package(
      this.identifier,
      this.packageType,
      this.storeProduct,
      this.presentedOfferingContext,
  );

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    json['identifier'] as String,
    _packageTypeFromJson(json['packageType']),
    StoreProduct.fromJson(Map<String, dynamic>.from(json['product'])),
    PresentedOfferingContext.fromJson(Map<String, dynamic>.from(json['presentedOfferingContext'])),
  );

  @override
  List<Object> get props => [
    identifier,
    packageType,
    storeProduct,
    presentedOfferingContext,
  ];
}

PackageType _packageTypeFromJson(dynamic value) {
  switch (value) {
    case 'UNKNOWN':
      return PackageType.unknown;
    case 'CUSTOM':
      return PackageType.custom;
    case 'LIFETIME':
      return PackageType.lifetime;
    case 'ANNUAL':
      return PackageType.annual;
    case 'SIX_MONTH':
      return PackageType.sixMonth;
    case 'THREE_MONTH':
      return PackageType.threeMonth;
    case 'TWO_MONTH':
      return PackageType.twoMonth;
    case 'MONTHLY':
      return PackageType.monthly;
    case 'WEEKLY':
      return PackageType.weekly;
    default:
      return PackageType.unknown;
  }
}

extension ExtendedPackage on Package {
  /// Offering this package belongs to.
  @Deprecated('use presentedOfferingContext')
  String get offeringIdentifier => presentedOfferingContext.offeringIdentifier;
}
