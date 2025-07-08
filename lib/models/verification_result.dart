/// Enum of entitlement verification modes
enum VerificationResult {
  /// The SDK will not perform any entitlement verification.
  notRequested,
  verified,
  verifiedOnDevice,
  failed,
  ;

  static fromJson(dynamic value) {
    switch (value) {
      case 'NOT_REQUESTED':
        return VerificationResult.notRequested;
      case 'FAILED':
        return VerificationResult.failed;
      case 'VERIFIED':
        return VerificationResult.verified;
      case 'VERIFIED_ON_DEVICE':
        return VerificationResult.verifiedOnDevice;
      default:
        return VerificationResult.notRequested;
    }
  }

  String toJson() {
    switch (this) {
      case VerificationResult.notRequested:
        return 'NOT_REQUESTED';
      case VerificationResult.failed:
        return 'FAILED';
      case VerificationResult.verified:
        return 'VERIFIED';
      case VerificationResult.verifiedOnDevice:
        return 'VERIFIED_ON_DEVICE';
    }
  }
}
