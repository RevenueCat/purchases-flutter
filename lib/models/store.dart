/// Enum of supported stores
enum Store {
  /// For entitlements granted via Apple App Store.
  appStore,
  /// For entitlements granted via Apple Mac App Store.
  macAppStore,
  /// For entitlements granted via Google Play Store.
  playStore,
  /// For entitlements granted via Stripe.
  stripe,
  /// For entitlements granted via a promo in RevenueCat.
  promotional,
  /// For entitlements granted via an unknown store.
  unknownStore,
  /// For entitlements granted via Amazon Appstore.
  amazon,
  rcBilling,
  paddle,
  externalStore,
}
