import 'package:freezed_annotation/freezed_annotation.dart';

import 'entitlement_infos_wrapper.dart';
import 'transaction.dart';

part 'purchaser_info_wrapper.freezed.dart';
part 'purchaser_info_wrapper.g.dart';

@freezed

/// Class containing all information regarding the purchaser
class PurchaserInfo with _$PurchaserInfo {
  const factory PurchaserInfo(
    /// Entitlements attached to this purchaser info
    @JsonKey(name: 'entitlements') EntitlementInfos entitlements,

    /// Map of skus to purchase dates
    @JsonKey(name: 'allPurchaseDates') Map<String, String> allPurchaseDates,

    /// Set of active subscription skus
    @JsonKey(name: 'activeSubscriptions') List<String> activeSubscriptions,

    /// Set of purchased skus, active and inactive
    @JsonKey(name: 'allPurchasedProductIdentifiers')
        List<String> allPurchasedProductIdentifiers,

    /// Returns all the non-subscription purchases a user has made.
    /// The purchases are ordered by purchase date in ascending order.
    @JsonKey(name: 'nonSubscriptionTransactions')
        List<Transaction> nonSubscriptionTransactions,

    /// The date this user was first seen in RevenueCat.
    @JsonKey(name: 'firstSeen') String firstSeen,

    /// The original App User Id recorded for this user.
    @JsonKey(name: 'originalAppUserId') String originalAppUserId,

    /// Map of skus to expiration dates
    @JsonKey(name: 'allExpirationDates')
        Map<String, String?> allExpirationDates,

    /// Date when this info was requested
    @JsonKey(name: 'requestDate') String requestDate, {

    /// The latest expiration date of all purchased skus
    @JsonKey(name: 'latestExpirationDate', nullable: true)
        String? latestExpirationDate,

    /// Returns the purchase date for the version of the application when the user bought the app.
    /// Use this for grandfathering users when migrating to subscriptions.
    @JsonKey(name: 'originalPurchaseDate', nullable: true)
        String? originalPurchaseDate,

    /// Returns the version number for the version of the application when the
    /// user bought the app. Use this for grandfathering users when migrating
    /// to subscriptions.
    ///
    /// This corresponds to the value of CFBundleVersion (in iOS) in the
    /// Info.plist file when the purchase was originally made. This is always null
    /// in Android
    @JsonKey(name: 'originalApplicationVersion', nullable: true)
        String? originalApplicationVersion,

    /// URL to manage the active subscription of the user. If this user has an active iOS
    /// subscription, this will point to the App Store, if the user has an active Play Store subscription
    /// it will point there. If there are no active subscriptions it will be null.
    /// If there are multiple for different platforms, it will point to the device store.
    @JsonKey(name: 'managementURL') String? managementURL,
  }) = _PurchaserInfo;

  factory PurchaserInfo.fromJson(Map<String, dynamic> json) =>
      _$PurchaserInfoFromJson(json);
}
