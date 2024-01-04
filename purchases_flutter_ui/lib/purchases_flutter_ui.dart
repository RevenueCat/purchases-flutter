
import 'package:flutter/services.dart';

class RevenueCatUI {
  static const _methodChannel = MethodChannel('purchases_flutter_ui');

  /// Presents the paywall as an activity on android or a modal in iOS.
  static Future<void> presentPaywall() async =>
      await _methodChannel.invokeMethod('presentPaywall');

  /// Presents the paywall as an activity on android or a modal in iOS as long
  /// as the user does not have the given entitlement identifier active.
  ///
  /// @param [requiredEntitlementIdentifier] Entitlement identifier to check if the user has access to before presenting the paywall.
  static Future<void> presentPaywallIfNeeded(String requiredEntitlementIdentifier) async =>
      await _methodChannel.invokeMethod(
        'presentPaywallIfNeeded',
        {'requiredEntitlementIdentifier': requiredEntitlementIdentifier},
      );
}
