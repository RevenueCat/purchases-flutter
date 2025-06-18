import 'package:equatable/equatable.dart';

class StoreProductDiscount extends Equatable {
  final String identifier;
  final double price;
  final String priceString;
  final int cycles;
  final String period;
  final String periodUnit;
  final int periodNumberOfUnits;

  const StoreProductDiscount(
    this.identifier,
    this.price,
    this.priceString,
    this.cycles,
    this.period,
    this.periodUnit,
    this.periodNumberOfUnits,
  );

  factory StoreProductDiscount.fromJson(Map<String, dynamic> json) => StoreProductDiscount(
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
