import 'package:freezed_annotation/freezed_annotation.dart';

import 'period_wrapper.dart';
import 'pricing_phase_wrapper.dart';

part 'subscription_option_wrapper.freezed.dart';
part 'subscription_option_wrapper.g.dart';

@freezed
class SubscriptionOption with _$SubscriptionOption {
  const factory SubscriptionOption(
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'storeProductId') String storeProductId,
    @JsonKey(name: 'productId') String productId,
    @JsonKey(name: 'pricingPhases') List<PricingPhase> pricingPhases,
    @JsonKey(name: 'tags') List<String> tags,
    @JsonKey(name: 'isBasePlan') bool isBasePlan,
    @JsonKey(name: 'billingPeriod', nullable: true) Period? billingPeriod,
    @JsonKey(name: 'fullPricePhase', nullable: true)
        PricingPhase? fullPricePhase,
    @JsonKey(name: 'freePhase', nullable: true) PricingPhase? freePhase,
    @JsonKey(name: 'introPhase', nullable: true) PricingPhase? introPhase,
  ) = _SubscriptionOption;

  factory SubscriptionOption.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionOptionFromJson(json);
}
