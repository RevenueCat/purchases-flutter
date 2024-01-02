import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter_ui/purchases_flutter_ui.dart';
import 'package:purchases_flutter_ui/purchases_flutter_ui_platform_interface.dart';
import 'package:purchases_flutter_ui/purchases_flutter_ui_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPurchasesFlutterUiPlatform
    with MockPlatformInterfaceMixin
    implements PurchasesFlutterUiPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PurchasesFlutterUiPlatform initialPlatform = PurchasesFlutterUiPlatform.instance;

  test('$MethodChannelPurchasesFlutterUi is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPurchasesFlutterUi>());
  });

  test('getPlatformVersion', () async {
    PurchasesFlutterUi purchasesFlutterUiPlugin = PurchasesFlutterUi();
    MockPurchasesFlutterUiPlatform fakePlatform = MockPurchasesFlutterUiPlatform();
    PurchasesFlutterUiPlatform.instance = fakePlatform;

    expect(await purchasesFlutterUiPlugin.getPlatformVersion(), '42');
  });
}
