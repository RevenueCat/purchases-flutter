import 'package:flutter_test/flutter_test.dart';
import 'package:e2e/e2e.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

// Execute the following in the `example` folder run these tests:
// `flutter drive --driver=test_driver/purchases_flutter_e2e_test.dart ../test/purchases_flutter_e2e.dart`

void main() {
  E2EWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Can setup Purchases', (WidgetTester tester) async {
    final Future<void> future = Purchases.setup('apiKey', appUserId: 'cesar');
    expect(future, completes);
  });
}
