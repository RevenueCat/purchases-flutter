import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _CustomerInfoApiTest {
  void _checkFromJsonFactory(Map<String, dynamic> json) {
    CustomerInfo customerInfo = CustomerInfo.fromJson(json);
  }

  void _checkToJson(CustomerInfo customerInfo) {
    Map<String, dynamic> json = customerInfo.toJson();
  }

  void _checkConstructor(
      EntitlementInfos entitlements,
      Map<String, String> allPurchaseDates,
      List<String> activeSubscriptions,
      List<String> allPurchasedProductIdentifiers,
      List<StoreTransaction> nonSubscriptionTransactions,
      String firstSeen,
      String originalAppUserId,
      Map<String, String?> allExpirationDates,
      String requestDate,
      String? latestExpirationDate,
      String? originalPurchaseDate,
      String? originalApplicationVersion,
      String? managementURL) {
    CustomerInfo customerInfo = CustomerInfo(
        entitlements,
        allPurchaseDates,
        activeSubscriptions,
        allPurchasedProductIdentifiers,
        nonSubscriptionTransactions,
        firstSeen,
        originalAppUserId,
        allExpirationDates,
        requestDate);
    customerInfo = CustomerInfo(
        entitlements,
        allPurchaseDates,
        activeSubscriptions,
        allPurchasedProductIdentifiers,
        nonSubscriptionTransactions,
        firstSeen,
        originalAppUserId,
        allExpirationDates,
        requestDate,
        latestExpirationDate: latestExpirationDate,
        originalPurchaseDate: originalPurchaseDate,
        originalApplicationVersion: originalApplicationVersion,
        managementURL: managementURL);
  }

  void _checkProperties(CustomerInfo customerInfo) {
    EntitlementInfos entitlements = customerInfo.entitlements;
    Map<String, String> allPurchaseDates = customerInfo.allPurchaseDates;
    List<String> activeSubscriptions = customerInfo.activeSubscriptions;
    List<String> allPurchasedProductIdentifiers =
        customerInfo.allPurchasedProductIdentifiers;
    List<StoreTransaction> nonSubscriptionTransactions =
        customerInfo.nonSubscriptionTransactions;
    String firstSeen = customerInfo.firstSeen;
    String originalAppUserId = customerInfo.originalAppUserId;
    Map<String, String?> allExpirationDates = customerInfo.allExpirationDates;
    String requestDate = customerInfo.requestDate;
    String? latestExpirationDate = customerInfo.latestExpirationDate;
    String? originalPurchaseDate = customerInfo.originalPurchaseDate;
    String? originalApplicationVersion =
        customerInfo.originalApplicationVersion;
    String? managementURL = customerInfo.managementURL;
  }
}
