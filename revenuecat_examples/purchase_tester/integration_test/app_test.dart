// Imports the Flutter Driver API.
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() => Purchases.setup('api_key', appUserId: 'test-user'));

  testWidgets('Configures without crashing', (WidgetTester tester) async {
    try {
      expect(Purchases.appUserID != null, true);
    } on PlatformException catch (e) {
      fail('there was an exception ' + e.toString());
    }
  });

  testWidgets('Purchaser info fetched successfully',
      (WidgetTester tester) async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      expect(customerInfo != null, true);
    } on PlatformException catch (e) {
      fail('there was an exception ' + e.toString());
    }
  });
}
