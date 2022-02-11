import 'package:freezed_annotation/freezed_annotation.dart';

part 'introductory_price.freezed.dart';
part 'introductory_price.g.dart';

// TODO add back JsonValues fully removing introPricePeriodUnit
enum PeriodUnit {
  // @JsonValue('DAY')
  day,
  // @JsonValue('WEEK')
  week,
  // @JsonValue('MONTH')
  month,
  // @JsonValue('YEAR')
  year,
  unknown
}

@freezed

/// Contains all the introductory information associated with a [Product]
class IntroductoryPrice with _$IntroductoryPrice {
  // TODO remove this ctor when fully removing introPricePeriodUnit string
  const IntroductoryPrice._();

  const factory IntroductoryPrice(
    /// Introductory price of a subscription in the local currency.
    @JsonKey(name: 'price') double price,

    /// Formatted introductory price of a subscription, including
    /// its currency sign, such as €3.99.
    @JsonKey(name: 'priceString') String priceString,

    /// Billing period of the introductory price, specified in
    /// ISO 8601 format.
    @JsonKey(name: 'period') String period,

    /// Number of subscription billing periods for which the
    /// user will be given the introductory price, such as 3.
    @JsonKey(name: 'cycles') int cycles,

   /// TODO add back when fully removing introPricePeriodUnit
    // /// Unit for the billing period of the introductory price, can be DAY, WEEK,
    // /// MONTH or YEAR.
    // @JsonKey(name: 'periodUnit', unknownEnumValue: PeriodUnit.unknown)
    // PeriodUnit periodUnit = getPeriodUnit(introPricePeriodUnit),

    /// String representation of unit for the billing period of the introductory
    /// price, can be DAY, WEEK, MONTH or YEAR.
    @Deprecated('Use periodUnit property of type PeriodUnit instead.')
    @JsonKey(name: 'periodUnit') String introPricePeriodUnit,

    /// Number of units for the billing period of the introductory price.
    @JsonKey(name: 'periodNumberOfUnits') int periodNumberOfUnits,
  ) = _IntroductoryPrice;

  /// TODO remove this method when fully removing introPricePeriodUnit string
  /// Maps introPricePeriodUnit string to PeriodUnit enum type
  PeriodUnit get periodUnit {
    switch (introPricePeriodUnit) {
      case 'DAY': { return PeriodUnit.day; }
      case 'WEEK': { return PeriodUnit.week; }
      case 'MONTH': { return PeriodUnit.month; }
      case 'YEAR': { return PeriodUnit.year; }
      default: { return PeriodUnit.unknown; }
    }
  }

  factory IntroductoryPrice.fromJson(Map<String, dynamic> json) =>
      _$IntroductoryPriceFromJson(json);
}