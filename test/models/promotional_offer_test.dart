import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/promotional_offer.dart';

void main() {
  group('PromotionalOffer.fromJson', () {
    test('parses all fields', () {
      final json = {
        'identifier': 'promo1',
        'keyIdentifier': 'key1',
        'nonce': 'nonce1',
        'signature': 'sig1',
        'timestamp': 1234567890,
      };
      final info = PromotionalOffer.fromJson(json);
      const expected = PromotionalOffer(
        'promo1',
        'key1',
        'nonce1',
        'sig1',
        1234567890,
      );
      expect(info, equals(expected));
    });
  });
} 