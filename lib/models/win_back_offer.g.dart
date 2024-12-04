// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'win_back_offer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WinBackOfferImpl _$$WinBackOfferImplFromJson(Map json) => _$WinBackOfferImpl(
      json['identifier'] as String,
      (json['price'] as num).toDouble(),
      json['priceString'] as String,
      (json['cycles'] as num).toInt(),
      json['period'] as String,
      json['periodUnit'] as String,
      (json['periodNumberOfUnits'] as num).toInt(),
    );

Map<String, dynamic> _$$WinBackOfferImplToJson(_$WinBackOfferImpl instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'price': instance.price,
      'priceString': instance.priceString,
      'cycles': instance.cycles,
      'period': instance.period,
      'periodUnit': instance.periodUnit,
      'periodNumberOfUnits': instance.periodNumberOfUnits,
    };
