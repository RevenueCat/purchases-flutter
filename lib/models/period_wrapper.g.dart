// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'period_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Period _$$_PeriodFromJson(Map json) => _$_Period(
      $enumDecode(_$UnitEnumMap, json['unit']),
      json['value'] as int,
    );

Map<String, dynamic> _$$_PeriodToJson(_$_Period instance) => <String, dynamic>{
      'unit': _$UnitEnumMap[instance.unit]!,
      'value': instance.value,
    };

const _$UnitEnumMap = {
  Unit.day: 'DAY',
  Unit.week: 'WEEK',
  Unit.month: 'MONTH',
  Unit.year: 'YEAR',
  Unit.unknown: 'UNKNOWN',
};
