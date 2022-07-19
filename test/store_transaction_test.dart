import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/store_transaction.dart';

void main() {
  Map<String, Object?> generateStoreTransactionJSON() => {
        'revenueCatId': 'abd123cd',
        'productId': 'consumable',
        'purchaseDateMillis': 1.58759855E9,
        'purchaseDate': '2020-04-22T23:35:50.000Z'
      };

  test('revenueCatIdentifier is correctly parsed', () {
    final storeTransaction =
        StoreTransaction.fromJson(generateStoreTransactionJSON());

    expect(storeTransaction.revenueCatIdentifier, 'abd123cd');
  });

  test('productId is correctly parsed', () {
    final storeTransaction =
        StoreTransaction.fromJson(generateStoreTransactionJSON());

    expect(storeTransaction.productIdentifier, 'consumable');
  });

  test('purchaseDate is correctly parsed', () {
    final storeTransaction =
        StoreTransaction.fromJson(generateStoreTransactionJSON());

    expect(storeTransaction.purchaseDate, '2020-04-22T23:35:50.000Z');
  });
}
