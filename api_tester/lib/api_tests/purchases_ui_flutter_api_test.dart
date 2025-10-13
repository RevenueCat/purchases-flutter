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

  void _checkPresentCustomerCenter() async {
    Future<void> f1 = RevenueCatUI.presentCustomerCenter();
  }

  void _checkPresentCustomerCenterWithCallbacks() async {
    Future<void> f1 = RevenueCatUI.presentCustomerCenter(
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

  void _checkCustomerCenterEventStream() {
    Stream<CustomerCenterEvent> stream = RevenueCatUI.customerCenterEventStream;
    
    // Test event stream subscription
    stream.listen((CustomerCenterEvent event) {
      // Test event type checking
      CustomerCenterEventType eventType = event.type;
      Map<String, dynamic>? eventData = event.data;
      
      switch (eventType) {
        case CustomerCenterEventType.dismiss:
          // No data for dismiss events
          break;
        case CustomerCenterEventType.restoreStarted:
          // No data for restore started events
          break;
        case CustomerCenterEventType.restoreCompleted:
          // Data contains customerInfo
          if (eventData != null) {
            Map<String, dynamic> customerInfo = eventData;
          }
          break;
        case CustomerCenterEventType.restoreFailed:
          // Data contains error information
          if (eventData != null) {
            Map<String, dynamic> error = eventData;
          }
          break;
        case CustomerCenterEventType.showingManageSubscriptions:
          // No data for manage subscriptions events
          break;
        case CustomerCenterEventType.refundRequestStarted:
          // Data contains refund request status
          if (eventData != null) {
            String refundRequestStatus = eventData['refundRequestStatus'] ?? '';
          }
          break;
        case CustomerCenterEventType.refundRequestCompleted:
          // Data contains refund request completion status
          if (eventData != null) {
            Map<String, dynamic> refundRequestStatus = eventData;
          }
          break;
        case CustomerCenterEventType.feedbackSurveyCompleted:
          // Data contains feedback survey option ID
          if (eventData != null) {
            String feedbackSurveyOptionId = eventData['feedbackSurveyOptionId'] ?? '';
          }
          break;
        case CustomerCenterEventType.managementOptionSelected:
          // Data contains optionId and url
          if (eventData != null) {
            String optionId = eventData['optionId'] ?? '';
            String? url = eventData['url'];
          }
          break;
        case CustomerCenterEventType.customActionSelected:
          // Data contains actionId and purchaseIdentifier
          if (eventData != null) {
            String actionId = eventData['actionId'] ?? '';
            String? purchaseIdentifier = eventData['purchaseIdentifier'];
          }
          break;
      }
    });
  }

  void _checkCustomerCenterEventTypes() {
    // Test that all event types are available
    CustomerCenterEventType dismissType = CustomerCenterEventType.dismiss;
    CustomerCenterEventType restoreStartedType = CustomerCenterEventType.restoreStarted;
    CustomerCenterEventType restoreCompletedType = CustomerCenterEventType.restoreCompleted;
    CustomerCenterEventType restoreFailedType = CustomerCenterEventType.restoreFailed;
    CustomerCenterEventType showingManageSubscriptionsType = CustomerCenterEventType.showingManageSubscriptions;
    CustomerCenterEventType refundRequestStartedType = CustomerCenterEventType.refundRequestStarted;
    CustomerCenterEventType refundRequestCompletedType = CustomerCenterEventType.refundRequestCompleted;
    CustomerCenterEventType feedbackSurveyCompletedType = CustomerCenterEventType.feedbackSurveyCompleted;
    CustomerCenterEventType managementOptionSelectedType = CustomerCenterEventType.managementOptionSelected;
    CustomerCenterEventType customActionSelectedType = CustomerCenterEventType.customActionSelected;
    
    // Test event construction
    CustomerCenterEvent dismissEvent = const CustomerCenterEvent(CustomerCenterEventType.dismiss);
    CustomerCenterEvent restoreStartedEvent = const CustomerCenterEvent(CustomerCenterEventType.restoreStarted);
    CustomerCenterEvent restoreCompletedEvent = const CustomerCenterEvent(CustomerCenterEventType.restoreCompleted, {});
    CustomerCenterEvent restoreFailedEvent = const CustomerCenterEvent(CustomerCenterEventType.restoreFailed, {});
    CustomerCenterEvent manageSubsEvent = const CustomerCenterEvent(CustomerCenterEventType.showingManageSubscriptions);
    CustomerCenterEvent refundStartedEvent = const CustomerCenterEvent(CustomerCenterEventType.refundRequestStarted, {'refundRequestStatus': ''});
    CustomerCenterEvent refundCompletedEvent = const CustomerCenterEvent(CustomerCenterEventType.refundRequestCompleted, {});
    CustomerCenterEvent feedbackEvent = const CustomerCenterEvent(CustomerCenterEventType.feedbackSurveyCompleted, {'feedbackSurveyOptionId': ''});
    CustomerCenterEvent managementEvent = const CustomerCenterEvent(CustomerCenterEventType.managementOptionSelected, {'optionId': '', 'url': null});
    CustomerCenterEvent customActionEvent = const CustomerCenterEvent(CustomerCenterEventType.customActionSelected, {'actionId': '', 'purchaseIdentifier': null});
  }
}
