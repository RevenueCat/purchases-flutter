// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'installments_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InstallmentsInfo _$InstallmentsInfoFromJson(Map json) => _InstallmentsInfo(
      (json['commitmentPaymentsCount'] as num).toInt(),
      (json['renewalCommitmentPaymentsCount'] as num).toInt(),
    );

Map<String, dynamic> _$InstallmentsInfoToJson(_InstallmentsInfo instance) =>
    <String, dynamic>{
      'commitmentPaymentsCount': instance.commitmentPaymentsCount,
      'renewalCommitmentPaymentsCount': instance.renewalCommitmentPaymentsCount,
    };
