import 'package:equatable/equatable.dart';

import 'map_helpers.dart';
import 'store.dart';
import 'verification_result.dart';

/// Enum of supported period types for an entitlement.
enum PeriodType {
  /// If the entitlement is under a introductory price period.
  intro,

  /// If the entitlement is not under an introductory or trial period.
  normal,

  /// If the entitlement is under a trial period.
  trial,

  /// If the entitlement is under a prepaid period.
  prepaid,

  /// If the period type couldn't be determined.
  unknown
}

/// Enum of ownership types
enum OwnershipType {
  /// The purchase was made directly by this user.
  purchased,

  /// The purchase has been shared to this user by a family member.
  familyShared,

  /// The purchase has no or an unknown ownership type.
  unknown
}

/// The EntitlementInfo object gives you access to all of the information about
/// the status of a user entitlement.
class EntitlementInfo extends Equatable {
  /// The entitlement identifier configured in the RevenueCat dashboard
  final String identifier;

  /// True if the user has access to this entitlement
  final bool isActive;

  /// True if the underlying subscription is set to renew at the end of
  /// the billing period (expirationDate).
  final bool willRenew;

  /// The latest purchase or renewal date for the entitlement.
  final String latestPurchaseDate;

  /// The first date this entitlement was purchased
  final String originalPurchaseDate;

  /// The product identifier that unlocked this entitlement
  final String productIdentifier;

  /// False if this entitlement is unlocked via a production purchase
  final bool isSandbox;

  /// Use this property to determine whether a purchase was made by the current
  /// user or shared to them by a family member. This can be useful for
  /// onboarding users who have had an entitlement shared with them, but might
  /// not be entirely aware of the benefits they now have.
  final OwnershipType ownershipType;

  /// The store where this entitlement was unlocked from
  final Store store;

  /// The last period type this entitlement was in
  final PeriodType periodType;

  /// The expiration date for the entitlement, can be null for lifetime access.
  /// If the [periodType] is [PeriodType.trial],
  /// this is the trial expiration date.
  final String? expirationDate;

  /// The date an unsubscribe was detected. Can be null if it's still
  /// subscribed or product is not a subscription.
  /// @note: Entitlement may still be active even if user has unsubscribed.
  /// Check the [isActive] property.
  final String? unsubscribeDetectedAt;

  /// The date a billing issue was detected. Can be null if there is no
  /// billing issue or an issue has been resolved.
  /// @note: Entitlement may still be active even if there is a billing issue.
  /// Check the [isActive] property.
  final String? billingIssueDetectedAt;

  /// The base plan identifier that unlocked this entitlement (Google only).
  final String? productPlanIdentifier;

  /// If entitlement verification was enabled, the result of that verification.
  /// If not, `VerificationResult.NOT_REQUESTED`.
  final VerificationResult verification;

  const EntitlementInfo(
    this.identifier,
    this.isActive,
    this.willRenew,
    this.latestPurchaseDate,
    this.originalPurchaseDate,
    this.productIdentifier,
    this.isSandbox, {
    this.ownershipType = OwnershipType.unknown,
    this.store = Store.unknownStore,
    this.periodType = PeriodType.unknown,
    this.expirationDate,
    this.unsubscribeDetectedAt,
    this.billingIssueDetectedAt,
    this.productPlanIdentifier,
    this.verification = VerificationResult.notRequested,
  });

  factory EntitlementInfo.fromJson(Map<String, dynamic> json) =>
    EntitlementInfo(
      json['identifier'] as String,
      json['isActive'] as bool,
      json['willRenew'] as bool,
      json['latestPurchaseDate'] as String,
      json['originalPurchaseDate'] as String,
      json['productIdentifier'] as String,
      json['isSandbox'] as bool,
      ownershipType: _ownershipTypeFromJson(json['ownershipType']),
      store: storeFromJson(json['store']),
      periodType: _periodTypeFromJson(json['periodType']),
      expirationDate: json['expirationDate'] as String?,
      unsubscribeDetectedAt: json['unsubscribeDetectedAt'] as String?,
      billingIssueDetectedAt: json['billingIssueDetectedAt'] as String?,
      productPlanIdentifier: json['productPlanIdentifier'] as String?,
      verification: verificationResultFromJson(json['verification']),
    );

  @override
  List<Object?> get props => [
    identifier,
    isActive,
    willRenew,
    latestPurchaseDate,
    originalPurchaseDate,
    productIdentifier,
    isSandbox,
    ownershipType,
    store,
    periodType,
    expirationDate,
    unsubscribeDetectedAt,
    billingIssueDetectedAt,
    productPlanIdentifier,
    verification,
  ];
}

OwnershipType _ownershipTypeFromJson(dynamic value) {
  switch (value) {
    case 'PURCHASED':
      return OwnershipType.purchased;
    case 'FAMILY_SHARED':
      return OwnershipType.familyShared;
    case 'UNKNOWN':
      return OwnershipType.unknown;
    default:
      return OwnershipType.unknown;
  }
}

PeriodType _periodTypeFromJson(dynamic value) {
  switch (value) {
    case 'INTRO':
      return PeriodType.intro;
    case 'NORMAL':
      return PeriodType.normal;
    case 'TRIAL':
      return PeriodType.trial;
    case 'PREPAID':
      return PeriodType.prepaid;
    default:
      return PeriodType.unknown;
  }
}
