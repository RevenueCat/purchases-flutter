// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'period_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PeriodImpl _$$PeriodImplFromJson(Map json) => _$PeriodImpl(
      $enumDecode(_$PeriodUnitEnumMap, json['unit']),
      (json['value'] as num).toInt(),
      json['iso8601'] as String,
    );

Map<String, dynamic> _$$PeriodImplToJson(_$PeriodImpl instance) =>
    <String, dynamic>{
      'unit': _$PeriodUnitEnumMap[instance.unit]!,
      'value': instance.value,
      'iso8601': instance.iso8601,
    };

const _$PeriodUnitEnumMap = {
  PeriodUnit.day: 'DAY',
  PeriodUnit.week: 'WEEK',
  PeriodUnit.month: 'MONTH',
  PeriodUnit.year: 'YEAR',
  PeriodUnit.unknown: 'unknown',
};
