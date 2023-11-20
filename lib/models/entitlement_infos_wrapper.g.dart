// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entitlement_infos_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EntitlementInfosImpl _$$EntitlementInfosImplFromJson(Map json) =>
    _$EntitlementInfosImpl(
      (json['all'] as Map).map(
        (k, e) => MapEntry(k as String,
            EntitlementInfo.fromJson(Map<String, dynamic>.from(e as Map))),
      ),
      (json['active'] as Map).map(
        (k, e) => MapEntry(k as String,
            EntitlementInfo.fromJson(Map<String, dynamic>.from(e as Map))),
      ),
      verification: $enumDecodeNullable(
              _$VerificationResultEnumMap, json['verification']) ??
          VerificationResult.notRequested,
    );

Map<String, dynamic> _$$EntitlementInfosImplToJson(
        _$EntitlementInfosImpl instance) =>
    <String, dynamic>{
      'all': instance.all.map((k, e) => MapEntry(k, e.toJson())),
      'active': instance.active.map((k, e) => MapEntry(k, e.toJson())),
      'verification': _$VerificationResultEnumMap[instance.verification]!,
    };

const _$VerificationResultEnumMap = {
  VerificationResult.notRequested: 'NOT_REQUESTED',
  VerificationResult.verified: 'VERIFIED',
  VerificationResult.verifiedOnDevice: 'VERIFIED_ON_DEVICE',
  VerificationResult.failed: 'FAILED',
};
