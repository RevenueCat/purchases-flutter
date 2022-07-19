import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _IntroductoryPriceApiTest {
  void _checkPeriodUnit(PeriodUnit periodUnit) {
    switch (periodUnit) {
      case PeriodUnit.day:
      case PeriodUnit.week:
      case PeriodUnit.month:
      case PeriodUnit.year:
      case PeriodUnit.unknown:
        break;
    }
  }

  void _checkFromJsonFactory(Map<String, dynamic> json) {
    IntroductoryPrice introductoryPrice = IntroductoryPrice.fromJson(json);
  }

  void _checkToJson(IntroductoryPrice introductoryPrice) {
    Map<String, dynamic> json = introductoryPrice.toJson();
  }

  void _checkConstructor(double price, String priceString, String period,
      int cycles, PeriodUnit periodUnit, int periodNumberOfUnits) {
    IntroductoryPrice introductoryPrice = IntroductoryPrice(
        price, priceString, period, cycles, periodUnit, periodNumberOfUnits);
  }

  void _checkProperties(IntroductoryPrice introductoryPrice) {
    double price = introductoryPrice.price;
    String priceString = introductoryPrice.priceString;
    String period = introductoryPrice.period;
    int cycles = introductoryPrice.cycles;
    PeriodUnit periodUnit = introductoryPrice.periodUnit;
    int periodNumberOfUnits = introductoryPrice.periodNumberOfUnits;
  }
}
