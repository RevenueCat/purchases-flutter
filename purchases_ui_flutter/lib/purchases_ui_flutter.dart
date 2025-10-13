import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:purchases_flutter/models/offering_wrapper.dart';
import 'package:purchases_flutter/models/purchases_error.dart';

import 'paywall_result.dart';
import 'views/customer_center_view_method_handler.dart';

export 'paywall_result.dart';
export 'views/customer_center_view.dart';
export 'views/paywall_footer_view.dart';
export 'views/paywall_view.dart';


/// Container for CustomerCenter callbacks
class CustomerCenterCallbacks {
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

  const CustomerCenterCallbacks({
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
}


class RevenueCatUI {
  static const _methodChannel = MethodChannel('purchases_ui_flutter');
  
  static CustomerCenterCallbacks? _customerCenterCallbacks;
  static bool _methodChannelHandlerSet = false;
  

  /// Presents the paywall as an activity on android or a modal in iOS.
  /// Returns a [PaywallResult] indicating the result of the paywall presentation.
  /// @param [offering] If set, will present the paywall associated to the given Offering.
  /// @param [displayCloseButton] Optionally present the paywall with a close button. Only available for original template paywalls. Ignored for V2 Paywalls.
  static Future<PaywallResult> presentPaywall({
    Offering? offering,
    bool displayCloseButton = false,
  }) async {
    final presentedOfferingContext = offering?.availablePackages.elementAtOrNull(0)?.presentedOfferingContext;
    final result = await _methodChannel.invokeMethod('presentPaywall', {
      'offeringIdentifier': offering?.identifier,
      'presentedOfferingContext': presentedOfferingContext?.toJson(),
      'displayCloseButton': displayCloseButton,
    });
    return _parseStringToResult(result);
  }

  /// Presents the paywall as an activity on android or a modal in iOS as long
  /// as the user does not have the given entitlement identifier active.
  /// Returns a [PaywallResult] indicating the result of the paywall presentation.
  ///
  /// @param [requiredEntitlementIdentifier] Entitlement identifier to check if the user has access to before presenting the paywall.
  /// @param [offering] If set, will present the paywall associated to the given Offering.
  /// @param [displayCloseButton] Optionally present the paywall with a close button. Only available for original template paywalls. Ignored for V2 Paywalls.
  static Future<PaywallResult> presentPaywallIfNeeded(
    String requiredEntitlementIdentifier, {
    Offering? offering,
    bool displayCloseButton = false,
  }) async {
    final presentedOfferingContext = offering?.availablePackages.elementAtOrNull(0)?.presentedOfferingContext;
    final result = await _methodChannel.invokeMethod(
      'presentPaywallIfNeeded',
      {
        'requiredEntitlementIdentifier': requiredEntitlementIdentifier,
        'offeringIdentifier': offering?.identifier,
        'presentedOfferingContext': presentedOfferingContext?.toJson(),
        'displayCloseButton': displayCloseButton,
      },
    );
    return _parseStringToResult(result);
  }

  static Future<void> presentCustomerCenter({
    CustomerCenterDismissed? onDismiss,
    CustomerCenterRestoreStarted? onRestoreStarted,
    CustomerCenterRestoreCompleted? onRestoreCompleted,
    CustomerCenterRestoreFailed? onRestoreFailed,
    CustomerCenterManageSubscriptions? onShowingManageSubscriptions,
    CustomerCenterRefundRequestStarted? onRefundRequestStarted,
    CustomerCenterRefundRequestCompleted? onRefundRequestCompleted,
    CustomerCenterFeedbackSurveyCompleted? onFeedbackSurveyCompleted,
    CustomerCenterManagementOptionSelected? onManagementOptionSelected,
    CustomerCenterCustomActionSelected? onCustomActionSelected,
  }) async {
    // Ensure method channel handler is set up
    _ensureMethodChannelHandler();
    
    // Store callbacks for the delegate to use
    _customerCenterCallbacks = CustomerCenterCallbacks(
      onDismiss: onDismiss,
      onRestoreStarted: onRestoreStarted,
      onRestoreCompleted: onRestoreCompleted,
      onRestoreFailed: onRestoreFailed,
      onShowingManageSubscriptions: onShowingManageSubscriptions,
      onRefundRequestStarted: onRefundRequestStarted,
      onRefundRequestCompleted: onRefundRequestCompleted,
      onFeedbackSurveyCompleted: onFeedbackSurveyCompleted,
      onManagementOptionSelected: onManagementOptionSelected,
      onCustomActionSelected: onCustomActionSelected,
    );
    
    await _methodChannel.invokeMethod('presentCustomerCenter');
  }

  static void _ensureMethodChannelHandler() {
    if (!_methodChannelHandlerSet) {
      _methodChannel.setMethodCallHandler((call) async {
        try {
          _handleCustomerCenterMethodCall(call);
        } catch (e) {
          debugPrint('RevenueCatUI: Error handling method call ${call.method}: $e');
        }
      });
      _methodChannelHandlerSet = true;
    }
  }

  static PaywallResult _parseStringToResult(String paywallResultString) {
    switch (paywallResultString) {
      case 'NOT_PRESENTED':
        return PaywallResult.notPresented;
      case 'CANCELLED':
        return PaywallResult.cancelled;
      case 'ERROR':
        return PaywallResult.error;
      case 'PURCHASED':
        return PaywallResult.purchased;
      case 'RESTORED':
        return PaywallResult.restored;
      default:
        return PaywallResult.error;
    }
  }

  static void _handleCustomerCenterMethodCall(MethodCall call) {
    final callbacks = _customerCenterCallbacks;

    switch (call.method) {
      case 'onDismiss':
        callbacks?.onDismiss?.call();
        break;
      case 'onRestoreStarted':
        callbacks?.onRestoreStarted?.call();
        break;
      case 'onRestoreCompleted':
        final customerInfoData = call.arguments as Map<String, dynamic>?;
        if (customerInfoData != null) {
          try {
            final customerInfo = CustomerInfo.fromJson(customerInfoData);
            callbacks?.onRestoreCompleted?.call(customerInfo);
          } catch (e) {
            debugPrint('RevenueCatUI: Error parsing CustomerInfo in onRestoreCompleted: $e');
          }
        } else {
          debugPrint('RevenueCatUI: Warning - onRestoreCompleted called with null arguments');
        }
        break;
      case 'onRestoreFailed':
        final errorData = call.arguments as Map<String, dynamic>?;
        if (errorData != null) {
          try {
            final error = PurchasesError.fromJson(errorData);
            callbacks?.onRestoreFailed?.call(error);
          } catch (e) {
            debugPrint('RevenueCatUI: Error parsing PurchasesError in onRestoreFailed: $e');
          }
        } else {
          debugPrint('RevenueCatUI: Warning - onRestoreFailed called with null arguments');
        }
        break;
      case 'onShowingManageSubscriptions':
        callbacks?.onShowingManageSubscriptions?.call();
        break;
      case 'onRefundRequestStarted':
        final productIdentifier = call.arguments as String?;
        if (productIdentifier != null && productIdentifier.isNotEmpty) {
          callbacks?.onRefundRequestStarted?.call(productIdentifier);
        } else {
          debugPrint('RevenueCatUI: Warning - onRefundRequestStarted called with invalid productIdentifier: $productIdentifier');
        }
        break;
      case 'onRefundRequestCompleted':
        final data = call.arguments as Map<String, dynamic>?;
        if (data != null) {
          final productIdentifier = data['productId'] as String?;
          final status = data['status'] as String?;
          if (productIdentifier != null && productIdentifier.isNotEmpty &&
              status != null && status.isNotEmpty) {
            callbacks?.onRefundRequestCompleted?.call(productIdentifier, status);
          } else {
            debugPrint('RevenueCatUI: Warning - onRefundRequestCompleted called with invalid data - productId: $productIdentifier, status: $status');
          }
        } else {
          debugPrint('RevenueCatUI: Warning - onRefundRequestCompleted called with null arguments');
        }
        break;
      case 'onFeedbackSurveyCompleted':
        final optionIdentifier = call.arguments as String?;
        if (optionIdentifier != null && optionIdentifier.isNotEmpty) {
          callbacks?.onFeedbackSurveyCompleted?.call(optionIdentifier);
        } else {
          debugPrint('RevenueCatUI: Warning - onFeedbackSurveyCompleted called with invalid optionIdentifier: $optionIdentifier');
        }
        break;
      case 'onManagementOptionSelected':
        final data = call.arguments as Map<String, dynamic>?;
        if (data != null) {
          final optionIdentifier = data['optionId'] as String?;
          final url = data['url'] as String?; // url can be null
          if (optionIdentifier != null && optionIdentifier.isNotEmpty) {
            callbacks?.onManagementOptionSelected?.call(optionIdentifier, url);
          } else {
            debugPrint('RevenueCatUI: Warning - onManagementOptionSelected called with invalid optionId: $optionIdentifier');
          }
        } else {
          debugPrint('RevenueCatUI: Warning - onManagementOptionSelected called with null arguments');
        }
        break;
      case 'onCustomActionSelected':
        final data = call.arguments as Map<String, dynamic>?;
        if (data != null) {
          final actionIdentifier = data['actionId'] as String?;
          final purchaseIdentifier = data['purchaseIdentifier'] as String?; // can be null
          if (actionIdentifier != null && actionIdentifier.isNotEmpty) {
            callbacks?.onCustomActionSelected?.call(actionIdentifier, purchaseIdentifier);
          } else {
            debugPrint('RevenueCatUI: Warning - onCustomActionSelected called with invalid actionId: $actionIdentifier');
          }
        } else {
          debugPrint('RevenueCatUI: Warning - onCustomActionSelected called with null arguments');
        }
        break;
    }
  }
}
