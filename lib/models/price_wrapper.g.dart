// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Price _$PriceFromJson(Map json) => _Price(
      json['formatted'] as String,
      (json['amountMicros'] as num).toInt(),
      json['currencyCode'] as String,
    );

Map<String, dynamic> _$PriceToJson(_Price instance) => <String, dynamic>{
      'formatted': instance.formatted,
      'amountMicros': instance.amountMicros,
      'currencyCode': instance.currencyCode,
    };
