import 'package:freezed_annotation/freezed_annotation.dart';

/// Enum of entitlement verification modes
enum EntitlementVerificationMode {
  /// The SDK will not perform any entitlement verification.
  @JsonValue('DISABLED')
  disabled,

  /// Enable entitlement verification.
  ///
  /// If verification fails, this will be indicated with [VerificationResult.FAILED] in
  /// the [EntitlementInfos.verification] and [EntitlementInfo.verification] properties but parsing will not fail
  /// (i.e. Entitlements will still be granted).
  ///
  /// This can be useful if you want to handle verification failures to display an error/warning to the user
  /// or to track this situation but still grant access.
  @JsonValue('INFORMATIONAL')
  informational,

  // Disabled temporarily until ENFORCED is supported.
  // @JsonValue('ENFORCED')
  // enforced
}
