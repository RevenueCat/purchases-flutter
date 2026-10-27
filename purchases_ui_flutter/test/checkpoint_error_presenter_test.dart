import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

void main() {
  testWidgets('presenter participates in parameter equality by identity',
      (tester) async {
    late BuildContext context;
    await tester.pumpWidget(MaterialApp(home: Builder(builder: (value) {
      context = value;
      return const SizedBox();
    })));
    final presenter = CheckpointErrorPresenter(
      context: context,
      present: (_) async {},
    );
    final a = CheckpointParams(errorPresenter: presenter);
    final b = CheckpointParams(errorPresenter: presenter);
    final c = CheckpointParams(
      errorPresenter: CheckpointErrorPresenter(
        context: context,
        present: (_) async {},
      ),
    );
    expect(a, b);
    expect(a.hashCode, b.hashCode);
    expect(a, isNot(c));
    expect(a, isNot(const CheckpointParams()));
    expect(a.toString(), isNot(contains(context.toString())));
  });

  test('error kinds are stable values with an unknown fallback', () {
    expect(CheckpointErrorKind.flowCouldNotBeShown.toString(),
        'flowCouldNotBeShown');
    expect(CheckpointErrorKind.flowActionFailed.toString(), 'flowActionFailed');
    expect(CheckpointErrorKind.flowResultSyncFailed.toString(),
        'flowResultSyncFailed');
    expect(CheckpointErrorKind.unknown.toString(), 'unknown');
    expect(const CheckpointParams().errorPresenter, isNull);
  });
}
