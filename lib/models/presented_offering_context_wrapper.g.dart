// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presented_offering_context_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PresentedOfferingContext _$PresentedOfferingContextFromJson(Map json) =>
    _PresentedOfferingContext(
      json['offeringIdentifier'] as String,
      json['placementIdentifier'] as String?,
      json['targetingContext'] == null
          ? null
          : PresentedOfferingTargetingContext.fromJson(
              Map<String, dynamic>.from(json['targetingContext'] as Map)),
    );

Map<String, dynamic> _$PresentedOfferingContextToJson(
        _PresentedOfferingContext instance) =>
    <String, dynamic>{
      'offeringIdentifier': instance.offeringIdentifier,
      'placementIdentifier': instance.placementIdentifier,
      'targetingContext': instance.targetingContext?.toJson(),
    };
