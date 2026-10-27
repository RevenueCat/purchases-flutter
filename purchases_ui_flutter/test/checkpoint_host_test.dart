import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

void main() {
  const mainChannel = MethodChannel('purchases_ui_flutter');
  final calls = <MethodCall>[];
  final nativeCalls = <MethodCall>[];
  late BuildContext context;
  late NavigatorState navigator;
  late String callId;
  var failHide = false;
  void Function()? remove;

  Future<void> event(String method, Map<String, dynamic> args) async {
    final reply = Completer<void>();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .handlePlatformMessage(
      'com.revenuecat.purchasesui/Checkpoint/$callId',
      const StandardMethodCodec().encodeMethodCall(
        MethodCall(method, {'callId': callId, ...args}),
      ),
      (_) => reply.complete(),
    );
    await reply.future;
  }

  Future<void> setup(WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Builder(builder: (value) {
      context = value;
      navigator = Navigator.of(value);
      return const Scaffold(body: Text('Original app'));
    })));
  }

  setUp(() {
    calls.clear();
    nativeCalls.clear();
    remove = null;
    failHide = false;
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(mainChannel, (call) async {
      calls.add(call);
      if (call.method == 'isCheckpointErrorPresenterAvailable') return true;
      if (call.method == 'startCheckpointWithErrorPresenter') {
        callId = (call.arguments as Map)['callId'] as String;
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
          MethodChannel('com.revenuecat.purchasesui/Checkpoint/$callId'),
          (call) async {
            nativeCalls.add(call);
            if (failHide && call.method == 'hideErrorHost') {
              throw MissingPluginException('Native activity detached');
            }
            return null;
          },
        );
      }
      return null;
    });
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform_views, (call) async {
      if (call.method == 'create') {
        final args = call.arguments as Map;
        final creation = const StandardMessageCodec().decodeMessage(
            ByteData.sublistView(args['params'] as Uint8List)) as Map;
        callId = creation['callId'] as String;
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
          MethodChannel('com.revenuecat.purchasesui/Checkpoint/$callId'),
          (call) async {
            nativeCalls.add(call);
            if (failHide && call.method == 'hideErrorHost') {
              throw MissingPluginException('Native activity detached');
            }
            return null;
          },
        );
      }
      return null;
    });
  });

  tearDown(() {
    remove?.call();
    debugDefaultTargetPlatformOverride = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(mainChannel, null);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform_views, null);
  });

  testWidgets('iOS owns a sheet, starts after view creation and finishes it',
      (tester) async {
    await setup(tester);
    remove = RevenueCatUI.checkpoint('upgrade', (_) {},
        params: CheckpointParams(
          errorPresenter:
              CheckpointErrorPresenter(context: context, present: (_) async {}),
        ));
    await tester.pumpAndSettle();
    expect(find.byType(UiKitView), findsOneWidget);
    expect(find.byType(BottomSheet), findsOneWidget);
    expect(nativeCalls.where((e) => e.method == 'start'), hasLength(1));
    await event('finished', {});
    await tester.pumpAndSettle();
    expect(find.byType(UiKitView), findsNothing);
    expect(find.text('Original app'), findsOneWidget);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('full-screen host shows app error UI and acknowledges dismissal',
      (tester) async {
    await setup(tester);
    remove = RevenueCatUI.checkpoint('upgrade', (_) {},
        params: CheckpointParams(
          presentationMode: FlowPresentationMode.modalFullScreen,
          errorPresenter: CheckpointErrorPresenter(
              context: context,
              present: (request) async {
                await showDialog<void>(
                    context: request.context,
                    useRootNavigator: false,
                    builder: (context) =>
                        AlertDialog(title: const Text('App error'), actions: [
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Dismiss')),
                        ]));
              }),
        ));
    await tester.pumpAndSettle();
    expect(find.byType(BottomSheet), findsNothing);
    await event('error', {
      'requestId': 'one',
      'kind': 'flowActionFailed',
      'error': {'code': 2, 'message': 'failed'}
    });
    await tester.pumpAndSettle();
    expect(find.text('App error'), findsOneWidget);
    expect(nativeCalls.where((e) => e.method == 'completeError'), isEmpty);
    await tester.tap(find.text('Dismiss'));
    await tester.pumpAndSettle();
    expect(nativeCalls.where((e) => e.method == 'completeError'), hasLength(1));
    remove!();
    await tester.pumpAndSettle();
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets(
      'cancel removes only the owned route, preserving a newer app route',
      (tester) async {
    await setup(tester);
    remove = RevenueCatUI.checkpoint('upgrade', (_) {},
        params: CheckpointParams(
          errorPresenter:
              CheckpointErrorPresenter(context: context, present: (_) async {}),
        ));
    await tester.pumpAndSettle();
    navigator.push(MaterialPageRoute<void>(
        builder: (_) => const Scaffold(body: Text('New app route'))));
    await tester.pumpAndSettle();
    remove!();
    remove!();
    await tester.pumpAndSettle();
    expect(find.text('New app route'), findsOneWidget);
    expect(find.byType(UiKitView, skipOffstage: false), findsNothing);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('immediate cancellation prevents a late iOS host start',
      (tester) async {
    await setup(tester);
    remove = RevenueCatUI.checkpoint('upgrade', (_) {},
        params: CheckpointParams(
          errorPresenter:
              CheckpointErrorPresenter(context: context, present: (_) async {}),
        ));
    remove!();
    await tester.pumpAndSettle();
    expect(find.byType(UiKitView), findsNothing);
    expect(nativeCalls.where((e) => e.method == 'start'), isEmpty);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('Android starts SDK flow and hosts only its errors',
      (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    await setup(tester);
    remove = RevenueCatUI.checkpoint('upgrade', (_) {},
        params: CheckpointParams(
          errorPresenter: CheckpointErrorPresenter(
              context: context,
              present: (request) async {
                await showDialog<void>(
                    context: request.context,
                    useRootNavigator: false,
                    builder: (context) => AlertDialog(
                            title: const Text('Android app error'),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Dismiss')),
                            ]));
              }),
        ));
    await tester.pumpAndSettle();
    expect(calls.single.method, 'startCheckpointWithErrorPresenter');
    expect(find.byType(UiKitView), findsNothing);
    expect(find.text('Original app'), findsOneWidget);
    await event('error', {
      'requestId': 'one',
      'kind': 'flowActionFailed',
      'error': {'code': 2, 'message': 'failed'}
    });
    await tester.pumpAndSettle();
    expect(find.text('Android app error'), findsOneWidget);
    expect(find.text('Original app'), findsNothing);
    expect(nativeCalls.any((e) => e.method == 'showErrorHost'), isTrue);
    await tester.tap(find.text('Dismiss'));
    await tester.pumpAndSettle();
    expect(find.text('Original app'), findsOneWidget);
    expect(
        nativeCalls.map((e) => e.method),
        containsAllInOrder(
            ['showErrorHost', 'hideErrorHost', 'completeError']));
    remove!();
    await tester.pumpAndSettle();
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('Android activity detach removes an open app error route',
      (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    await setup(tester);
    remove = RevenueCatUI.checkpoint('upgrade', (_) {},
        params: CheckpointParams(
          errorPresenter: CheckpointErrorPresenter(
              context: context,
              present: (request) async {
                await showDialog<void>(
                    context: request.context,
                    useRootNavigator: false,
                    builder: (_) =>
                        const AlertDialog(title: Text('Pending error')));
              }),
        ));
    await tester.pumpAndSettle();
    await event('error', {
      'requestId': 'one',
      'kind': 'flowActionFailed',
      'error': {'code': 2}
    });
    await tester.pumpAndSettle();
    expect(find.text('Pending error'), findsOneWidget);
    failHide = true;
    await event('finished', {});
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.text('Pending error'), findsNothing);
    expect(find.text('Original app'), findsOneWidget);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('system back respects an app error dialog pop guard',
      (tester) async {
    await setup(tester);
    remove = RevenueCatUI.checkpoint('upgrade', (_) {},
        params: CheckpointParams(
          errorPresenter: CheckpointErrorPresenter(
              context: context,
              present: (request) async {
                await showDialog<void>(
                    context: request.context,
                    useRootNavigator: false,
                    builder: (_) => const PopScope(
                        canPop: false,
                        child: AlertDialog(title: Text('Protected error'))));
              }),
        ));
    await tester.pumpAndSettle();
    await event('error', {
      'requestId': 'one',
      'kind': 'flowActionFailed',
      'error': {'code': 2}
    });
    await tester.pumpAndSettle();
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text('Protected error'), findsOneWidget);
    expect(nativeCalls.where((e) => e.method == 'completeError'), isEmpty);
    remove!();
    await tester.pumpAndSettle();
    debugDefaultTargetPlatformOverride = null;
  });
}
