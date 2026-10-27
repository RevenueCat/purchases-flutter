import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('purchases_ui_flutter');
  final log = <MethodCall>[];
  late Completer<Object?> nativeReply;

  final entitlementJson = {
    'identifier': 'pro',
    'isActive': true,
    'willRenew': true,
    'latestPurchaseDate': '2026-01-01T00:00:00Z',
    'originalPurchaseDate': '2026-01-01T00:00:00Z',
    'productIdentifier': 'pro_monthly',
    'isSandbox': true,
  };
  final customerJson = {
    'entitlements': {
      'all': {'pro': entitlementJson},
      'active': {'pro': entitlementJson},
      'verification': 'NOT_REQUESTED',
    },
    'allPurchaseDates': <String, dynamic>{},
    'activeSubscriptions': ['pro_monthly'],
    'allPurchasedProductIdentifiers': ['pro_monthly'],
    'nonSubscriptionTransactions': <dynamic>[],
    'firstSeen': '2026-01-01T00:00:00Z',
    'originalAppUserId': 'user',
    'allExpirationDates': <String, dynamic>{},
    'requestDate': '2026-01-01T00:00:00Z',
  };
  final productJson = {
    'identifier': 'pro_monthly',
    'description': 'Pro',
    'title': 'Pro monthly',
    'price': 4.99,
    'priceString': r'$4.99',
    'currencyCode': 'USD',
  };

  setUp(() {
    nativeReply = Completer<Object?>();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) {
      log.add(call);
      return nativeReply.future;
    });
  });

  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
    log.clear();
  });

  Future<void> settle() => Future<void>.delayed(Duration.zero);

  test('sends the identifier with default parameters', () {
    RevenueCatUI.checkpoint('upgrade', (_) {});

    expect(log, <Matcher>[
      isMethodCall(
        'checkpoint',
        arguments: {
          'identifier': 'upgrade',
          'customVariables': null,
          'presentationMode': 'DEFAULT',
        },
      ),
    ]);
  });

  test('sends typed custom variables and the presentation mode', () {
    RevenueCatUI.checkpoint(
      'upgrade',
      (_) {},
      params: CheckpointParams(
        customVariables: {
          'name': CustomVariableValue.string('Taylor'),
          'level': CustomVariableValue.number(12),
          'premium': CustomVariableValue.boolean(false),
        },
        presentationMode: FlowPresentationMode.modalFullScreen,
      ),
    );

    expect(log, <Matcher>[
      isMethodCall(
        'checkpoint',
        arguments: {
          'identifier': 'upgrade',
          'customVariables': {
            'name': 'Taylor',
            'level': 12.0,
            'premium': false
          },
          'presentationMode': 'MODAL_FULL_SCREEN',
        },
      ),
    ]);
  });

  test('sends the sheet presentation mode', () {
    RevenueCatUI.checkpoint(
      'upgrade',
      (_) {},
      params:
          CheckpointParams(presentationMode: FlowPresentationMode.modalSheet),
    );

    expect(log.single.arguments['presentationMode'], 'MODAL_SHEET');
  });

  test('does not call back until the checkpoint passes', () async {
    var calls = 0;
    RevenueCatUI.checkpoint('upgrade', (_) => calls++);
    await settle();

    expect(calls, 0);
  });

  test('calls back once with the customer and the obtained flow', () async {
    final results = <CheckpointResult>[];
    RevenueCatUI.checkpoint('upgrade', results.add);

    nativeReply.complete({
      'customer': customerJson,
      'flow': {
        'obtainedEntitlements': [
          {'entitlementInfo': entitlementJson},
        ],
        'obtainedProducts': [
          {'product': productJson},
        ],
      },
    });
    await settle();

    expect(results, hasLength(1));
    final result = results.single;
    expect(result.customer.originalAppUserId, 'user');
    expect(result.customer.entitlements.active.keys, ['pro']);
    final flow = result.flow!;
    expect(flow.obtainedEntitlements.single.entitlementInfo.identifier, 'pro');
    expect(flow.obtainedProducts.single.product.identifier, 'pro_monthly');
  });

  test('passes a null flow when there was nothing to present', () async {
    final results = <CheckpointResult>[];
    RevenueCatUI.checkpoint('upgrade', results.add);

    nativeReply.complete({'customer': customerJson, 'flow': null});
    await settle();

    expect(results.single.flow, isNull);
    expect(results.single.customer.originalAppUserId, 'user');
  });

  test('stops reporting once the callback is removed', () async {
    var calls = 0;
    final remove = RevenueCatUI.checkpoint('upgrade', (_) => calls++);
    remove();
    remove();

    nativeReply.complete({'customer': customerJson, 'flow': null});
    await settle();

    expect(calls, 0);
  });

  test('does not call back or throw when the native call fails', () async {
    var calls = 0;
    RevenueCatUI.checkpoint('upgrade', (_) => calls++);

    nativeReply.completeError(
      PlatformException(code: 'UNSUPPORTED_OS_VERSION', message: 'iOS 15+'),
    );
    await settle();

    expect(calls, 0);
  });

  test('does not call back when the native result is malformed', () async {
    var calls = 0;
    RevenueCatUI.checkpoint('upgrade', (_) => calls++);

    nativeReply.complete({'unexpected': true});
    await settle();

    expect(calls, 0);
  });

  test('keeps reporting when the app callback throws', () async {
    final errors = <FlutterErrorDetails>[];
    final previous = FlutterError.onError;
    FlutterError.onError = errors.add;
    addTearDown(() => FlutterError.onError = previous);

    RevenueCatUI.checkpoint('upgrade', (_) => throw StateError('boom'));
    nativeReply.complete({'customer': customerJson, 'flow': null});
    await settle();

    expect(errors, hasLength(1));
    expect(errors.single.exception, isA<StateError>());
  });

  for (final platform in [TargetPlatform.macOS, TargetPlatform.fuchsia]) {
    test('throws without calling native on $platform', () {
      debugDefaultTargetPlatformOverride = platform;

      expect(
        () => RevenueCatUI.checkpoint('upgrade', (_) {}),
        throwsA(isA<UnsupportedError>()),
      );
      expect(log, isEmpty);
    });
  }

  test('works on iOS', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

    RevenueCatUI.checkpoint('upgrade', (_) {});

    expect(log, hasLength(1));
  });
}
