// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PriceImpl _$$PriceImplFromJson(Map json) => _$PriceImpl(
      json['formatted'] as String,
      (json['amountMicros'] as num).toInt(),
      json['currencyCode'] as String,
    );

Map<String, dynamic> _$$PriceImplToJson(_$PriceImpl instance) =>
    <String, dynamic>{
      'formatted': instance.formatted,
      'amountMicros': instance.amountMicros,
      'currencyCode': instance.currencyCode,
    };
