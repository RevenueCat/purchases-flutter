import 'package:equatable/equatable.dart';

import 'map_helpers.dart';
import 'period_unit.dart';

class IntroductoryPrice extends Equatable {
  /// Introductory price of a subscription in the local currency.
  final double price;

  /// Formatted introductory price of a subscription, including
  /// its currency sign, such as €3.99.
  final String priceString;

  /// Billing period of the introductory price, specified in
  /// ISO 8601 format.
  final String period;

  /// Number of subscription billing periods for which the
  /// user will be given the introductory price, such as 3.
  final int cycles;

  /// Unit for the billing period of the introductory price, can be DAY, WEEK,
  /// MONTH or YEAR.
  final PeriodUnit periodUnit;

  /// Number of units for the billing period of the introductory price.
  final int periodNumberOfUnits;

  const IntroductoryPrice(
    this.price,
    this.priceString,
    this.period,
    this.cycles,
    this.periodUnit,
    this.periodNumberOfUnits,
  );

  factory IntroductoryPrice.fromJson(Map<String, dynamic> json) => IntroductoryPrice(
      (json['price'] as num).toDouble(),
      json['priceString'] as String,
      json['period'] as String,
      json['cycles'] as int,
      periodUnitFromJson(json['periodUnit']),
      json['periodNumberOfUnits'] as int,
    );

  @override
  List<Object?> get props => [
    price,
    priceString,
    period,
    cycles,
    periodUnit,
    periodNumberOfUnits,
  ];
}
