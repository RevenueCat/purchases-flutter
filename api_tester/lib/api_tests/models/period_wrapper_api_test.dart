import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _PeriodApiTest {
  void _checkFromJsonFactory(Map<String, dynamic> json) {
    Period period = Period.fromJson(json);
  }

  void _checkToJson(Period period) {
    Map<String, dynamic> json = period.toJson();
  }

  void _checkConstructor(
    PeriodUnit unit,
    int value,
    String iso8601,
  ) {
    Period period = Period(unit, value, iso8601);
  }

  void _checkProperties(Period period) {
    PeriodUnit unit = period.unit;
    int value = period.value;
    String iso8601 = period.iso8601;
  }
}
