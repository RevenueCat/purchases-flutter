// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_product_discount.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoreProductDiscountImpl _$$StoreProductDiscountImplFromJson(Map json) =>
    _$StoreProductDiscountImpl(
      json['identifier'] as String,
      (json['price'] as num).toDouble(),
      json['priceString'] as String,
      json['cycles'] as int,
      json['period'] as String,
      json['periodUnit'] as String,
      json['periodNumberOfUnits'] as int,
    );

Map<String, dynamic> _$$StoreProductDiscountImplToJson(
        _$StoreProductDiscountImpl instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'price': instance.price,
      'priceString': instance.priceString,
      'cycles': instance.cycles,
      'period': instance.period,
      'periodUnit': instance.periodUnit,
      'periodNumberOfUnits': instance.periodNumberOfUnits,
    };
