import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _WebPurchaseRedemptionApiTest {

  void _checkConstructor(Map<String, dynamic> json) {
    WebPurchaseRedemption redemption = WebPurchaseRedemption('redemptionLink');
    WebPurchaseRedemption redemption2 = WebPurchaseRedemption.fromJson(json);
  }

  void _checkProperties(WebPurchaseRedemption webPurchaseRedemption) {
    String redemptionLink = webPurchaseRedemption.redemptionLink;
  }
}
