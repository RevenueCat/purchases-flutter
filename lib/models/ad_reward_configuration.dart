import 'package:equatable/equatable.dart';

/// A reward configured for a rewarded ad, before the ad is shown.
///
/// Inspect the concrete subtype to read its data:
/// [VirtualCurrencyRewardConfiguration], [EntitlementRewardConfiguration], or
/// [UnsupportedAdRewardConfiguration]. Configured rewards describe what can be
/// advertised; verification determines which rewards are actually granted.
abstract class AdRewardConfiguration extends Equatable {
  const AdRewardConfiguration._();

  /// Creates a configured reward from its native SDK representation.
  factory AdRewardConfiguration.fromMap(Map<String, dynamic> map) {
    switch (map['type']) {
      case 'virtual_currency':
        return VirtualCurrencyRewardConfiguration(
          code: map['code'] as String,
          amount: (map['amount'] as num).round(),
        );
      case 'entitlement':
        return EntitlementRewardConfiguration(
          identifier: map['identifier'] as String,
          duration: Duration(
            microseconds: ((map['durationSeconds'] as num) *
                    Duration.microsecondsPerSecond)
                .round(),
          ),
        );
      default:
        return const UnsupportedAdRewardConfiguration();
    }
  }
}

/// A configured reward of [amount] units of the virtual currency [code].
class VirtualCurrencyRewardConfiguration extends AdRewardConfiguration {
  /// The virtual currency code, for example `coins` or `gems`.
  final String code;

  /// The configured reward amount.
  final int amount;

  const VirtualCurrencyRewardConfiguration({
    required this.code,
    required this.amount,
  }) : super._();

  @override
  List<Object?> get props => [code, amount];
}

/// A configured reward granting the entitlement [identifier] for [duration].
class EntitlementRewardConfiguration extends AdRewardConfiguration {
  /// The entitlement identifier.
  final String identifier;

  /// How long the entitlement will be granted for, rather than an expiration.
  final Duration duration;

  const EntitlementRewardConfiguration({
    required this.identifier,
    required this.duration,
  }) : super._();

  @override
  List<Object?> get props => [identifier, duration];
}

/// A configured reward type that this SDK version does not model.
///
/// Its position among the configured rewards is preserved. Use generic copy
/// when advertising this reward.
class UnsupportedAdRewardConfiguration extends AdRewardConfiguration {
  const UnsupportedAdRewardConfiguration() : super._();

  @override
  List<Object?> get props => [];
}
