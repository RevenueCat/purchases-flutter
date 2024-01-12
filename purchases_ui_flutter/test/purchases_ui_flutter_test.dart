import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('purchases_ui_flutter');
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
    response = 'NOT_PRESENTED';
    await RevenueCatUI.presentPaywall();
    expect(log, <Matcher>[
      isMethodCall('presentPaywall', arguments: null),
    ]);
  });

  test('presentPaywallIfNeeded', () async {
    response = 'NOT_PRESENTED';
    await RevenueCatUI.presentPaywallIfNeeded('entitlement');
    expect(log, <Matcher>[
      isMethodCall(
        'presentPaywallIfNeeded',
        arguments: {'requiredEntitlementIdentifier': 'entitlement'},
      ),
    ]);
  });

  test('presentPaywall parses response correctly', () async {
    response = 'NOT_PRESENTED';
    var paywallResult = await RevenueCatUI.presentPaywall();
    expect(paywallResult, PaywallResult.notPresented);
    response = 'CANCELLED';
    paywallResult = await RevenueCatUI.presentPaywall();
    expect(paywallResult, PaywallResult.cancelled);
    response = 'ERROR';
    paywallResult = await RevenueCatUI.presentPaywall();
    expect(paywallResult, PaywallResult.error);
    response = 'PURCHASED';
    paywallResult = await RevenueCatUI.presentPaywall();
    expect(paywallResult, PaywallResult.purchased);
    response = 'RESTORED';
    paywallResult = await RevenueCatUI.presentPaywall();
    expect(paywallResult, PaywallResult.restored);
  });
}
