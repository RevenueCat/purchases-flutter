import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/virtual_currencies.dart';
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

  test(
      'fromJson correctly parses VirtualCurrencies with 0 VirtualCurrency objects',
      () {
    final result = VirtualCurrencies.fromJson(
      const <String, dynamic>{'all': <String, dynamic>{}},
    );

    expect(result.all.isEmpty, true);
  });

  test(
      'fromJson correctly parses VirtualCurrencies with 1 VirtualCurrency object',
      () {
    const balance = 100;
    const name = 'Gold';
    const code = 'GLD';
    const serverDescription = 'Gold currency';

    final result = VirtualCurrencies.fromJson(
      <String, dynamic>{
        'all': <String, dynamic>{
          code: createVirtualCurrencyMap(
            balance: balance,
            name: name,
            code: code,
            serverDescription: serverDescription,
          ),
        },
      },
    );

    expect(result.all.isEmpty, false);
    expect(result.all.length, 1);

    final virtualCurrency = result.all[code]!;
    expect(virtualCurrency.balance, balance);
    expect(virtualCurrency.name, name);
    expect(virtualCurrency.code, code);
    expect(virtualCurrency.serverDescription, serverDescription);
  });

  test(
      'fromJson correctly parses VirtualCurrencies with 2 VirtualCurrency objects',
      () {
    const balance1 = 100;
    const name1 = 'Gold';
    const code1 = 'GLD';
    const serverDescription1 = 'Gold currency';

    const balance2 = 200;
    const name2 = 'Silver';
    const code2 = 'SLV';

    final result = VirtualCurrencies.fromJson(
      <String, dynamic>{
        'all': <String, dynamic>{
          code1: createVirtualCurrencyMap(
            balance: balance1,
            name: name1,
            code: code1,
            serverDescription: serverDescription1,
          ),
          code2: createVirtualCurrencyMap(
            balance: balance2,
            name: name2,
            code: code2,
          ),
        },
      },
    );

    expect(result.all.isEmpty, false);
    expect(result.all.length, 2);

    final virtualCurrency1 = result.all[code1]!;
    expect(virtualCurrency1.balance, balance1);
    expect(virtualCurrency1.name, name1);
    expect(virtualCurrency1.code, code1);
    expect(virtualCurrency1.serverDescription, serverDescription1);

    final virtualCurrency2 = result.all[code2]!;
    expect(virtualCurrency2.balance, balance2);
    expect(virtualCurrency2.name, name2);
    expect(virtualCurrency2.code, code2);
    expect(virtualCurrency2.serverDescription, null);
  });
}
