import 'package:purchases_flutter/object_wrappers.dart';

/// Contains information about the product available for the user to purchase.
/// For more info see https://docs.revenuecat.com/docs/entitlements
class Package {
  /// Unique identifier for this package. Can be one a predefined package type
  /// or a custom one.
  final String identifier;

  /// Package type for the product. Will be one of [PackageType].
  final PackageType packageType;

  /// Product assigned to this package.
  final Product product;

  /// Offering this package belongs to.
  final String offeringIdentifier;

  /// Constructs a Package from a JSON object.
  Package.fromJson(Map<dynamic, dynamic> json)
      : identifier = json['identifier'],
        packageType = _PackageTypeHelper.getFromString(json['packageType']),
        product = Product.fromJson(json['product']),
        offeringIdentifier = json['offeringIdentifier'];

  @override
  String toString() {
    return 'Package{identifier: $identifier, packageType: $packageType, product: $product, offeringIdentifier: $offeringIdentifier}';
  }
}

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

class _PackageTypeHelper {
  static PackageType getFromString(String name) {
    switch (name) {
      case "UNKNOWN":
        return PackageType.unknown;
      case "CUSTOM":
        return PackageType.custom;
      case "LIFETIME":
        return PackageType.lifetime;
      case "ANNUAL":
        return PackageType.annual;
      case "SIX_MONTH":
        return PackageType.sixMonth;
      case "THREE_MONTH":
        return PackageType.threeMonth;
      case "TWO_MONTH":
        return PackageType.twoMonth;
      case "MONTHLY":
        return PackageType.monthly;
      case "WEEKLY":
        return PackageType.weekly;
      default:
        return PackageType.unknown;
    }
  }
}
