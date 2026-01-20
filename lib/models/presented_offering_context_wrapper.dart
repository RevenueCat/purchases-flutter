import 'package:equatable/equatable.dart';

import 'presented_offering_targeting_context_wrapper.dart';

class PresentedOfferingContext extends Equatable {
  /// The identifier of the offering used to obtain this object
  final String offeringIdentifier;

  /// The identifier of the placement used to obtain this object
  final String? placementIdentifier;

  /// The revision of the targeting used to obtain this object
  final PresentedOfferingTargetingContext? targetingContext;

  const PresentedOfferingContext(
    this.offeringIdentifier,
    this.placementIdentifier,
    this.targetingContext,
  );

  toJson() => {
    'offeringIdentifier': offeringIdentifier,
    'placementIdentifier': placementIdentifier,
    'targetingContext': targetingContext?.toJson(),
  };

  factory PresentedOfferingContext.fromJson(Map<String, dynamic> json) => PresentedOfferingContext(
    json['offeringIdentifier'] as String,
    json['placementIdentifier'] as String?,
    json['targetingContext'] != null ? PresentedOfferingTargetingContext.fromJson(Map<String, dynamic>.from(json['targetingContext'])) : null,
  );

  @override
  List<Object?> get props => [
    offeringIdentifier,
    placementIdentifier,
    targetingContext,
  ];
}
