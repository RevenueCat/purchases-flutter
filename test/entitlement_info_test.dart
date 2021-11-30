import 'package:purchases_flutter/entitlement_info_wrapper.dart';
import 'package:test/test.dart';

void main() {
  test('unknown period if missing from json', () {
    Map<dynamic, dynamic> entitlementInfoJson = {
      "identifier": "almost_pro",
      "isActive": true,
      "willRenew": true,
      "latestPurchaseDateMillis": 1.58759855E9,
      "latestPurchaseDate": "2020-04-22T23:35:50.000Z",
      "originalPurchaseDateMillis": 1.591725245E9,
      "originalPurchaseDate": "2020-06-09T17:54:05.000Z",
      "expirationDateMillis": null,
      "expirationDate": null,
      "store": "PLAY_STORE",
      "productIdentifier": "consumable",
      "isSandbox": true,
      "unsubscribeDetectedAt": null,
      "unsubscribeDetectedAtMillis": null,
      "billingIssueDetectedAt": null,
      "billingIssueDetectedAtMillis": null
    };
    final entitlementInfo = EntitlementInfo.fromJson(entitlementInfoJson);

    expect(entitlementInfo.periodType, PeriodType.unknown);
  });

  test('unknown store if missing from json', () {
    Map<dynamic, dynamic> entitlementInfoJson = {
      "identifier": "almost_pro",
      "isActive": true,
      "willRenew": true,
      "periodType": "NORMAL",
      "latestPurchaseDateMillis": 1.58759855E9,
      "latestPurchaseDate": "2020-04-22T23:35:50.000Z",
      "originalPurchaseDateMillis": 1.591725245E9,
      "originalPurchaseDate": "2020-06-09T17:54:05.000Z",
      "expirationDateMillis": null,
      "expirationDate": null,
      "productIdentifier": "consumable",
      "isSandbox": true,
      "unsubscribeDetectedAt": null,
      "unsubscribeDetectedAtMillis": null,
      "billingIssueDetectedAt": null,
      "billingIssueDetectedAtMillis": null
    };
    final entitlementInfo = EntitlementInfo.fromJson(entitlementInfoJson);

    expect(entitlementInfo.store, Store.unknownStore);
  });

  test('unknown ownership type if missing from json', () {
    Map<dynamic, dynamic> entitlementInfoJson = {
      "identifier": "almost_pro",
      "isActive": true,
      "willRenew": true,
      "latestPurchaseDateMillis": 1.58759855E9,
      "latestPurchaseDate": "2020-04-22T23:35:50.000Z",
      "originalPurchaseDateMillis": 1.591725245E9,
      "originalPurchaseDate": "2020-06-09T17:54:05.000Z",
      "expirationDateMillis": null,
      "expirationDate": null,
      "store": "PLAY_STORE",
      "productIdentifier": "consumable",
      "isSandbox": true,
      "unsubscribeDetectedAt": null,
      "unsubscribeDetectedAtMillis": null,
      "billingIssueDetectedAt": null,
      "billingIssueDetectedAtMillis": null
    };
    final entitlementInfo = EntitlementInfo.fromJson(entitlementInfoJson);

    expect(entitlementInfo.ownershipType, OwnershipType.unknown);
  });

  test('ownership type parsed from json', () {
    Map<dynamic, dynamic> entitlementInfoJson = {
      "identifier": "almost_pro",
      "isActive": true,
      "willRenew": true,
      "latestPurchaseDateMillis": 1.58759855E9,
      "latestPurchaseDate": "2020-04-22T23:35:50.000Z",
      "originalPurchaseDateMillis": 1.591725245E9,
      "originalPurchaseDate": "2020-06-09T17:54:05.000Z",
      "expirationDateMillis": null,
      "expirationDate": null,
      "store": "PLAY_STORE",
      "productIdentifier": "consumable",
      "isSandbox": true,
      "unsubscribeDetectedAt": null,
      "unsubscribeDetectedAtMillis": null,
      "billingIssueDetectedAt": null,
      "billingIssueDetectedAtMillis": null
    };
    entitlementInfoJson["ownershipType"] = "PURCHASED";
    var entitlementInfo = EntitlementInfo.fromJson(entitlementInfoJson);

    expect(entitlementInfo.ownershipType, OwnershipType.purchased);

    entitlementInfoJson["ownershipType"] = "FAMILY_SHARED";
    entitlementInfo = EntitlementInfo.fromJson(entitlementInfoJson);

    expect(entitlementInfo.ownershipType, OwnershipType.familyShared);

    entitlementInfoJson["ownershipType"] = "UNKNOWN";
    entitlementInfo = EntitlementInfo.fromJson(entitlementInfoJson);

    expect(entitlementInfo.ownershipType, OwnershipType.unknown);

    entitlementInfoJson["ownershipType"] = "AN_UNKNOWN_OWNERSHIP_TYPE";
    entitlementInfo = EntitlementInfo.fromJson(entitlementInfoJson);

    expect(entitlementInfo.ownershipType, OwnershipType.unknown);
  });
}
