
import 'package:flutter/services.dart';

class RevenueCatUI {
  static const _methodChannel = MethodChannel('purchases_flutter_ui');

  static Future<void> presentPaywall() async =>
      await _methodChannel.invokeMethod('presentPaywall');

  static Future<void> presentPaywallIfNeeded(String requiredEntitlementIdentifier) async =>
      await _methodChannel.invokeMethod(
        'presentPaywallIfNeeded',
        {'requiredEntitlementIdentifier': requiredEntitlementIdentifier},
      );
}
