import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/introductory_price.dart';
import 'package:purchases_flutter/models/period_unit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  mockIntroductoryPriceJson({String periodUnit = 'DAY'}) => {
        'price': 0.0,
        'priceString': '\$0.00',
        'period': 'P2W',
        'cycles': 1,
        'periodUnit': periodUnit,
        'periodNumberOfUnits': 14,
      };

  test('IntroductoryPrice maps correctly', () async {
    final mockIntroPrice = IntroductoryPrice.fromJson(
      mockIntroductoryPriceJson(),
    );
    expect(mockIntroPrice.price, 0);
    expect(mockIntroPrice.priceString, '\$0.00');
    expect(mockIntroPrice.period, 'P2W');
    expect(mockIntroPrice.periodNumberOfUnits, 14);
    expect(mockIntroPrice.cycles, 1);
  });

  test('IntroductoryPrice PeriodUnit.day maps correctly', () async {
    final mockIntroPriceDay = IntroductoryPrice.fromJson(
      mockIntroductoryPriceJson(),
    );
    expect(mockIntroPriceDay.periodUnit, PeriodUnit.day);
  });

  test('IntroductoryPrice PeriodUnit.week maps correctly', () async {
    final mockIntroPriceWeek = IntroductoryPrice.fromJson(
      mockIntroductoryPriceJson(periodUnit: 'WEEK'),
    );
    expect(mockIntroPriceWeek.periodUnit, PeriodUnit.week);
  });

  test('IntroductoryPrice PeriodUnit.month maps correctly', () async {
    final mockIntroPriceMonth = IntroductoryPrice.fromJson(
      mockIntroductoryPriceJson(periodUnit: 'MONTH'),
    );
    expect(mockIntroPriceMonth.periodUnit, PeriodUnit.month);
  });

  test('IntroductoryPrice PeriodUnit.year maps correctly', () async {
    final mockIntroPriceYear = IntroductoryPrice.fromJson(
      mockIntroductoryPriceJson(periodUnit: 'YEAR'),
    );
    expect(mockIntroPriceYear.periodUnit, PeriodUnit.year);
  });

  test('IntroductoryPrice PeriodUnit.unknown maps correctly', () async {
    final mockIntroPriceUnknown = IntroductoryPrice.fromJson(
      mockIntroductoryPriceJson(periodUnit: 'asdf'),
    );
    expect(mockIntroPriceUnknown.periodUnit, PeriodUnit.unknown);
  });
}
