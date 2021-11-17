// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'introductory_price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_IntroductoryPrice _$$_IntroductoryPriceFromJson(Map json) =>
    _$_IntroductoryPrice(
      (json['intro_price'] as num).toDouble(),
      json['intro_price_string'] as String,
      json['intro_price_period'] as String,
      json['intro_price_period_unit'] as String,
      json['intro_price_period_number_of_units'] as int,
      json['intro_price_cycles'] as int,
    );

Map<String, dynamic> _$$_IntroductoryPriceToJson(
        _$_IntroductoryPrice instance) =>
    <String, dynamic>{
      'intro_price': instance.introPrice,
      'intro_price_string': instance.introPriceString,
      'intro_price_period': instance.introPricePeriod,
      'intro_price_period_unit': instance.introPricePeriodUnit,
      'intro_price_period_number_of_units':
          instance.introPricePeriodNumberOfUnits,
      'intro_price_cycles': instance.introPriceCycles,
    };
