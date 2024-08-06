// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'installments_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InstallmentsInfoImpl _$$InstallmentsInfoImplFromJson(Map json) =>
    _$InstallmentsInfoImpl(
      (json['commitmentPaymentsCount'] as num).toInt(),
      (json['renewalCommitmentPaymentsCount'] as num).toInt(),
    );

Map<String, dynamic> _$$InstallmentsInfoImplToJson(
        _$InstallmentsInfoImpl instance) =>
    <String, dynamic>{
      'commitmentPaymentsCount': instance.commitmentPaymentsCount,
      'renewalCommitmentPaymentsCount': instance.renewalCommitmentPaymentsCount,
    };
