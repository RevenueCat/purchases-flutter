import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter_ui/purchases_flutter_ui.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('purchases_flutter_ui');
  final log = <MethodCall>[];
  dynamic response;

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
      log.add(call);
      return response;
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
    log.clear();
    response = null;
  });

  test('presentPaywall', () async {
    await RevenueCatUI.presentPaywall();
    expect(log, <Matcher>[
      isMethodCall('presentPaywall', arguments: null),
    ]);
  });

  test('presentPaywallIfNeeded', () async {
    await RevenueCatUI.presentPaywallIfNeeded('entitlement');
    expect(log, <Matcher>[
      isMethodCall('presentPaywallIfNeeded', arguments: {'requiredEntitlementIdentifier': 'entitlement'}),
    ]);
  });
}
