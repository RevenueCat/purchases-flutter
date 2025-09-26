import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

class CustomerCenterViewModalScreen extends StatelessWidget {
  const CustomerCenterViewModalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: CustomerCenterView(
            onDismiss: () {
              debugPrint('[CustomerCenter] Dismissed');
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
            onRestoreStarted: () {
              debugPrint('[CustomerCenter] Restore started');
            },
            onRestoreCompleted: (customerInfo) {
              debugPrint('[CustomerCenter] Restore completed: $customerInfo');
            },
            onRestoreFailed: (error) {
              debugPrint('[CustomerCenter] Restore failed: $error');
            },
            onShowingManageSubscriptions: () {
              debugPrint('[CustomerCenter] Showing manage subscriptions');
            },
            onRefundRequestStarted: (productIdentifier) {
              debugPrint('[CustomerCenter] Refund request started for product: $productIdentifier');
            },
            onRefundRequestCompleted: (productIdentifier, status) {
              debugPrint('[CustomerCenter] Refund request completed for product $productIdentifier with status $status');
            },
            onFeedbackSurveyCompleted: (optionIdentifier) {
              debugPrint('[CustomerCenter] Feedback survey completed with option: $optionIdentifier');
            },
            onManagementOptionSelected: (optionIdentifier, url) {
              debugPrint('[CustomerCenter] Management option selected: $optionIdentifier (url: ${url ?? 'none'})');
            },
            onCustomActionSelected: (actionIdentifier, purchaseIdentifier) {
              debugPrint('[CustomerCenter] Custom action selected: $actionIdentifier (purchase: ${purchaseIdentifier ?? 'none'})');
            },
          ),
        ),
      ),
    );
  }
}
