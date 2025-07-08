import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/installments_info.dart';
import 'package:purchases_flutter/models/period_unit.dart';
import 'package:purchases_flutter/models/period_wrapper.dart';
import 'package:purchases_flutter/models/presented_offering_context_wrapper.dart';
import 'package:purchases_flutter/models/price_wrapper.dart';
import 'package:purchases_flutter/models/pricing_phase_wrapper.dart';
import 'package:purchases_flutter/models/subscription_option_wrapper.dart';

void main() {
  group('SubscriptionOption.fromJson', () {
    test('parses minimum required fields', () {
      final json = {
        'id': 'opt1',
        'storeProductId': 'prod1',
        'productId': 'base1',
        'pricingPhases': [],
        'tags': [],
        'isBasePlan': true,
        'isPrepaid': false,
      };
      final info = SubscriptionOption.fromJson(json);
      const expected = SubscriptionOption(
        'opt1',
        'prod1',
        'base1',
        [],
        [],
        true,
        null,
        false,
        null,
        null,
        null,
        null,
        null,
      );
      expect(info, equals(expected));
      expect(SubscriptionOption.fromJson(info.toJson()), equals(expected));
    });

    test('parses all fields', () {
      final json = {
        'id': 'opt2',
        'storeProductId': 'prod2',
        'productId': 'base2',
        'pricingPhases': [
          {
            'price': {
              'formatted': '\$1.99',
              'amountMicros': 1990000,
              'currencyCode': 'USD',
            },
            'billingPeriod': {'unit': 'MONTH', 'value': 1, 'iso8601': 'P1M'},
            'recurrenceMode': 1,
            'billingCycleCount': 2,
            'offerPaymentMode': 'FREE_TRIAL',
          }
        ],
        'tags': ['tag1', 'tag2'],
        'isBasePlan': false,
        'billingPeriod': {'unit': 'MONTH', 'value': 1, 'iso8601': 'P1M'},
        'isPrepaid': true,
        'fullPricePhase': {
          'price': {
            'formatted': '\$2.99',
            'amountMicros': 2990000,
            'currencyCode': 'USD',
          },
          'billingPeriod': {'unit': 'MONTH', 'value': 1, 'iso8601': 'P1M'},
          'recurrenceMode': 1,
          'billingCycleCount': 1,
          'offerPaymentMode': 'SINGLE_PAYMENT',
        },
        'freePhase': {
          'price': {
            'formatted': '\$0.00',
            'amountMicros': 0,
            'currencyCode': 'USD',
          },
          'billingPeriod': {'unit': 'MONTH', 'value': 1, 'iso8601': 'P1M'},
          'recurrenceMode': 2,
          'billingCycleCount': 1,
          'offerPaymentMode': 'FREE_TRIAL',
        },
        'introPhase': {
          'price': {
            'formatted': '\$0.50',
            'amountMicros': 500000,
            'currencyCode': 'USD',
          },
          'billingPeriod': {'unit': 'MONTH', 'value': 1, 'iso8601': 'P1M'},
          'recurrenceMode': 3,
          'billingCycleCount': 1,
          'offerPaymentMode': 'DISCOUNTED_RECURRING_PAYMENT',
        },
        'presentedOfferingContext': {
          'offeringIdentifier': 'off1',
          'placementIdentifier': 'placement1',
          'targetingContext': null,
        },
        'installmentsInfo': {
          'commitmentPaymentsCount': 6,
          'renewalCommitmentPaymentsCount': 2,
        },
      };
      final info = SubscriptionOption.fromJson(json);
      const expected = SubscriptionOption(
        'opt2',
        'prod2',
        'base2',
        [
          PricingPhase(
            Period(PeriodUnit.month, 1, 'P1M'),
            RecurrenceMode.infiniteRecurring,
            2,
            Price('\$1.99', 1990000, 'USD'),
            OfferPaymentMode.freeTrial,
          ),
        ],
        ['tag1', 'tag2'],
        false,
        Period(PeriodUnit.month, 1, 'P1M'),
        true,
        PricingPhase(
          Period(PeriodUnit.month, 1, 'P1M'),
          RecurrenceMode.infiniteRecurring,
          1,
          Price('\$2.99', 2990000, 'USD'),
          OfferPaymentMode.singlePayment,
        ),
        PricingPhase(
          Period(PeriodUnit.month, 1, 'P1M'),
          RecurrenceMode.finiteRecurring,
          1,
          Price('\$0.00', 0, 'USD'),
          OfferPaymentMode.freeTrial,
        ),
        PricingPhase(
          Period(PeriodUnit.month, 1, 'P1M'),
          RecurrenceMode.nonRecurring,
          1,
          Price('\$0.50', 500000, 'USD'),
          OfferPaymentMode.discountedRecurringPayment,
        ),
        PresentedOfferingContext(
          'off1',
          'placement1',
          null,
        ),
        InstallmentsInfo(6, 2),
      );
      expect(info, equals(expected));
      expect(SubscriptionOption.fromJson(info.toJson()), equals(expected));
    });
  });
}
