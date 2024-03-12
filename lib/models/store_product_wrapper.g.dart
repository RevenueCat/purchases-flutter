// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_product_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoreProductImpl _$$StoreProductImplFromJson(Map json) => _$StoreProductImpl(
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
      productCategory: $enumDecodeNullable(
          _$ProductCategoryEnumMap, json['productCategory']),
      defaultOption: json['defaultOption'] == null
          ? null
          : SubscriptionOption.fromJson(
              Map<String, dynamic>.from(json['defaultOption'] as Map)),
      subscriptionOptions: (json['subscriptionOptions'] as List<dynamic>?)
          ?.map((e) =>
              SubscriptionOption.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      presentedOfferingContext: json['presentedOfferingContext'] == null
          ? null
          : PresentedOfferingContext.fromJson(Map<String, dynamic>.from(
              json['presentedOfferingContext'] as Map)),
      subscriptionPeriod: json['subscriptionPeriod'] as String?,
    );

Map<String, dynamic> _$$StoreProductImplToJson(_$StoreProductImpl instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'description': instance.description,
      'title': instance.title,
      'price': instance.price,
      'priceString': instance.priceString,
      'currencyCode': instance.currencyCode,
      'introPrice': instance.introductoryPrice?.toJson(),
      'discounts': instance.discounts?.map((e) => e.toJson()).toList(),
      'productCategory': _$ProductCategoryEnumMap[instance.productCategory],
      'defaultOption': instance.defaultOption?.toJson(),
      'subscriptionOptions':
          instance.subscriptionOptions?.map((e) => e.toJson()).toList(),
      'presentedOfferingContext': instance.presentedOfferingContext?.toJson(),
      'subscriptionPeriod': instance.subscriptionPeriod,
    };

const _$ProductCategoryEnumMap = {
  ProductCategory.nonSubscription: 'NON_SUBSCRIPTION',
  ProductCategory.subscription: 'SUBSCRIPTION',
};
