import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _VirtualCurrencyApiTest {
  void _checkFromJsonFactory(Map<String, dynamic> json) {
    VirtualCurrency vc = VirtualCurrency.fromJson(json);
  }

  void _checkConstructor(
      int balance, String name, String code, String? serverDescription) {
    VirtualCurrency vc =
        VirtualCurrency(balance, name, code, serverDescription);
  }

  void _checkProperties(VirtualCurrency virtualCurrency) {
    int balance = virtualCurrency.balance;
    String name = virtualCurrency.name;
    String code = virtualCurrency.code;
    String? serverDescription = virtualCurrency.serverDescription;
  }
}
