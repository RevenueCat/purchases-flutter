import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/store_transaction.dart';

void main() {
  group('StoreTransaction.fromJson', () {
    test('parses all fields', () {
      final json = {
        'transactionIdentifier': 'tx1',
        'revenueCatIdentifier': 'rc1',
        'productIdentifier': 'sku1',
        'purchaseDate': '2024-01-01T00:00:00Z',
      };
      final info = StoreTransaction.fromJson(json);
      final expected = StoreTransaction(
        'tx1',
        'sku1',
        '2024-01-01T00:00:00Z',
      );
      expect(info, equals(expected));
    });
  });
} 