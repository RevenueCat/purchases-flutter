class PurchaserInfo {
  /// The identifiers of all the active entitlements
  final List<String> activeEntitlements;

  /// The latest expiration date of all purchased skus
  final String latestExpirationDate;

  /// Map of skus to expiration dates
  final Map<String, String> allExpirationDates;

  /// Map of entitlement ids to expiration dates
  final Map<String, String> expirationsForActiveEntitlements;

  /// Set of active subscription skus
  final List<String> activeSubscriptions;

  /// Set of purchased skus, active and inactive
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
