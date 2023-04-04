// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricing_phase_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PricingPhase _$$_PricingPhaseFromJson(Map json) => _$_PricingPhase(
      json['billingPeriod'] == null
          ? null
          : Period.fromJson(
              Map<String, dynamic>.from(json['billingPeriod'] as Map)),
      $enumDecodeNullable(_$RecurrenceModeEnumMap, json['recurrenceMode']),
      json['billingCycleCount'] as int?,
      Price.fromJson(Map<String, dynamic>.from(json['price'] as Map)),
    );

Map<String, dynamic> _$$_PricingPhaseToJson(_$_PricingPhase instance) =>
    <String, dynamic>{
      'billingPeriod': instance.billingPeriod?.toJson(),
      'recurrenceMode': _$RecurrenceModeEnumMap[instance.recurrenceMode],
      'billingCycleCount': instance.billingCycleCount,
      'price': instance.price.toJson(),
    };

const _$RecurrenceModeEnumMap = {
  RecurrenceMode.infiniteRecurring: 1,
  RecurrenceMode.finiteRecurring: 2,
  RecurrenceMode.nonRecurring: 3,
  RecurrenceMode.unknown: null,
};
