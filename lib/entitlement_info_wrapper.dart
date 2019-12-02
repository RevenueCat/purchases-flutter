/// The EntitlementInfo object gives you access to all of the information about the status of a user entitlement.
class EntitlementInfo {
  /// The entitlement identifier configured in the RevenueCat dashboard
  final String identifier;

  /// True if the user has access to this entitlement
  final bool isActive;

  /// True if the underlying subscription is set to renew at the end of
  /// the billing period (expirationDate). Will always be True if entitlement
  /// is for lifetime access.
  final bool willRenew;

  /// The last period type this entitlement was in
  /// Either: normal, intro, trial
  final PeriodType periodType;

  /// The latest purchase or renewal date for the entitlement.
  final String latestPurchaseDate;

  /// The first date this entitlement was purchased
  final String originalPurchaseDate;

  /// The expiration date for the entitlement, can be `null` for lifetime access.
  /// If the `periodType` is `trial`, this is the trial expiration date.
  final String expirationDate;

  /// The store where this entitlement was unlocked from
  /// Either: appStore, macAppStore, playStore, stripe, promotional, unknownStore
  final Store store;

  /// The product identifier that unlocked this entitlement
  final String productIdentifier;

  /// False if this entitlement is unlocked via a production purchase
  final bool isSandbox;

  /// The date an unsubscribe was detected. Can be `null`.
  /// @note: Entitlement may still be active even if user has unsubscribed.
  /// Check the `isActive` property.
  final String unsubscribeDetectedAt;

  /// The date a billing issue was detected. Can be `nil` if there is no
  /// billing issue or an issue has been resolved.
  /// @note: Entitlement may still be active even if there is a billing issue.
  /// Check the `isActive` property.
  final String billingIssueDetectedAt;

  EntitlementInfo(
      this.identifier,
      this.isActive,
      this.willRenew,
      this.periodType,
      this.latestPurchaseDate,
      this.originalPurchaseDate,
      this.expirationDate,
      this.store,
      this.productIdentifier,
      this.isSandbox,
      this.unsubscribeDetectedAt,
      this.billingIssueDetectedAt);

  factory EntitlementInfo.fromJson(Map<dynamic, dynamic> json) {
    var periodType;
    switch (json["periodType"] as String) {
      case "INTRO":
        periodType = PeriodType.intro;
        break;
      case "NORMAL":
        periodType = PeriodType.normal;
        break;
      case "TRIAL":
        periodType = PeriodType.trial;
        break;
    }
    var store;
    switch (json["store"] as String) {
      case "APP_STORE":
        store = Store.appStore;
        break;
      case "MAC_APP_STORE":
        store = Store.macAppStore;
        break;
      case "PLAY_STORE":
        store = Store.playStore;
        break;
      case "STRIPE":
        store = Store.stripe;
        break;
      case "PROMOTIONAL":
        store = Store.promotional;
        break;
      case "UNKNOWN_STORE":
        store = Store.unknownStore;
        break;
    }
    return EntitlementInfo(
        json["identifier"] as String,
        json["isActive"] as bool,
        json["willRenew"] as bool,
        periodType,
        json["latestPurchaseDate"] as String,
        json["originalPurchaseDate"] as String,
        json["expirationDate"] as String,
        store,
        json["productIdentifier"] as String,
        json["isSandbox"] as bool,
        json["unsubscribeDetectedAt"] as String,
        json["billingIssueDetectedAt"] as String);
  }

  @override
  String toString() {
    return 'EntitlementInfo{identifier: $identifier, isActive: $isActive, willRenew: $willRenew, periodType: $periodType, latestPurchaseDate: $latestPurchaseDate, originalPurchaseDate: $originalPurchaseDate, expirationDate: $expirationDate, store: $store, productIdentifier: $productIdentifier, isSandbox: $isSandbox, unsubscribeDetectedAt: $unsubscribeDetectedAt, billingIssueDetectedAt: $billingIssueDetectedAt}';
  }
}

/// Enum of supported period types for an entitlement.
enum PeriodType {
  /// If the entitlement is under a introductory price period.
  intro,

  /// If the entitlement is not under an introductory or trial period.
  normal,

  /// If the entitlement is under a trial period.
  trial
}

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
  unknownStore
}
