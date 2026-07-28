import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/reward_verification_result.dart';
import 'package:purchases_flutter/models/verified_reward.dart';

void main() {
  group('RewardVerificationResult.fromMap', () {
    test('parses a single verified reward', () {
      final result = RewardVerificationResult.fromMap({
        'failed': false,
        'reward': {
          'type': 'virtual_currency',
          'code': 'GOLD',
          'amount': 100,
        },
      });
      expect(result.failed, isFalse);
      final reward = result.reward;
      expect(reward, isA<VerifiedVirtualCurrencyReward>());
      expect((reward as VerifiedVirtualCurrencyReward).code, 'GOLD');
      expect(reward.amount, 100);
      expect(result.moreRewards, isEmpty);
    });

    test('parses a multi-grant result', () {
      final result = RewardVerificationResult.fromMap({
        'failed': false,
        'reward': {'type': 'entitlement', 'identifier': 'premium'},
        'moreRewards': [
          {'type': 'virtual_currency', 'code': 'GOLD', 'amount': 50},
          {'type': 'virtual_currency', 'code': 'GEMS', 'amount': 5},
        ],
      });
      expect(result.failed, isFalse);
      expect((result.reward as VerifiedEntitlementReward).identifier, 'premium');
      expect(result.moreRewards.length, 2);
      expect(
        (result.moreRewards[0] as VerifiedVirtualCurrencyReward).code,
        'GOLD',
      );
      expect(
        (result.moreRewards[1] as VerifiedVirtualCurrencyReward).code,
        'GEMS',
      );
    });

    test('parses a failed result', () {
      final result = RewardVerificationResult.fromMap({'failed': true});
      expect(result.failed, isTrue);
      expect(result.reward, isNull);
      expect(result.moreRewards, isEmpty);
    });

    test('defaults to failed when the flag is missing', () {
      final result = RewardVerificationResult.fromMap({});
      expect(result.failed, isTrue);
      expect(result.reward, isNull);
      expect(result.moreRewards, isEmpty);
    });
  });
}
