import 'package:freezed_annotation/freezed_annotation.dart';

part 'price_wrapper.freezed.dart';
part 'price_wrapper.g.dart';

@freezed

/// Contains all the details associated with a Price
class Price with _$Price {
  const factory Price(
    /// Formatted price of the item, including its currency sign. For example $3.00
    String formatted,

    /// Price in micro-units, where 1,000,000 micro-units equal one unit of the currency.
    ///
    /// For example, if price is "€7.99", price_amount_micros is 7,990,000. This value represents
    /// the localized, rounded price for a particular currency.
    int amountMicros,

    /// Returns ISO 4217 currency code for price and original price.
    ///
    /// For example, if price is specified in British pounds sterling, price_currency_code is "GBP".
    ///
    /// If currency code cannot be determined, currency symbol is returned.
    String currencyCode,
  ) = _Price;

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
}
