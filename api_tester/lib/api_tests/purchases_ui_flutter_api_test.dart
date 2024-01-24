import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _PurchasesFlutterApiTest {
  void _checkPresentPaywall(offering: Offering?) async {
    Future<PaywallResult> future1 = RevenueCatUI.presentPaywall();
    Future<PaywallResult> future1 = RevenueCatUI.presentPaywall(offering: offering);
    Future<PaywallResult> future2 = RevenueCatUI.presentPaywallIfNeeded("test");
    Future<PaywallResult> future2 = RevenueCatUI.presentPaywallIfNeeded("test", offering: offering);
  }

  void _checkPaywallResult(PaywallResult result) {
    switch (result) {
      case PaywallResult.notPresented:
      case PaywallResult.cancelled:
      case PaywallResult.error:
      case PaywallResult.purchased:
      case PaywallResult.restored:
        break;
    }
  }
}
