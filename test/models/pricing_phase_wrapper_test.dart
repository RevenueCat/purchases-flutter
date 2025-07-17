import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/period_unit.dart';
import 'package:purchases_flutter/models/pricing_phase_wrapper.dart';
import 'package:purchases_flutter/models/price_wrapper.dart';
import 'package:purchases_flutter/models/period_wrapper.dart';

void main() {
  group('PricingPhase.fromJson', () {
    test('parses all fields', () {
      final json = {
        'billingPeriod': {'unit': 'MONTH', 'value': 1, 'iso8601': 'P1M'},
        'recurrenceMode': 1,
        'billingCycleCount': 2,
        'price': {'formatted': '\$1.99', 'amountMicros': 1990000, 'currencyCode': 'USD'},
        'offerPaymentMode': 'FREE_TRIAL',
      };
      final info = PricingPhase.fromJson(json);
      const expected = PricingPhase(
        Period(PeriodUnit.month, 1, 'P1M'),
        RecurrenceMode.infiniteRecurring,
        2,
        Price('\$1.99', 1990000, 'USD'),
        OfferPaymentMode.freeTrial,
      );
      expect(info, equals(expected));
    });
  });
} 
