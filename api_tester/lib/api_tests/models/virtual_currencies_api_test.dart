import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _VirtualCurrenciesApiTest {
  void _checkFromJsonFactory(Map<String, dynamic> json) {
    VirtualCurrencies vcs = VirtualCurrencies.fromJson(json);
  }

  void _checkConstructor(Map<String, VirtualCurrency> all) {
    VirtualCurrencies vcs = VirtualCurrencies(all);
  }

  void _checkProperties(VirtualCurrencies virtualCurrencies) {
    Map<String, VirtualCurrency> all = virtualCurrencies.all;
  }
}
