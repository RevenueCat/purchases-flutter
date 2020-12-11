import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('purchases_flutter');
  final List<MethodCall> log = <MethodCall>[];
  dynamic response;

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      log.add(methodCall);
      return response;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
    log.clear();
    response = null;
  });

  test('setupPurchases', () async {
    await Purchases.setup('api_key', appUserId: 'cesar', observerMode: true);
    expect(
      log,
      <Matcher>[
        isMethodCall(
          'setupPurchases',
          arguments: <String, dynamic>{
            'apiKey': 'api_key',
            'appUserId': 'cesar',
            'observerMode': true,
            'userDefaultsSuiteName': null
          },
        )
      ],
    );
  });
}
