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
        WebRedemptionSuccess(customerInfo: customerInfo);
    result = WebRedemptionError(error: error);
    result = const WebRedemptionPurchaseBelongsToOtherUser();
    result = const WebRedemptionInvalidToken();
    result = WebRedemptionExpired(obfuscatedEmail: obfuscatedEmail);
  }

  void _checkSwitch(WebPurchaseRedemptionResult result) {
    final resultType = switch (result) {
      WebRedemptionSuccess(:CustomerInfo customerInfo) => 'SUCCESS',
      WebRedemptionError(:PurchasesError error) => 'ERROR',
      WebRedemptionPurchaseBelongsToOtherUser() => 'PURCHASE_BELONGS_TO_OTHER_USER',
      WebRedemptionInvalidToken() => 'INVALID_TOKEN',
      WebRedemptionExpired(:String obfuscatedEmail) => 'EXPIRED',
    };
  }
}
