import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _SubscriptionInfoApiTest {
  void _checkFromJsonFactory(Map<String, dynamic> json) {
    SubscriptionInfo info = SubscriptionInfo.fromJson(json);
  }

  void _checkConstructor(
      String productIdentifier,
      String purchaseDate,
      bool isSandbox,
      bool isActive,
      bool willRenew,
      String? originalPurchaseDate,
      String? expiresDate,
      Store store,
      String? unsubscribeDetectedAt,
      String? billingIssuesDetectedAt,
      String? gracePeriodExpiresDate,
      OwnershipType ownershipType,
      PeriodType periodType,
      String? refundedAt,
      String? storeTransactionId,
      String? autoResumeDate,
      String? displayName,
      String? managementURL,
      String? productPlanIdentifier) {
    SubscriptionInfo info = SubscriptionInfo(
        productIdentifier, purchaseDate, isSandbox, isActive, willRenew);
    info = SubscriptionInfo(
        productIdentifier, purchaseDate, isSandbox, isActive, willRenew,
        originalPurchaseDate: originalPurchaseDate,
        expiresDate: expiresDate,
        store: store,
        unsubscribeDetectedAt: unsubscribeDetectedAt,
        billingIssuesDetectedAt: billingIssuesDetectedAt,
        gracePeriodExpiresDate: gracePeriodExpiresDate,
        ownershipType: ownershipType,
        periodType: periodType,
        refundedAt: refundedAt,
        storeTransactionId: storeTransactionId,
        autoResumeDate: autoResumeDate,
        displayName: displayName,
        managementURL: managementURL,
        productPlanIdentifier: productPlanIdentifier);
  }

  void _checkProperties(SubscriptionInfo info) {
    String productIdentifier = info.productIdentifier;
    String purchaseDate = info.purchaseDate;
    bool isSandbox = info.isSandbox;
    bool isActive = info.isActive;
    bool willRenew = info.willRenew;
    String? originalPurchaseDate = info.originalPurchaseDate;
    String? expiresDate = info.expiresDate;
    Store store = info.store;
    String? unsubscribeDetectedAt = info.unsubscribeDetectedAt;
    String? billingIssuesDetectedAt = info.billingIssuesDetectedAt;
    String? gracePeriodExpiresDate = info.gracePeriodExpiresDate;
    OwnershipType ownershipType = info.ownershipType;
    PeriodType periodType = info.periodType;
    String? refundedAt = info.refundedAt;
    String? storeTransactionId = info.storeTransactionId;
    String? autoResumeDate = info.autoResumeDate;
    String? displayName = info.displayName;
    String? managementURL = info.managementURL;
    String? productPlanIdentifier = info.productPlanIdentifier;
  }
}
