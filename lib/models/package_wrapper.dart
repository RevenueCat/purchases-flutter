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
  weekly,
  ;

  static PackageType fromJson(dynamic value) {
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

  String toJson() {
    switch (this) {
      case PackageType.unknown:
        return 'UNKNOWN';
      case PackageType.custom:
        return 'CUSTOM';
      case PackageType.lifetime:
        return 'LIFETIME';
      case PackageType.annual:
        return 'ANNUAL';
      case PackageType.sixMonth:
        return 'SIX_MONTH';
      case PackageType.threeMonth:
        return 'THREE_MONTH';
      case PackageType.twoMonth:
        return 'TWO_MONTH';
      case PackageType.monthly:
        return 'MONTHLY';
      case PackageType.weekly:
        return 'WEEKLY';
    }
  }
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
        PackageType.fromJson(json['packageType']),
        StoreProduct.fromJson(Map<String, dynamic>.from(json['product'])),
        PresentedOfferingContext.fromJson(
          Map<String, dynamic>.from(json['presentedOfferingContext']),
        ),
      );

  Map<String, dynamic> toJson() => {
        'identifier': identifier,
        'packageType': packageType.toJson(),
        'product': storeProduct.toJson(),
        'presentedOfferingContext': presentedOfferingContext.toJson(),
      };

  @override
  List<Object> get props => [
        identifier,
        packageType,
        storeProduct,
        presentedOfferingContext,
      ];
}

extension ExtendedPackage on Package {
  /// Offering this package belongs to.
  @Deprecated('use presentedOfferingContext')
  String get offeringIdentifier => presentedOfferingContext.offeringIdentifier;
}
