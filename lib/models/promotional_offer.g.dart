// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotional_offer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PromotionalOfferImpl _$$PromotionalOfferImplFromJson(Map json) =>
    _$PromotionalOfferImpl(
      json['identifier'] as String,
      json['keyIdentifier'] as String,
      json['nonce'] as String,
      json['signature'] as String,
      (json['timestamp'] as num).toInt(),
    );

Map<String, dynamic> _$$PromotionalOfferImplToJson(
        _$PromotionalOfferImpl instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'keyIdentifier': instance.keyIdentifier,
      'nonce': instance.nonce,
      'signature': instance.signature,
      'timestamp': instance.timestamp,
    };
