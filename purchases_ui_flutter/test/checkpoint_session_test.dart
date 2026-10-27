import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/errors.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:purchases_ui_flutter/src/checkpoint_session.dart';

void main() {
  final calls = <MethodCall>[];
  final requests = <CheckpointErrorRequest>[];
  const channel = MethodChannel('com.revenuecat.purchasesui/Checkpoint/test');
  late BuildContext context;
  late CheckpointSession session;
  var passes = 0;
  var closes = 0;
  Future<void> Function(CheckpointErrorRequest)? present;
  Future<void> Function()? close;

  Future<void> event(String method, [Map<String, dynamic> args = const {}]) =>
      session.handleMethodCall(MethodCall(method, {'callId': 'test', ...args}));

  Map<String, dynamic> error(String id, {Object code = 2}) => {
        'requestId': id,
        'kind': 'flowActionFailed',
        'error': {'code': code, 'message': 'Failed'},
      };

  final result = {
    'flow': null,
    'customer': {
      'entitlements': {
        'all': <String, dynamic>{},
        'active': <String, dynamic>{},
        'verification': 'NOT_REQUESTED',
      },
      'allPurchaseDates': <String, dynamic>{},
      'activeSubscriptions': <String>[],
      'allPurchasedProductIdentifiers': <String>[],
      'nonSubscriptionTransactions': <dynamic>[],
      'firstSeen': '2026-01-01T00:00:00Z',
      'originalAppUserId': 'test',
      'allExpirationDates': <String, dynamic>{},
      'requestDate': '2026-01-01T00:00:00Z',
    },
  };

  Future<void> setup(WidgetTester tester,
      {bool waitsForFinished = true}) async {
    await tester.pumpWidget(MaterialApp(home: Builder(builder: (value) {
      context = value;
      return const SizedBox();
    })));
    session = CheckpointSession(
      callId: 'test',
      onPassed: (_) => passes++,
      errorContext: () => context,
      presentError: (request) async {
        requests.add(request);
        await present?.call(request);
      },
      closeHost: () async {
        closes++;
        await close?.call();
      },
      waitsForFinished: waitsForFinished,
    );
  }

  setUp(() {
    calls.clear();
    requests.clear();
    passes = closes = 0;
    present = null;
    close = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
      calls.add(call);
      return null;
    });
  });
  tearDown(() {
    session.cancel();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  testWidgets('error replies immediately; acknowledgement waits for presenter',
      (tester) async {
    final pending = Completer<void>();
    present = (_) => pending.future;
    await setup(tester);
    await event('error', error('one'));
    await tester.pump();
    expect(requests, hasLength(1));
    expect(calls, isEmpty);
    expect(requests.single.context, context);
    expect(requests.single.kind, CheckpointErrorKind.flowActionFailed);
    pending.complete();
    await tester.pump();
    expect(calls.single.method, 'completeError');
    expect(calls.single.arguments, {'requestId': 'one'});
  });

  testWidgets('explicit and automatic completion acknowledge once',
      (tester) async {
    present = (request) async {
      await request.complete();
      await request.complete();
    };
    await setup(tester);
    await event('error', error('one'));
    await tester.pump();
    expect(calls.where((e) => e.method == 'completeError'), hasLength(1));
  });

  testWidgets('duplicates are ignored and presenters run sequentially',
      (tester) async {
    final pending = Completer<void>();
    present = (_) => pending.future;
    await setup(tester);
    await event('error', error('one'));
    await event('error', error('one'));
    await event('error', error('two'));
    await tester.pump();
    expect(requests.map((e) => e.requestId), ['one']);
    pending.complete();
    await tester.pump();
    expect(requests.map((e) => e.requestId), ['one', 'two']);
    expect(calls, hasLength(2));
  });

  testWidgets('presenter failure is reported and acknowledged once',
      (tester) async {
    present = (_) async => throw StateError('app presenter');
    await setup(tester);
    await event('error', error('one'));
    await tester.pump();
    expect(tester.takeException(), isStateError);
    expect(calls.single.method, 'completeError');
  });

  testWidgets('passed waits for finished and host disposal, and delivers once',
      (tester) async {
    final disposed = Completer<void>();
    close = () => disposed.future;
    await setup(tester);
    await event('passed', {'result': result});
    await event('passed', {'result': result});
    expect(passes, 0);
    await event('finished');
    await event('finished');
    await tester.pump();
    expect(closes, 1);
    expect(passes, 0);
    disposed.complete();
    await tester.pump();
    expect(passes, 1);
  });

  testWidgets('Android passed terminates without a native finished signal',
      (tester) async {
    await setup(tester, waitsForFinished: false);
    await event('passed', {'result': result});
    await tester.pump();
    expect(passes, 1);
    expect(closes, 1);
  });

  testWidgets('cancel suppresses pending callback and late acknowledgements',
      (tester) async {
    final pending = Completer<void>();
    final disposed = Completer<void>();
    present = (_) => pending.future;
    close = () => disposed.future;
    await setup(tester);
    await event('error', error('one'));
    await tester.pump();
    await event('passed', {'result': result});
    await event('finished');
    session.cancel();
    session.cancel();
    pending.complete();
    disposed.complete();
    await tester.pump();
    await requests.single.complete();
    expect(passes, 0);
    expect(calls.where((e) => e.method == 'completeError'), isEmpty);
    expect(closes, 1);
  });

  testWidgets('foreign calls ignored; malformed events cancel only this call',
      (tester) async {
    await setup(tester);
    await session.handleMethodCall(MethodCall('error', {
      'callId': 'other',
      ...error('foreign'),
    }));
    await event('futureEvent');
    expect(requests, isEmpty);
    expect(tester.takeException(), isNull);
    await event('error', {'requestId': 'broken'});
    await tester.pump();
    expect(tester.takeException(), isFormatException);
    expect(calls.single.method, 'cancel');
    expect(closes, 1);
  });

  testWidgets('unknown kind and invalid error codes are safe', (tester) async {
    await setup(tester);
    for (final code in [-1, 99999, 'invalid']) {
      await event('error', {
        ...error('$code', code: code),
        'kind': 'newNativeKind',
      });
    }
    await tester.pump();
    expect(requests, hasLength(3));
    for (final request in requests) {
      expect(request.kind, CheckpointErrorKind.unknown);
      expect(request.error.code, PurchasesErrorCode.unknownError);
      expect(request.error.underlyingErrorMessage, '');
      expect(request.error.readableErrorCode, '');
    }
  });
}
