// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'introductory_price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntroductoryPrice _$IntroductoryPriceFromJson(Map json) => _IntroductoryPrice(
      (json['price'] as num).toDouble(),
      json['priceString'] as String,
      json['period'] as String,
      (json['cycles'] as num).toInt(),
      $enumDecode(_$PeriodUnitEnumMap, json['periodUnit'],
          unknownValue: PeriodUnit.unknown),
      (json['periodNumberOfUnits'] as num).toInt(),
    );

Map<String, dynamic> _$IntroductoryPriceToJson(_IntroductoryPrice instance) =>
    <String, dynamic>{
      'price': instance.price,
      'priceString': instance.priceString,
      'period': instance.period,
      'cycles': instance.cycles,
      'periodUnit': _$PeriodUnitEnumMap[instance.periodUnit]!,
      'periodNumberOfUnits': instance.periodNumberOfUnits,
    };

const _$PeriodUnitEnumMap = {
  PeriodUnit.day: 'DAY',
  PeriodUnit.week: 'WEEK',
  PeriodUnit.month: 'MONTH',
  PeriodUnit.year: 'YEAR',
  PeriodUnit.unknown: 'unknown',
};
