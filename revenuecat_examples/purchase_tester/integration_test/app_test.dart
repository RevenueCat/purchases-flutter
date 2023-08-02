// Imports the Flutter Driver API.
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  var uuid = UniqueKey().toString();

  setUpAll(() {
    PurchasesConfiguration configuration = PurchasesConfiguration("appl_KhXKryBEHUWEdShrggQyjyzHKHW");
    configuration.appUserID = uuid;
    Purchases.configure(configuration);
  });

  testWidgets('Configures without crashing', (WidgetTester tester) async {
    try {
      assert(await Purchases.appUserID == uuid, true);
    } on PlatformException catch (e) {
      fail('there was an exception ' + e.toString());
    }
  });

  testWidgets('Purchaser info fetched successfully',
      (WidgetTester tester) async {
    try {
      assert((await Purchases.getCustomerInfo()).originalAppUserId == uuid, true);
    } on PlatformException catch (e) {
      fail('there was an exception ' + e.toString());
    }
  });
}
