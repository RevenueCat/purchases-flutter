import 'package:flutter/material.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:purchases_flutter/models/offering_wrapper.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';
import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:purchases_flutter/models/purchases_error.dart';
import 'package:purchases_flutter/models/store_transaction.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
// ignore_for_file: deprecated_member_use
// ignore_for_file: prefer_const_literals_to_create_immutables
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

  void _checkPresentPaywallWithCustomVariables(Offering? offering) async {
    Future<PaywallResult> f1 = RevenueCatUI.presentPaywall(
      customVariables: {'player_name': const CustomVariableValue.string('John')},
    );
    Future<PaywallResult> f2 = RevenueCatUI.presentPaywall(
      offering: offering,
      customVariables: {
        'player_name': const CustomVariableValue.string('John'),
        'level': const CustomVariableValue.string('5'),
      },
    );
    Future<PaywallResult> f3 = RevenueCatUI.presentPaywallIfNeeded(
      "test",
      customVariables: {'player_name': const CustomVariableValue.string('John')},
    );
  }

  Widget _checkPaywallViewWithCustomVariables(Offering offering) {
    return PaywallView(
      offering: offering,
      customVariables: {'player_name': const CustomVariableValue.string('John')},
    );
  }

  void _checkCustomVariableValue() {
    // Create a string custom variable value
    CustomVariableValue stringValue = const CustomVariableValue.string('test');

    // Access the string value
    String value = stringValue.stringValue;

    // CustomVariableValue is a sealed class with only String subtype available
    StringCustomVariableValue stringVariable = const StringCustomVariableValue('test');
    String directValue = stringVariable.value;
    String stringValueFromSubtype = stringVariable.stringValue;
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

  Widget _checkPaywallView() {
    return const Scaffold(
      body: Center(
        child: PaywallView(),
      ),
    );
  }

  Widget _checkPaywallViewWithOffering(Offering offering) {
    return Scaffold(
      body: Center(
        child: PaywallView(
          offering: offering,
        ),
      ),
    );
  }

  Widget _checkPaywallViewWithListeners(
      Offering offering,
      bool displayCloseButton,
  ) {
    return Scaffold(
      body: Center(
        child: PaywallView(
          offering: offering,
          displayCloseButton: displayCloseButton,
          onPurchaseStarted: (Package rcPackage) {
          },
          onPurchaseCompleted:
              (CustomerInfo customerInfo, StoreTransaction storeTransaction) {
          },
          onPurchaseCancelled: () {
          },
          onPurchaseError: (PurchasesError error) {
          },
          onRestoreCompleted: (CustomerInfo customerInfo) {
          },
          onRestoreError: (PurchasesError error) {
          },
          onDismiss: () {
          },
        ),
      ),
    );
  }

  Widget _checkOriginalTemplatePaywallFooterView() {
    return Scaffold(
      body: Center(
        child: OriginalTemplatePaywallFooterView(
          contentCreator: (double bottomPadding) {
            return Container();
          },
        ),
      ),
    );
  }

  Widget _checkPaywallFooterView() {
    return Scaffold(
      body: Center(
        child: PaywallFooterView(
          contentCreator: (double bottomPadding) {
            return Container();
          },
        ),
      ),
    );
  }

  Widget _checkOriginalTemplatePaywallFooterViewWithOffering(
      Offering offering,
  ) {
    return Scaffold(
      body: Center(
        child: OriginalTemplatePaywallFooterView(
          offering: offering,
          contentCreator: (double bottomPadding) {
            return Container();
          },
        ),
      ),
    );
  }

  Widget _checkPaywallFooterViewWithOffering(Offering offering) {
    return Scaffold(
      body: Center(
        child: PaywallFooterView(
          offering: offering,
          contentCreator: (double bottomPadding) {
            return Container();
          },
        ),
      ),
    );
  }

  Widget _checkOriginalTemplatePaywallFooterViewWithListeners(
      Offering offering,
  ) {
    return Scaffold(
      body: Center(
        child: OriginalTemplatePaywallFooterView(
          onPurchaseStarted: (Package rcPackage) {
          },
          onPurchaseCompleted:
              (CustomerInfo customerInfo, StoreTransaction storeTransaction) {
          },
          onPurchaseCancelled: () {
          },
          onPurchaseError: (PurchasesError error) {
          },
          onRestoreCompleted: (CustomerInfo customerInfo) {
          },
          onRestoreError: (PurchasesError error) {
          },
          onDismiss: () {
          },
          contentCreator: (double bottomPadding) {
            return Container();
          },
        ),
      ),
    );
  }

  Widget _checkPaywallFooterViewWithListeners(Offering offering) {
    return Scaffold(
      body: Center(
        child: PaywallFooterView(
          onPurchaseStarted: (Package rcPackage) {
          },
          onPurchaseCompleted:
              (CustomerInfo customerInfo, StoreTransaction storeTransaction) {
          },
          onPurchaseCancelled: () {
          },
          onPurchaseError: (PurchasesError error) {
          },
          onRestoreCompleted: (CustomerInfo customerInfo) {
          },
          onRestoreError: (PurchasesError error) {
          },
          onDismiss: () {
          },
          contentCreator: (double bottomPadding) {
            return Container();
          },
        ),
      ),
    );
  }

  void _checkPurchaseLogicResult(PurchaseLogicResult result) {
    switch (result) {
      case PurchaseLogicResult.success:
      case PurchaseLogicResult.cancellation:
      case PurchaseLogicResult.error:
        break;
    }
  }

  Widget _checkPaywallViewWithPurchaseLogic(PaywallPurchaseLogic logic) {
    return Scaffold(
      body: Center(
        child: PaywallView(
          purchaseLogic: logic,
        ),
      ),
    );
  }

  void _checkPresentCustomerCenter() async {
    Future<void> f1 = RevenueCatUI.presentCustomerCenter();
    Future<void> f2 = RevenueCatUI.presentCustomerCenter(
      onRestoreStarted: () {},
    );
  }

  void _checkPresentCustomerCenterWithCallbacks() async {
    Future<void> f1 = RevenueCatUI.presentCustomerCenter(
      onRestoreStarted: () {},
      onRestoreCompleted: (CustomerInfo customerInfo) {},
      onRestoreFailed: (PurchasesError error) {},
      onShowingManageSubscriptions: () {},
      onRefundRequestStarted: (String productIdentifier) {},
      onRefundRequestCompleted: (String productIdentifier, String status) {},
      onFeedbackSurveyCompleted: (String optionIdentifier) {},
      onManagementOptionSelected: (String optionIdentifier, String? url) {},
      onCustomActionSelected: (String actionIdentifier, String? purchaseIdentifier) {},
    );
  }

  Widget _checkCustomerCenterView() {
    return const Scaffold(
      body: Center(
        child: CustomerCenterView(),
      ),
    );
  }

  Widget _checkCustomerCenterViewWithCallbacks() {
    return Scaffold(
      body: Center(
        child: CustomerCenterView(
          onDismiss: () {},
          onRestoreStarted: () {},
          onRestoreCompleted: (CustomerInfo customerInfo) {},
          onRestoreFailed: (PurchasesError error) {},
          onShowingManageSubscriptions: () {},
          onRefundRequestStarted: (String productIdentifier) {},
          onRefundRequestCompleted: (String productIdentifier, String status) {},
          onFeedbackSurveyCompleted: (String optionIdentifier) {},
          onManagementOptionSelected: (String optionIdentifier, String? url) {},
          onCustomActionSelected: (String actionIdentifier, String? purchaseIdentifier) {},
        ),
      ),
    );
  }

}
