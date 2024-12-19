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
        WebPurchaseRedemptionResult.success(customerInfo: customerInfo);
    result = WebPurchaseRedemptionResult.error(error: error);
    result = const WebPurchaseRedemptionResult.purchaseBelongsToOtherUser();
    result = const WebPurchaseRedemptionResult.invalidToken();
    result = WebPurchaseRedemptionResult.expired(obfuscatedEmail: obfuscatedEmail);
  }

  void _checkFreezedWhen(WebPurchaseRedemptionResult result) {
    result.when(
      success: (CustomerInfo customerInfo) => 'SUCCESS',
      error: (PurchasesError error) => 'ERROR',
      purchaseBelongsToOtherUser: () => 'PURCHASE_BELONGS_TO_OTHER_USER',
      invalidToken: () => 'INVALID_TOKEN',
      expired: (String obfuscatedEmail) => 'EXPIRED',
    );
  }
}
