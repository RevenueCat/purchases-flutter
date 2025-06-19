import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/storefront.dart';

void main() {
  group('Storefront.fromJson', () {
    test('parses required field', () {
      final json = {'countryCode': 'US'};
      final info = Storefront.fromJson(json);
      const expected = Storefront(countryCode: 'US');
      expect(info, equals(expected));
    });
  });
} 