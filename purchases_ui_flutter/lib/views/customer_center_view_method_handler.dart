import 'package:flutter/services.dart';
import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:purchases_flutter/models/purchases_error.dart';

typedef CustomerCenterDismissCallback = void Function();
typedef CustomerCenterRestoreStartedCallback = void Function();
typedef CustomerCenterRestoreCompletedCallback = void Function(CustomerInfo customerInfo);
typedef CustomerCenterRestoreFailedCallback = void Function(PurchasesError error);
typedef CustomerCenterManageSubscriptionsCallback = void Function();
typedef CustomerCenterRefundRequestStartedCallback = void Function(String productIdentifier);
typedef CustomerCenterRefundRequestCompletedCallback = void Function(String productIdentifier, String status);
typedef CustomerCenterFeedbackSurveyCompletedCallback = void Function(String optionIdentifier);
typedef CustomerCenterManagementOptionSelectedCallback = void Function(String optionIdentifier, String? url);
typedef CustomerCenterCustomActionSelectedCallback = void Function(String actionIdentifier, String? purchaseIdentifier);

class CustomerCenterViewMethodHandler {
  final CustomerCenterDismissCallback? onDismiss;
  final CustomerCenterRestoreStartedCallback? onRestoreStarted;
  final CustomerCenterRestoreCompletedCallback? onRestoreCompleted;
  final CustomerCenterRestoreFailedCallback? onRestoreFailed;
  final CustomerCenterManageSubscriptionsCallback? onShowingManageSubscriptions;
  final CustomerCenterRefundRequestStartedCallback? onRefundRequestStarted;
  final CustomerCenterRefundRequestCompletedCallback? onRefundRequestCompleted;
  final CustomerCenterFeedbackSurveyCompletedCallback? onFeedbackSurveyCompleted;
  final CustomerCenterManagementOptionSelectedCallback? onManagementOptionSelected;
  final CustomerCenterCustomActionSelectedCallback? onCustomActionSelected;

  const CustomerCenterViewMethodHandler({
    this.onDismiss,
    this.onRestoreStarted,
    this.onRestoreCompleted,
    this.onRestoreFailed,
    this.onShowingManageSubscriptions,
    this.onRefundRequestStarted,
    this.onRefundRequestCompleted,
    this.onFeedbackSurveyCompleted,
    this.onManagementOptionSelected,
    this.onCustomActionSelected,
  });

  Future<void> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onDismiss':
        onDismiss?.call();
        break;
      case 'onRestoreStarted':
        onRestoreStarted?.call();
        break;
      case 'onRestoreCompleted':
        _handleRestoreCompleted(call.arguments);
        break;
      case 'onRestoreFailed':
        _handleRestoreFailed(call.arguments);
        break;
      case 'onShowingManageSubscriptions':
        onShowingManageSubscriptions?.call();
        break;
      case 'onRefundRequestStarted':
        _handleRefundRequestStarted(call.arguments);
        break;
      case 'onRefundRequestCompleted':
        _handleRefundRequestCompleted(call.arguments);
        break;
      case 'onFeedbackSurveyCompleted':
        _handleFeedbackSurveyCompleted(call.arguments);
        break;
      case 'onManagementOptionSelected':
        _handleManagementOptionSelected(call.arguments);
        break;
      case 'onCustomActionSelected':
        _handleCustomActionSelected(call.arguments);
        break;
      default:
        break;
    }
  }

  void _handleRestoreCompleted(dynamic arguments) {
    if (onRestoreCompleted == null) {
      return;
    }
    if (arguments is Map) {
      final customerInfo = CustomerInfo.fromJson(Map<String, dynamic>.from(arguments));
      onRestoreCompleted?.call(customerInfo);
    }
  }

  void _handleRestoreFailed(dynamic arguments) {
    if (onRestoreFailed == null) {
      return;
    }
    if (arguments is Map) {
      final error = PurchasesError.fromJson(Map<String, dynamic>.from(arguments));
      onRestoreFailed?.call(error);
    }
  }

  void _handleRefundRequestStarted(dynamic arguments) {
    if (onRefundRequestStarted == null) {
      return;
    }
    if (arguments is String) {
      onRefundRequestStarted?.call(arguments);
    }
  }

  void _handleRefundRequestCompleted(dynamic arguments) {
    if (onRefundRequestCompleted == null) {
      return;
    }
    if (arguments is Map) {
      final data = Map<String, dynamic>.from(arguments);
      final productIdentifier = data['productId'] as String?;
      final status = data['status'] as String?;
      if (productIdentifier != null && status != null) {
        onRefundRequestCompleted?.call(productIdentifier, status);
      }
    }
  }

  void _handleFeedbackSurveyCompleted(dynamic arguments) {
    if (onFeedbackSurveyCompleted == null) {
      return;
    }
    if (arguments is String) {
      onFeedbackSurveyCompleted?.call(arguments);
    }
  }

  void _handleManagementOptionSelected(dynamic arguments) {
    if (onManagementOptionSelected == null) {
      return;
    }
    if (arguments is Map) {
      final data = Map<String, dynamic>.from(arguments);
      final optionIdentifier = data['optionId'] as String?;
      final url = data['url'] as String?;
      if (optionIdentifier != null) {
        onManagementOptionSelected?.call(optionIdentifier, url);
      }
    }
  }

  void _handleCustomActionSelected(dynamic arguments) {
    if (onCustomActionSelected == null) {
      return;
    }
    if (arguments is Map) {
      final data = Map<String, dynamic>.from(arguments);
      final actionId = data['actionId'] as String?;
      final purchaseIdentifier = data['purchaseIdentifier'] as String?;
      if (actionId != null) {
        onCustomActionSelected?.call(actionId, purchaseIdentifier);
      }
    }
  }
}
