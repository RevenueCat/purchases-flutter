import 'package:equatable/equatable.dart';

import 'entitlement_info_wrapper.dart';
import 'verification_result.dart';

/// This class contains all the entitlements associated to the user.
class EntitlementInfos extends Equatable {
  /// Map of all EntitlementInfo (`EntitlementInfo`) objects (active and inactive)
  /// keyed by entitlement identifier.
  final Map<String, EntitlementInfo> all;

  /// Map of active EntitlementInfo (`EntitlementInfo`) objects keyed by
  /// entitlement identifier.
  final Map<String, EntitlementInfo> active;

  /// If entitlement verification was enabled, the result of that verification.
  /// If not, `VerificationResult.NOT_REQUESTED`.
  final VerificationResult verification;

  const EntitlementInfos(
    this.all,
    this.active, {
    this.verification = VerificationResult.notRequested,
  });

  factory EntitlementInfos.fromJson(Map<String, dynamic> json) =>
      EntitlementInfos(
        Map<String, dynamic>.from(json['all']).map(
          (k, v) => MapEntry(
            k,
            EntitlementInfo.fromJson(Map<String, dynamic>.from(v)),
          ),
        ),
        Map<String, dynamic>.from(json['active']).map(
          (k, v) => MapEntry(
            k,
            EntitlementInfo.fromJson(Map<String, dynamic>.from(v)),
          ),
        ),
        verification: VerificationResult.fromJson(json['verification']),
      );

  Map<String, dynamic> toJson() => {
        'all': all.map((k, v) => MapEntry(k, v.toJson())),
        'active': active.map((k, v) => MapEntry(k, v.toJson())),
        'verification': verification.toJson(),
      };

  @override
  List<Object?> get props => [
        all,
        active,
        verification,
      ];
}
