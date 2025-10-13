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
      onRestoreCompleted: (Map<String, dynamic> customerInfo) {},
      onRestoreFailed: (Map<String, dynamic> error) {},
      onShowingManageSubscriptions: () {},
      onRefundRequestStarted: (String refundRequestStatus) {},
      onRefundRequestCompleted: (Map<String, dynamic> refundRequestStatus) {},
      onFeedbackSurveyCompleted: (String feedbackSurveyOptionId) {},
      onManagementOptionSelected: (Map<String, dynamic> data) {},
      onCustomActionSelected: (Map<String, dynamic> data) {},
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
          onRestoreCompleted: (Map<String, dynamic> customerInfo) {},
          onRestoreFailed: (Map<String, dynamic> error) {},
          onShowingManageSubscriptions: () {},
          onRefundRequestStarted: (String refundRequestStatus) {},
          onRefundRequestCompleted: (Map<String, dynamic> refundRequestStatus) {},
          onFeedbackSurveyCompleted: (String feedbackSurveyOptionId) {},
          onManagementOptionSelected: (Map<String, dynamic> data) {},
          onCustomActionSelected: (Map<String, dynamic> data) {},
        ),
      ),
    );
  }

  void _checkCustomerCenterEventStream() {
    Stream<CustomerCenterEvent> stream = RevenueCatUI.customerCenterEventStream;
    
    // Test event stream subscription
    stream.listen((CustomerCenterEvent event) {
      // Test event type checking
      switch (event.runtimeType) {
        case CustomerCenterOnDismissEvent:
          CustomerCenterOnDismissEvent dismissEvent = event as CustomerCenterOnDismissEvent;
          break;
        case CustomerCenterOnRestoreStartedEvent:
          CustomerCenterOnRestoreStartedEvent restoreStartedEvent = event as CustomerCenterOnRestoreStartedEvent;
          break;
        case CustomerCenterOnRestoreCompletedEvent:
          CustomerCenterOnRestoreCompletedEvent restoreCompletedEvent = event as CustomerCenterOnRestoreCompletedEvent;
          Map<String, dynamic> customerInfo = restoreCompletedEvent.customerInfo;
          break;
        case CustomerCenterOnRestoreFailedEvent:
          CustomerCenterOnRestoreFailedEvent restoreFailedEvent = event as CustomerCenterOnRestoreFailedEvent;
          Map<String, dynamic> error = restoreFailedEvent.error;
          break;
        case CustomerCenterOnShowingManageSubscriptionsEvent:
          CustomerCenterOnShowingManageSubscriptionsEvent manageSubsEvent = event as CustomerCenterOnShowingManageSubscriptionsEvent;
          break;
        case CustomerCenterOnRefundRequestStartedEvent:
          CustomerCenterOnRefundRequestStartedEvent refundStartedEvent = event as CustomerCenterOnRefundRequestStartedEvent;
          String refundRequestStatus = refundStartedEvent.refundRequestStatus;
          break;
        case CustomerCenterOnRefundRequestCompletedEvent:
          CustomerCenterOnRefundRequestCompletedEvent refundCompletedEvent = event as CustomerCenterOnRefundRequestCompletedEvent;
          Map<String, dynamic> refundRequestStatus = refundCompletedEvent.refundRequestStatus;
          break;
        case CustomerCenterOnFeedbackSurveyCompletedEvent:
          CustomerCenterOnFeedbackSurveyCompletedEvent feedbackEvent = event as CustomerCenterOnFeedbackSurveyCompletedEvent;
          String feedbackSurveyOptionId = feedbackEvent.feedbackSurveyOptionId;
          break;
        case CustomerCenterOnManagementOptionSelectedEvent:
          CustomerCenterOnManagementOptionSelectedEvent managementEvent = event as CustomerCenterOnManagementOptionSelectedEvent;
          Map<String, dynamic> data = managementEvent.data;
          break;
        case CustomerCenterOnCustomActionSelectedEvent:
          CustomerCenterOnCustomActionSelectedEvent customActionEvent = event as CustomerCenterOnCustomActionSelectedEvent;
          Map<String, dynamic> data = customActionEvent.data;
          break;
      }
    });
  }

  void _checkCustomerCenterEventTypes() {
    // Test that all event types are available
    CustomerCenterOnDismissEvent dismissEvent = CustomerCenterOnDismissEvent();
    CustomerCenterOnRestoreStartedEvent restoreStartedEvent = CustomerCenterOnRestoreStartedEvent();
    CustomerCenterOnRestoreCompletedEvent restoreCompletedEvent = CustomerCenterOnRestoreCompletedEvent({});
    CustomerCenterOnRestoreFailedEvent restoreFailedEvent = CustomerCenterOnRestoreFailedEvent({});
    CustomerCenterOnShowingManageSubscriptionsEvent manageSubsEvent = CustomerCenterOnShowingManageSubscriptionsEvent();
    CustomerCenterOnRefundRequestStartedEvent refundStartedEvent = CustomerCenterOnRefundRequestStartedEvent("");
    CustomerCenterOnRefundRequestCompletedEvent refundCompletedEvent = CustomerCenterOnRefundRequestCompletedEvent({});
    CustomerCenterOnFeedbackSurveyCompletedEvent feedbackEvent = CustomerCenterOnFeedbackSurveyCompletedEvent("");
    CustomerCenterOnManagementOptionSelectedEvent managementEvent = CustomerCenterOnManagementOptionSelectedEvent({});
    CustomerCenterOnCustomActionSelectedEvent customActionEvent = CustomerCenterOnCustomActionSelectedEvent({});
  }
}
