// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Product _$$_ProductFromJson(Map json) => _$_Product(
      json['identifier'] as String,
      json['description'] as String,
      json['title'] as String,
      (json['price'] as num).toDouble(),
      json['price_string'] as String,
      json['currency_code'] as String,
      introductoryPrice: json['introPrice'] == null
          ? null
          : IntroductoryPrice.fromJson(
              Map<String, dynamic>.from(json['introPrice'] as Map)),
      discounts: (json['discounts'] as List<dynamic>?)
          ?.map((e) => Discount.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$$_ProductToJson(_$_Product instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'description': instance.description,
      'title': instance.title,
      'price': instance.price,
      'price_string': instance.priceString,
      'currency_code': instance.currencyCode,
      'introPrice': instance.introductoryPrice?.toJson(),
      'discounts': instance.discounts?.map((e) => e.toJson()).toList(),
    };
