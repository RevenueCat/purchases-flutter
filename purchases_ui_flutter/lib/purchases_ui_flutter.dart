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
        final rawArguments = call.arguments;
        if (rawArguments is! Map) {
          debugPrint('RevenueCatUI: Error - onRestoreCompleted called with invalid arguments: $rawArguments');
          return;
        }
        final arguments = Map<String, dynamic>.from(rawArguments);
        try {
          final customerInfo = CustomerInfo.fromJson(arguments);
          callbacks?.onRestoreCompleted?.call(customerInfo);
        } catch (e) {
          debugPrint('RevenueCatUI: Error parsing CustomerInfo in onRestoreCompleted: $e');
        }
        break;
      case 'onRestoreFailed':
        final rawArguments = call.arguments;
        if (rawArguments is! Map) {
          debugPrint('RevenueCatUI: Error - onRestoreFailed called with invalid arguments: $rawArguments');
          return;
        }
        final arguments = Map<String, dynamic>.from(rawArguments);
        try {
          final error = PurchasesError.fromJson(arguments);
          callbacks?.onRestoreFailed?.call(error);
        } catch (e) {
          debugPrint('RevenueCatUI: Error parsing PurchasesError in onRestoreFailed: $e');
        }
        break;
      case 'onShowingManageSubscriptions':
        callbacks?.onShowingManageSubscriptions?.call();
        break;
      case 'onRefundRequestStarted':
        final arguments = call.arguments;
        if (arguments is! String || arguments.isEmpty) {
          debugPrint('RevenueCatUI: Error - onRefundRequestStarted called with invalid productIdentifier: $arguments');
          return;
        }
        callbacks?.onRefundRequestStarted?.call(arguments);
        break;
      case 'onRefundRequestCompleted':
        final rawArguments = call.arguments;
        if (rawArguments is! Map) {
          debugPrint('RevenueCatUI: Error - onRefundRequestCompleted called with invalid arguments: $rawArguments');
          return;
        }
        final arguments = Map<String, dynamic>.from(rawArguments);
        final productIdentifier = arguments['productId'];
        final status = arguments['status'];
        if (productIdentifier is! String || productIdentifier.isEmpty) {
          debugPrint('RevenueCatUI: Error - onRefundRequestCompleted called without a valid productId: $productIdentifier');
          return;
        }
        if (status is! String || status.isEmpty) {
          debugPrint('RevenueCatUI: Error - onRefundRequestCompleted called without a valid status: $status');
          return;
        }
        callbacks?.onRefundRequestCompleted?.call(productIdentifier, status);
        break;
      case 'onFeedbackSurveyCompleted':
        final arguments = call.arguments;
        if (arguments is! String || arguments.isEmpty) {
          debugPrint('RevenueCatUI: Error - onFeedbackSurveyCompleted called with invalid optionIdentifier: $arguments');
          return;
        }
        callbacks?.onFeedbackSurveyCompleted?.call(arguments);
        break;
      case 'onManagementOptionSelected':
        final rawArguments = call.arguments;
        if (rawArguments is! Map) {
          debugPrint('RevenueCatUI: Error - onManagementOptionSelected called with invalid arguments: $rawArguments');
          return;
        }
        final arguments = Map<String, dynamic>.from(rawArguments);
        final optionIdentifier = arguments['optionId'];
        if (optionIdentifier is! String || optionIdentifier.isEmpty) {
          debugPrint('RevenueCatUI: Error - onManagementOptionSelected called without a valid optionId: $optionIdentifier');
          return;
        }
        final url = arguments['url'];
        if (url != null && url is! String) {
          debugPrint('RevenueCatUI: Error - onManagementOptionSelected called with invalid url: $url');
          return;
        }
        callbacks?.onManagementOptionSelected?.call(optionIdentifier, url as String?);
        break;
      case 'onCustomActionSelected':
        final rawArguments = call.arguments;
        if (rawArguments is! Map) {
          debugPrint('RevenueCatUI: Error - onCustomActionSelected called with invalid arguments: $rawArguments');
          return;
        }
        final arguments = Map<String, dynamic>.from(rawArguments);
        final actionIdentifier = arguments['actionId'];
        if (actionIdentifier is! String || actionIdentifier.isEmpty) {
          debugPrint('RevenueCatUI: Error - onCustomActionSelected called without a valid actionId: $actionIdentifier');
          return;
        }
        final purchaseIdentifier = arguments['purchaseIdentifier'];
        if (purchaseIdentifier != null && purchaseIdentifier is! String) {
          debugPrint('RevenueCatUI: Error - onCustomActionSelected called with invalid purchaseIdentifier: $purchaseIdentifier');
          return;
        }
        callbacks?.onCustomActionSelected?.call(actionIdentifier, purchaseIdentifier as String?);
        break;
    }
  }
}
