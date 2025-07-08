import 'package:equatable/equatable.dart';

/// Type containing information of installment subscriptions.
/// Currently only supported in Google Play.
class InstallmentsInfo extends Equatable {
  /// Number of payments the customer commits to in order to purchase
  /// the subscription.
  final int commitmentPaymentsCount;

  /// After the commitment payments are complete, the number of payments
  /// the user commits to upon a renewal.
  final int renewalCommitmentPaymentsCount;

  const InstallmentsInfo(
    this.commitmentPaymentsCount,
    this.renewalCommitmentPaymentsCount,
  );

  factory InstallmentsInfo.fromJson(Map<String, dynamic> json) =>
      InstallmentsInfo(
        json['commitmentPaymentsCount'] as int,
        json['renewalCommitmentPaymentsCount'] as int,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'commitmentPaymentsCount': commitmentPaymentsCount,
        'renewalCommitmentPaymentsCount': renewalCommitmentPaymentsCount,
      };

  @override
  List<Object?> get props => [
        commitmentPaymentsCount,
        renewalCommitmentPaymentsCount,
      ];
}
