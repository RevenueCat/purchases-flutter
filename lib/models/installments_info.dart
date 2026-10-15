import 'package:equatable/equatable.dart';

import 'billing_plan_type.dart';
import 'map_helpers.dart';

/// Type containing information of installment subscriptions.
/// Supported in Google Play (via SubscriptionOption) and iOS (via StoreProduct).
class InstallmentsInfo extends Equatable {
  /// Number of payments the customer commits to in order to purchase
  /// the subscription.
  final int commitmentPaymentsCount;

  /// After the commitment payments are complete, the number of payments
  /// the user commits to upon a renewal.
  final int renewalCommitmentPaymentsCount;

  /// Duration of each installment, specified in ISO 8601 format. For example, P1M equates to one month.
  /// iOS only. Null on Android.
  final String? commitmentInstallmentPeriod;

  /// Price charged for each installment billing period.
  /// iOS only. Null on Android.
  final double? installmentBillingPrice;

  /// Formatted price charged for each installment billing period, including its currency sign.
  /// iOS only. Null on Android.
  final String? installmentBillingPriceString;

  /// Total duration of the customer's installment commitment, specified in ISO 8601 format.
  /// iOS only. Null on Android.
  final String? commitmentTotalPeriod;

  /// Total price the customer commits to paying across all installments.
  /// iOS only. Null on Android.
  final double? commitmentTotalPrice;

  /// Formatted total price the customer commits to paying across all installments, including its currency sign.
  /// iOS only. Null on Android.
  final String? commitmentTotalPriceString;

  /// The billing plan used for the installments.
  /// iOS only. Null on Android.
  final BillingPlanType? billingPlanType;

  const InstallmentsInfo(
      this.commitmentPaymentsCount,
      this.renewalCommitmentPaymentsCount, {
      this.commitmentInstallmentPeriod,
      this.installmentBillingPrice,
      this.installmentBillingPriceString,
      this.commitmentTotalPeriod,
      this.commitmentTotalPrice,
      this.commitmentTotalPriceString,
      this.billingPlanType,
  });

  factory InstallmentsInfo.fromJson(Map<String, dynamic> json) => InstallmentsInfo(
    json['commitmentPaymentsCount'] as int,
    json['renewalCommitmentPaymentsCount'] as int,
    commitmentInstallmentPeriod: json['commitmentInstallmentPeriod'] as String?,
    installmentBillingPrice: json['installmentBillingPrice'] != null ? (json['installmentBillingPrice'] as num).toDouble() : null,
    installmentBillingPriceString: json['installmentBillingPriceString'] as String?,
    commitmentTotalPeriod: json['commitmentTotalPeriod'] as String?,
    commitmentTotalPrice: json['commitmentTotalPrice'] != null ? (json['commitmentTotalPrice'] as num).toDouble() : null,
    commitmentTotalPriceString: json['commitmentTotalPriceString'] as String?,
    billingPlanType: billingPlanTypeFromJson(json['billingPlanType']),
  );

  @override
  List<Object?> get props => [
    commitmentPaymentsCount,
    renewalCommitmentPaymentsCount,
    commitmentInstallmentPeriod,
    installmentBillingPrice,
    installmentBillingPriceString,
    commitmentTotalPeriod,
    commitmentTotalPrice,
    commitmentTotalPriceString,
    billingPlanType,
  ];
}
