import 'package:meta/meta.dart';

/// A single reward granted by a verified rewarded ad.
///
/// [type] is one of `virtual_currency`, `entitlement`, `no_reward`, or
/// `unsupported_reward`. The remaining fields are populated only for the
/// matching type.
@experimental
class VerifiedReward {
  final String type;

  /// Virtual-currency code (`virtual_currency` only).
  final String? code;

  /// Virtual-currency amount (`virtual_currency` only).
  final int? amount;

  /// Entitlement identifier (`entitlement` only).
  final String? identifier;

  /// Entitlement expiration (`entitlement` only).
  final DateTime? expiresAt;

  const VerifiedReward({
    required this.type,
    this.code,
    this.amount,
    this.identifier,
    this.expiresAt,
  });

  factory VerifiedReward.fromMap(Map<String, dynamic> map) {
    final millis = map['expiresAtMillis'];
    return VerifiedReward(
      type: map['type'] as String,
      code: map['code'] as String?,
      amount: map['amount'] as int?,
      identifier: map['identifier'] as String?,
      expiresAt: millis is num
          ? DateTime.fromMillisecondsSinceEpoch(millis.toInt())
          : null,
    );
  }
}
