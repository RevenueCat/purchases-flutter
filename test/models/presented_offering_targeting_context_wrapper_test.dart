import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/presented_offering_targeting_context_wrapper.dart';

void main() {
  group('PresentedOfferingTargetingContext.fromJson', () {
    test('parses all fields (all are required)', () {
      final json = {
        'revision': 1,
        'ruleId': 'rule_abc',
      };
      final info = PresentedOfferingTargetingContext.fromJson(json);
      const expected = PresentedOfferingTargetingContext(
        1,
        'rule_abc',
      );
      expect(info, equals(expected));
    });
  });
} 