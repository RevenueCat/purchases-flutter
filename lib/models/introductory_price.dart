import 'package:freezed_annotation/freezed_annotation.dart';

part 'introductory_price.freezed.dart';
part 'introductory_price.g.dart';

enum PeriodUnit { day, week, month, year, unknown }

@freezed

/// Contains all the introductory information associated with a [Product]
class IntroductoryPrice with _$IntroductoryPrice {
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

    /// String representation of unit for the billing period of the introductory
    /// price, can be DAY, WEEK, MONTH or YEAR.
    @Deprecated('Use periodUnit property of type PeriodUnit instead.')
    @JsonKey(name: 'periodUnit')
        String introPricePeriodUnit,

    /// Number of units for the billing period of the introductory price.
    @JsonKey(name: 'periodNumberOfUnits') int periodNumberOfUnits,
  ) = _IntroductoryPrice;

  /// Unit for the billing period of the introductory price, can be DAY, WEEK,
  /// MONTH or YEAR.
  PeriodUnit get periodUnit {
    // ignore: deprecated_member_use_from_same_package
    switch (introPricePeriodUnit) {
      case 'DAY':
        {
          return PeriodUnit.day;
        }
      case 'WEEK':
        {
          return PeriodUnit.week;
        }
      case 'MONTH':
        {
          return PeriodUnit.month;
        }
      case 'YEAR':
        {
          return PeriodUnit.year;
        }
      default:
        {
          return PeriodUnit.unknown;
        }
    }
  }

  /// Introductory price of a subscription in the local currency.
  @Deprecated('Use price instead.')
  double get introPrice => price;

  /// Formatted introductory price of a subscription, including
  /// its currency sign, such as €3.99.
  @Deprecated('Use priceString instead.')
  String get introPriceString => priceString;

  /// Billing period of the introductory price, specified in
  /// ISO 8601 format.
  @Deprecated('Use period instead.')
  String get introPricePeriod => period;

  /// Number of units for the billing period of the introductory price.
  @Deprecated('Use periodNumberOfUnits instead.')
  int get introPricePeriodNumberOfUnits => periodNumberOfUnits;

  /// Number of subscription billing periods for which the
  /// user will be given the introductory price, such as 3.
  @Deprecated('Use cycles instead.')
  int get introPriceCycles => cycles;

  factory IntroductoryPrice.fromJson(Map<String, dynamic> json) =>
      _$IntroductoryPriceFromJson(json);
}
