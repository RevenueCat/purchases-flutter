import 'package:equatable/equatable.dart';

import 'virtual_currency.dart';

class VirtualCurrencies extends Equatable {
  final Map<String, VirtualCurrency> all;

  const VirtualCurrencies(this.all);

  factory VirtualCurrencies.fromJson(Map<String, dynamic> json) =>
      VirtualCurrencies(
        (json['all'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(
            key,
            VirtualCurrency.fromJson(value as Map<String, dynamic>),
          ),
        ),
      );

  @override
  List<Object?> get props => [all];
}
