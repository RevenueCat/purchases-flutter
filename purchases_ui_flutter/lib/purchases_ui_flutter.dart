import 'package:flutter/services.dart';
import 'paywall_result.dart';

export 'paywall_result.dart';

class RevenueCatUI {
  static const _methodChannel = MethodChannel('purchases_ui_flutter');

  /// Presents the paywall as an activity on android or a modal in iOS.
  /// Returns a [PaywallResult] indicating the result of the paywall presentation.
  static Future<PaywallResult> presentPaywall() async {
    final result = await _methodChannel.invokeMethod('presentPaywall');
    return _parseStringToResult(result);
  }


  /// Presents the paywall as an activity on android or a modal in iOS as long
  /// as the user does not have the given entitlement identifier active.
  /// Returns a [PaywallResult] indicating the result of the paywall presentation.
  ///
  /// @param [requiredEntitlementIdentifier] Entitlement identifier to check if the user has access to before presenting the paywall.
  static Future<PaywallResult> presentPaywallIfNeeded(String requiredEntitlementIdentifier) async {
    final result = await _methodChannel.invokeMethod(
      'presentPaywallIfNeeded',
      {'requiredEntitlementIdentifier': requiredEntitlementIdentifier},
    );
    return _parseStringToResult(result);
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
}
