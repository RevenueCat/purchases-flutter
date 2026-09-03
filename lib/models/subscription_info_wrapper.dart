import 'package:equatable/equatable.dart';

import 'entitlement_info_wrapper.dart';
import 'map_helpers.dart';
import 'store.dart';

/// Subscription purchase of a customer, keyed by product identifier in
/// [CustomerInfo.subscriptionsByProductIdentifier].
class SubscriptionInfo extends Equatable {
  /// The product identifier.
  final String productIdentifier;

  /// Date when the last subscription period started.
  final String purchaseDate;

  /// Whether or not the purchase was made in sandbox mode.
  final bool isSandbox;

  /// Whether the subscription is currently active.
  final bool isActive;

  /// Whether the subscription will renew at the next billing period.
  final bool willRenew;

  /// Date when this subscription first started. Can be null for non-subscriptions.
  final String? originalPurchaseDate;

  /// Date when the subscription expires/expired. Can be null for non-subscriptions.
  final String? expiresDate;

  /// Store where the subscription was purchased.
  final Store store;

  /// Date when RevenueCat detected that auto-renewal was turned off for this
  /// subscription. Note the subscription may still be active, check the
  /// [expiresDate] attribute.
  final String? unsubscribeDetectedAt;

  /// Date when RevenueCat detected any billing issues with this subscription.
  /// If and when the billing issue gets resolved, this field is set to null.
  /// Note the subscription may still be active, check the [expiresDate] attribute.
  final String? billingIssuesDetectedAt;

  /// Date when any grace period for this subscription expires/expired.
  /// Null if the customer has never been in a grace period.
  final String? gracePeriodExpiresDate;

  /// How the customer received access to this subscription.
  final OwnershipType ownershipType;

  /// Type of the current subscription period.
  final PeriodType periodType;

  /// Date when RevenueCat detected a refund of this subscription.
  final String? refundedAt;

  /// The transaction id in the store of the subscription.
  final String? storeTransactionId;

  /// The date the paused subscription will automatically resume.
  /// Only set for Google Play subscriptions that have been paused; null otherwise.
  final String? autoResumeDate;

  /// The display name of the subscription as configured in the RevenueCat dashboard.
  final String? displayName;

  /// The URL to manage this subscription in the store. Can be null.
  final String? managementURL;

  /// The base plan identifier that unlocked this subscription (Google Play base
  /// plans and Apple purchases with non-upfront billing plans). Null otherwise.
  final String? productPlanIdentifier;

  const SubscriptionInfo(
    this.productIdentifier,
    this.purchaseDate,
    this.isSandbox,
    this.isActive,
    this.willRenew, {
    this.originalPurchaseDate,
    this.expiresDate,
    this.store = Store.unknownStore,
    this.unsubscribeDetectedAt,
    this.billingIssuesDetectedAt,
    this.gracePeriodExpiresDate,
    this.ownershipType = OwnershipType.unknown,
    this.periodType = PeriodType.unknown,
    this.refundedAt,
    this.storeTransactionId,
    this.autoResumeDate,
    this.displayName,
    this.managementURL,
    this.productPlanIdentifier,
  });

  factory SubscriptionInfo.fromJson(Map<String, dynamic> json) =>
    SubscriptionInfo(
      json['productIdentifier'] as String,
      json['purchaseDate'] as String,
      json['isSandbox'] as bool,
      json['isActive'] as bool,
      json['willRenew'] as bool,
      originalPurchaseDate: json['originalPurchaseDate'] as String?,
      expiresDate: json['expiresDate'] as String?,
      store: storeFromJson(json['store']),
      unsubscribeDetectedAt: json['unsubscribeDetectedAt'] as String?,
      billingIssuesDetectedAt: json['billingIssuesDetectedAt'] as String?,
      gracePeriodExpiresDate: json['gracePeriodExpiresDate'] as String?,
      ownershipType: ownershipTypeFromJson(json['ownershipType']),
      periodType: periodTypeFromJson(json['periodType']),
      refundedAt: json['refundedAt'] as String?,
      storeTransactionId: json['storeTransactionId'] as String?,
      autoResumeDate: json['autoResumeDate'] as String?,
      displayName: json['displayName'] as String?,
      managementURL: json['managementURL'] as String?,
      productPlanIdentifier: json['productPlanIdentifier'] as String?,
    );

  @override
  List<Object?> get props => [
    productIdentifier,
    purchaseDate,
    isSandbox,
    isActive,
    willRenew,
    originalPurchaseDate,
    expiresDate,
    store,
    unsubscribeDetectedAt,
    billingIssuesDetectedAt,
    gracePeriodExpiresDate,
    ownershipType,
    periodType,
    refundedAt,
    storeTransactionId,
    autoResumeDate,
    displayName,
    managementURL,
    productPlanIdentifier,
  ];
}
