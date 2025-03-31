import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/virtual_currency_info.dart';

void main() {
  test('fromJson correctly parses balances', () {
    final result = VirtualCurrencyInfo.fromJson({
      'balance': 100,
    });

    expect(result, isNotNull);
    expect(result.balance, equals(100));
  });
}
