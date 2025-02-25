import 'package:freezed_annotation/freezed_annotation.dart';
import 'store.dart';
import 'verification_result.dart';

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

  /// If the entitlement is under a prepaid period.
  @JsonValue('PREPAID')
  prepaid,

  /// If the period type couldn't be determined.
  unknown
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
  @JsonValue('UNKNOWN')
  unknown
}

/// The EntitlementInfo object gives you access to all of the information about
/// the status of a user entitlement.
@freezed
class EntitlementInfo with _$EntitlementInfo {
  const factory EntitlementInfo(
    /// The entitlement identifier configured in the RevenueCat dashboard
    String identifier,

    /// True if the user has access to this entitlement
    bool isActive,

    /// True if the underlying subscription is set to renew at the end of
    /// the billing period (expirationDate).
    bool willRenew,

    /// The latest purchase or renewal date for the entitlement.
    String latestPurchaseDate,

    /// The first date this entitlement was purchased
    String originalPurchaseDate,

    /// The product identifier that unlocked this entitlement
    String productIdentifier,

    /// False if this entitlement is unlocked via a production purchase
    bool isSandbox, {

    /// Use this property to determine whether a purchase was made by the current
    /// user or shared to them by a family member. This can be useful for
    /// onboarding users who have had an entitlement shared with them, but might
    /// not be entirely aware of the benefits they now have.
    @Default(OwnershipType.unknown)
    // ignore: invalid_annotation_target
    @JsonKey(
      name: 'ownershipType',
      unknownEnumValue: OwnershipType.unknown,
    )
        OwnershipType ownershipType,

    /// The store where this entitlement was unlocked from
    @Default(Store.unknownStore)
    // ignore: invalid_annotation_target
    @JsonKey(
      name: 'store',
      unknownEnumValue: Store.unknownStore,
    )
        Store store,

    /// The last period type this entitlement was in
    @Default(PeriodType.unknown)
    // ignore: invalid_annotation_target
    @JsonKey(
      name: 'periodType',
      unknownEnumValue: PeriodType.unknown,
    )
        PeriodType periodType,

    /// The expiration date for the entitlement, can be null for lifetime access.
    /// If the [periodType] is [PeriodType.trial],
    /// this is the trial expiration date.
    String? expirationDate,

    /// The date an unsubscribe was detected. Can be null if it's still
    /// subscribed or product is not a subscription.
    /// @note: Entitlement may still be active even if user has unsubscribed.
    /// Check the [isActive] property.
    String? unsubscribeDetectedAt,

    /// The date a billing issue was detected. Can be null if there is no
    /// billing issue or an issue has been resolved.
    /// @note: Entitlement may still be active even if there is a billing issue.
    /// Check the [isActive] property.
    String? billingIssueDetectedAt,

    /// The base plan identifier that unlocked this entitlement (Google only).
    String? productPlanIdentifier,

    /// If entitlement verification was enabled, the result of that verification.
    /// If not, `VerificationResult.NOT_REQUESTED`.
    @Default(VerificationResult.notRequested)
    VerificationResult verification,
  }) = _EntitlementInfo;

  factory EntitlementInfo.fromJson(Map<String, dynamic> json) =>
      _$EntitlementInfoFromJson(json);
}
