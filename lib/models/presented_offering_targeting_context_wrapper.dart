import 'package:freezed_annotation/freezed_annotation.dart';

part 'presented_offering_targeting_context_wrapper.freezed.dart';
part 'presented_offering_targeting_context_wrapper.g.dart';

@freezed

/// Contains all the details associated with a PresentedOfferingContext
class PresentedOfferingTargetingContext
    with _$PresentedOfferingTargetingContext {
  const factory PresentedOfferingTargetingContext(
    /// The revision of the targeting used to obtain this object
    int revision,

    /// The rule id from the targeting used to obtain this object
    String ruleId,
  ) = _PresentedOfferingTargetingContext;

  factory PresentedOfferingTargetingContext.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PresentedOfferingTargetingContextFromJson(json);
}
