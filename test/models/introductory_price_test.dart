import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/introductory_price.dart';
import 'package:purchases_flutter/models/period_unit.dart';

void main() {
  group('IntroductoryPrice.fromJson', () {
    test('parses all fields', () {
      final json = {
        'price': 1.99,
        'priceString': '\$1.99',
        'period': 'P1W',
        'cycles': 2,
        'periodUnit': 'WEEK',
        'periodNumberOfUnits': 1,
      };
      final info = IntroductoryPrice.fromJson(json);
      const expected = IntroductoryPrice(
        1.99,
        '\$1.99',
        'P1W',
        2,
        PeriodUnit.week,
        1,
      );
      expect(info, equals(expected));
    });
  });
} 