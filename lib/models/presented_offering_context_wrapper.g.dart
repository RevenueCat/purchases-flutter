// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presented_offering_context_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PresentedOfferingContextImpl _$$PresentedOfferingContextImplFromJson(
        Map json) =>
    _$PresentedOfferingContextImpl(
      json['offeringIdentifier'] as String,
      json['placementIdentifier'] as String?,
      json['targetingContext'] == null
          ? null
          : PresentedOfferingTargetingContext.fromJson(
              Map<String, dynamic>.from(json['targetingContext'] as Map)),
    );

Map<String, dynamic> _$$PresentedOfferingContextImplToJson(
        _$PresentedOfferingContextImpl instance) =>
    <String, dynamic>{
      'offeringIdentifier': instance.offeringIdentifier,
      'placementIdentifier': instance.placementIdentifier,
      'targetingContext': instance.targetingContext?.toJson(),
    };
