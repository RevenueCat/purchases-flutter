import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/store_product_discount.dart';

void main() {
  group('StoreProductDiscount.fromJson', () {
    test('parses all fields (all are required)', () {
      final json = {
        'identifier': 'discount1',
        'price': 4.99,
        'priceString': '\$4.99',
        'cycles': 2,
        'period': 'P1W',
        'periodUnit': 'WEEK',
        'periodNumberOfUnits': 1,
      };
      final info = StoreProductDiscount.fromJson(json);
      const expected = StoreProductDiscount(
        'discount1',
        4.99,
        '\$4.99',
        2,
        'P1W',
        'WEEK',
        1,
      );
      expect(info, equals(expected));
      expect(StoreProductDiscount.fromJson(info.toJson()), equals(expected));
    });
  });
}
