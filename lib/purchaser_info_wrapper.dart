class PurchaserInfo {
  final List<String> activeEntitlements;
  final String latestExpirationDate;
  final Map<String, String> allExpirationDates;
  final Map<String, String> expirationsForActiveEntitlements;
  final List<String> activeSubscriptions;
  final List<String> allPurchasedProductIdentifiers;

  PurchaserInfo.fromJson(Map<dynamic, dynamic> map)
      : activeEntitlements = (map["activeEntitlements"] as List<dynamic>)
      .map((item) => item as String)
      .toList(),
        activeSubscriptions = (map["activeSubscriptions"] as List<dynamic>)
            .map((item) => item as String)
            .toList(),
        latestExpirationDate = map["latestExpirationDate"],
        allExpirationDates =
        (map["allExpirationDates"] as Map<dynamic, dynamic>)
            .map((key, value) => MapEntry(key as String, value as String)),
        expirationsForActiveEntitlements =
        (map["expirationsForActiveEntitlements"] as Map<dynamic, dynamic>)
            .map((key, value) => MapEntry(key as String, value as String)),
        allPurchasedProductIdentifiers =
        (map["allPurchasedProductIdentifiers"] as List<dynamic>)
            .map((item) => item as String)
            .toList();

  @override
  String toString() {
    return 'PurchaserInfo{activeEntitlements: $activeEntitlements, latestExpirationDate: $latestExpirationDate, allExpirationDates: $allExpirationDates, expirationsForActiveEntitlements: $expirationsForActiveEntitlements, activeSubscriptions: $activeSubscriptions, allPurchasedProductIdentifiers: $allPurchasedProductIdentifiers}';
  }
}
