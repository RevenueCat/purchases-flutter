import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/entitlement_info_wrapper.dart';
import 'package:purchases_flutter/models/entitlement_infos_wrapper.dart';
import 'package:purchases_flutter/models/store.dart';
import 'package:purchases_flutter/models/verification_result.dart';

void main() {
  group('EntitlementInfos.fromJson', () {
    test('parses minimum required fields', () {
      final json = {
        'all': {
          'pro': {
            'identifier': 'pro',
            'isActive': true,
            'willRenew': true,
            'latestPurchaseDate': '2024-01-01T00:00:00Z',
            'originalPurchaseDate': '2023-01-01T00:00:00Z',
            'productIdentifier': 'prod1',
            'isSandbox': false,
          },
        },
        'active': {
          'pro': {
            'identifier': 'pro',
            'isActive': true,
            'willRenew': true,
            'latestPurchaseDate': '2024-01-01T00:00:00Z',
            'originalPurchaseDate': '2023-01-01T00:00:00Z',
            'productIdentifier': 'prod1',
            'isSandbox': false,
          },
        },
        'verification': 'VERIFIED',
      };
      final info = EntitlementInfos.fromJson(json);
      const expected = EntitlementInfos(
        {
          'pro': EntitlementInfo(
            'pro',
            true,
            true,
            '2024-01-01T00:00:00Z',
            '2023-01-01T00:00:00Z',
            'prod1',
            false,
          ),
        },
        {
          'pro': EntitlementInfo(
            'pro',
            true,
            true,
            '2024-01-01T00:00:00Z',
            '2023-01-01T00:00:00Z',
            'prod1',
            false,
          ),
        },
        verification: VerificationResult.verified,
      );
      expect(info, equals(expected));
      expect(EntitlementInfos.fromJson(info.toJson()), equals(expected));
    });

    test('parses all fields', () {
      final json = {
        'all': {
          'pro': {
            'identifier': 'pro',
            'isActive': true,
            'willRenew': false,
            'latestPurchaseDate': '2024-01-01T00:00:00Z',
            'originalPurchaseDate': '2023-01-01T00:00:00Z',
            'productIdentifier': 'prod1',
            'isSandbox': true,
            'ownershipType': 'FAMILY_SHARED',
            'store': 'PLAY_STORE',
            'periodType': 'TRIAL',
            'expirationDate': '2024-02-01T00:00:00Z',
            'unsubscribeDetectedAt': '2024-01-15T00:00:00Z',
            'billingIssueDetectedAt': '2024-01-20T00:00:00Z',
            'productPlanIdentifier': 'plan1',
            'verification': 'VERIFIED',
          },
        },
        'active': {
          'pro': {
            'identifier': 'pro',
            'isActive': true,
            'willRenew': false,
            'latestPurchaseDate': '2024-01-01T00:00:00Z',
            'originalPurchaseDate': '2023-01-01T00:00:00Z',
            'productIdentifier': 'prod1',
            'isSandbox': true,
            'ownershipType': 'FAMILY_SHARED',
            'store': 'PLAY_STORE',
            'periodType': 'TRIAL',
            'expirationDate': '2024-02-01T00:00:00Z',
            'unsubscribeDetectedAt': '2024-01-15T00:00:00Z',
            'billingIssueDetectedAt': '2024-01-20T00:00:00Z',
            'productPlanIdentifier': 'plan1',
            'verification': 'VERIFIED',
          },
        },
        'verification': 'VERIFIED_ON_DEVICE',
      };
      final info = EntitlementInfos.fromJson(json);
      const expected = EntitlementInfos(
        {
          'pro': EntitlementInfo(
            'pro',
            true,
            false,
            '2024-01-01T00:00:00Z',
            '2023-01-01T00:00:00Z',
            'prod1',
            true,
            ownershipType: OwnershipType.familyShared,
            store: Store.playStore,
            periodType: PeriodType.trial,
            expirationDate: '2024-02-01T00:00:00Z',
            unsubscribeDetectedAt: '2024-01-15T00:00:00Z',
            billingIssueDetectedAt: '2024-01-20T00:00:00Z',
            productPlanIdentifier: 'plan1',
            verification: VerificationResult.verified,
          ),
        },
        {
          'pro': EntitlementInfo(
            'pro',
            true,
            false,
            '2024-01-01T00:00:00Z',
            '2023-01-01T00:00:00Z',
            'prod1',
            true,
            ownershipType: OwnershipType.familyShared,
            store: Store.playStore,
            periodType: PeriodType.trial,
            expirationDate: '2024-02-01T00:00:00Z',
            unsubscribeDetectedAt: '2024-01-15T00:00:00Z',
            billingIssueDetectedAt: '2024-01-20T00:00:00Z',
            productPlanIdentifier: 'plan1',
            verification: VerificationResult.verified,
          ),
        },
        verification: VerificationResult.verifiedOnDevice,
      );
      expect(info, equals(expected));
      expect(EntitlementInfos.fromJson(info.toJson()), equals(expected));
    });
  });
}
