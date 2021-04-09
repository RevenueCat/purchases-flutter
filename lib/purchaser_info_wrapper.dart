import 'package:purchases_flutter/entitlement_infos_wrapper.dart';
import 'package:purchases_flutter/transaction.dart';
import 'package:collection/collection.dart';

/// Class containing all information regarding the purchaser
class PurchaserInfo {
  /// Entitlements attached to this purchaser info
  final EntitlementInfos entitlements;

  /// The latest expiration date of all purchased skus
  final String? latestExpirationDate;

  /// Map of skus to expiration dates
  final Map<String, String?> allExpirationDates;

  /// Map of skus to purchase dates
  final Map<String, String> allPurchaseDates;

  /// Set of active subscription skus
  final List<String> activeSubscriptions;

  /// Set of purchased skus, active and inactive
  final List<String> allPurchasedProductIdentifiers;

  /// Returns all the non-subscription purchases a user has made.
  /// The purchases are ordered by purchase date in ascending order.
  final List<Transaction> nonSubscriptionTransactions;

  /// The date this user was first seen in RevenueCat.
  final String firstSeen;

  /// The original App User Id recorded for this user.
  final String originalAppUserId;

  /// Date when this info was requested
  final String requestDate;

  /// Returns the purchase date for the version of the application when the user bought the app.
  /// Use this for grandfathering users when migrating to subscriptions.
  final String? originalPurchaseDate;

  /// Returns the version number for the version of the application when the
  /// user bought the app. Use this for grandfathering users when migrating
  /// to subscriptions.
  ///
  /// This corresponds to the value of CFBundleVersion (in iOS) in the
  /// Info.plist file when the purchase was originally made. This is always null
  /// in Android
  final String? originalApplicationVersion;

  /// URL to manage the active subscription of the user. If this user has an active iOS
  /// subscription, this will point to the App Store, if the user has an active Play Store subscription
  /// it will point there. If there are no active subscriptions it will be null.
  /// If there are multiple for different platforms, it will point to the device store.
  final String? managementURL;

  /// Constructs a PurchaserInfo from a JSON object.
  PurchaserInfo.fromJson(Map<dynamic, dynamic> map)
      : entitlements = EntitlementInfos.fromJson(
            map["entitlements"] as Map<dynamic, dynamic>),
        activeSubscriptions = (map["activeSubscriptions"] as List<dynamic>)
            .map((item) => item as String)
            .toList(),
        latestExpirationDate = map["latestExpirationDate"],
        allExpirationDates =
            (map["allExpirationDates"] as Map<dynamic, dynamic>)
                .map((key, value) => MapEntry(key as String, value as String?)),
        allPurchasedProductIdentifiers =
            (map["allPurchasedProductIdentifiers"] as List<dynamic>)
                .map((item) => item as String)
                .toList(),
        firstSeen = map["firstSeen"],
        originalAppUserId = map["originalAppUserId"],
        requestDate = map["requestDate"],
        allPurchaseDates = (map["allPurchaseDates"] as Map<dynamic, dynamic>)
            .map((key, value) => MapEntry(key as String, value as String)),
        originalApplicationVersion = map["originalApplicationVersion"],
        originalPurchaseDate = map["originalPurchaseDate"],
        managementURL = map["managementURL"],
        nonSubscriptionTransactions =
            (map["nonSubscriptionTransactions"] as List<dynamic>)
                .map((item) => Transaction.fromJson(item))
                .toList();

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
        'originalApplicationVersion: $originalApplicationVersion, '
        'originalPurchaseDate: $originalPurchaseDate, '
        'managementURL: $managementURL, '
        'nonSubscriptionTransactions: $nonSubscriptionTransactions'
        '}';
  }

  @override
  bool operator ==(other) {
    if (!(other is PurchaserInfo)) {
      return false;
    }
    final mapEq = MapEquality().equals;
    final listEq = ListEquality().equals;
    return (this.entitlements == other.entitlements &&
        this.latestExpirationDate == other.latestExpirationDate &&
        mapEq(this.allExpirationDates, other.allExpirationDates) &&
        mapEq(this.allPurchaseDates, other.allPurchaseDates) &&
        listEq(this.activeSubscriptions, other.activeSubscriptions) &&
        listEq(this.allPurchasedProductIdentifiers,
            other.allPurchasedProductIdentifiers) &&
        listEq(this.nonSubscriptionTransactions,
            other.nonSubscriptionTransactions) &&
        this.firstSeen == other.firstSeen &&
        this.originalAppUserId == other.originalAppUserId &&
        this.requestDate == other.requestDate &&
        this.originalPurchaseDate == other.originalPurchaseDate &&
        this.originalApplicationVersion == other.originalApplicationVersion &&
        this.managementURL == other.managementURL);
  }
}
