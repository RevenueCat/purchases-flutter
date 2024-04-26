// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricing_phase_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PricingPhaseImpl _$$PricingPhaseImplFromJson(Map json) => _$PricingPhaseImpl(
      json['billingPeriod'] == null
          ? null
          : Period.fromJson(
              Map<String, dynamic>.from(json['billingPeriod'] as Map)),
      $enumDecodeNullable(_$RecurrenceModeEnumMap, json['recurrenceMode']),
      (json['billingCycleCount'] as num?)?.toInt(),
      Price.fromJson(Map<String, dynamic>.from(json['price'] as Map)),
      $enumDecodeNullable(_$OfferPaymentModeEnumMap, json['offerPaymentMode']),
    );

Map<String, dynamic> _$$PricingPhaseImplToJson(_$PricingPhaseImpl instance) =>
    <String, dynamic>{
      'billingPeriod': instance.billingPeriod?.toJson(),
      'recurrenceMode': _$RecurrenceModeEnumMap[instance.recurrenceMode],
      'billingCycleCount': instance.billingCycleCount,
      'price': instance.price.toJson(),
      'offerPaymentMode': _$OfferPaymentModeEnumMap[instance.offerPaymentMode],
    };

const _$RecurrenceModeEnumMap = {
  RecurrenceMode.infiniteRecurring: 1,
  RecurrenceMode.finiteRecurring: 2,
  RecurrenceMode.nonRecurring: 3,
  RecurrenceMode.unknown: null,
};

const _$OfferPaymentModeEnumMap = {
  OfferPaymentMode.freeTrial: 'FREE_TRIAL',
  OfferPaymentMode.singlePayment: 'SINGLE_PAYMENT',
  OfferPaymentMode.discountedRecurringPayment: 'DISCOUNTED_RECURRING_PAYMENT',
};
