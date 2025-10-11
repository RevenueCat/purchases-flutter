import 'dart:async';

import 'package:flutter/services.dart';
import 'package:purchases_flutter/models/offering_wrapper.dart';

import 'paywall_result.dart';

export 'paywall_result.dart';
export 'views/customer_center_view.dart';
export 'views/paywall_footer_view.dart';
export 'views/paywall_view.dart';

// Default empty callbacks
void _emptyCallback() {}
void _emptyStringCallback(String _) {}
void _emptyDataCallback(Map<String, dynamic> _) {}

/// Container for CustomerCenter callbacks
class CustomerCenterCallbacks {
  final VoidCallback onDismiss;
  final VoidCallback onRestoreStarted;
  final Function(Map<String, dynamic>) onRestoreCompleted;
  final Function(Map<String, dynamic>) onRestoreFailed;
  final VoidCallback onShowingManageSubscriptions;
  final Function(String) onRefundRequestStarted;
  final Function(Map<String, dynamic>) onRefundRequestCompleted;
  final Function(String) onFeedbackSurveyCompleted;
  final Function(Map<String, dynamic>) onManagementOptionSelected;
  final Function(Map<String, dynamic>) onCustomActionSelected;

  const CustomerCenterCallbacks({
    required this.onDismiss,
    required this.onRestoreStarted,
    required this.onRestoreCompleted,
    required this.onRestoreFailed,
    required this.onShowingManageSubscriptions,
    required this.onRefundRequestStarted,
    required this.onRefundRequestCompleted,
    required this.onFeedbackSurveyCompleted,
    required this.onManagementOptionSelected,
    required this.onCustomActionSelected,
  });
}

/// CustomerCenter event types for global event stream
enum CustomerCenterEventType {
  dismiss,
  restoreStarted,
  restoreCompleted,
  restoreFailed,
  showingManageSubscriptions,
  refundRequestStarted,
  refundRequestCompleted,
  feedbackSurveyCompleted,
  managementOptionSelected,
  customActionSelected,
}

/// CustomerCenter event data
class CustomerCenterEvent {
  final CustomerCenterEventType type;
  final Map<String, dynamic>? data;
  
  const CustomerCenterEvent(this.type, [this.data]);
}

class RevenueCatUI {
  static const _methodChannel = MethodChannel('purchases_ui_flutter');
  static const _customerCenterEventChannel = MethodChannel('purchases_ui_flutter/customerCenterEvents');
  
  static Stream<CustomerCenterEvent>? _customerCenterEventStream;
  static CustomerCenterCallbacks? _customerCenterCallbacks;
  static bool _methodChannelHandlerSet = false;
  
  /// Stream of CustomerCenter events from presentCustomerCenter()
  /// 
  /// Listen to this stream to receive events when using the modal CustomerCenter:
  /// ```dart
  /// RevenueCatUI.customerCenterEventStream.listen((event) {
  ///   switch (event.type) {
  ///     case CustomerCenterEventType.restoreStarted:
  ///       print('Restore started');
  ///       break;
  ///     case CustomerCenterEventType.restoreCompleted:
  ///       final customerInfo = CustomerInfo.fromJson(event.data!);
  ///       print('Restore completed: $customerInfo');
  ///       break;
  ///   }
  /// });
  /// ```
  static Stream<CustomerCenterEvent> get customerCenterEventStream {
    _customerCenterEventStream ??= _setupCustomerCenterEventStream();
    return _customerCenterEventStream!;
  }
  
  static Stream<CustomerCenterEvent> _setupCustomerCenterEventStream() {
    late StreamController<CustomerCenterEvent> controller;
    
    controller = StreamController<CustomerCenterEvent>.broadcast(
      onListen: () {
        _customerCenterEventChannel.setMethodCallHandler((call) async {
          try {
            _handleCustomerCenterMethodCall(call);
            final event = _parseCustomerCenterMethodCall(call);
            controller.add(event);
          } catch (e) {
            controller.addError(e);
          }
        });
      },
      onCancel: () {
        _customerCenterEventChannel.setMethodCallHandler(null);
      },
    );
    
    return controller.stream;
  }

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
    VoidCallback onDismiss = _emptyCallback,
    VoidCallback onRestoreStarted = _emptyCallback,
    Function(Map<String, dynamic>) onRestoreCompleted = _emptyDataCallback,
    Function(Map<String, dynamic>) onRestoreFailed = _emptyDataCallback,
    VoidCallback onShowingManageSubscriptions = _emptyCallback,
    Function(String) onRefundRequestStarted = _emptyStringCallback,
    Function(Map<String, dynamic>) onRefundRequestCompleted = _emptyDataCallback,
    Function(String) onFeedbackSurveyCompleted = _emptyStringCallback,
    Function(Map<String, dynamic>) onManagementOptionSelected = _emptyDataCallback,
    Function(Map<String, dynamic>) onCustomActionSelected = _emptyDataCallback,
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
      _customerCenterEventChannel.setMethodCallHandler((call) async {
        try {
          _handleCustomerCenterMethodCall(call);
        } catch (e) {
          // Silently ignore callback errors
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
    if (callbacks == null) return;

    switch (call.method) {
      case 'onDismiss':
        callbacks.onDismiss();
        break;
      case 'onRestoreStarted':
        callbacks.onRestoreStarted();
        break;
      case 'onRestoreCompleted':
        callbacks.onRestoreCompleted(call.arguments as Map<String, dynamic>? ?? {});
        break;
      case 'onRestoreFailed':
        callbacks.onRestoreFailed(call.arguments as Map<String, dynamic>? ?? {});
        break;
      case 'onShowingManageSubscriptions':
        callbacks.onShowingManageSubscriptions();
        break;
      case 'onRefundRequestStarted':
        callbacks.onRefundRequestStarted(call.arguments as String? ?? '');
        break;
      case 'onRefundRequestCompleted':
        callbacks.onRefundRequestCompleted(call.arguments as Map<String, dynamic>? ?? {});
        break;
      case 'onFeedbackSurveyCompleted':
        callbacks.onFeedbackSurveyCompleted(call.arguments as String? ?? '');
        break;
      case 'onManagementOptionSelected':
        callbacks.onManagementOptionSelected(call.arguments as Map<String, dynamic>? ?? {});
        break;
      case 'onCustomActionSelected':
        callbacks.onCustomActionSelected(call.arguments as Map<String, dynamic>? ?? {});
        break;
    }
  }

  static CustomerCenterEvent _parseCustomerCenterMethodCall(MethodCall call) {
    switch (call.method) {
      case 'onDismiss':
        return const CustomerCenterEvent(CustomerCenterEventType.dismiss);
      case 'onRestoreStarted':
        return const CustomerCenterEvent(CustomerCenterEventType.restoreStarted);
      case 'onRestoreCompleted':
        return CustomerCenterEvent(
          CustomerCenterEventType.restoreCompleted, 
          call.arguments as Map<String, dynamic>?,
        );
      case 'onRestoreFailed':
        return CustomerCenterEvent(
          CustomerCenterEventType.restoreFailed, 
          call.arguments as Map<String, dynamic>?,
        );
      case 'onShowingManageSubscriptions':
        return const CustomerCenterEvent(CustomerCenterEventType.showingManageSubscriptions);
      case 'onRefundRequestStarted':
        return CustomerCenterEvent(
          CustomerCenterEventType.refundRequestStarted, 
          {'productIdentifier': call.arguments},
        );
      case 'onRefundRequestCompleted':
        return CustomerCenterEvent(
          CustomerCenterEventType.refundRequestCompleted, 
          call.arguments as Map<String, dynamic>?,
        );
      case 'onFeedbackSurveyCompleted':
        return CustomerCenterEvent(
          CustomerCenterEventType.feedbackSurveyCompleted, 
          {'optionIdentifier': call.arguments},
        );
      case 'onManagementOptionSelected':
        return CustomerCenterEvent(
          CustomerCenterEventType.managementOptionSelected, 
          call.arguments as Map<String, dynamic>?,
        );
      case 'onCustomActionSelected':
        return CustomerCenterEvent(
          CustomerCenterEventType.customActionSelected, 
          call.arguments as Map<String, dynamic>?,
        );
      default:
        throw ArgumentError('Unknown CustomerCenter event: ${call.method}');
    }
  }
}
