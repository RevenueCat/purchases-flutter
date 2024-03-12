// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PackageImpl _$$PackageImplFromJson(Map json) => _$PackageImpl(
      json['identifier'] as String,
      $enumDecode(_$PackageTypeEnumMap, json['packageType'],
          unknownValue: PackageType.unknown),
      StoreProduct.fromJson(Map<String, dynamic>.from(json['product'] as Map)),
      PresentedOfferingContext.fromJson(
          Map<String, dynamic>.from(json['presentedOfferingContext'] as Map)),
    );

Map<String, dynamic> _$$PackageImplToJson(_$PackageImpl instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'packageType': _$PackageTypeEnumMap[instance.packageType]!,
      'product': instance.storeProduct.toJson(),
      'presentedOfferingContext': instance.presentedOfferingContext.toJson(),
    };

const _$PackageTypeEnumMap = {
  PackageType.unknown: 'UNKNOWN',
  PackageType.custom: 'CUSTOM',
  PackageType.lifetime: 'LIFETIME',
  PackageType.annual: 'ANNUAL',
  PackageType.sixMonth: 'SIX_MONTH',
  PackageType.threeMonth: 'THREE_MONTH',
  PackageType.twoMonth: 'TWO_MONTH',
  PackageType.monthly: 'MONTHLY',
  PackageType.weekly: 'WEEKLY',
};
