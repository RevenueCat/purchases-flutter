import 'package:freezed_annotation/freezed_annotation.dart';

part 'introductory_price.freezed.dart';
part 'introductory_price.g.dart';

@freezed

/// Contains all the introductory information associated with a [Product]
class IntroductoryPrice with _$IntroductoryPrice {
  const factory IntroductoryPrice(
    /// Introductory price of a subscription in the local currency.
    @JsonKey(name: 'intro_price') double introPrice,

    /// Formatted introductory price of a subscription, including
    /// its currency sign, such as €3.99.
    @JsonKey(name: 'intro_price_string') String introPriceString,

    /// Billing period of the introductory price, specified in
    /// ISO 8601 format.
    @JsonKey(name: 'intro_price_period') String introPricePeriod,

    /// Unit for the billing period of the introductory price, can be DAY, WEEK,
    /// MONTH or YEAR.
    @JsonKey(name: 'intro_price_period_unit') String introPricePeriodUnit,

    /// Number of units for the billing period of the introductory price.
    @JsonKey(name: 'intro_price_period_number_of_units')
        int introPricePeriodNumberOfUnits,

    /// Number of subscription billing periods for which the
    /// user will be given the introductory price, such as 3.
    @JsonKey(name: 'intro_price_cycles') int introPriceCycles,
  ) = _IntroductoryPrice;

  factory IntroductoryPrice.fromJson(Map<String, dynamic> json) =>
      _$IntroductoryPriceFromJson(json);
}
