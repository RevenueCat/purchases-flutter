import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

void main() {
  const MethodChannel channel = MethodChannel('purchases_flutter');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('setupPurchases', () async {
    Purchases.setup("api_key", appUserId: "cesar", observerMode: true);
  });
}
