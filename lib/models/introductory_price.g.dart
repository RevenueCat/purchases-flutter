// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'introductory_price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_IntroductoryPrice _$$_IntroductoryPriceFromJson(Map json) =>
    _$_IntroductoryPrice(
      (json['price'] as num).toDouble(),
      json['priceString'] as String,
      json['period'] as String,
      json['periodUnit'] as String,
      json['periodNumberOfUnits'] as int,
      json['cycles'] as int,
    );

Map<String, dynamic> _$$_IntroductoryPriceToJson(
        _$_IntroductoryPrice instance) =>
    <String, dynamic>{
      'price': instance.introPrice,
      'priceString': instance.introPriceString,
      'period': instance.introPricePeriod,
      'periodUnit': instance.introPricePeriodUnit,
      'periodNumberOfUnits': instance.introPricePeriodNumberOfUnits,
      'cycles': instance.introPriceCycles,
    };
