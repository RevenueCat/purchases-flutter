import 'package:purchases_flutter/entitlement_infos_wrapper.dart';

class PurchaserInfo {
  /// Entitlements attached to this purchaser info
  final EntitlementInfos entitlements;

  /// The identifiers of all the active entitlements
  @Deprecated("Use PurchaserInfo.entitlements.active instead.")
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

  /// The date this user was first seen in RevenueCat.
  final String firstSeen;

  /// The original App User Id recorded for this user.
  final String originalAppUserId;

  PurchaserInfo.fromJson(Map<dynamic, dynamic> map)
      : entitlements = EntitlementInfos.fromJson(
            map["entitlements"] as Map<dynamic, dynamic>),
        activeEntitlements = (map["activeEntitlements"] as List<dynamic>)
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
                .toList(),
        firstSeen = map["firstSeen"],
        originalAppUserId = map["originalAppUserId"];

  @override
  String toString() {
    return 'PurchaserInfo{entitlements: $entitlements, latestExpirationDate: $latestExpirationDate, allExpirationDates: $allExpirationDates, expirationsForActiveEntitlements: $expirationsForActiveEntitlements, activeSubscriptions: $activeSubscriptions, allPurchasedProductIdentifiers: $allPurchasedProductIdentifiers, firstSeen: $firstSeen, originalAppUserId: $originalAppUserId}';
  }
}
