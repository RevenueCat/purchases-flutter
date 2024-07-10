import 'package:freezed_annotation/freezed_annotation.dart';

part 'installments_info.freezed.dart';
part 'installments_info.g.dart';

@freezed

/// Type containing information of installment subscriptions.
/// Currently only supported in Google Play.
class InstallmentsInfo with _$InstallmentsInfo {
  const factory InstallmentsInfo(
    /// Number of payments the customer commits to in order to purchase
    /// the subscription.
    int commitmentPaymentsCount,

    /// After the commitment payments are complete, the number of payments
    /// the user commits to upon a renewal.
    int renewalCommitmentPaymentsCount,
  ) = _InstallmentsInfo;

  factory InstallmentsInfo.fromJson(Map<String, dynamic> json) =>
      _$InstallmentsInfoFromJson(json);
}
