import 'package:freezed_annotation/freezed_annotation.dart';

part 'period_wrapper.freezed.dart';
part 'period_wrapper.g.dart';

@freezed

/// Contains all the details associated with a Period
class Period with _$Period {
  const factory Period(
    /// The number of period units
    @JsonKey(name: 'periodUnit') String unit,

    /// The increment of time that a subscription period is specified in
    @JsonKey(name: 'periodNumberOfUnits') int value,
  ) = _Period;

  factory Period.fromJson(Map<String, dynamic> json) => _$PeriodFromJson(json);
}
