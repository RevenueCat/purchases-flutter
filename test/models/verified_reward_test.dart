import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/verified_reward.dart';

void main() {
  group('VerifiedReward.fromMap', () {
    test('parses a virtual currency reward', () {
      final reward = VerifiedReward.fromMap({
        'type': 'virtual_currency',
        'code': 'GOLD',
        'amount': 100,
      });
      expect(reward, isA<VerifiedVirtualCurrencyReward>());
      final currency = reward as VerifiedVirtualCurrencyReward;
      expect(currency.code, 'GOLD');
      expect(currency.amount, 100);
    });

    test('parses an entitlement reward', () {
      final reward = VerifiedReward.fromMap({
        'type': 'entitlement',
        'identifier': 'premium',
        'expiresAtMillis': 1617979680000,
      });
      expect(reward, isA<VerifiedEntitlementReward>());
      final entitlement = reward as VerifiedEntitlementReward;
      expect(entitlement.identifier, 'premium');
      expect(
        entitlement.expiresAt,
        DateTime.fromMillisecondsSinceEpoch(1617979680000),
      );
    });

    test('parses an entitlement reward without an expiration', () {
      final reward = VerifiedReward.fromMap({
        'type': 'entitlement',
        'identifier': 'premium',
      });
      expect((reward as VerifiedEntitlementReward).expiresAt, isNull);
    });

    test('rounds a non-int amount from the platform channel', () {
      final reward = VerifiedReward.fromMap({
        'type': 'virtual_currency',
        'code': 'GOLD',
        'amount': 100.0,
      });
      expect((reward as VerifiedVirtualCurrencyReward).amount, 100);
    });

    test('parses a no-reward result', () {
      final reward = VerifiedReward.fromMap({'type': 'no_reward'});
      expect(reward, isA<VerifiedNoReward>());
    });

    test('parses an unknown type as an unsupported reward', () {
      final reward = VerifiedReward.fromMap({'type': 'something_new'});
      expect(reward, isA<VerifiedUnsupportedReward>());
    });
  });
}
