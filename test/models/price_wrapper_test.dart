import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/price_wrapper.dart';

void main() {
  group('Price.fromJson', () {
    test('parses all fields', () {
      final json = {
        'formatted': '\$4.99',
        'amountMicros': 4990000,
        'currencyCode': 'USD',
      };
      final info = Price.fromJson(json);
      const expected = Price(
        '\$4.99',
        4990000,
        'USD',
      );
      expect(info, equals(expected));
    });
  });
} 
