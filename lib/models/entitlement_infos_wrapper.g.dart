// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entitlement_infos_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EntitlementInfos _$$_EntitlementInfosFromJson(Map json) =>
    _$_EntitlementInfos(
      (json['all'] as Map).map(
        (k, e) => MapEntry(k as String,
            EntitlementInfo.fromJson(Map<String, dynamic>.from(e as Map))),
      ),
      (json['active'] as Map).map(
        (k, e) => MapEntry(k as String,
            EntitlementInfo.fromJson(Map<String, dynamic>.from(e as Map))),
      ),
    );

Map<String, dynamic> _$$_EntitlementInfosToJson(_$_EntitlementInfos instance) =>
    <String, dynamic>{
      'all': instance.all.map((k, e) => MapEntry(k, e.toJson())),
      'active': instance.active.map((k, e) => MapEntry(k, e.toJson())),
    };
