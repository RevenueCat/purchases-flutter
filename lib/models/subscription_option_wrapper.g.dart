// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_option_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SubscriptionOption _$$_SubscriptionOptionFromJson(Map json) =>
    _$_SubscriptionOption(
      json['id'] as String,
      json['storeProductId'] as String,
      json['productId'] as String,
      (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      json['isBasePlan'] as bool,
    );

Map<String, dynamic> _$$_SubscriptionOptionToJson(
        _$_SubscriptionOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'storeProductId': instance.storeProductId,
      'productId': instance.productId,
      'tags': instance.tags,
      'isBasePlan': instance.isBasePlan,
    };
