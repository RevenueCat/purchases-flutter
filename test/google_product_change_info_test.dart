import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
      'Test GoogleProrationMode.immediateWithTimeProration value matches Billing Client with 1',
      () async {
    expect(GoogleProrationMode.immediateWithTimeProration.value, 1);
  });

  test(
      'Test GoogleProrationMode.immediateWithoutProration value matches Billing Client with 3',
      () async {
    expect(GoogleProrationMode.immediateWithoutProration.value, 3);
  });
}
