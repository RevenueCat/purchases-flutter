/// A single reward granted by a verified rewarded ad.
///
/// This is an abstract base type; inspect the concrete subtype to read the
/// reward's data: [VerifiedVirtualCurrencyReward], [VerifiedEntitlementReward],
/// [VerifiedNoReward], or [VerifiedUnsupportedReward].
///
/// ```dart
/// final reward = result.reward;
/// if (reward is VerifiedVirtualCurrencyReward) {
///   grantCurrency(reward.code, reward.amount);
/// } else if (reward is VerifiedEntitlementReward) {
///   unlock(reward.identifier);
/// }
/// ```
abstract class VerifiedReward {
  const VerifiedReward._();

  factory VerifiedReward.fromMap(Map<String, dynamic> map) {
    switch (map['type'] as String?) {
      case 'virtual_currency':
        return VerifiedVirtualCurrencyReward(
          code: map['code'] as String,
          amount: (map['amount'] as num).round(),
        );
      case 'entitlement':
        final millis = map['expiresAtMillis'];
        return VerifiedEntitlementReward(
          identifier: map['identifier'] as String,
          expiresAt: millis is num
              ? DateTime.fromMillisecondsSinceEpoch(millis.toInt())
              : null,
        );
      case 'no_reward':
        return const VerifiedNoReward();
      default:
        return const VerifiedUnsupportedReward();
    }
  }
}

/// A reward of [amount] units of the virtual currency [code].
class VerifiedVirtualCurrencyReward extends VerifiedReward {
  final String code;
  final int amount;

  const VerifiedVirtualCurrencyReward({
    required this.code,
    required this.amount,
  }) : super._();
}

/// A reward granting the entitlement [identifier].
class VerifiedEntitlementReward extends VerifiedReward {
  final String identifier;

  /// When the entitlement expires, or null if it does not expire.
  final DateTime? expiresAt;

  const VerifiedEntitlementReward({
    required this.identifier,
    this.expiresAt,
  }) : super._();
}

/// Verification completed but no reward was granted.
class VerifiedNoReward extends VerifiedReward {
  const VerifiedNoReward() : super._();
}

/// Verification completed with a reward type not modeled by this SDK version.
class VerifiedUnsupportedReward extends VerifiedReward {
  const VerifiedUnsupportedReward() : super._();
}
