import 'package:freezed_annotation/freezed_annotation.dart';

import 'period_wrapper.dart';
import 'pricing_phase_wrapper.dart';

part 'subscription_option_wrapper.freezed.dart';
part 'subscription_option_wrapper.g.dart';

@freezed

/// Contains all details associated with a SubscriptionOption
/// Used only for Google
class SubscriptionOption with _$SubscriptionOption {
  const factory SubscriptionOption(
    /// Identifier of the subscription option
    /// If this SubscriptionOption represents a base plan, this will be the basePlanId.
    /// If it represents an offer, it will be {basePlanId}:{offerId}
    @JsonKey(name: 'id') String id,

    /// Identifier of the StoreProduct associated with this SubscriptionOption
    /// This will be {subId}:{basePlanId}
    @JsonKey(name: 'storeProductId') String storeProductId,

    /// Identifer of the subscription associated with this SubsriptionOption
    /// This will be {subId}
    @JsonKey(name: 'productId') String productId,

    /// Pricing phases defining a user's payment plan for the product over time.
    @JsonKey(name: 'pricingPhases') List<PricingPhase> pricingPhases,

    /// Tags defined on the base plan or offer.
    @JsonKey(name: 'tags') List<String> tags,

    /// True if this SubscriptionOption represents a Google subscription base plan (rather than an offer).
    @JsonKey(name: 'isBasePlan') bool isBasePlan,

    /// The subscription period of fullPricePhase (after free and intro trials).
    @JsonKey(name: 'billingPeriod') Period? billingPeriod,

    /// True if the subscription is pre-paid.
    @JsonKey(name: 'isPrepaid') bool isPrepaid,

    /// The full price PricingPhase of the subscription.
    /// Looks for the last price phase of the SubscriptionOption.
    @JsonKey(name: 'fullPricePhase') PricingPhase? fullPricePhase,

    /// The free trial PricingPhase of the subscription.
    /// Looks for the first pricing phase of the SubscriptionOption where amountMicros is 0.
    /// There can be a freeTrialPhase and an introductoryPhase in the same SubscriptionOption.
    @JsonKey(name: 'freePhase') PricingPhase? freePhase,

    /// The intro trial PricingPhase of the subscription.
    /// Looks for the first pricing phase of the SubscriptionOption where amountMicros is greater than 0.
    /// There can be a freeTrialPhase and an introductoryPhase in the same SubscriptionOption.
    @JsonKey(name: 'introPhase') PricingPhase? introPhase,

    // Offering identifier the subscriptioni option was presented from
    @JsonKey(name: 'presentedOfferingIdentifier')
    String? presentedOfferingIdentifier,
  ) = _SubscriptionOption;

  factory SubscriptionOption.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionOptionFromJson(json);
}
