import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_ui_flutter/views/paywall_view.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'shows the platform view immediately when there is no transition',
    (tester) async {
      await tester.pumpWidget(const MaterialApp(home: PaywallView()));

      expect(find.byType(UiKitView), findsOneWidget);
    },
  );

  testWidgets('waits until the route transition finishes before embedding', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder:
              (context) => TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const PaywallView(),
                    ),
                  );
                },
                child: const Text('open'),
              ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pump();

    expect(find.byType(UiKitView), findsNothing);

    await tester.pumpAndSettle();

    expect(find.byType(UiKitView), findsOneWidget);
  });
}
