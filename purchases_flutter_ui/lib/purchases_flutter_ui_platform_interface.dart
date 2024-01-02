import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'purchases_flutter_ui_method_channel.dart';

abstract class PurchasesFlutterUiPlatform extends PlatformInterface {
  /// Constructs a PurchasesFlutterUiPlatform.
  PurchasesFlutterUiPlatform() : super(token: _token);

  static final Object _token = Object();

  static PurchasesFlutterUiPlatform _instance = MethodChannelPurchasesFlutterUi();

  /// The default instance of [PurchasesFlutterUiPlatform] to use.
  ///
  /// Defaults to [MethodChannelPurchasesFlutterUi].
  static PurchasesFlutterUiPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PurchasesFlutterUiPlatform] when
  /// they register themselves.
  static set instance(PurchasesFlutterUiPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
