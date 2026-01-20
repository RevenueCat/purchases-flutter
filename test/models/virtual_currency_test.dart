import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/virtual_currency.dart';

void main() {
  Map<String, dynamic> createVirtualCurrencyMap({
    required int balance,
    required String name,
    required String code,
    String? serverDescription,
  }) =>
      {
        'balance': balance,
        'name': name,
        'code': code,
        'serverDescription': serverDescription,
      };

  test('fromJson correctly parses virtual currencies with all fields', () {
    const balance = 100;
    const name = 'Gold';
    const code = 'GLD';
    const serverDescription = 'Gold currency';

    final result = VirtualCurrency.fromJson(
      createVirtualCurrencyMap(
        balance: balance,
        name: name,
        code: code,
        serverDescription: serverDescription,
      ),
    );

    expect(result.balance, balance);
    expect(result.name, name);
    expect(result.code, code);
    expect(result.serverDescription, serverDescription);
  });

  test(
      'fromJson correctly parses virtual currencies with null serverDescription',
      () {
    const balance = 100;
    const name = 'Gold';
    const code = 'GLD';

    final result = VirtualCurrency.fromJson(
      createVirtualCurrencyMap(
        balance: balance,
        name: name,
        code: code,
      ),
    );

    expect(result.balance, balance);
    expect(result.name, name);
    expect(result.code, code);
    expect(result.serverDescription, null);
  });

  test('fromJson correctly parses virtual currencies with negative balance',
      () {
    const negativeBalance = -1;
    const name = 'Gold';
    const code = 'GLD';
    const serverDescription = 'Gold currency';

    final result = VirtualCurrency.fromJson(
      createVirtualCurrencyMap(
        balance: negativeBalance,
        name: name,
        code: code,
        serverDescription: serverDescription,
      ),
    );

    expect(result.balance, negativeBalance);
    expect(result.name, name);
    expect(result.code, code);
    expect(result.serverDescription, serverDescription);
  });
}
