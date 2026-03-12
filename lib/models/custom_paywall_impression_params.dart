/// Parameters for tracking a custom paywall impression.
///
/// Use this class to provide additional context when tracking
/// custom paywall impressions with [Purchases.trackCustomPaywallImpression].
class CustomPaywallImpressionParams {
  /// An optional identifier for the paywall being displayed.
  final String? paywallId;

  /// Creates [CustomPaywallImpressionParams] with an optional [paywallId].
  const CustomPaywallImpressionParams({this.paywallId});
}
