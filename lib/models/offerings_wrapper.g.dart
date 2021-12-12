// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offerings_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Offerings _$$_OfferingsFromJson(Map json) => _$_Offerings(
      (json['all'] as Map).map(
        (k, e) => MapEntry(k as String,
            Offering.fromJson(Map<String, dynamic>.from(e as Map))),
      ),
      current: json['current'] == null
          ? null
          : Offering.fromJson(
              Map<String, dynamic>.from(json['current'] as Map)),
    );

Map<String, dynamic> _$$_OfferingsToJson(_$_Offerings instance) =>
    <String, dynamic>{
      'all': instance.all.map((k, e) => MapEntry(k, e.toJson())),
      'current': instance.current?.toJson(),
    };
