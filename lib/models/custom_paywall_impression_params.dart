import 'offering_wrapper.dart';

/// Parameters for tracking a custom paywall impression.
///
/// Use this class to provide additional context when tracking
/// custom paywall impressions with [Purchases.trackCustomPaywallImpression].
class CustomPaywallImpressionParams {
  /// An optional identifier for the paywall being displayed.
  final String? paywallId;

  /// The offering associated with the custom paywall.
  ///
  /// Pass the offering object so RevenueCat can track placement and targeting
  /// context for placement-resolved offerings.
  final Offering? offering;

  /// An optional identifier for the offering associated with the custom paywall.
  ///
  /// Deprecated. Pass [offering] instead so RevenueCat can track placement and
  /// targeting context.
  @Deprecated('Use offering instead.')
  final String? offeringId;

  /// Creates [CustomPaywallImpressionParams] with optional context.
  const CustomPaywallImpressionParams({
    this.paywallId,
    this.offering,
    @Deprecated('Use offering instead.') this.offeringId,
  });
}
