import 'package:equatable/equatable.dart';

/// Contains all the details associated with a Price
class Price extends Equatable {
  /// Formatted price of the item, including its currency sign. For example $3.00
  final String formatted;

  /// Price in micro-units, where 1,000,000 micro-units equal one unit of the currency.
  ///
  /// For example, if price is "€7.99", price_amount_micros is 7,990,000. This value represents
  /// the localized, rounded price for a particular currency.
  final int amountMicros;

  /// Returns ISO 4217 currency code for price and original price.
  ///
  /// For example, if price is specified in British pounds sterling, price_currency_code is "GBP".
  ///
  /// If currency code cannot be determined, currency symbol is returned.
  final String currencyCode;

  const Price(
    this.formatted,
    this.amountMicros,
    this.currencyCode,
  );

  factory Price.fromJson(Map<String, dynamic> json) => Price(
    json['formatted'] as String,
    json['amountMicros'] as int,
    json['currencyCode'] as String,
  );

  @override
  List<Object?> get props => [
    formatted,
    amountMicros,
    currencyCode,
  ];
}
