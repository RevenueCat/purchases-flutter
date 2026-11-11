import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('purchases_flutter');
  final calls = <MethodCall>[];
  final responses = <String, Map<String, dynamic>?>{};
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  setUp(() {
    messenger.setMockMethodCallHandler(channel, (call) async {
      calls.add(call);
      return responses[(call.arguments as Map)['adUnitId']];
    });
  });

  tearDown(() {
    messenger.setMockMethodCallHandler(channel, null);
    calls.clear();
    responses.clear();
  });

  test('passes ad unit IDs unchanged for exact native lookup', () async {
    responses['Unit-A'] = {
      'reward': {'type': 'virtual_currency', 'code': 'coins', 'amount': 10},
      'moreRewards': [],
    };
    responses['unit-a'] = {'reward': null, 'moreRewards': []};

    final rewards = await Purchases.getAdRewards('Unit-A');
    expect(rewards?.reward, isA<VirtualCurrencyRewardConfiguration>());
    expect(
      await Purchases.getAdRewards('unit-a'),
      ConfiguredAdRewards.noConfiguredReward,
    );
    expect(calls, [
      isMethodCall('getAdRewards', arguments: {'adUnitId': 'Unit-A'}),
      isMethodCall('getAdRewards', arguments: {'adUnitId': 'unit-a'}),
    ]);
  });

  test(
    'distinguishes unavailable configuration from resolved no reward',
    () async {
      expect(await Purchases.getAdRewards('unit'), isNull);
      responses['unit'] = {'reward': null, 'moreRewards': []};
      expect(
        await Purchases.getAdRewards('unit'),
        ConfiguredAdRewards.noConfiguredReward,
      );
    },
  );

  test('returns unavailable for an empty ID using native validation', () async {
    expect(await Purchases.getAdRewards(''), isNull);
    expect(
      calls.single,
      isMethodCall('getAdRewards', arguments: {'adUnitId': ''}),
    );
  });

  test('maps primary and ordered additional rewards from native', () async {
    responses['unit'] = {
      'reward': {
        'type': 'entitlement',
        'identifier': 'premium',
        'durationSeconds': 60.0,
      },
      'moreRewards': [
        {'type': 'future_reward'},
        {'type': 'virtual_currency', 'code': 'gems', 'amount': 2},
      ],
    };
    final rewards = await Purchases.getAdRewards('unit');
    expect(
      rewards?.reward,
      const EntitlementRewardConfiguration(
        identifier: 'premium',
        duration: Duration(minutes: 1),
      ),
    );
    expect(rewards?.moreRewards, [
      const UnsupportedAdRewardConfiguration(),
      const VirtualCurrencyRewardConfiguration(code: 'gems', amount: 2),
    ]);
  });

  test(
    'reads native configuration each time without a Dart result cache',
    () async {
      responses['unit'] = {
        'reward': {'type': 'virtual_currency', 'code': 'coins', 'amount': 10},
        'moreRewards': [],
      };
      expect((await Purchases.getAdRewards('unit'))?.reward, isNotNull);
      responses.remove('unit');
      expect(await Purchases.getAdRewards('unit'), isNull);
      expect(calls, hasLength(2));
    },
  );

  test(
    'leaves simultaneous calls to native configuration coordination',
    () async {
      responses['a'] = {'reward': null, 'moreRewards': []};
      final results = await Future.wait([
        Purchases.getAdRewards('a'),
        Purchases.getAdRewards('b'),
      ]);
      expect(results, [ConfiguredAdRewards.noConfiguredReward, null]);
      expect(calls, hasLength(2));
    },
  );

  test('propagates native platform errors', () async {
    messenger.setMockMethodCallHandler(channel, (call) async {
      throw PlatformException(code: '23', message: 'Unsupported platform');
    });
    await expectLater(
      Purchases.getAdRewards('unit'),
      throwsA(isA<PlatformException>().having((e) => e.code, 'code', '23')),
    );
  });
}
