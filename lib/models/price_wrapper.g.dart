// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Price _$$_PriceFromJson(Map json) => _$_Price(
      json['formatted'] as String,
      json['amountMicros'] as int,
      json['currencyCode'] as String,
    );

Map<String, dynamic> _$$_PriceToJson(_$_Price instance) => <String, dynamic>{
      'formatted': instance.formatted,
      'amountMicros': instance.amountMicros,
      'currencyCode': instance.currencyCode,
    };
