// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'period_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Period _$$_PeriodFromJson(Map json) => _$_Period(
      $enumDecode(_$UnitEnumMap, json['unit']),
      json['value'] as int,
      json['iso8601'] as String,
    );

Map<String, dynamic> _$$_PeriodToJson(_$_Period instance) => <String, dynamic>{
      'unit': _$UnitEnumMap[instance.unit]!,
      'value': instance.value,
      'iso8601': instance.iso8601,
    };

const _$UnitEnumMap = {
  Unit.day: 'DAY',
  Unit.week: 'WEEK',
  Unit.month: 'MONTH',
  Unit.year: 'YEAR',
  Unit.unknown: 'UNKNOWN',
};
