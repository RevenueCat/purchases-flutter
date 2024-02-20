// Imports the Flutter Driver API.
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  var userId = "integration-test-${DateTime.now().millisecondsSinceEpoch}";

  setUpAll(() {
    PurchasesConfiguration configuration = PurchasesConfiguration("appl_KhXKryBEHUWEdShrggQyjyzHKHW");
    configuration.appUserID = userId;
    configuration.entitlementVerificationMode = EntitlementVerificationMode.informational;
    Purchases.configure(configuration);
  });

  testWidgets('Configures without crashing', (WidgetTester tester) async {
    try {
      assert(await Purchases.appUserID == userId, true);
    } on PlatformException catch (e) {
      fail('there was an exception ' + e.toString());
    }
  });

  testWidgets('Purchaser info fetched successfully',
      (WidgetTester tester) async {
    try {
      assert((await Purchases.getCustomerInfo()).originalAppUserId == userId, true);
    } on PlatformException catch (e) {
      fail('there was an exception ' + e.toString());
    }
  });
}
