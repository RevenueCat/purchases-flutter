// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_StoreTransaction _$$_StoreTransactionFromJson(Map json) =>
    _$_StoreTransaction(
      json['revenueCatId'] as String,
      json['productId'] as String,
      json['purchaseDate'] as String,
    );

Map<String, dynamic> _$$_StoreTransactionToJson(_$_StoreTransaction instance) =>
    <String, dynamic>{
      'revenueCatId': instance.revenueCatIdentifier,
      'productId': instance.productIdentifier,
      'purchaseDate': instance.purchaseDate,
    };
