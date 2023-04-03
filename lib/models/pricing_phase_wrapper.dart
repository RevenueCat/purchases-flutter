import 'package:freezed_annotation/freezed_annotation.dart';

import 'period_wrapper.dart';
import 'price_wrapper.dart';

part 'pricing_phase_wrapper.freezed.dart';
part 'pricing_phase_wrapper.g.dart';

@freezed

/// Contains all the details associated with a PricingPhase
class PricingPhase with _$PricingPhase {
  const factory PricingPhase(
    /// Billing period for which the PricingPhase applies
    @JsonKey(name: 'billingPeriod') Period billingPeriod,

    /// Recurrence mode of the PricingPhase
    @JsonKey(name: 'recurrenceMode', nullable: true)
        RecurrenceMode? recurrenceMode,

    /// Number of cycles for which the pricing phase applies.
    /// Null for INFINITE_RECURRING or NON_RECURRING recurrence modes.
    @JsonKey(name: 'billingCycleCount', nullable: true) int? billingCycleCount,

    /// Price of the PricingPhase
    @JsonKey(name: 'price') Price price,
  ) = _PricingPhase;

  factory PricingPhase.fromJson(Map<String, dynamic> json) =>
      _$PricingPhaseFromJson(json);
}

enum RecurrenceMode {
  @JsonValue(1)
  infiniteRecurring,
  @JsonValue(2)
  finiteRecurring,
  @JsonValue(3)
  nonRecurring,
  @JsonValue(null)
  unknown,
}
