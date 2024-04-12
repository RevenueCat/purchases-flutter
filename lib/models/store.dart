import 'package:freezed_annotation/freezed_annotation.dart';

/// Enum of supported stores
enum Store {
  /// For entitlements granted via Apple App Store.
  @JsonValue('APP_STORE')
  appStore,

  /// For entitlements granted via Apple Mac App Store.
  @JsonValue('MAC_APP_STORE')
  macAppStore,

  /// For entitlements granted via Google Play Store.
  @JsonValue('PLAY_STORE')
  playStore,

  /// For entitlements granted via Stripe.
  @JsonValue('STRIPE')
  stripe,

  /// For entitlements granted via a promo in RevenueCat.
  @JsonValue('PROMOTIONAL')
  promotional,

  /// For entitlements granted via an unknown store.
  unknownStore,

  /// For entitlements granted via Amazon Appstore.
  @JsonValue('AMAZON')
  amazon,

  @JsonValue('RC_BILLING')
  rcBilling,

  @JsonValue('EXTERNAL')
  externalStore,
}
