// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricing_phase_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PricingPhase _$$_PricingPhaseFromJson(Map json) => _$_PricingPhase(
      Period.fromJson(Map<String, dynamic>.from(json['billingPeriod'] as Map)),
      json['recurrenceMode'] as int?,
      json['billingCycleCount'] as int?,
      Price.fromJson(Map<String, dynamic>.from(json['price'] as Map)),
    );

Map<String, dynamic> _$$_PricingPhaseToJson(_$_PricingPhase instance) =>
    <String, dynamic>{
      'billingPeriod': instance.billingPeriod.toJson(),
      'recurrenceMode': instance.recurrenceMode,
      'billingCycleCount': instance.billingCycleCount,
      'price': instance.price.toJson(),
    };
