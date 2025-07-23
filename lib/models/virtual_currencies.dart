import 'package:equatable/equatable.dart';

import 'virtual_currency.dart';

/// The VirtualCurrencies object contains all the virtual currencies associated to a user.
class VirtualCurrencies extends Equatable {
  /// A map of all [VirtualCurrency] objects keyed by virtual currency code.
  final Map<String, VirtualCurrency> all;

  const VirtualCurrencies(this.all);

  factory VirtualCurrencies.fromJson(Map<String, dynamic> json) =>
      VirtualCurrencies(
        Map<String, dynamic>.from(json['all']).map(
          (k, v) => MapEntry(
            k,
            VirtualCurrency.fromJson(Map<String, dynamic>.from(v)),
          ),
        ),
      );

  @override
  List<Object?> get props => [all];
}
