import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/web_purchase_redemption.dart';

void main() {
  group('WebPurchaseRedemption.fromJson', () {
    test('parses all fields', () {
      final json = {
        'redemptionLink': 'https://redeem.link',
      };
      final info = WebPurchaseRedemption.fromJson(json);
      const expected = WebPurchaseRedemption('https://redeem.link');
      expect(info, equals(expected));
    });
  });
} 
