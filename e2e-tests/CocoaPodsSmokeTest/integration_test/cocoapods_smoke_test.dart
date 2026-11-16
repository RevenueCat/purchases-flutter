import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Git-sourced CocoaPods configure and call the native bridge',
      (WidgetTester tester) async {
    const appUserID = 'git-cocoapods-smoke-test';
    final configuration = PurchasesConfiguration('appl_cocoapods_smoke_test')
      ..appUserID = appUserID;

    await Purchases.configure(configuration);

    expect(await Purchases.appUserID, appUserID);
    expect(await Purchases.isAnonymous, isFalse);
  });
}
