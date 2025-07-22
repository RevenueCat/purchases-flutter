import 'package:equatable/equatable.dart';

import 'virtual_currency.dart';

class VirtualCurrencies extends Equatable {
  final Map<String, VirtualCurrency> all;

  const VirtualCurrencies(this.all);

  factory VirtualCurrencies.fromJson(Map<String, dynamic> json) =>
      VirtualCurrencies(
        Map<String, dynamic>.from(json['all']).map(
          (k, v) => MapEntry(
              k, VirtualCurrency.fromJson(Map<String, dynamic>.from(v))),
        ),
      );

  @override
  List<Object?> get props => [all];
}
