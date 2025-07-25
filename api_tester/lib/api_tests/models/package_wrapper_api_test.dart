import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
// ignore_for_file: deprecated_member_use
class _PackageApiTest {
  void _checkPackageType(PackageType type) {
    switch (type) {
      case PackageType.unknown:
      case PackageType.custom:
      case PackageType.lifetime:
      case PackageType.annual:
      case PackageType.sixMonth:
      case PackageType.threeMonth:
      case PackageType.twoMonth:
      case PackageType.monthly:
      case PackageType.weekly:
        break;
    }
  }

  void _checkFromJsonFactory(Map<String, dynamic> json) {
    Package package = Package.fromJson(json);
  }

  void _checkConstructor(
      String identifier,
      PackageType packageType,
      StoreProduct storeProduct,
      PresentedOfferingContext presentedOfferingContext) {
    Package package = Package(
        identifier, packageType, storeProduct, presentedOfferingContext);
  }

  void _checkProperties(Package package) {
    String identifier = package.identifier;
    PackageType packageType = package.packageType;
    StoreProduct storeProduct = package.storeProduct;
    String offeringIdentifier = package.offeringIdentifier;
    PresentedOfferingContext presentedOfferingContext =
        package.presentedOfferingContext;
  }
}
