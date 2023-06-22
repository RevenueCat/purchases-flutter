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
    Period? billingPeriod,

    /// Recurrence mode of the PricingPhase
    RecurrenceMode? recurrenceMode,

    /// Number of cycles for which the pricing phase applies.
    /// Null for infiniteRecurring or finiteRecurring recurrence modes.
    int? billingCycleCount,

    /// Price of the PricingPhase
    Price price,

    /// Indicates how the pricing phase is charged for finiteRecurring pricing phases
    OfferPaymentMode? offerPaymentMode,
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

enum OfferPaymentMode {
  // Subscribers don't pay until the specified period ends
  @JsonValue('FREE_TRIAL')
  freeTrial,

  // Subscribers pay up front for a specified period
  @JsonValue('SINGLE_PAYMENT')
  singlePayment,

  // Subscribers pay a discounted amount for a specified number of periods
  @JsonValue('DISCOUNTED_RECURRING_PAYMENT')
  discountedRecurringPayment,
}
