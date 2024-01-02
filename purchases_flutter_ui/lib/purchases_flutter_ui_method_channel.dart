import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'purchases_flutter_ui_platform_interface.dart';

/// An implementation of [PurchasesFlutterUiPlatform] that uses method channels.
class MethodChannelPurchasesFlutterUi extends PurchasesFlutterUiPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('purchases_flutter_ui');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
