// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotional_offer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PromotionalOffer _$$_PromotionalOfferFromJson(Map json) =>
    _$_PromotionalOffer(
      json['identifier'] as String,
      json['keyIdentifier'] as String,
      json['nonce'] as String,
      json['signature'] as String,
      json['timestamp'] as int,
    );

Map<String, dynamic> _$$_PromotionalOfferToJson(_$_PromotionalOffer instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'keyIdentifier': instance.keyIdentifier,
      'nonce': instance.nonce,
      'signature': instance.signature,
      'timestamp': instance.timestamp,
    };
