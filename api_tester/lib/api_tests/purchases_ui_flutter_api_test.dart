import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _PurchasesFlutterApiTest {
  void _checkPresentPaywall() async {
    Future<PaywallResult> future1 = RevenueCatUI.presentPaywall();
    Future<PaywallResult> future2 = RevenueCatUI.presentPaywallIfNeeded("test");
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
