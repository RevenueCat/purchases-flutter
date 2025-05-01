import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/web_purchase_redemption_result.dart';

void main() {
  test('fromJson correctly parses expired', () {
    final result = WebPurchaseRedemptionResult.fromJson({
      'result': 'EXPIRED',
      'obfuscatedEmail': 'test-obfuscated-email@g******m',
    });
    Expired? resultIfExpired;
    switch (result) {
      case Expired(:final obfuscatedEmail):
        expect(obfuscatedEmail, 'test-obfuscated-email@g******m');
        resultIfExpired = result;
      case _:
        break;
    }
    expect(resultIfExpired, isNotNull);
  });

  test('fromJson correctly parses purchaseBelongsToOtherUser', () {
    final result = WebPurchaseRedemptionResult.fromJson({
      'result': 'PURCHASE_BELONGS_TO_OTHER_USER',
    });

    PurchaseBelongsToOtherUser? resultIfPurchaseBelongsToOtherUser;
    switch (result) {
      case PurchaseBelongsToOtherUser():
        resultIfPurchaseBelongsToOtherUser = result;
      case _:
        break;
    }
    expect(resultIfPurchaseBelongsToOtherUser, isNotNull);
  });

  test('fromJson correctly parses success', () {
    const customerInfoJson = {
      'originalAppUserId': 'pepe',
      'entitlements': {
        'all': {},
        'active': {},
        'verification': 'NOT_REQUESTED'
      },
      'activeSubscriptions': [],
      'latestExpirationDate': '2021-04-09T14:48:00.000Z',
      'allExpirationDates': {},
      'allPurchasedProductIdentifiers': [],
      'firstSeen': '2021-01-09T14:48:00.000Z',
      'requestDate': '2021-04-09T14:48:00.000Z',
      'allPurchaseDates': {},
      'originalApplicationVersion': '1.2.3',
      'nonSubscriptionTransactions': [],
    };
    final result = WebPurchaseRedemptionResult.fromJson({
      'result': 'SUCCESS',
      'customerInfo': customerInfoJson,
    });

    Success? resultIfSuccess;
    switch (result) {
      case Success(:final customerInfo):
        expect(customerInfo.originalAppUserId, 'pepe');
        return result;
      case _:
        break;
    }
    expect(resultIfSuccess, isNotNull);
  });
}
