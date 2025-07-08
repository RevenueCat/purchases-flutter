import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/presented_offering_context_wrapper.dart';
import 'package:purchases_flutter/models/presented_offering_targeting_context_wrapper.dart';

void main() {
  group('PresentedOfferingContext.fromJson', () {
    test('parses all fields', () {
      final json = {
        'offeringIdentifier': 'off1',
        'placementIdentifier': 'placement1',
        'targetingContext': {
          'revision': 1,
          'ruleId': 'rule_abc',
        },
      };
      final info = PresentedOfferingContext.fromJson(json);
      const expected = PresentedOfferingContext(
        'off1',
        'placement1',
        PresentedOfferingTargetingContext(1, 'rule_abc'),
      );
      expect(info, equals(expected));
      expect(PresentedOfferingContext.fromJson(info.toJson()), equals(expected));
    });
  });
}
