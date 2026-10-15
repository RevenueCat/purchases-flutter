import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:purchases_ui_flutter/src/android_platform_view.dart';

// ignore_for_file: deprecated_member_use

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final platformViewCalls = <MethodCall>[];

  setUp(() {
    platformViewCalls.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      SystemChannels.platform_views,
      (call) async {
        platformViewCalls.add(call);
        final arguments = call.arguments as Map<dynamic, dynamic>?;
        switch (call.method) {
          case 'create':
            return arguments?['hybrid'] == true ? null : 0;
          case 'resize':
            return <String, dynamic>{
              'width': arguments?['width'],
              'height': arguments?['height'],
            };
          default:
            return null;
        }
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform_views, null);
  });

  Future<void> expectUsesMode(
    WidgetTester tester,
    AndroidPlatformViewMode mode,
  ) async {
    platformViewCalls.clear();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: buildAndroidPlatformViewLink(
            viewType: 'test-view',
            creationParams: const {},
            mode: mode,
            onPlatformViewCreated: (_) {},
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(PlatformViewLink), findsOneWidget);

    final createCall = platformViewCalls.singleWhere(
      (call) => call.method == 'create',
    );
    // 'hybrid' is how the engine flags expensive (Hybrid Composition) views.
    final creationParams = createCall.arguments as Map<dynamic, dynamic>;
    expect(
      creationParams['hybrid'],
      mode == AndroidPlatformViewMode.hybridComposition ? isTrue : isNull,
    );
  }

  testWidgets('builds Android platform views with either mode', (tester) async {
    await expectUsesMode(
      tester,
      AndroidPlatformViewMode.textureLayerHybridComposition,
    );
    await expectUsesMode(tester, AndroidPlatformViewMode.hybridComposition);
    await expectUsesMode(
      tester,
      AndroidPlatformViewMode.textureLayerHybridComposition,
    );
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });

  test('public views default to Texture Layer Hybrid Composition', () {
    expect(
      const PaywallView().androidPlatformViewMode,
      AndroidPlatformViewMode.textureLayerHybridComposition,
    );
    expect(
      OriginalTemplatePaywallFooterView(
        contentCreator: (_) => const SizedBox.shrink(),
      ).androidPlatformViewMode,
      AndroidPlatformViewMode.textureLayerHybridComposition,
    );
    expect(
      PaywallFooterView(
        contentCreator: (_) => const SizedBox.shrink(),
      ).androidPlatformViewMode,
      AndroidPlatformViewMode.textureLayerHybridComposition,
    );
    expect(
      const CustomerCenterView().androidPlatformViewMode,
      AndroidPlatformViewMode.textureLayerHybridComposition,
    );
  });

  test('public views accept Hybrid Composition', () {
    const mode = AndroidPlatformViewMode.hybridComposition;

    expect(
      const PaywallView(androidPlatformViewMode: mode).androidPlatformViewMode,
      mode,
    );
    expect(
      OriginalTemplatePaywallFooterView(
        androidPlatformViewMode: mode,
        contentCreator: (_) => const SizedBox.shrink(),
      ).androidPlatformViewMode,
      mode,
    );
    expect(
      PaywallFooterView(
        androidPlatformViewMode: mode,
        contentCreator: (_) => const SizedBox.shrink(),
      ).androidPlatformViewMode,
      mode,
    );
    expect(
      const CustomerCenterView(
        androidPlatformViewMode: mode,
      ).androidPlatformViewMode,
      mode,
    );
  });
}
