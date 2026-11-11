import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const mainChannel = MethodChannel('purchases_ui_flutter');
  const callbacks = MethodChannel('com.revenuecat.purchasesui/Checkpoints');
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  final starts = <MethodCall>[];
  final commands = <MethodCall>[];
  final removers = <void Function()>[];
  final replies = <Completer<Object?>>[];
  Future<void> settle() => Future<void>.delayed(Duration.zero);

  String start(
      {PaywallPresenter? presenter,
      CheckpointErrorDialogFactory? factory,
      bool native = false}) {
    removers.add(RevenueCatUI.checkpoint('upgrade', (_) {},
        params: CheckpointParams(
          paywallPresenter: presenter,
          errorDialogFactory: factory,
          useNativePaywallPresenter: native,
        )));
    return starts.last.arguments['callId'] as String;
  }

  Future<void> event(String method, String callId,
      {String requestId = 'request', Object? params, Object? error}) async {
    final done = Completer<void>();
    messenger.handlePlatformMessage(
        callbacks.name,
        callbacks.codec.encodeMethodCall(
          MethodCall(method, {
            'callId': callId,
            'requestId': requestId,
            if (params != null) 'params': params,
            if (error != null) 'error': error
          }),
        ),
        (_) => done.complete());
    await done.future;
    await settle();
  }

  final paywallParams = {
    'checkpointIdentifier': 'upgrade',
    'customVariables': {'name': 'Taylor', 'level': 12, 'premium': true},
    'presentationMode': 'MODAL_SHEET',
    'offering': {
      'identifier': 'pro',
      'serverDescription': 'Pro',
      'metadata': <String, Object>{},
      'availablePackages': <Object>[]
    },
  };
  const error = {
    'kind': 'flowResultSyncFailed',
    'code': 10,
    'message': 'Offline'
  };

  setUp(() {
    messenger.setMockMethodCallHandler(mainChannel, (call) {
      starts.add(call);
      final reply = Completer<Object?>();
      replies.add(reply);
      return reply.future;
    });
    messenger.setMockMethodCallHandler(callbacks, (call) async {
      if (call.method != 'initialize') commands.add(call);
      return null;
    });
  });
  tearDown(() async {
    for (final remove in removers) {
      remove();
    }
    RevenueCatUI.setPaywallPresenter(null);
    await settle();
    messenger.setMockMethodCallHandler(mainChannel, null);
    messenger.setMockMethodCallHandler(callbacks, null);
    starts.clear();
    commands.clear();
    removers.clear();
    replies.clear();
  });

  test('routes typed paywall params and completes at most once', () async {
    PaywallPresentationParams? received;
    final id = start(presenter: (params, complete) {
      received = params;
      complete(PaywallPresentationResult.continued);
      complete(PaywallPresentationResult.navigatedBack);
    });
    expect(starts.single.arguments['useCustomPaywallPresenter'], true);
    await event('onPaywallPresentation', id, params: paywallParams);
    expect(received!.checkpointIdentifier, 'upgrade');
    expect(received!.offering.identifier, 'pro');
    expect(received!.presentationMode, FlowPresentationMode.modalSheet);
    expect(received!.customVariables, {
      'name': const CustomVariableValue.string('Taylor'),
      'level': const CustomVariableValue.number(12),
      'premium': const CustomVariableValue.boolean(true)
    });
    expect(
        commands
            .where((c) => c.method == 'completePaywallPresentation')
            .single
            .arguments,
        {'requestId': 'request', 'result': 'CONTINUED'});
  });

  test('captures global presenter and supports per-call and native overrides',
      () async {
    final called = <String>[];
    RevenueCatUI.setPaywallPresenter((_, complete) {
      called.add('first');
      complete(PaywallPresentationResult.closed);
    });
    final first = start();
    RevenueCatUI.setPaywallPresenter((_, complete) {
      called.add('second');
      complete(PaywallPresentationResult.closed);
    });
    final second = start(presenter: (_, complete) {
      called.add('override');
      complete(PaywallPresentationResult.closed);
    });
    start(native: true);
    expect(starts.last.arguments['useCustomPaywallPresenter'], false);
    await event('onPaywallPresentation', first, params: paywallParams);
    await event('onPaywallPresentation', second,
        requestId: 'second', params: paywallParams);
    expect(called, ['first', 'override']);
    expect(commands.every((c) => c.arguments['result'] == 'CLOSED'), true);
  });

  for (final asynchronous in [false, true]) {
    test('backs out when ${asynchronous ? 'async' : 'sync'} presenter throws',
        () async {
      final id = start(
          presenter: asynchronous
              ? (_, __) async {
                  throw StateError('boom');
                }
              : (_, __) {
                  throw StateError('boom');
                });
      await event('onPaywallPresentation', id, params: paywallParams);
      expect(commands.first.arguments,
          {'requestId': 'request', 'result': 'NAVIGATED_BACK'});
    });
  }

  test('a returned future does not complete the paywall', () async {
    final id = start(presenter: (_, __) async {});
    await event('onPaywallPresentation', id, params: paywallParams);
    expect(commands, isEmpty);
  });

  test('malformed paywall params back out without invoking presenter',
      () async {
    var called = false;
    final id = start(presenter: (_, __) {
      called = true;
    });
    await event('onPaywallPresentation', id, params: {'bad': true});
    expect(called, false);
    expect(commands.first.arguments['result'], 'NAVIGATED_BACK');
  });

  test('removal cancels queued presentations and defaults late errors',
      () async {
    var called = false;
    final id = start(
        presenter: (_, __) {
          called = true;
        },
        factory: (_) => const CheckpointErrorDialogOutcome.suppress());
    removers.single();
    removers.single();
    await event('onPaywallPresentation', id, params: paywallParams);
    await event('onErrorDialogRequested', id, error: error);
    expect(called, false);
    expect(
        commands.where((c) => c.method == 'detachCheckpoint').single.arguments,
        {'callId': id, 'activePaywallRequestId': null});
    expect(
        commands
            .where((c) => c.method == 'completePaywallPresentation')
            .single
            .arguments['result'],
        'NAVIGATED_BACK');
    expect(
        commands
            .where((c) => c.method == 'resolveErrorDialog')
            .single
            .arguments['outcome'],
        {'type': 'useDefault'});
  });

  test('already presented paywall can complete after callback removal',
      () async {
    late void Function(PaywallPresentationResult) complete;
    final id = start(presenter: (_, callback) {
      complete = callback;
    });
    await event('onPaywallPresentation', id, params: paywallParams);
    removers.single();
    expect(commands.last.arguments,
        {'callId': id, 'activePaywallRequestId': 'request'});
    complete(PaywallPresentationResult.continued);
    await settle();
    expect(commands.last.arguments,
        {'requestId': 'request', 'result': 'CONTINUED'});
  });

  test('uses typed async error factory and maps primary button title',
      () async {
    CheckpointError? received;
    final id = start(factory: (error) async {
      received = error;
      return const CheckpointErrorDialogOutcome.show(CheckpointErrorDialog(
          message: 'Try again', primaryButtonTitle: 'OK'));
    });
    expect(starts.single.arguments['hasErrorDialogFactory'], true);
    await event('onErrorDialogRequested', id, error: error);
    expect(received!.kind, CheckpointErrorKind.flowResultSyncFailed);
    expect(received!.code, 10);
    expect(received!.message, 'Offline');
    expect(commands.single.arguments, {
      'requestId': 'request',
      'outcome': {
        'type': 'show',
        'dialog': {'message': 'Try again', 'buttonTitle': 'OK'}
      }
    });
  });

  for (final entry in {
    'useDefault': const CheckpointErrorDialogOutcome.useDefault(),
    'suppress': const CheckpointErrorDialogOutcome.suppress(),
  }.entries) {
    test('resolves ${entry.key} factory outcome', () async {
      final id = start(factory: (_) => entry.value);
      await event('onErrorDialogRequested', id, error: error);
      expect(commands.single.arguments['outcome'], {'type': entry.key});
    });
  }

  for (final invalid in [false, true]) {
    test(
        'falls back to default when factory ${invalid ? 'returns empty content' : 'throws'}',
        () async {
      final id = start(factory: (_) async {
        if (!invalid) throw StateError('boom');
        return const CheckpointErrorDialogOutcome.show(
            CheckpointErrorDialog(message: '', primaryButtonTitle: 'OK'));
      });
      await event('onErrorDialogRequested', id, error: error);
      expect(commands.single.arguments['outcome'], {'type': 'useDefault'});
    });
  }

  test('removal while factory is pending prevents a late resolution', () async {
    final response = Completer<CheckpointErrorDialogOutcome>();
    final invoked = Completer<void>();
    final id = start(factory: (_) {
      invoked.complete();
      return response.future;
    });
    final pendingEvent = event('onErrorDialogRequested', id, error: error);
    await invoked.future;
    removers.single();
    response.complete(const CheckpointErrorDialogOutcome.suppress());
    await pendingEvent;
    expect(commands.map((c) => c.method), ['detachCheckpoint']);
  });

  test('concurrent calls keep their error factories separate', () async {
    final first =
        start(factory: (_) => const CheckpointErrorDialogOutcome.suppress());
    final second =
        start(factory: (_) => const CheckpointErrorDialogOutcome.useDefault());
    expect(first, isNot(second));
    await event('onErrorDialogRequested', second,
        requestId: 'two', error: error);
    await event('onErrorDialogRequested', first,
        requestId: 'one', error: error);
    expect(commands.map((c) => c.arguments), [
      {
        'requestId': 'two',
        'outcome': {'type': 'useDefault'}
      },
      {
        'requestId': 'one',
        'outcome': {'type': 'suppress'}
      },
    ]);
  });

  test('native startup error releases callbacks and defaults late requests',
      () async {
    final id =
        start(factory: (_) => const CheckpointErrorDialogOutcome.suppress());
    replies.single.completeError(PlatformException(code: 'NOT_CONFIGURED'));
    await settle();
    await event('onErrorDialogRequested', id, error: error);
    expect(commands.last.arguments['outcome'], {'type': 'useDefault'});
  });
}
