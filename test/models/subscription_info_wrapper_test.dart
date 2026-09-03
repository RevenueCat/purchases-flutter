import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/entitlement_info_wrapper.dart';
import 'package:purchases_flutter/models/store.dart';
import 'package:purchases_flutter/models/subscription_info_wrapper.dart';

void main() {
  group('SubscriptionInfo.fromJson', () {
    test('parses required fields and applies defaults', () {
      final json = {
        'productIdentifier': 'sku1',
        'purchaseDate': '2024-01-01T00:00:00Z',
        'isSandbox': false,
        'isActive': true,
        'willRenew': true,
      };
      final info = SubscriptionInfo.fromJson(json);
      const expected = SubscriptionInfo(
        'sku1',
        '2024-01-01T00:00:00Z',
        false,
        true,
        true,
      );
      expect(info, equals(expected));
      expect(info.store, Store.unknownStore);
      expect(info.periodType, PeriodType.unknown);
      expect(info.ownershipType, OwnershipType.unknown);
      expect(info.autoResumeDate, isNull);
      expect(info.displayName, isNull);
      expect(info.managementURL, isNull);
      expect(info.productPlanIdentifier, isNull);
    });

    test('parses all fields including autoResumeDate and productPlanIdentifier',
        () {
      final json = {
        'productIdentifier': 'sku1',
        'purchaseDate': '2024-01-01T00:00:00Z',
        'isSandbox': true,
        'isActive': false,
        'willRenew': false,
        'originalPurchaseDate': '2023-12-01T00:00:00Z',
        'expiresDate': '2024-02-01T00:00:00Z',
        'store': 'PLAY_STORE',
        'unsubscribeDetectedAt': '2024-01-15T00:00:00Z',
        'billingIssuesDetectedAt': '2024-01-16T00:00:00Z',
        'gracePeriodExpiresDate': '2024-01-20T00:00:00Z',
        'ownershipType': 'PURCHASED',
        'periodType': 'NORMAL',
        'refundedAt': '2024-01-18T00:00:00Z',
        'storeTransactionId': 'gpa.123',
        'autoResumeDate': '2024-03-01T00:00:00Z',
        'displayName': 'Premium',
        'managementURL': 'https://play.google.com/store/account/subscriptions',
        'productPlanIdentifier': 'monthly-plan',
      };
      final info = SubscriptionInfo.fromJson(json);
      expect(info.store, Store.playStore);
      expect(info.periodType, PeriodType.normal);
      expect(info.ownershipType, OwnershipType.purchased);
      expect(info.willRenew, false);
      expect(info.storeTransactionId, 'gpa.123');
      expect(info.autoResumeDate, '2024-03-01T00:00:00Z');
      expect(info.displayName, 'Premium');
      expect(info.managementURL,
          'https://play.google.com/store/account/subscriptions');
      expect(info.productPlanIdentifier, 'monthly-plan');
    });
  });
}
