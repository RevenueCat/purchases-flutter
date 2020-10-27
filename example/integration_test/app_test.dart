// Imports the Flutter Driver API.
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    setUpAll(() async {
      print("setupAll");
      const apiKey = String.fromEnvironment("API_KEY", defaultValue: null);
      await Purchases.setup(apiKey, appUserId: "test-user");
    });

  test("Configures successfully", () async {
    expect(Purchases.appUserID != null, true);
  });

  test("Purchaser info fetched successfully", () async {
    PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
    expect(purchaserInfo != null, false);
  });
}
