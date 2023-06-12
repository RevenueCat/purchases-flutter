
import 'package:freezed_annotation/freezed_annotation.dart';

enum PeriodUnit {
  @JsonValue('DAY')
  day,
  @JsonValue('WEEK')
  week,
  @JsonValue('MONTH')
  month,
  @JsonValue('YEAR')
  year,
  unknown
}
