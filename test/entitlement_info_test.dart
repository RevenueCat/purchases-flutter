import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/entitlement_info_wrapper.dart';
import 'package:purchases_flutter/models/store.dart';
import 'package:purchases_flutter/models/verification_result.dart';

void main() {
  Map<String, Object?> generateEntitlementInfoJSON(String store) => {
        'identifier': 'almost_pro',
        'isActive': true,
        'willRenew': true,
        'periodType': 'NORMAL',
        'latestPurchaseDateMillis': 1.58759855E9,
        'latestPurchaseDate': '2020-04-22T23:35:50.000Z',
        'originalPurchaseDateMillis': 1.591725245E9,
        'originalPurchaseDate': '2020-06-09T17:54:05.000Z',
        'expirationDateMillis': null,
        'expirationDate': null,
        'productIdentifier': 'consumable',
        'isSandbox': true,
        'unsubscribeDetectedAt': null,
        'unsubscribeDetectedAtMillis': null,
        'billingIssueDetectedAt': null,
        'billingIssueDetectedAtMillis': null,
        'store': store,
        'verification': 'VERIFIED',
      };

  test('unknown period if missing from json', () {
    final entitlementInfoJson = {
      'identifier': 'almost_pro',
      'isActive': true,
      'willRenew': true,
      'latestPurchaseDateMillis': 1.58759855E9,
      'latestPurchaseDate': '2020-04-22T23:35:50.000Z',
      'originalPurchaseDateMillis': 1.591725245E9,
      'originalPurchaseDate': '2020-06-09T17:54:05.000Z',
      'expirationDateMillis': null,
      'expirationDate': null,
      'store': 'PLAY_STORE',
      'productIdentifier': 'consumable',
      'isSandbox': true,
      'unsubscribeDetectedAt': null,
      'unsubscribeDetectedAtMillis': null,
      'billingIssueDetectedAt': null,
      'billingIssueDetectedAtMillis': null,
      'verification': 'VERIFIED',
    };
    final entitlementInfo = EntitlementInfo.fromJson(entitlementInfoJson);

    expect(entitlementInfo.periodType, PeriodType.unknown);
  });

  test('prepaid period type if PREPAID is contained in json', () {
    final entitlementInfoJson = {
      'identifier': 'almost_pro',
      'isActive': true,
      'willRenew': true,
      'periodType': 'PREPAID',
      'latestPurchaseDateMillis': 1.58759855E9,
      'latestPurchaseDate': '2020-04-22T23:35:50.000Z',
      'originalPurchaseDateMillis': 1.591725245E9,
      'originalPurchaseDate': '2020-06-09T17:54:05.000Z',
      'expirationDateMillis': null,
      'expirationDate': null,
      'store': 'PLAY_STORE',
      'productIdentifier': 'consumable',
      'isSandbox': true,
      'unsubscribeDetectedAt': null,
      'unsubscribeDetectedAtMillis': null,
      'billingIssueDetectedAt': null,
      'billingIssueDetectedAtMillis': null,
      'verification': 'VERIFIED',
    };
    final entitlementInfo = EntitlementInfo.fromJson(entitlementInfoJson);

    expect(entitlementInfo.periodType, PeriodType.prepaid);
  });

  test('unknown store if missing from json', () {
    final entitlementInfoJson = {
      'identifier': 'almost_pro',
      'isActive': true,
      'willRenew': true,
      'periodType': 'NORMAL',
      'latestPurchaseDateMillis': 1.58759855E9,
      'latestPurchaseDate': '2020-04-22T23:35:50.000Z',
      'originalPurchaseDateMillis': 1.591725245E9,
      'originalPurchaseDate': '2020-06-09T17:54:05.000Z',
      'expirationDateMillis': null,
      'expirationDate': null,
      'productIdentifier': 'consumable',
      'isSandbox': true,
      'unsubscribeDetectedAt': null,
      'unsubscribeDetectedAtMillis': null,
      'billingIssueDetectedAt': null,
      'billingIssueDetectedAtMillis': null,
      'verification': 'VERIFIED',
    };
    final entitlementInfo = EntitlementInfo.fromJson(entitlementInfoJson);

    expect(entitlementInfo.store, Store.unknownStore);
  });

  test('not requested verification result if missing from json', () {
    final entitlementInfoJson = {
      'identifier': 'almost_pro',
      'isActive': true,
      'willRenew': true,
      'periodType': 'NORMAL',
      'latestPurchaseDateMillis': 1.58759855E9,
      'latestPurchaseDate': '2020-04-22T23:35:50.000Z',
      'originalPurchaseDateMillis': 1.591725245E9,
      'originalPurchaseDate': '2020-06-09T17:54:05.000Z',
      'expirationDateMillis': null,
      'expirationDate': null,
      'productIdentifier': 'consumable',
      'isSandbox': true,
      'unsubscribeDetectedAt': null,
      'unsubscribeDetectedAtMillis': null,
      'billingIssueDetectedAt': null,
      'billingIssueDetectedAtMillis': null,
    };
    final entitlementInfo = EntitlementInfo.fromJson(entitlementInfoJson);

    expect(entitlementInfo.verification, VerificationResult.notRequested);
  });

  test('app store gets parsed if present in json', () {
    final entitlementInfoJson = generateEntitlementInfoJSON('APP_STORE');
    final entitlementInfo = EntitlementInfo.fromJson(entitlementInfoJson);
    expect(entitlementInfo.store, Store.appStore);
  });

  test('mac app store gets parsed if present in json', () {
    final entitlementInfoJson = generateEntitlementInfoJSON('MAC_APP_STORE');
    final entitlementInfo = EntitlementInfo.fromJson(entitlementInfoJson);
    expect(entitlementInfo.store, Store.macAppStore);
  });

  test('play store gets parsed if present in json', () {
    final entitlementInfoJson = generateEntitlementInfoJSON('PLAY_STORE');
    final entitlementInfo = EntitlementInfo.fromJson(entitlementInfoJson);
    expect(entitlementInfo.store, Store.playStore);
  });

  test('stripe gets parsed if present in json', () {
    final entitlementInfoJson = generateEntitlementInfoJSON('STRIPE');
    final entitlementInfo = EntitlementInfo.fromJson(entitlementInfoJson);
    expect(entitlementInfo.store, Store.stripe);
  });

  test('promotional gets parsed if present in json', () {
    final entitlementInfoJson = generateEntitlementInfoJSON('PROMOTIONAL');
    final entitlementInfo = EntitlementInfo.fromJson(entitlementInfoJson);
    expect(entitlementInfo.store, Store.promotional);
  });

  test('amazon store gets parsed if present in json', () {
    final entitlementInfoJson = generateEntitlementInfoJSON('AMAZON');
    final entitlementInfo = EntitlementInfo.fromJson(entitlementInfoJson);
    expect(entitlementInfo.store, Store.amazon);
  });

  test('unknown ownership type if missing from json', () {
    final entitlementInfoJson = {
      'identifier': 'almost_pro',
      'isActive': true,
      'willRenew': true,
      'latestPurchaseDateMillis': 1.58759855E9,
      'latestPurchaseDate': '2020-04-22T23:35:50.000Z',
      'originalPurchaseDateMillis': 1.591725245E9,
      'originalPurchaseDate': '2020-06-09T17:54:05.000Z',
      'expirationDateMillis': null,
      'expirationDate': null,
      'store': 'PLAY_STORE',
      'productIdentifier': 'consumable',
      'isSandbox': true,
      'unsubscribeDetectedAt': null,
      'unsubscribeDetectedAtMillis': null,
      'billingIssueDetectedAt': null,
      'billingIssueDetectedAtMillis': null,
      'verification': 'VERIFIED',
    };
    final entitlementInfo = EntitlementInfo.fromJson(entitlementInfoJson);

    expect(entitlementInfo.ownershipType, OwnershipType.unknown);
  });

  test('ownership type parsed from json', () {
    final entitlementInfoJson = {
      'identifier': 'almost_pro',
      'isActive': true,
      'willRenew': true,
      'latestPurchaseDateMillis': 1.58759855E9,
      'latestPurchaseDate': '2020-04-22T23:35:50.000Z',
      'originalPurchaseDateMillis': 1.591725245E9,
      'originalPurchaseDate': '2020-06-09T17:54:05.000Z',
      'expirationDateMillis': null,
      'expirationDate': null,
      'store': 'PLAY_STORE',
      'productIdentifier': 'consumable',
      'isSandbox': true,
      'unsubscribeDetectedAt': null,
      'unsubscribeDetectedAtMillis': null,
      'billingIssueDetectedAt': null,
      'billingIssueDetectedAtMillis': null,
      'verification': 'VERIFIED',
    };
    entitlementInfoJson['ownershipType'] = 'PURCHASED';
    var entitlementInfo = EntitlementInfo.fromJson(entitlementInfoJson);

    expect(entitlementInfo.ownershipType, OwnershipType.purchased);

    entitlementInfoJson['ownershipType'] = 'FAMILY_SHARED';
    entitlementInfo = EntitlementInfo.fromJson(entitlementInfoJson);

    expect(entitlementInfo.ownershipType, OwnershipType.familyShared);

    entitlementInfoJson['ownershipType'] = 'UNKNOWN';
    entitlementInfo = EntitlementInfo.fromJson(entitlementInfoJson);

    expect(entitlementInfo.ownershipType, OwnershipType.unknown);

    entitlementInfoJson['ownershipType'] = 'AN_UNKNOWN_OWNERSHIP_TYPE';
    entitlementInfo = EntitlementInfo.fromJson(entitlementInfoJson);

    expect(entitlementInfo.ownershipType, OwnershipType.unknown);
  });
}
