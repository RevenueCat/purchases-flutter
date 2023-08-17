import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/store_transaction.dart';

void main() {
  Map<String, Object?> generateStoreTransactionJSON() => {
        'transactionIdentifier': 'abd123cd',
        'productIdentifier': 'consumable',
        'purchaseDateMillis': 1.58759855E9,
        'purchaseDate': '2020-04-22T23:35:50.000Z',
      };

  test('constructor assigns correct values', () {
    const storeTransaction = StoreTransaction.create(
      'transactionIdentifier',
      'revenueCatIdentifier',
      'productIdentifier',
      'purchaseDate',
    );

    expect(storeTransaction.transactionIdentifier, 'transactionIdentifier');
    // ignore: deprecated_member_use_from_same_package
    expect(storeTransaction.revenueCatIdentifier, 'revenueCatIdentifier');
    expect(storeTransaction.productIdentifier, 'productIdentifier');
    expect(storeTransaction.purchaseDate, 'purchaseDate');
  });

  test('transactionIdentifier is correctly parsed', () {
    final storeTransaction =
        StoreTransaction.fromJson(generateStoreTransactionJSON());

    expect(storeTransaction.transactionIdentifier, 'abd123cd');
  });

  test('revenueCatIdentifier is correctly parsed', () {
    final storeTransaction =
        StoreTransaction.fromJson(generateStoreTransactionJSON());

    // ignore: deprecated_member_use_from_same_package
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
