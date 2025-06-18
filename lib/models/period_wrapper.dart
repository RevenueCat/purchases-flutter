import 'package:equatable/equatable.dart';

import 'map_helpers.dart';
import 'period_unit.dart';

class Period extends Equatable {
  /// The number of period units: day, week, month, year, unknown
  final PeriodUnit unit;

  /// The increment of time that a subscription period is specified in
  final int value;

  /// Specified in ISO 8601 format. For example, P1W equates to one week,
  /// P1M equates to one month, P3M equates to three months, P6M equates to
  /// six months, and P1Y equates to one year
  final String iso8601;

  const Period(
    this.unit,
    this.value,
    this.iso8601,
  );

  factory Period.fromJson(Map<String, dynamic> json) => Period(
      periodUnitFromJson(json['unit']),
      json['value'] as int,
      json['iso8601'] as String,
  );

  @override
  List<Object> get props => [
    unit,
    value,
    iso8601,
  ];
}
