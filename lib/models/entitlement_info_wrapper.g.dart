// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entitlement_info_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EntitlementInfoImpl _$$EntitlementInfoImplFromJson(Map json) =>
    _$EntitlementInfoImpl(
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
      productPlanIdentifier: json['productPlanIdentifier'] as String?,
      verification: $enumDecodeNullable(
              _$VerificationResultEnumMap, json['verification']) ??
          VerificationResult.notRequested,
    );

Map<String, dynamic> _$$EntitlementInfoImplToJson(
        _$EntitlementInfoImpl instance) =>
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
      'productPlanIdentifier': instance.productPlanIdentifier,
      'verification': _$VerificationResultEnumMap[instance.verification]!,
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
  Store.rcBilling: 'RC_BILLING',
  Store.paddle: 'PADDLE',
  Store.externalStore: 'EXTERNAL',
};

const _$PeriodTypeEnumMap = {
  PeriodType.intro: 'INTRO',
  PeriodType.normal: 'NORMAL',
  PeriodType.trial: 'TRIAL',
  PeriodType.prepaid: 'PREPAID',
  PeriodType.unknown: 'unknown',
};

const _$VerificationResultEnumMap = {
  VerificationResult.notRequested: 'NOT_REQUESTED',
  VerificationResult.verified: 'VERIFIED',
  VerificationResult.verifiedOnDevice: 'VERIFIED_ON_DEVICE',
  VerificationResult.failed: 'FAILED',
};
