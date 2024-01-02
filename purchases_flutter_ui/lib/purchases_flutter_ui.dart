
import 'purchases_flutter_ui_platform_interface.dart';

class PurchasesFlutterUi {
  Future<String?> getPlatformVersion() {
    return PurchasesFlutterUiPlatform.instance.getPlatformVersion();
  }
}
