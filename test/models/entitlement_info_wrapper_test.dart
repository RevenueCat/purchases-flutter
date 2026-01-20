import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/entitlement_info_wrapper.dart';
import 'package:purchases_flutter/models/store.dart';
import 'package:purchases_flutter/models/verification_result.dart';

void main() {
  group('EntitlementInfo.fromJson', () {
    test('parses minimum required fields', () {
      final json = {
        'identifier': 'entitlement_1',
        'isActive': true,
        'willRenew': false,
        'latestPurchaseDate': '2024-01-01T00:00:00Z',
        'originalPurchaseDate': '2023-12-01T00:00:00Z',
        'productIdentifier': 'sku1',
        'isSandbox': false,
      };
      final info = EntitlementInfo.fromJson(json);
      const expected = EntitlementInfo(
        'entitlement_1',
        true,
        false,
        '2024-01-01T00:00:00Z',
        '2023-12-01T00:00:00Z',
        'sku1',
        false,
      );
      expect(info, equals(expected));
    });

    test('parses all fields with values', () {
      final json = {
        'identifier': 'entitlement_2',
        'isActive': false,
        'willRenew': true,
        'latestPurchaseDate': '2024-02-01T00:00:00Z',
        'originalPurchaseDate': '2023-11-01T00:00:00Z',
        'productIdentifier': 'sku2',
        'isSandbox': true,
        'ownershipType': 'FAMILY_SHARED',
        'store': 'PLAY_STORE',
        'periodType': 'TRIAL',
        'expirationDate': '2024-03-01T00:00:00Z',
        'unsubscribeDetectedAt': '2024-02-15T00:00:00Z',
        'billingIssueDetectedAt': '2024-02-20T00:00:00Z',
        'productPlanIdentifier': 'plan_123',
        'verification': 'VERIFIED_ON_DEVICE',
      };
      final info = EntitlementInfo.fromJson(json);
      const expected = EntitlementInfo(
        'entitlement_2',
        false,
        true,
        '2024-02-01T00:00:00Z',
        '2023-11-01T00:00:00Z',
        'sku2',
        true,
        ownershipType: OwnershipType.familyShared,
        store: Store.playStore,
        periodType: PeriodType.trial,
        expirationDate: '2024-03-01T00:00:00Z',
        unsubscribeDetectedAt: '2024-02-15T00:00:00Z',
        billingIssueDetectedAt: '2024-02-20T00:00:00Z',
        productPlanIdentifier: 'plan_123',
        verification: VerificationResult.verifiedOnDevice,
      );
      expect(info, equals(expected));
    });
  });
} 