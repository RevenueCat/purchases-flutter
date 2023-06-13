// Imports the Flutter Driver API.
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    PurchasesConfiguration configuration = PurchasesConfiguration("appl_KhXKryBEHUWEdShrggQyjyzHKHW");
    configuration.appUserID = "test-user";
    Purchases.configure(configuration);
  });

  testWidgets('Configures without crashing', (WidgetTester tester) async {
    try {
      assert(await Purchases.appUserID == "test-user", true);
    } on PlatformException catch (e) {
      fail('there was an exception ' + e.toString());
    }
  });

  testWidgets('Purchaser info fetched successfully',
      (WidgetTester tester) async {
    try {
      assert((await Purchases.getCustomerInfo()).originalAppUserId == "test-user", true);
    } on PlatformException catch (e) {
      fail('there was an exception ' + e.toString());
    }
  });
}
