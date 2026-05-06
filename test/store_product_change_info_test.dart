import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('StoreProductChangeInfo stores product change values', () {
    const productChangeInfo = StoreProductChangeInfo(
      'old_product_id',
      replacementMode: StoreReplacementMode.chargeFullPrice,
    );

    expect(productChangeInfo.oldProductIdentifier, 'old_product_id');
    expect(
      productChangeInfo.replacementMode,
      StoreReplacementMode.chargeFullPrice,
    );
  });

  test('StoreReplacementMode values match hybrid common names', () {
    expect(
      StoreReplacementMode.withTimeProration.value,
      'WITH_TIME_PRORATION',
    );
    expect(
      StoreReplacementMode.chargeProratedPrice.value,
      'CHARGE_PRORATED_PRICE',
    );
    expect(
      StoreReplacementMode.withoutProration.value,
      'WITHOUT_PRORATION',
    );
    expect(
      StoreReplacementMode.chargeFullPrice.value,
      'CHARGE_FULL_PRICE',
    );
    expect(StoreReplacementMode.deferred.value, 'DEFERRED');
  });
}
