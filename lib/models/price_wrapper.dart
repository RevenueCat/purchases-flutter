import 'package:freezed_annotation/freezed_annotation.dart';

part 'price_wrapper.freezed.dart';
part 'price_wrapper.g.dart';

@freezed
class Price with _$Price {
  const factory Price(
    @JsonKey(name: 'formatted') String formatted,
    @JsonKey(name: 'amountMicros') int amountMicros,
    @JsonKey(name: 'currencyCode') String currencyCode,
  ) = _Price;

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
}
