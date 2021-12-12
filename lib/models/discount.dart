import 'package:freezed_annotation/freezed_annotation.dart';

part 'discount.freezed.dart';
part 'discount.g.dart';

@freezed
class Discount with _$Discount {
  const factory Discount(
    /// Identifier of the discount.
    @JsonKey(name: 'identifier') String identifier,

    /// Identifier of the discount.
    @JsonKey(name: 'price') double price,

    /// Formatted price, including its currency sign, such as €3.99.
    @JsonKey(name: 'priceString') String priceString,

    /// Number of subscription billing periods for which the user will be given the discount, such as 3.
    @JsonKey(name: 'cycles') int cycles,

    /// Billing period of the discount, specified in ISO 8601 format.
    @JsonKey(name: 'period') String period,

    /// Unit for the billing period of the discount, can be DAY, WEEK, MONTH or YEAR.
    @JsonKey(name: 'periodUnit') String periodUnit,

    /// Number of units for the billing period of the discount.
    @JsonKey(name: 'periodNumberOfUnits') int periodNumberOfUnits,
  ) = _Discount;

  factory Discount.fromJson(Map<String, dynamic> json) =>
      _$DiscountFromJson(json);
}
