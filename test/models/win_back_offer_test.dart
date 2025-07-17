import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/win_back_offer.dart';

void main() {
  group('WinBackOffer.fromJson', () {
    test('parses all fields (all are required)', () {
      final json = {
        'identifier': 'offer1',
        'price': 9.99,
        'priceString': '\$9.99',
        'cycles': 3,
        'period': 'P1M',
        'periodUnit': 'MONTH',
        'periodNumberOfUnits': 1,
      };
      final info = WinBackOffer.fromJson(json);
      const expected = WinBackOffer(
        'offer1',
        9.99,
        '\$9.99',
        3,
        'P1M',
        'MONTH',
        1,
      );
      expect(info, equals(expected));
    });
  });
} 
