import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _StoreTransactionApiTest {
  void _checkFromJsonFactory(Map<String, dynamic> json) {
    StoreTransaction transaction = StoreTransaction.fromJson(json);
  }

  void _checkToJson(StoreTransaction transaction) {
    Map<String, dynamic> json = transaction.toJson();
  }

  void _checkConstructor(String revenueCatIdentifier, String productIdentifier,
      String purchaseDate) {
    StoreTransaction transaction =
        StoreTransaction(revenueCatIdentifier, productIdentifier, purchaseDate);
  }

  void _checkProperties(StoreTransaction transaction) {
    String revenueCatIdentifier = transaction.revenueCatIdentifier;
    String productIdentifier = transaction.productIdentifier;
    String purchaseDate = transaction.purchaseDate;
  }
}
