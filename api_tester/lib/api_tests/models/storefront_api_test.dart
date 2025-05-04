import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _StorefrontApiTest {
  void _checkFromJsonFactory(Map<String, dynamic> json) {
    Storefront storefront = Storefront.fromJson(json);
  }

  void _checkConstructor(
    String countryCode,
  ) {
    Storefront storefront = Storefront(countryCode: countryCode);
  }

  void _checkProperties(Storefront storefront) {
    String countryCode = storefront.countryCode;
  }
}
