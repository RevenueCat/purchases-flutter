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
      expect(reward.type, 'virtual_currency');
      expect(reward.code, 'GOLD');
      expect(reward.amount, 100);
      expect(reward.identifier, isNull);
      expect(reward.expiresAt, isNull);
    });

    test('parses an entitlement reward', () {
      final reward = VerifiedReward.fromMap({
        'type': 'entitlement',
        'identifier': 'premium',
        'expiresAtMillis': 1617979680000,
      });
      expect(reward.type, 'entitlement');
      expect(reward.identifier, 'premium');
      expect(
        reward.expiresAt,
        DateTime.fromMillisecondsSinceEpoch(1617979680000),
      );
      expect(reward.code, isNull);
      expect(reward.amount, isNull);
    });

    test('parses a no-reward result', () {
      final reward = VerifiedReward.fromMap({'type': 'no_reward'});
      expect(reward.type, 'no_reward');
      expect(reward.code, isNull);
      expect(reward.amount, isNull);
      expect(reward.identifier, isNull);
      expect(reward.expiresAt, isNull);
    });

    test('parses an unsupported reward without failing', () {
      final reward = VerifiedReward.fromMap({'type': 'unsupported_reward'});
      expect(reward.type, 'unsupported_reward');
    });
  });
}
