import 'package:freezed_annotation/freezed_annotation.dart';

import 'period_unit.dart';

part 'introductory_price.freezed.dart';
part 'introductory_price.g.dart';

@freezed

/// Contains all the introductory information associated with a [Product]
class IntroductoryPrice with _$IntroductoryPrice {
  const factory IntroductoryPrice(
    /// Introductory price of a subscription in the local currency.
    double price,

    /// Formatted introductory price of a subscription, including
    /// its currency sign, such as €3.99.
    String priceString,

    /// Billing period of the introductory price, specified in
    /// ISO 8601 format.
    String period,

    /// Number of subscription billing periods for which the
    /// user will be given the introductory price, such as 3.
    int cycles,

    /// Unit for the billing period of the introductory price, can be DAY, WEEK,
    /// MONTH or YEAR.
    // ignore: invalid_annotation_target
    @JsonKey(name: 'periodUnit', unknownEnumValue: PeriodUnit.unknown)
        PeriodUnit periodUnit,

    /// Number of units for the billing period of the introductory price.
    int periodNumberOfUnits,
  ) = _IntroductoryPrice;

  factory IntroductoryPrice.fromJson(Map<String, dynamic> json) =>
      _$IntroductoryPriceFromJson(json);
}
