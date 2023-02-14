// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_StoreTransaction _$$_StoreTransactionFromJson(Map json) =>
    _$_StoreTransaction(
      json['transactionIdentifier'] as String,
      json['revenueCatId'] as String,
      json['productIdentifier'] as String,
      json['purchaseDate'] as String,
    );

Map<String, dynamic> _$$_StoreTransactionToJson(_$_StoreTransaction instance) =>
    <String, dynamic>{
      'transactionIdentifier': instance.transactionIdentifier,
      'revenueCatId': instance.revenueCatIdentifier,
      'productIdentifier': instance.productIdentifier,
      'purchaseDate': instance.purchaseDate,
    };
