import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/period_wrapper.dart';
import 'package:purchases_flutter/models/period_unit.dart';

void main() {
  group('Period.fromJson', () {
    test('parses all fields', () {
      final json = {
        'unit': 'MONTH',
        'value': 1,
        'iso8601': 'P1M',
      };
      final info = Period.fromJson(json);
      const expected = Period(
        PeriodUnit.month,
        1,
        'P1M',
      );
      expect(info, equals(expected));
    });
  });
} 
