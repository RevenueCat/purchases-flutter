import 'package:equatable/equatable.dart';

class WinBackOffer extends Equatable {
  /// Identifier of the discount.
  final String identifier;

  /// Identifier of the discount.
  final double price;

  /// Formatted price, including its currency sign, such as €3.99.
  final String priceString;

  /// Number of subscription billing periods for which the user will be given the discount, such as 3.
  final int cycles;

  /// Billing period of the discount, specified in ISO 8601 format.
  final String period;

  /// Unit for the billing period of the discount, can be DAY, WEEK, MONTH or YEAR.
  final String periodUnit;

  /// Number of units for the billing period of the discount.
  final int periodNumberOfUnits;

  const WinBackOffer(
    this.identifier,
    this.price,
    this.priceString,
    this.cycles,
    this.period,
    this.periodUnit,
    this.periodNumberOfUnits,
  );

  factory WinBackOffer.fromJson(Map<String, dynamic> json) => WinBackOffer(
    json['identifier'] as String,
    (json['price'] as num).toDouble(),
    json['priceString'] as String,
    json['cycles'] as int,
    json['period'] as String,
    json['periodUnit'] as String,
    json['periodNumberOfUnits'] as int,
  );

  @override
  List<Object?> get props => [
    identifier,
    price,
    priceString,
    cycles,
    period,
    periodUnit,
    periodNumberOfUnits,
  ];
}
