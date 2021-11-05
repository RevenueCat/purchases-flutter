// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_discount.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PaymentDiscount _$$_PaymentDiscountFromJson(Map json) => _$_PaymentDiscount(
      json['identifier'] as String,
      json['keyIdentifier'] as String,
      json['nonce'] as String,
      json['signature'] as String,
      json['timestamp'] as int,
    );

Map<String, dynamic> _$$_PaymentDiscountToJson(_$_PaymentDiscount instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'keyIdentifier': instance.keyIdentifier,
      'nonce': instance.nonce,
      'signature': instance.signature,
      'timestamp': instance.timestamp,
    };
