import 'package:equatable/equatable.dart';

import 'entitlement_infos_wrapper.dart';
import 'store_transaction.dart';

/// Class containing all information regarding the customer
class CustomerInfo extends Equatable {
  /// Entitlements attached to this customer info
  final EntitlementInfos entitlements;

  /// Map of skus to purchase dates
  final Map<String, String?> allPurchaseDates;

  /// Set of active subscription skus
  final List<String> activeSubscriptions;

  /// Set of purchased skus, active and inactive
  final List<String> allPurchasedProductIdentifiers;

  /// Returns all the non-subscription purchases a user has made.
  /// The purchases are ordered by purchase date in ascending order.
  final List<StoreTransaction> nonSubscriptionTransactions;

  /// The date this user was first seen in RevenueCat.
  final String firstSeen;

  /// The original App User Id recorded for this user.
  final String originalAppUserId;

  /// Map of skus to expiration dates
  final Map<String, String?> allExpirationDates;

  /// Date when this info was requested
  final String requestDate;

  /// The latest expiration date of all purchased skus
  final String? latestExpirationDate;

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

  const CustomerInfo(
    this.entitlements,
    this.allPurchaseDates,
    this.activeSubscriptions,
    this.allPurchasedProductIdentifiers,
    this.nonSubscriptionTransactions,
    this.firstSeen,
    this.originalAppUserId,
    this.allExpirationDates,
    this.requestDate, {
    this.latestExpirationDate,
    this.originalPurchaseDate,
    this.originalApplicationVersion,
    this.managementURL,
  });

  factory CustomerInfo.fromJson(Map<String, dynamic> json) => CustomerInfo(
        EntitlementInfos.fromJson(
          Map<String, dynamic>.from(json['entitlements']),
        ),
        Map<String, dynamic>.from(json['allPurchaseDates'])
            .map((k, v) => MapEntry(k, v as String?)),
        (json['activeSubscriptions'] as List).map((e) => e as String).toList(),
        (json['allPurchasedProductIdentifiers'] as List)
            .map((e) => e as String)
            .toList(),
        (json['nonSubscriptionTransactions'] as List)
            .map((e) => StoreTransaction.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
        json['firstSeen'] as String,
        json['originalAppUserId'] as String,
        Map<String, dynamic>.from(json['allExpirationDates'])
            .map((k, v) => MapEntry(k, v as String?)),
        json['requestDate'] as String,
        latestExpirationDate: json['latestExpirationDate'] as String?,
        originalPurchaseDate: json['originalPurchaseDate'] as String?,
        originalApplicationVersion:
            json['originalApplicationVersion'] as String?,
        managementURL: json['managementURL'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'entitlements': entitlements.toJson(),
        'allPurchaseDates': allPurchaseDates,
        'activeSubscriptions': activeSubscriptions,
        'allPurchasedProductIdentifiers': allPurchasedProductIdentifiers,
        'nonSubscriptionTransactions':
            nonSubscriptionTransactions.map((e) => e.toJson()).toList(),
        'firstSeen': firstSeen,
        'originalAppUserId': originalAppUserId,
        'allExpirationDates': allExpirationDates,
        'requestDate': requestDate,
        'latestExpirationDate': latestExpirationDate,
        'originalPurchaseDate': originalPurchaseDate,
        'originalApplicationVersion': originalApplicationVersion,
        'managementURL': managementURL,
      };

  @override
  List<Object?> get props => [
        entitlements,
        allPurchaseDates,
        activeSubscriptions,
        allPurchasedProductIdentifiers,
        nonSubscriptionTransactions,
        firstSeen,
        originalAppUserId,
        allExpirationDates,
        requestDate,
        latestExpirationDate,
        originalPurchaseDate,
        originalApplicationVersion,
        managementURL,
      ];
}
