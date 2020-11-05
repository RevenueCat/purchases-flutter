// Imports the Flutter Driver API.
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    setUpAll(() async {
      await Purchases.setup("api_key", appUserId: "test-user");
    });

  test("Configures without crashing", () async {
    expect(Purchases.appUserID != null, true);
  });

  test("Purchaser info fetched successfully", () async {
    PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
    expect(purchaserInfo != null, false);
  });
}
