import 'package:purchases_flutter/entitlement_infos_wrapper.dart';

class PurchaserInfo {
  /// Entitlements attached to this purchaser info
  final EntitlementInfos entitlements;

  /// The latest expiration date of all purchased skus
  final String latestExpirationDate;

  /// Map of skus to expiration dates
  final Map<String, String> allExpirationDates;

  /// Map of skus to purchase dates
  final Map<String, String> allPurchaseDates;

  /// Set of active subscription skus
  final List<String> activeSubscriptions;

  /// Set of purchased skus, active and inactive
  final List<String> allPurchasedProductIdentifiers;

  /// The date this user was first seen in RevenueCat.
  final String firstSeen;

  /// The original App User Id recorded for this user.
  final String originalAppUserId;

  /// Date when this info was requested
  final String requestDate;

  /// Returns the version number for the version of the application when the
  /// user bought the app. Use this for grandfathering users when migrating
  /// to subscriptions.
  ///
  /// This corresponds to the value of CFBundleVersion (in iOS) in the
  /// Info.plist file when the purchase was originally made. This is always null
  /// in Android
  final String originalApplicationVersion;

  PurchaserInfo.fromJson(Map<dynamic, dynamic> map)
      : entitlements = EntitlementInfos.fromJson(
            map["entitlements"] as Map<dynamic, dynamic>),
        activeSubscriptions = (map["activeSubscriptions"] as List<dynamic>)
            .map((item) => item as String)
            .toList(),
        latestExpirationDate = map["latestExpirationDate"],
        allExpirationDates =
            (map["allExpirationDates"] as Map<dynamic, dynamic>)
                .map((key, value) => MapEntry(key as String, value as String)),
        allPurchasedProductIdentifiers =
            (map["allPurchasedProductIdentifiers"] as List<dynamic>)
                .map((item) => item as String)
                .toList(),
        firstSeen = map["firstSeen"],
        originalAppUserId = map["originalAppUserId"],
        requestDate = map["requestDate"],
        allPurchaseDates = (map["allPurchaseDates"] as Map<dynamic, dynamic>)
            .map((key, value) => MapEntry(key as String, value as String)),
        originalApplicationVersion = map["originalApplicationVersion"];

  @override
  String toString() {
    return 'PurchaserInfo{'
        'entitlements: $entitlements, '
        'latestExpirationDate: $latestExpirationDate, '
        'allExpirationDates: $allExpirationDates, '
        'allPurchaseDates: $allPurchaseDates, '
        'activeSubscriptions: $activeSubscriptions, '
        'allPurchasedProductIdentifiers: $allPurchasedProductIdentifiers, '
        'firstSeen: $firstSeen, '
        'originalAppUserId: $originalAppUserId, '
        'requestDate: $requestDate, '
        'originalApplicationVersion: $originalApplicationVersion}';
  }
}
