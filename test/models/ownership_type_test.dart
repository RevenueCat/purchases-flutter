import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/entitlement_info_wrapper.dart';
import 'package:purchases_flutter/models/map_helpers.dart';

void main() {
  group('ownershipTypeFromJson', () {
    test('parses PURCHASED', () {
      expect(ownershipTypeFromJson('PURCHASED'), OwnershipType.purchased);
    });

    test('parses FAMILY_SHARED', () {
      expect(
          ownershipTypeFromJson('FAMILY_SHARED'), OwnershipType.familyShared);
    });

    test('parses ASSIGNED', () {
      expect(ownershipTypeFromJson('ASSIGNED'), OwnershipType.assigned);
    });

    test('parses UNKNOWN', () {
      expect(ownershipTypeFromJson('UNKNOWN'), OwnershipType.unknown);
    });

    test('maps unrecognized values to unknown', () {
      expect(ownershipTypeFromJson('SOME_FUTURE_VALUE'), OwnershipType.unknown);
    });

    test('maps null to unknown', () {
      expect(ownershipTypeFromJson(null), OwnershipType.unknown);
    });
  });
}
