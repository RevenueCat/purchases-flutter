import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _StoreProductDiscountApiTest {
  void _checkFromJsonFactory(Map<String, dynamic> json) {
    StoreProductDiscount discount = StoreProductDiscount.fromJson(json);
  }

  void _checkToJson(StoreProductDiscount discount) {
    Map<String, dynamic> json = discount.toJson();
  }

  void _checkConstructor(String identifier, double price, String priceString,
      int cycles, String period, String periodUnit, int periodNumberOfUnits) {
    StoreProductDiscount discount = StoreProductDiscount(identifier, price,
        priceString, cycles, period, periodUnit, periodNumberOfUnits);
  }

  void _checkProperties(StoreProductDiscount discount) {
    String identifier = discount.identifier;
    double price = discount.price;
    String priceString = discount.priceString;
    int cycles = discount.cycles;
    String period = discount.period;
    String periodUnit = discount.periodUnit;
    int periodNumberOfUnits = discount.periodNumberOfUnits;
  }
}
