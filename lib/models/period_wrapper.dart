import 'package:freezed_annotation/freezed_annotation.dart';

part 'period_wrapper.freezed.dart';
part 'period_wrapper.g.dart';

@freezed
class Period with _$Period {
  const factory Period(
    @JsonKey(name: 'periodUnit') String unit,
    @JsonKey(name: 'periodNumberOfUnits') int value,
  ) = _Period;

  factory Period.fromJson(Map<String, dynamic> json) => _$PeriodFromJson(json);
}
