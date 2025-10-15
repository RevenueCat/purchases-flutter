import 'package:flutter/services.dart';
import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:purchases_flutter/models/purchases_error.dart';

/// Called when the customer center is dismissed by the user.
typedef CustomerCenterDismissed = void Function();

/// Called when a restore purchases operation begins.
typedef CustomerCenterRestoreStarted = void Function();

/// Called when restore purchases completes successfully.
/// 
/// [customerInfo] The updated customer information after restore.
typedef CustomerCenterRestoreCompleted = void Function(CustomerInfo customerInfo);

/// Called when restore purchases fails.
/// 
/// [error] The error that occurred during restore.
typedef CustomerCenterRestoreFailed = void Function(PurchasesError error);

/// Called when the customer center shows the manage subscriptions screen.
typedef CustomerCenterManageSubscriptions = void Function();

/// Called when a refund request is initiated.
/// 
/// [productIdentifier] The product identifier for which the refund was requested.
typedef CustomerCenterRefundRequestStarted = void Function(String productIdentifier);

/// Called when a refund request completes.
/// 
/// [productIdentifier] The product identifier for which the refund was requested.
/// [status] The status of the refund request.
typedef CustomerCenterRefundRequestCompleted = void Function(String productIdentifier, String status);

/// Called when a feedback survey is completed.
/// 
/// [optionIdentifier] The identifier of the selected feedback option.
typedef CustomerCenterFeedbackSurveyCompleted = void Function(String optionIdentifier);

/// Called when a management option is selected.
/// 
/// [optionIdentifier] The identifier of the selected management option.
/// [url] Optional URL associated with the management option.
typedef CustomerCenterManagementOptionSelected = void Function(String optionIdentifier, String? url);

/// Called when a custom action is selected.
/// 
/// [actionIdentifier] The identifier of the selected custom action.
/// [purchaseIdentifier] Optional purchase identifier associated with the action.
typedef CustomerCenterCustomActionSelected = void Function(String actionIdentifier, String? purchaseIdentifier);

class CustomerCenterViewMethodHandler {
  final CustomerCenterDismissed? onDismiss;
  final CustomerCenterRestoreStarted? onRestoreStarted;
  final CustomerCenterRestoreCompleted? onRestoreCompleted;
  final CustomerCenterRestoreFailed? onRestoreFailed;
  final CustomerCenterManageSubscriptions? onShowingManageSubscriptions;
  final CustomerCenterRefundRequestStarted? onRefundRequestStarted;
  final CustomerCenterRefundRequestCompleted? onRefundRequestCompleted;
  final CustomerCenterFeedbackSurveyCompleted? onFeedbackSurveyCompleted;
  final CustomerCenterManagementOptionSelected? onManagementOptionSelected;
  final CustomerCenterCustomActionSelected? onCustomActionSelected;

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
    if (arguments is Map) {
      final data = Map<String, dynamic>.from(arguments);
      final productIdentifier = data['productId'] as String?;
      if (productIdentifier != null) {
        onRefundRequestStarted?.call(productIdentifier);
      }
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
    if (arguments is Map) {
      final data = Map<String, dynamic>.from(arguments);
      final optionIdentifier = data['optionId'] as String?;
      if (optionIdentifier != null) {
        onFeedbackSurveyCompleted?.call(optionIdentifier);
      }
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
