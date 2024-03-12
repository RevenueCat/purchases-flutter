import 'package:freezed_annotation/freezed_annotation.dart';

import 'presented_offering_targeting_context_wrapper.dart';

part 'presented_offering_context_wrapper.freezed.dart';
part 'presented_offering_context_wrapper.g.dart';

@freezed

/// Contains all the details associated with a PresentedOfferingContext
class PresentedOfferingContext with _$PresentedOfferingContext {
  const factory PresentedOfferingContext(
    /// The identifier of the offering used to obtain this object
    String offeringIdentifier,

    /// The identifier of the placement used to obtain this object
    String? placementIdentifier,

    /// The revision of the targeting used to obtain this object
    PresentedOfferingTargetingContext? targetingContext,
  ) = _PresentedOfferingContext;

  factory PresentedOfferingContext.fromJson(Map<String, dynamic> json) =>
      _$PresentedOfferingContextFromJson(json);
}
