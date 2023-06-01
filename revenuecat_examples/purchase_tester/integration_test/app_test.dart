// Imports the Flutter Driver API.
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() => Purchases.setup('appl_KhXKryBEHUWEdShrggQyjyzHKHW', appUserId: 'test-user'));

  testWidgets('Configures without crashing', (WidgetTester tester) async {
    try {
      Purchases.appUserID;
    } on PlatformException catch (e) {
      fail('there was an exception ' + e.toString());
    }
  });

  testWidgets('Purchaser info fetched successfully',
      (WidgetTester tester) async {
    try {
      await Purchases.getCustomerInfo();
    } on PlatformException catch (e) {
      fail('there was an exception ' + e.toString());
    }
  });
}
