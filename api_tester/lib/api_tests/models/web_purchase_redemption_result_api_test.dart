import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _WebPurchaseRedemptionResultApiTest {
  void _checkFromJsonFactory(Map<String, dynamic> json) {
    WebPurchaseRedemptionResult result =
        WebPurchaseRedemptionResult.fromJson(json);
  }

  void _checkFactories(
    CustomerInfo customerInfo,
    PurchasesError error,
    String obfuscatedEmail,
  ) {
    WebPurchaseRedemptionResult result =
        WebPurchaseRedemptionSuccess(customerInfo: customerInfo);
    result = WebPurchaseRedemptionError(error: error);
    result = const WebPurchaseRedemptionPurchaseBelongsToOtherUser();
    result = const WebPurchaseRedemptionInvalidToken();
    result = WebPurchaseRedemptionExpired(obfuscatedEmail: obfuscatedEmail);
  }

  void _checkSwitch(WebPurchaseRedemptionResult result) {
    final resultType = switch (result) {
      WebPurchaseRedemptionSuccess(:CustomerInfo customerInfo) => 'SUCCESS',
      WebPurchaseRedemptionError(:PurchasesError error) => 'ERROR',
      WebPurchaseRedemptionPurchaseBelongsToOtherUser() =>
        'PURCHASE_BELONGS_TO_OTHER_USER',
      WebPurchaseRedemptionInvalidToken() => 'INVALID_TOKEN',
      WebPurchaseRedemptionExpired(:String obfuscatedEmail) => 'EXPIRED',
    };
  }
}
