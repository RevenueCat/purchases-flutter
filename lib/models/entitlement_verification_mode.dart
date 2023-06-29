import 'package:freezed_annotation/freezed_annotation.dart';

/// Enum of entitlement verification modes
enum EntitlementVerificationMode {
  @JsonValue('DISABLED')
  disabled,

  @JsonValue('INFORMATIONAL')
  informational,

  @JsonValue('ENFORCED')
  enforced
}
