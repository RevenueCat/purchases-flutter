import 'package:freezed_annotation/freezed_annotation.dart';

import 'entitlement_infos_wrapper.dart';
import 'store_transaction.dart';

part 'customer_info_wrapper.freezed.dart';
part 'customer_info_wrapper.g.dart';

@freezed

/// Class containing all information regarding the customer
class CustomerInfo with _$CustomerInfo {
  const factory CustomerInfo(
    /// Entitlements attached to this customer info
    EntitlementInfos entitlements,

    /// Map of skus to purchase dates
    Map<String, String?> allPurchaseDates,

    /// Set of active subscription skus
    List<String> activeSubscriptions,

    /// Set of purchased skus, active and inactive
    List<String> allPurchasedProductIdentifiers,

    /// Returns all the non-subscription purchases a user has made.
    /// The purchases are ordered by purchase date in ascending order.
    List<StoreTransaction> nonSubscriptionTransactions,

    /// The date this user was first seen in RevenueCat.
    String firstSeen,

    /// The original App User Id recorded for this user.
    String originalAppUserId,

    /// Map of skus to expiration dates
    Map<String, String?> allExpirationDates,

    /// Date when this info was requested
    String requestDate, {

    /// The latest expiration date of all purchased skus
    String? latestExpirationDate,

    /// Returns the purchase date for the version of the application when the user bought the app.
    /// Use this for grandfathering users when migrating to subscriptions.
    String? originalPurchaseDate,

    /// Returns the version number for the version of the application when the
    /// user bought the app. Use this for grandfathering users when migrating
    /// to subscriptions.
    ///
    /// This corresponds to the value of CFBundleVersion (in iOS) in the
    /// Info.plist file when the purchase was originally made. This is always null
    /// in Android
    String? originalApplicationVersion,

    /// URL to manage the active subscription of the user. If this user has an active iOS
    /// subscription, this will point to the App Store, if the user has an active Play Store subscription
    /// it will point there. If there are no active subscriptions it will be null.
    /// If there are multiple for different platforms, it will point to the device store.
    String? managementURL,
  }) = _CustomerInfo;

  factory CustomerInfo.fromJson(Map<String, dynamic> json) =>
      _$CustomerInfoFromJson(json);
}
