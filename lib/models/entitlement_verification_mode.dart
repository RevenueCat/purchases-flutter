/// Enum of entitlement verification modes
enum EntitlementVerificationMode {
  /// The SDK will not perform any entitlement verification.
  disabled,

  /// Enable entitlement verification.
  ///
  /// If verification fails, this will be indicated with [VerificationResult.FAILED] in
  /// the [EntitlementInfos.verification] and [EntitlementInfo.verification] properties but parsing will not fail
  /// (i.e. Entitlements will still be granted).
  ///
  /// This can be useful if you want to handle verification failures to display an error/warning to the user
  /// or to track this situation but still grant access.
  informational,

  // Disabled temporarily until ENFORCED is supported.
  // enforced
}

extension EntitlementVerificationModeExtension on EntitlementVerificationMode {
  String get name {
    switch (this) {
      case EntitlementVerificationMode.disabled:
        return 'DISABLED';
      case EntitlementVerificationMode.informational:
        return 'INFORMATIONAL';
    }
  }
}
