// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entitlement_info_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EntitlementInfo _$$_EntitlementInfoFromJson(Map json) => _$_EntitlementInfo(
      json['identifier'] as String,
      json['isActive'] as bool,
      json['willRenew'] as bool,
      json['latestPurchaseDate'] as String,
      json['originalPurchaseDate'] as String,
      json['productIdentifier'] as String,
      json['isSandbox'] as bool,
      ownershipType: $enumDecodeNullable(
              _$OwnershipTypeEnumMap, json['ownershipType'],
              unknownValue: OwnershipType.unknown) ??
          OwnershipType.unknown,
      store: $enumDecodeNullable(_$StoreEnumMap, json['store'],
              unknownValue: Store.unknownStore) ??
          Store.unknownStore,
      periodType: $enumDecodeNullable(_$PeriodTypeEnumMap, json['periodType'],
              unknownValue: PeriodType.unknown) ??
          PeriodType.unknown,
      expirationDate: json['expirationDate'] as String?,
      unsubscribeDetectedAt: json['unsubscribeDetectedAt'] as String?,
      billingIssueDetectedAt: json['billingIssueDetectedAt'] as String?,
    );

Map<String, dynamic> _$$_EntitlementInfoToJson(_$_EntitlementInfo instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'isActive': instance.isActive,
      'willRenew': instance.willRenew,
      'latestPurchaseDate': instance.latestPurchaseDate,
      'originalPurchaseDate': instance.originalPurchaseDate,
      'productIdentifier': instance.productIdentifier,
      'isSandbox': instance.isSandbox,
      'ownershipType': _$OwnershipTypeEnumMap[instance.ownershipType]!,
      'store': _$StoreEnumMap[instance.store]!,
      'periodType': _$PeriodTypeEnumMap[instance.periodType]!,
      'expirationDate': instance.expirationDate,
      'unsubscribeDetectedAt': instance.unsubscribeDetectedAt,
      'billingIssueDetectedAt': instance.billingIssueDetectedAt,
    };

const _$OwnershipTypeEnumMap = {
  OwnershipType.purchased: 'PURCHASED',
  OwnershipType.familyShared: 'FAMILY_SHARED',
  OwnershipType.unknown: 'UNKNOWN',
};

const _$StoreEnumMap = {
  Store.appStore: 'APP_STORE',
  Store.macAppStore: 'MAC_APP_STORE',
  Store.playStore: 'PLAY_STORE',
  Store.stripe: 'STRIPE',
  Store.promotional: 'PROMOTIONAL',
  Store.unknownStore: 'unknownStore',
  Store.amazon: 'AMAZON',
};

const _$PeriodTypeEnumMap = {
  PeriodType.intro: 'INTRO',
  PeriodType.normal: 'NORMAL',
  PeriodType.trial: 'TRIAL',
  PeriodType.unknown: 'unknown',
};
