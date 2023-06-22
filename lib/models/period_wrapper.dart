import 'package:freezed_annotation/freezed_annotation.dart';

import 'period_unit.dart';

part 'period_wrapper.freezed.dart';
part 'period_wrapper.g.dart';

@freezed

/// Contains all the details associated with a Period
class Period with _$Period {
  const factory Period(
    /// The number of period units: day, week, month, year, unknown
    PeriodUnit unit,

    /// The increment of time that a subscription period is specified in
    int value,

    /// Specified in ISO 8601 format. For example, P1W equates to one week,
    /// P1M equates to one month, P3M equates to three months, P6M equates to
    /// six months, and P1Y equates to one year
    String iso8601,
  ) = _Period;

  factory Period.fromJson(Map<String, dynamic> json) => _$PeriodFromJson(json);
}
