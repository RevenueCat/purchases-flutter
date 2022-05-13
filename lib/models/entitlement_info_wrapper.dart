import 'package:freezed_annotation/freezed_annotation.dart';

part 'entitlement_info_wrapper.freezed.dart';
part 'entitlement_info_wrapper.g.dart';

/// Enum of supported period types for an entitlement.
enum PeriodType {
  /// If the entitlement is under a introductory price period.
  @JsonValue('INTRO')
  intro,

  /// If the entitlement is not under an introductory or trial period.
  @JsonValue('NORMAL')
  normal,

  /// If the entitlement is under a trial period.
  @JsonValue('TRIAL')
  trial,

  /// If the period type couldn't be determined.
  unknown
}

/// Enum of supported stores
enum Store {
  /// For entitlements granted via Apple App Store.
  @JsonValue('APP_STORE')
  appStore,

  /// For entitlements granted via Apple Mac App Store.
  @JsonValue('MAC_APP_STORE')
  macAppStore,

  /// For entitlements granted via Google Play Store.
  @JsonValue('PLAY_STORE')
  playStore,

  /// For entitlements granted via Stripe.
  @JsonValue('STRIPE')
  stripe,

  /// For entitlements granted via a promo in RevenueCat.
  @JsonValue('PROMOTIONAL')
  promotional,

  /// For entitlements granted via an unknown store.
  unknownStore
}

/// Enum of ownership types
enum OwnershipType {
  /// The purchase was made directly by this user.
  @JsonValue('PURCHASED')
  purchased,

  /// The purchase has been shared to this user by a family member.
  @JsonValue('FAMILY_SHARED')
  familyShared,

  /// The purchase has no or an unknown ownership type.
  unknown
}

@freezed

/// The EntitlementInfo object gives you access to all of the information about the status of a user entitlement.
class EntitlementInfo with _$EntitlementInfo {
  const factory EntitlementInfo(
    /// The entitlement identifier configured in the RevenueCat dashboard
    @JsonKey(name: 'identifier')
        String identifier,

    /// True if the user has access to this entitlement
    @JsonKey(name: 'isActive')
        bool isActive,

    /// True if the underlying subscription is set to renew at the end of
    /// the billing period (expirationDate).
    @JsonKey(name: 'willRenew')
        bool willRenew,

    /// The latest purchase or renewal date for the entitlement.
    @JsonKey(name: 'latestPurchaseDate')
        String latestPurchaseDate,

    /// The first date this entitlement was purchased
    @JsonKey(name: 'originalPurchaseDate')
        String originalPurchaseDate,

    /// The product identifier that unlocked this entitlement
    @JsonKey(name: 'productIdentifier')
        String productIdentifier,

    /// False if this entitlement is unlocked via a production purchase
    @JsonKey(name: 'isSandbox')
        bool isSandbox, {

    /// Use this property to determine whether a purchase was made by the current
    /// user or shared to them by a family member. This can be useful for
    /// onboarding users who have had an entitlement shared with them, but might
    /// not be entirely aware of the benefits they now have.
    @Default(OwnershipType.unknown)
    @JsonKey(
      name: 'ownershipType',
      unknownEnumValue: OwnershipType.unknown,
    )
        OwnershipType ownershipType,

    /// The store where this entitlement was unlocked from
    /// Either: appStore, macAppStore, playStore, stripe, promotional, unknownStore
    @Default(Store.unknownStore)
    @JsonKey(name: 'store', unknownEnumValue: Store.unknownStore)
        Store store,

    /// The last period type this entitlement was in
    /// Either: normal, intro, trial
    @Default(PeriodType.unknown)
    @JsonKey(name: 'periodType', unknownEnumValue: PeriodType.unknown)
        PeriodType periodType,

    /// The expiration date for the entitlement, can be `null` for lifetime access.
    /// If the `periodType` is `trial`, this is the trial expiration date.
    @JsonKey(name: 'expirationDate', nullable: true)
        String? expirationDate,

    /// The date an unsubscribe was detected. Can be `null` if it's still
    /// subscribed or product is not a subscription.
    /// @note: Entitlement may still be active even if user has unsubscribed.
    /// Check the `isActive` property.
    @JsonKey(name: 'unsubscribeDetectedAt', nullable: true)
        String? unsubscribeDetectedAt,

    /// The date a billing issue was detected. Can be `null` if there is no
    /// billing issue or an issue has been resolved.
    /// @note: Entitlement may still be active even if there is a billing issue.
    /// Check the `isActive` property.
    @JsonKey(name: 'billingIssueDetectedAt', nullable: true)
        String? billingIssueDetectedAt,
  }) = _EntitlementInfo;

  factory EntitlementInfo.fromJson(Map<String, dynamic> json) =>
      _$EntitlementInfoFromJson(json);
}
