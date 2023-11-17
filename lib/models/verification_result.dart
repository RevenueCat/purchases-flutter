import 'package:freezed_annotation/freezed_annotation.dart';

/// Enum of entitlement verification modes
enum VerificationResult {
  /// The SDK will not perform any entitlement verification.
  @JsonValue('NOT_REQUESTED')
  notRequested,

  @JsonValue('VERIFIED')
  verified,

  @JsonValue('VERIFIED_ON_DEVICE')
  verifiedOnDevice,

  @JsonValue('FAILED')
  failed
}
