/// Enum of entitlement verification modes
enum VerificationResult {
  /// The SDK will not perform any entitlement verification.
  notRequested,
  verified,
  verifiedOnDevice,
  failed
}
