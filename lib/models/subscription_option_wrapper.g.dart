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
      (json['pricingPhases'] as List<dynamic>)
          .map(
              (e) => PricingPhase.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      json['isBasePlan'] as bool,
      json['billingPeriod'] == null
          ? null
          : Period.fromJson(
              Map<String, dynamic>.from(json['billingPeriod'] as Map)),
      json['isPrepaid'] as bool,
      json['fullPricePhase'] == null
          ? null
          : PricingPhase.fromJson(
              Map<String, dynamic>.from(json['fullPricePhase'] as Map)),
      json['freePhase'] == null
          ? null
          : PricingPhase.fromJson(
              Map<String, dynamic>.from(json['freePhase'] as Map)),
      json['introPhase'] == null
          ? null
          : PricingPhase.fromJson(
              Map<String, dynamic>.from(json['introPhase'] as Map)),
      json['presentedOfferingIdentifier'] as String?,
    );

Map<String, dynamic> _$$_SubscriptionOptionToJson(
        _$_SubscriptionOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'storeProductId': instance.storeProductId,
      'productId': instance.productId,
      'pricingPhases': instance.pricingPhases.map((e) => e.toJson()).toList(),
      'tags': instance.tags,
      'isBasePlan': instance.isBasePlan,
      'billingPeriod': instance.billingPeriod?.toJson(),
      'isPrepaid': instance.isPrepaid,
      'fullPricePhase': instance.fullPricePhase?.toJson(),
      'freePhase': instance.freePhase?.toJson(),
      'introPhase': instance.introPhase?.toJson(),
      'presentedOfferingIdentifier': instance.presentedOfferingIdentifier,
    };
