// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_product_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_StoreProduct _$$_StoreProductFromJson(Map json) => _$_StoreProduct(
      json['identifier'] as String,
      json['description'] as String,
      json['title'] as String,
      (json['price'] as num).toDouble(),
      json['priceString'] as String,
      json['currencyCode'] as String,
      introductoryPrice: json['introPrice'] == null
          ? null
          : IntroductoryPrice.fromJson(
              Map<String, dynamic>.from(json['introPrice'] as Map)),
      discounts: (json['discounts'] as List<dynamic>?)
          ?.map((e) => StoreProductDiscount.fromJson(
              Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$$_StoreProductToJson(_$_StoreProduct instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'description': instance.description,
      'title': instance.title,
      'price': instance.price,
      'priceString': instance.priceString,
      'currencyCode': instance.currencyCode,
      'introPrice': instance.introductoryPrice?.toJson(),
      'discounts': instance.discounts?.map((e) => e.toJson()).toList(),
    };
