import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _PriceApiTest {
  void _checkFromJsonFactory(Map<String, dynamic> json) {
    Price price = Price.fromJson(json);
  }

  void _checkToJson(Price price) {
    Map<String, dynamic> json = price.toJson();
  }

  void _checkConstructor(
    String formatted,
    int amountMicros,
    String currencyCode,
  ) {
    Price price = Price(formatted, amountMicros, currencyCode);
  }

  void _checkProperties(Price price) {
    String formatted = price.formatted;
    int amountMicros = price.amountMicros;
    String currencyCode = price.currencyCode;
  }
}
