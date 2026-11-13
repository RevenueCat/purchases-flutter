import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

void main() {
  const currency = VirtualCurrencyRewardConfiguration(
    code: 'coins',
    amount: 10,
  );
  const entitlement = EntitlementRewardConfiguration(
    identifier: 'premium',
    duration: Duration(minutes: 30),
  );

  group('AdRewardConfiguration.fromMap', () {
    test('maps virtual currency', () {
      expect(
        AdRewardConfiguration.fromMap(const {
          'type': 'virtual_currency',
          'code': 'coins',
          'amount': 10,
        }),
        currency,
      );
    });

    test('accepts an integer amount encoded as a platform double', () {
      final reward = AdRewardConfiguration.fromMap(const {
        'type': 'virtual_currency',
        'code': 'coins',
        'amount': 10.0,
      }) as VirtualCurrencyRewardConfiguration;
      expect(reward.amount, 10);
    });

    test('maps entitlement seconds to Duration', () {
      expect(
        AdRewardConfiguration.fromMap(const {
          'type': 'entitlement',
          'identifier': 'premium',
          'durationSeconds': 1800,
        }),
        entitlement,
      );
    });

    test('accepts duration seconds encoded as a platform double', () {
      final reward = AdRewardConfiguration.fromMap(const {
        'type': 'entitlement',
        'identifier': 'premium',
        'durationSeconds': 1800.0,
      }) as EntitlementRewardConfiguration;
      expect(reward.duration, const Duration(minutes: 30));
    });

    test('preserves fractional seconds through microseconds', () {
      final reward = AdRewardConfiguration.fromMap(const {
        'type': 'entitlement',
        'identifier': 'premium',
        'durationSeconds': 1.125,
      }) as EntitlementRewardConfiguration;
      expect(reward.duration, const Duration(microseconds: 1125000));
    });

    for (final type in ['unsupported_reward', 'future_reward']) {
      test('represents $type as unsupported', () {
        expect(
          AdRewardConfiguration.fromMap({'type': type, 'futureField': true}),
          const UnsupportedAdRewardConfiguration(),
        );
      });
    }
  });

  group('ConfiguredAdRewards', () {
    test('noConfiguredReward exposes no primary or additional rewards', () {
      expect(ConfiguredAdRewards.noConfiguredReward.reward, isNull);
      expect(ConfiguredAdRewards.noConfiguredReward.moreRewards, isEmpty);
    });

    test('maps explicit no configured reward from native', () {
      expect(
        ConfiguredAdRewards.fromMap(const {'reward': null, 'moreRewards': []}),
        ConfiguredAdRewards.noConfiguredReward,
      );
    });

    test('accepts omitted null primary and empty additional rewards', () {
      expect(
        ConfiguredAdRewards.fromMap(const {}),
        ConfiguredAdRewards.noConfiguredReward,
      );
    });

    test('keeps primary and ordered additional rewards including unknowns', () {
      final rewards = ConfiguredAdRewards.fromMap(const {
        'reward': {'type': 'virtual_currency', 'code': 'coins', 'amount': 10},
        'moreRewards': [
          {'type': 'future_reward'},
          {
            'type': 'entitlement',
            'identifier': 'premium',
            'durationSeconds': 1800,
          },
          {'type': 'virtual_currency', 'code': 'gems', 'amount': 2},
        ],
      });
      expect(rewards.reward, currency);
      expect(rewards.moreRewards, [
        const UnsupportedAdRewardConfiguration(),
        entitlement,
        const VirtualCurrencyRewardConfiguration(code: 'gems', amount: 2),
      ]);
    });

    test('keeps an unknown primary instead of reporting no reward', () {
      final rewards = ConfiguredAdRewards.fromMap(const {
        'reward': {'type': 'future_reward'},
        'moreRewards': [],
      });
      expect(rewards.reward, const UnsupportedAdRewardConfiguration());
      expect(rewards, isNot(ConfiguredAdRewards.noConfiguredReward));
    });

    test('rejects additional rewards without a primary', () {
      expect(
        () => ConfiguredAdRewards.fromMap(const {
          'reward': null,
          'moreRewards': [
            {'type': 'virtual_currency', 'code': 'coins', 'amount': 10},
          ],
        }),
        throwsFormatException,
      );
    });

    test('copies and protects additional rewards', () {
      final additional = <AdRewardConfiguration>[entitlement];
      final rewards = ConfiguredAdRewards(
        reward: currency,
        moreRewards: additional,
      );
      additional.clear();
      expect(rewards.moreRewards, [entitlement]);
      expect(rewards.moreRewards.clear, throwsUnsupportedError);
      expect(
        () => ConfiguredAdRewards.noConfiguredReward.moreRewards.add(currency),
        throwsUnsupportedError,
      );
    });

    test('compares values including reward order', () {
      final rewards = ConfiguredAdRewards(
        reward: currency,
        moreRewards: const [entitlement, currency],
      );
      expect(
        rewards,
        ConfiguredAdRewards(
          reward: currency,
          moreRewards: const [entitlement, currency],
        ),
      );
      expect(
        rewards,
        isNot(
          ConfiguredAdRewards(
            reward: currency,
            moreRewards: const [currency, entitlement],
          ),
        ),
      );
    });
  });
}
