import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:purchases_flutter/models/offering_wrapper.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _PurchasesFlutterApiTest {
  void _checkPresentPaywall(Offering? offering) async {
    Future<PaywallResult> f1 = RevenueCatUI.presentPaywall();
    Future<PaywallResult> f2 = RevenueCatUI.presentPaywall(offering: offering);
    Future<PaywallResult> f3 =
        RevenueCatUI.presentPaywall(displayCloseButton: true);
    Future<PaywallResult> f4 = RevenueCatUI.presentPaywall(
        offering: offering, displayCloseButton: true);

    Future<PaywallResult> f5 = RevenueCatUI.presentPaywallIfNeeded("test");
    Future<PaywallResult> f6 =
        RevenueCatUI.presentPaywallIfNeeded("test", displayCloseButton: true);
    Future<PaywallResult> f7 =
        RevenueCatUI.presentPaywallIfNeeded("test", offering: offering);
    Future<PaywallResult> f8 = RevenueCatUI.presentPaywallIfNeeded("test",
        offering: offering, displayCloseButton: true);
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
