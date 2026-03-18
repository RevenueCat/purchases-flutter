/// Parameters for tracking a custom paywall impression.
///
/// Use this class to provide additional context when tracking
/// custom paywall impressions with [Purchases.trackCustomPaywallImpression].
class CustomPaywallImpressionParams {
  /// An optional identifier for the paywall being displayed.
  final String? paywallId;

  /// An optional identifier for the offering associated with the custom paywall.
  /// If not provided, the SDK will use the current offering identifier from the
  /// cache.
  final String? offeringId;

  /// Creates [CustomPaywallImpressionParams] with an optional [paywallId]
  /// and [offeringId].
  const CustomPaywallImpressionParams({this.paywallId, this.offeringId});
}
