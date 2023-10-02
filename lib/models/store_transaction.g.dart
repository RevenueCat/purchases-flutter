// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoreTransactionImpl _$$StoreTransactionImplFromJson(Map json) =>
    _$StoreTransactionImpl(
      json['transactionIdentifier'] as String,
      _readRevenueCatIdentifier(json, 'revenueCatIdentifier') as String,
      json['productIdentifier'] as String,
      json['purchaseDate'] as String,
    );

Map<String, dynamic> _$$StoreTransactionImplToJson(
        _$StoreTransactionImpl instance) =>
    <String, dynamic>{
      'transactionIdentifier': instance.transactionIdentifier,
      'revenueCatIdentifier': instance.revenueCatIdentifier,
      'productIdentifier': instance.productIdentifier,
      'purchaseDate': instance.purchaseDate,
    };
