import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/store_product_wrapper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  mockStoreProductJson() => {
        'identifier': 'monthly_intro_pricing_one_week',
        'description': 'Monthly Product Intro Pricing One Week',
        'title': 'Monthly Product Intro Pricing One Week (PurchasesSample)',
        'price': 4.99,
        'priceString': '\$4.99',
        'currencyCode': 'USD',
        'introPrice': {
          'price': 0,
          'priceString': '\$0.00',
          'period': 'P1W',
          'cycles': 1,
          'periodUnit': 'DAY',
          'periodNumberOfUnits': 7,
        },
        'discounts': [
          {
            'periodNumberOfUnits': 1,
            'price': 29.99,
            'cycles': 1,
            'period': 'P1M',
            'identifier': 'promo_cat_2',
            'priceString': '\$29.99',
            'periodUnit': 'MONTH',
          },
          {
            'period': 'P1M',
            'price': 0.0,
            'identifier': 'promo_cat_1',
            'periodNumberOfUnits': 1,
            'cycles': 1,
            'periodUnit': 'MONTH',
            'priceString': '\$0.00',
          }
        ],
        'productCategory': 'SUBSCRIPTION',
      };

  test('StoreProduct maps correctly', () async {
    final mockIntroPrice = StoreProduct.fromJson(
      mockStoreProductJson(),
    );
    expect(mockIntroPrice.identifier, 'monthly_intro_pricing_one_week');
    expect(
      mockIntroPrice.description,
      'Monthly Product Intro Pricing One Week',
    );
    expect(
      mockIntroPrice.title,
      'Monthly Product Intro Pricing One Week (PurchasesSample)',
    );
    expect(mockIntroPrice.price, 4.99);
    expect(mockIntroPrice.priceString, '\$4.99');
    expect(mockIntroPrice.currencyCode, 'USD');
    expect(mockIntroPrice.introductoryPrice, isNotNull);
    expect(mockIntroPrice.discounts, isNotNull);
    expect(mockIntroPrice.discounts?.length, 2);
  });
}
