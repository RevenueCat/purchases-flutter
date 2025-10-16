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
class RevenueCatUI {
  static const _methodChannel = MethodChannel('purchases_ui_flutter');
  
  static CustomerCenterRestoreStarted? _customerCenterOnRestoreStarted;
  static CustomerCenterRestoreCompleted? _customerCenterOnRestoreCompleted;
  static CustomerCenterRestoreFailed? _customerCenterOnRestoreFailed;
  static CustomerCenterManageSubscriptions? _customerCenterOnShowingManageSubscriptions;
  static CustomerCenterRefundRequestStarted? _customerCenterOnRefundRequestStarted;
  static CustomerCenterRefundRequestCompleted? _customerCenterOnRefundRequestCompleted;
  static CustomerCenterFeedbackSurveyCompleted? _customerCenterOnFeedbackSurveyCompleted;
  static CustomerCenterManagementOptionSelected? _customerCenterOnManagementOptionSelected;
  static CustomerCenterCustomActionSelected? _customerCenterOnCustomActionSelected;
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

  /// Presents the customer center modally using the native SDKs.
  ///
  /// Provide callback handlers to receive customer center lifecycle events.
  /// All handlers are optional.
  static Future<void> presentCustomerCenter({
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
    _setMethodChannelHandlerIfNeeded();
    final hasCallbacks = onRestoreStarted != null ||
        onRestoreCompleted != null ||
        onRestoreFailed != null ||
        onShowingManageSubscriptions != null ||
        onRefundRequestStarted != null ||
        onRefundRequestCompleted != null ||
        onFeedbackSurveyCompleted != null ||
        onManagementOptionSelected != null ||
        onCustomActionSelected != null;

    await _clearCustomerCenterCallbacks();

    if (hasCallbacks) {
      await _registerCustomerCenterCallbacks(
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

  static void _setMethodChannelHandlerIfNeeded() {
    if (!_methodChannelHandlerSet) {
      _methodChannel.setMethodCallHandler((call) async {
        try {
          await _handleCustomerCenterMethodCall(call);
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

  static Future<void> _registerCustomerCenterCallbacks({
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
    _storeCustomerCenterCallbacks(
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
    await _methodChannel.invokeMethod('setCustomerCenterCallbacks');
  }

  static Future<void> _clearCustomerCenterCallbacks() async {
    _setMethodChannelHandlerIfNeeded();
    _customerCenterOnRestoreStarted = null;
    _customerCenterOnRestoreCompleted = null;
    _customerCenterOnRestoreFailed = null;
    _customerCenterOnShowingManageSubscriptions = null;
    _customerCenterOnRefundRequestStarted = null;
    _customerCenterOnRefundRequestCompleted = null;
    _customerCenterOnFeedbackSurveyCompleted = null;
    _customerCenterOnManagementOptionSelected = null;
    _customerCenterOnCustomActionSelected = null;
    await _methodChannel.invokeMethod('clearCustomerCenterCallbacks');
  }

  static void _storeCustomerCenterCallbacks({
    CustomerCenterRestoreStarted? onRestoreStarted,
    CustomerCenterRestoreCompleted? onRestoreCompleted,
    CustomerCenterRestoreFailed? onRestoreFailed,
    CustomerCenterManageSubscriptions? onShowingManageSubscriptions,
    CustomerCenterRefundRequestStarted? onRefundRequestStarted,
    CustomerCenterRefundRequestCompleted? onRefundRequestCompleted,
    CustomerCenterFeedbackSurveyCompleted? onFeedbackSurveyCompleted,
    CustomerCenterManagementOptionSelected? onManagementOptionSelected,
    CustomerCenterCustomActionSelected? onCustomActionSelected,
  }) {
    _setMethodChannelHandlerIfNeeded();
    _customerCenterOnRestoreStarted = onRestoreStarted;
    _customerCenterOnRestoreCompleted = onRestoreCompleted;
    _customerCenterOnRestoreFailed = onRestoreFailed;
    _customerCenterOnShowingManageSubscriptions = onShowingManageSubscriptions;
    _customerCenterOnRefundRequestStarted = onRefundRequestStarted;
    _customerCenterOnRefundRequestCompleted = onRefundRequestCompleted;
    _customerCenterOnFeedbackSurveyCompleted = onFeedbackSurveyCompleted;
    _customerCenterOnManagementOptionSelected = onManagementOptionSelected;
    _customerCenterOnCustomActionSelected = onCustomActionSelected;
  }

  static Future<void> _handleCustomerCenterMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onDismiss':
        // Clear the listener registration to avoid retaining the plugin
        await _clearCustomerCenterCallbacks();
        break;
      case 'onRestoreStarted':
        _customerCenterOnRestoreStarted?.call();
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
          _customerCenterOnRestoreCompleted?.call(customerInfo);
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
          _customerCenterOnRestoreFailed?.call(error);
        } catch (e) {
          debugPrint('RevenueCatUI: Error parsing PurchasesError in onRestoreFailed: $e');
        }
        break;
      case 'onShowingManageSubscriptions':
        _customerCenterOnShowingManageSubscriptions?.call();
        break;
      case 'onRefundRequestStarted':
        final rawArguments = call.arguments;
        if (rawArguments is! Map) {
          debugPrint('RevenueCatUI: Error - onRefundRequestStarted called with invalid arguments: $rawArguments');
          return;
        }
        final arguments = Map<String, dynamic>.from(rawArguments);
        final productIdentifier = arguments['productId'];
        if (productIdentifier is! String || productIdentifier.isEmpty) {
          debugPrint('RevenueCatUI: Error - onRefundRequestStarted called without a valid productId: $productIdentifier');
          return;
        }
        _customerCenterOnRefundRequestStarted?.call(productIdentifier);
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
        _customerCenterOnRefundRequestCompleted?.call(productIdentifier, status);
        break;
      case 'onFeedbackSurveyCompleted':
        final rawArguments = call.arguments;
        if (rawArguments is! Map) {
          debugPrint('RevenueCatUI: Error - onFeedbackSurveyCompleted called with invalid arguments: $rawArguments');
          return;
        }
        final arguments = Map<String, dynamic>.from(rawArguments);
        final optionIdentifier = arguments['optionId'];
        if (optionIdentifier is! String || optionIdentifier.isEmpty) {
          debugPrint('RevenueCatUI: Error - onFeedbackSurveyCompleted called without a valid optionId: $optionIdentifier');
          return;
        }
        _customerCenterOnFeedbackSurveyCompleted?.call(optionIdentifier);
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
        _customerCenterOnManagementOptionSelected?.call(optionIdentifier, url as String?);
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
        _customerCenterOnCustomActionSelected?.call(actionIdentifier, purchaseIdentifier as String?);
        break;
    }
  }
}
