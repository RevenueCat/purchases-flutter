import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:purchases_flutter/models/entitlement_infos_wrapper.dart';
import 'package:purchases_flutter/models/store.dart';
import 'package:purchases_flutter/models/store_transaction.dart';
import 'package:purchases_flutter/models/verification_result.dart';

void main() {
  group('CustomerInfo.fromJson', () {
    test('parses minimum required fields', () {
      final json = {
        'entitlements': {
          'all': {},
          'active': {},
          'verification': 'FAILED',
        },
        'allPurchaseDates': {},
        'activeSubscriptions': [],
        'allPurchasedProductIdentifiers': [],
        'nonSubscriptionTransactions': [],
        'firstSeen': '2024-01-01T00:00:00Z',
        'originalAppUserId': 'user_123',
        'allExpirationDates': {},
        'requestDate': '2024-01-01T00:00:00Z',
      };
      final info = CustomerInfo.fromJson(json);
      const expected = CustomerInfo(
        EntitlementInfos({}, {}, verification: VerificationResult.failed),
        {},
        [],
        [],
        [],
        '2024-01-01T00:00:00Z',
        'user_123',
        {},
        '2024-01-01T00:00:00Z',
      );
      expect(info, equals(expected));
      expect(info.subscriptionsByProductIdentifier, isEmpty);
    });

    test('parses all fields with values', () {
      final json = {
        'entitlements': {
          'all': {},
          'active': {},
          'verification': 'VERIFIED',
        },
        'allPurchaseDates': {'sku1': '2024-01-01'},
        'activeSubscriptions': ['sku1'],
        'allPurchasedProductIdentifiers': ['sku1', 'sku2'],
        'nonSubscriptionTransactions': [
          {
            'transactionIdentifier': 'tx1',
            'revenueCatIdentifier': 'rc1',
            'productIdentifier': 'sku1',
            'purchaseDate': '2024-01-01T00:00:00Z',
          }
        ],
        'firstSeen': '2024-01-01T00:00:00Z',
        'originalAppUserId': 'user_123',
        'allExpirationDates': {'sku1': '2024-02-01'},
        'requestDate': '2024-01-01T00:00:00Z',
        'latestExpirationDate': '2024-02-01',
        'originalPurchaseDate': '2023-12-01',
        'originalApplicationVersion': '1.0.0',
        'managementURL': 'https://example.com/manage',
      };
      final info = CustomerInfo.fromJson(json);
      const expected = CustomerInfo(
        EntitlementInfos({}, {}, verification: VerificationResult.verified),
        {'sku1': '2024-01-01'},
        ['sku1'],
        ['sku1', 'sku2'],
        [StoreTransaction('tx1', 'sku1', '2024-01-01T00:00:00Z')],
        '2024-01-01T00:00:00Z',
        'user_123',
        {'sku1': '2024-02-01'},
        '2024-01-01T00:00:00Z',
        latestExpirationDate: '2024-02-01',
        originalPurchaseDate: '2023-12-01',
        originalApplicationVersion: '1.0.0',
        managementURL: 'https://example.com/manage',
      );
      expect(info, equals(expected));
    });

    test('parses subscriptionsByProductIdentifier', () {
      final json = {
        'entitlements': {
          'all': {},
          'active': {},
          'verification': 'NOT_REQUESTED',
        },
        'allPurchaseDates': {},
        'activeSubscriptions': ['sku1'],
        'allPurchasedProductIdentifiers': ['sku1'],
        'nonSubscriptionTransactions': [],
        'firstSeen': '2024-01-01T00:00:00Z',
        'originalAppUserId': 'user_123',
        'allExpirationDates': {},
        'requestDate': '2024-01-01T00:00:00Z',
        'subscriptionsByProductIdentifier': {
          'sku1': {
            'productIdentifier': 'sku1',
            'purchaseDate': '2024-01-01T00:00:00Z',
            'isSandbox': false,
            'isActive': true,
            'willRenew': false,
            'store': 'PLAY_STORE',
            'autoResumeDate': '2024-03-01T00:00:00Z',
            'productPlanIdentifier': 'monthly-plan',
          }
        },
      };
      final info = CustomerInfo.fromJson(json);
      expect(info.subscriptionsByProductIdentifier.keys, ['sku1']);
      final subscription = info.subscriptionsByProductIdentifier['sku1']!;
      expect(subscription.productIdentifier, 'sku1');
      expect(subscription.store, Store.playStore);
      expect(subscription.autoResumeDate, '2024-03-01T00:00:00Z');
      expect(subscription.productPlanIdentifier, 'monthly-plan');
    });
  });
}
