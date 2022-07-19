import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _EntitlementInfoApiTest {
  void _checkPeriodType(PeriodType type) {
    switch (type) {
      case PeriodType.intro:
      case PeriodType.normal:
      case PeriodType.trial:
      case PeriodType.unknown:
        break;
    }
  }

  void _checkOwnershipType(OwnershipType type) {
    switch (type) {
      case OwnershipType.purchased:
      case OwnershipType.familyShared:
      case OwnershipType.unknown:
        break;
    }
  }

  void _checkFromJsonFactory(Map<String, dynamic> json) {
    EntitlementInfo info = EntitlementInfo.fromJson(json);
  }

  void _checkToJson(EntitlementInfo entitlementInfo) {
    Map<String, dynamic> json = entitlementInfo.toJson();
  }

  void _checkConstructor(
      String identifier,
      bool isActive,
      bool willRenew,
      String latestPurchaseDate,
      String originalPurchaseDate,
      String productIdentifier,
      bool isSandbox,
      OwnershipType ownershipType,
      Store store,
      PeriodType periodType,
      String? expirationDate,
      String? unsubscribeDetectedAt,
      String? billingIssueDetectedAt) {
    EntitlementInfo entitlementInfo = EntitlementInfo(
        identifier,
        isActive,
        willRenew,
        latestPurchaseDate,
        originalPurchaseDate,
        productIdentifier,
        isSandbox);
    entitlementInfo = EntitlementInfo(identifier, isActive, willRenew,
        latestPurchaseDate, originalPurchaseDate, productIdentifier, isSandbox,
        ownershipType: ownershipType,
        store: store,
        periodType: periodType,
        expirationDate: expirationDate,
        unsubscribeDetectedAt: unsubscribeDetectedAt,
        billingIssueDetectedAt: billingIssueDetectedAt);
  }

  void _checkProperties(EntitlementInfo info) {
    String identifier = info.identifier;
    bool isActive = info.isActive;
    bool willRenew = info.willRenew;
    String latestPurchaseDate = info.latestPurchaseDate;
    String originalPurchaseDate = info.originalPurchaseDate;
    String productIdentifier = info.productIdentifier;
    bool isSandbox = info.isSandbox;
    OwnershipType ownershipType = info.ownershipType;
    Store store = info.store;
    PeriodType periodType = info.periodType;
    String? expirationDate = info.expirationDate;
    String? unsubscribeDetectedAt = info.unsubscribeDetectedAt;
    String? billingIssueDetectedAt = info.billingIssueDetectedAt;
  }
}
