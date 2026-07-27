import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/reward_verification_result.dart';

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
      expect(result.reward?.type, 'virtual_currency');
      expect(result.reward?.code, 'GOLD');
      expect(result.reward?.amount, 100);
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
      expect(result.reward?.identifier, 'premium');
      expect(result.moreRewards.length, 2);
      expect(result.moreRewards[0].code, 'GOLD');
      expect(result.moreRewards[1].code, 'GEMS');
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
