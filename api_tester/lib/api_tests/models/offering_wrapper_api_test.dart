import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _OfferingApiTest {
  void _checkFromJsonFactory(Map<String, dynamic> json) {
    Offering offering = Offering.fromJson(json);
  }

  void _checkToJson(Offering offering) {
    Map<String, dynamic> json = offering.toJson();
  }

  void _checkConstructor(
      String identifier,
      String serverDescription,
      Map<String, Object> metadata,
      List<Package> availablePackages,
      Package? lifetime,
      Package? annual,
      Package? sixMonth,
      Package? threeMonth,
      Package? twoMonth,
      Package? monthly,
      Package? weekly) {
    Offering offering =
        Offering(identifier, serverDescription, metadata, availablePackages);
    offering = Offering(
        identifier, serverDescription, metadata, availablePackages,
        lifetime: lifetime,
        annual: annual,
        sixMonth: sixMonth,
        threeMonth: threeMonth,
        twoMonth: twoMonth,
        monthly: monthly,
        weekly: weekly);
  }

  void _checkProperties(Offering offering) {
    String identifier = offering.identifier;
    String serverDescription = offering.serverDescription;
    Map<String, Object> metadata = offering.metadata;
    List<Package> availablePackages = offering.availablePackages;
    Package? lifetime = offering.lifetime;
    Package? annual = offering.annual;
    Package? sixMonth = offering.sixMonth;
    Package? threeMonth = offering.threeMonth;
    Package? twoMonth = offering.twoMonth;
    Package? monthly = offering.monthly;
    Package? weekly = offering.weekly;

    String value = offering.getMetadataString('key', 'default value');
  }

  void _checkListOfPackagesExtension(List<Package> packages) {
    Package? package = packages.firstWhereOrNull((package) => false);
  }
}
