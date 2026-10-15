import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/billing_plan_type.dart';
import 'package:purchases_flutter/models/installments_info.dart';

void main() {
  group('InstallmentsInfo.fromJson', () {
    test('parses required fields', () {
      final json = {
        'commitmentPaymentsCount': 6,
        'renewalCommitmentPaymentsCount': 2,
      };
      final info = InstallmentsInfo.fromJson(json);
      const expected = InstallmentsInfo(
        6,
        2,
      );
      expect(info, equals(expected));
    });

    test('parses all fields', () {
      final json = {
        'commitmentPaymentsCount': 12,
        'renewalCommitmentPaymentsCount': 12,
        'commitmentInstallmentPeriod': 'P1M',
        'installmentBillingPrice': 9.99,
        'installmentBillingPriceString': '\$9.99',
        'commitmentTotalPeriod': 'P1Y',
        'commitmentTotalPrice': 119.88,
        'commitmentTotalPriceString': '\$119.88',
        'billingPlanType': 'MONTHLY',
      };
      final info = InstallmentsInfo.fromJson(json);
      const expected = InstallmentsInfo(
        12,
        12,
        commitmentInstallmentPeriod: 'P1M',
        installmentBillingPrice: 9.99,
        installmentBillingPriceString: '\$9.99',
        commitmentTotalPeriod: 'P1Y',
        commitmentTotalPrice: 119.88,
        commitmentTotalPriceString: '\$119.88',
        billingPlanType: BillingPlanType.monthly,
      );
      expect(info, equals(expected));
    });

    test('parses null iOS-only fields sent from Android', () {
      final json = {
        'commitmentPaymentsCount': 6,
        'renewalCommitmentPaymentsCount': 2,
        'commitmentInstallmentPeriod': null,
        'installmentBillingPrice': null,
        'installmentBillingPriceString': null,
        'commitmentTotalPeriod': null,
        'commitmentTotalPrice': null,
        'commitmentTotalPriceString': null,
        'billingPlanType': null,
      };
      final info = InstallmentsInfo.fromJson(json);
      const expected = InstallmentsInfo(
        6,
        2,
      );
      expect(info, equals(expected));
    });

    test('parses integer prices as doubles', () {
      final json = {
        'commitmentPaymentsCount': 12,
        'renewalCommitmentPaymentsCount': 12,
        'installmentBillingPrice': 10,
        'commitmentTotalPrice': 120,
      };
      final info = InstallmentsInfo.fromJson(json);
      expect(info.installmentBillingPrice, 10.0);
      expect(info.commitmentTotalPrice, 120.0);
    });

    test('parses billingPlanType values', () {
      const cases = {
        'UP_FRONT': BillingPlanType.upFront,
        'MONTHLY': BillingPlanType.monthly,
        'UNKNOWN': BillingPlanType.unknown,
        'SOME_FUTURE_VALUE': BillingPlanType.unknown,
      };
      for (final entry in cases.entries) {
        final info = InstallmentsInfo.fromJson({
          'commitmentPaymentsCount': 12,
          'renewalCommitmentPaymentsCount': 12,
          'billingPlanType': entry.key,
        });
        expect(info.billingPlanType, entry.value);
      }
    });
  });
}
