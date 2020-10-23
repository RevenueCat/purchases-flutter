/// The details of a discount offer for a subscription product.
class Discount {
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

  // ignore: public_member_api_docs
  Discount(this.identifier, this.price, this.priceString, this.cycles,
      this.period, this.periodUnit, this.periodNumberOfUnits);

  // ignore: public_member_api_docs
  Discount.fromJson(Map<dynamic, dynamic> json)
      : identifier = json['identifier'],
        price = json['price'].toDouble(),
        priceString = json['priceString'],
        cycles = json['cycles'],
        period = json['period'],
        periodUnit = json['periodUnit'],
        periodNumberOfUnits = json['periodNumberOfUnits'];

  @override
  String toString() {
    return 'Discount{'
        'identifier: $identifier, '
        'price: $price, '
        'priceString: $priceString, '
        'cycles: $cycles, '
        'period: $period, '
        'periodUnit: $periodUnit, '
        'periodNumberOfUnits: $periodNumberOfUnits}';
  }
}
