import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/billing_plan_type.dart';
import 'package:purchases_flutter/models/map_helpers.dart';

void main() {
  group('billingPlanTypeFromJson', () {
    test('parses UP_FRONT', () {
      expect(billingPlanTypeFromJson('UP_FRONT'), BillingPlanType.upFront);
    });

    test('parses MONTHLY', () {
      expect(billingPlanTypeFromJson('MONTHLY'), BillingPlanType.monthly);
    });

    test('parses UNKNOWN', () {
      expect(billingPlanTypeFromJson('UNKNOWN'), BillingPlanType.unknown);
    });

    test('maps unrecognized values to unknown', () {
      expect(billingPlanTypeFromJson('SOME_FUTURE_VALUE'),
          BillingPlanType.unknown);
    });

    test('maps null to null', () {
      expect(billingPlanTypeFromJson(null), isNull);
    });
  });
}
