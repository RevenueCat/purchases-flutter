import 'package:freezed_annotation/freezed_annotation.dart';

import 'period_wrapper.dart';
import 'price_wrapper.dart';

part 'pricing_phase_wrapper.freezed.dart';
part 'pricing_phase_wrapper.g.dart';

@freezed
class PricingPhase with _$PricingPhase {
  const factory PricingPhase(
    @JsonKey(name: 'billingPeriod') Period billingPeriod,
    @JsonKey(name: 'recurrenceMode', nullable: true) int? recurrenceMode,
    @JsonKey(name: 'billingCycleCount', nullable: true) int? billingCycleCount,
    @JsonKey(name: 'price') Price price,
  ) = _PricingPhase;

  factory PricingPhase.fromJson(Map<String, dynamic> json) =>
      _$PricingPhaseFromJson(json);
}
