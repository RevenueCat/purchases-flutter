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
  ;

  static fromJson(dynamic value) {
    switch (value) {
      case 'APP_STORE':
        return Store.appStore;
      case 'MAC_APP_STORE':
        return Store.macAppStore;
      case 'PLAY_STORE':
        return Store.playStore;
      case 'STRIPE':
        return Store.stripe;
      case 'PROMOTIONAL':
        return Store.promotional;
      case 'AMAZON':
        return Store.amazon;
      case 'RC_BILLING':
        return Store.rcBilling;
      case 'PADDLE':
        return Store.paddle;
      case 'EXTERNAL':
        return Store.externalStore;
      case null:
        return Store.unknownStore;
      default:
        return Store.unknownStore;
    }
  }

  String toJson() {
    switch (this) {
      case Store.appStore:
        return 'APP_STORE';
      case Store.macAppStore:
        return 'MAC_APP_STORE';
      case Store.playStore:
        return 'PLAY_STORE';
      case Store.stripe:
        return 'STRIPE';
      case Store.promotional:
        return 'PROMOTIONAL';
      case Store.amazon:
        return 'AMAZON';
      case Store.rcBilling:
        return 'RC_BILLING';
      case Store.paddle:
        return 'PADDLE';
      case Store.externalStore:
        return 'EXTERNAL';
      default:
        return 'unknownStore';
    }
  }
}
