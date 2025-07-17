import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/period_unit.dart';
import 'package:purchases_flutter/models/store_product_wrapper.dart';
import 'package:purchases_flutter/models/introductory_price.dart';
import 'package:purchases_flutter/models/store_product_discount.dart';
import 'package:purchases_flutter/models/product_category.dart';
import 'package:purchases_flutter/models/subscription_option_wrapper.dart';
import 'package:purchases_flutter/models/presented_offering_context_wrapper.dart';

void main() {
  group('StoreProduct.fromJson', () {
    test('parses minimum required fields', () {
      final json = {
        'identifier': 'prod1',
        'description': 'desc',
        'title': 'title',
        'price': 1.99,
        'priceString': '\$1.99',
        'currencyCode': 'USD',
      };
      final info = StoreProduct.fromJson(json);
      const expected = StoreProduct(
        'prod1',
        'desc',
        'title',
        1.99,
        '\$1.99',
        'USD',
      );
      expect(info, equals(expected));
    });

    test('parses all fields', () {
      final json = {
        'identifier': 'prod2',
        'description': 'desc2',
        'title': 'title2',
        'price': 2.99,
        'priceString': '\$2.99',
        'currencyCode': 'EUR',
        'introPrice': {
          'price': 0.99,
          'priceString': '\$0.99',
          'period': 'P1W',
          'cycles': 1,
          'periodUnit': 'WEEK',
          'periodNumberOfUnits': 1,
        },
        'discounts': [
          {
            'identifier': 'd1',
            'price': 0.5,
            'priceString': '\$0.5',
            'cycles': 1,
            'period': 'P1W',
            'periodUnit': 'WEEK',
            'periodNumberOfUnits': 1,
          }
        ],
        'productCategory': 'SUBSCRIPTION',
        'defaultOption': null,
        'subscriptionOptions': null,
        'presentedOfferingContext': null,
        'subscriptionPeriod': 'P1M',
      };
      final info = StoreProduct.fromJson(json);
      const expected = StoreProduct(
        'prod2',
        'desc2',
        'title2',
        2.99,
        '\$2.99',
        'EUR',
        introductoryPrice: IntroductoryPrice(
          0.99,
          '\$0.99',
          'P1W',
          1,
          PeriodUnit.week,
          1,
        ),
        discounts: [
          StoreProductDiscount(
            'd1',
            0.5,
            '\$0.5',
            1,
            'P1W',
            'WEEK',
            1,
          )
        ],
        productCategory: ProductCategory.subscription,
        defaultOption: null,
        subscriptionOptions: null,
        presentedOfferingContext: null,
        subscriptionPeriod: 'P1M',
      );
      expect(info, equals(expected));
    });
  });
} 
