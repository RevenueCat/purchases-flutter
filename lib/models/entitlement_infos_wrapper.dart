import 'package:freezed_annotation/freezed_annotation.dart';

import 'entitlement_info_wrapper.dart';
import 'verification_result.dart';

part 'entitlement_infos_wrapper.freezed.dart';
part 'entitlement_infos_wrapper.g.dart';

@freezed

/// This class contains all the entitlements associated to the user.
class EntitlementInfos with _$EntitlementInfos {
  const factory EntitlementInfos(
    /// Map of all EntitlementInfo (`EntitlementInfo`) objects (active and inactive)
    /// keyed by entitlement identifier.
    final Map<String, EntitlementInfo> all,

    /// Map of active EntitlementInfo (`EntitlementInfo`) objects keyed by
    /// entitlement identifier.
    final Map<String, EntitlementInfo> active, {

    /// If entitlement verification was enabled, the result of that verification.
    /// If not, `VerificationResult.NOT_REQUESTED`.
    @Default(VerificationResult.notRequested)
    final VerificationResult verification,
  }) = _EntitlementInfos;

  factory EntitlementInfos.fromJson(Map<String, dynamic> json) =>
      _$EntitlementInfosFromJson(json);
}
