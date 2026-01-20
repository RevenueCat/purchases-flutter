import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/installments_info.dart';

void main() {
  group('InstallmentsInfo.fromJson', () {
    test('parses all fields', () {
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
  });
} 