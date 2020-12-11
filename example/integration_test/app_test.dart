// Imports the Flutter Driver API.
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Purchases.setup("api_key", appUserId: "test-user");
  });

  testWidgets("Configures without crashing", (WidgetTester tester) async {
    try {
      expect(Purchases.appUserID != null, true);
    } on PlatformException catch (e) {
      fail("there was an exception " + e.toString());
    }
  });

  testWidgets("Purchaser info fetched successfully",
      (WidgetTester tester) async {
    try {
      PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
      expect(purchaserInfo != null, true);
    } on PlatformException catch (e) {
      fail("there was an exception " + e.toString());
    }
  });
}
