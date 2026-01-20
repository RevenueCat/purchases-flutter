import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
// ignore_for_file: deprecated_member_use
class _PurchaseResultApiTest {
  void _checkFromJsonFactory(Map<String, dynamic> json) {
    PurchaseResult transaction = PurchaseResult.fromJson(json);
  }

  void _checkConstructor(
      CustomerInfo customerInfo,
      StoreTransaction storeTransaction) {
    PurchaseResult purchaseResult =
    PurchaseResult(customerInfo, storeTransaction);
  }

  void _checkProperties(PurchaseResult purchaseResult) {
    CustomerInfo customerInfo = purchaseResult.customerInfo;
    StoreTransaction storeTransaction = purchaseResult.storeTransaction;
  }
}
