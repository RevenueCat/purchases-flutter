## RevenueCat SDK
### 💥 Breaking Changes
* Play Billing Library 8 update

This release updates the SDK to use Google Play Billing Library 8. This version of the Billing Library removed APIs to query for expired subscriptions and consumed one-time products, aside from other improvements. You can check the full list of changes here: https://developer.android.com/google/play/billing/release-notes#8-0-0

#### No expired subscriptions or consumed one-time products
Note: the following is only relevant if you recently integrated RevenueCat, and do not (yet) have all your transactions imported.

Play Billing Library 8 removed functionality to query expired subscriptions or consumed one-time products. This means that, for users migrating from a non-RevenueCat implementation of the Play Billing Library, the SDK will not be able to send purchase information from these purchases. We can still ingest historical data from these purchases through a backend historical import. See [docs](https://www.revenuecat.com/docs/migrating-to-revenuecat/migrating-existing-subscriptions). This doesn't affect developers that have all transactions in RevenueCat, which is true for the vast majority.

#### Using the SDK with your own IAP code (previously Observer Mode)
Using the SDK with your own IAP code is still supported in v9. Other than updating the SDK version, there are no changes required. Just make sure the version of the Play Billing Library is also version 8.0.0+.

* Increased min Flutter SDK to 3.22.0 and Dart min SDK to 3.4.0

* Remove freezed in favor of manually parsed models (#1368) via Toni Rico (@tonidero)
   * This removed some APIs like `toJson`, `StoreTransaction.revenueCatIdentifier`
   * This also modified our APIs to use WebPurchaseRedemptionResult. Now you will need to do:
```
WebPurchaseRedemptionResult result;
switch (result) {
  case WebPurchaseRedemptionSuccess(:final customerInfo):
    // Handle successful redemption
    break;
  case WebPurchaseRedemptionError(:final error):
    // Handle error in redemption
    break;
  case WebPurchaseRedemptionPurchaseBelongsToOtherUser():
    // Handle case where the purchase belongs to another user
    break;
  case WebPurchaseRedemptionInvalidToken():
    // Handle case where the token is invalid
    break;
  case WebPurchaseRedemptionExpired(:final obfuscatedEmail):
    // Handle case where the redemption link has expired
    break;
};
```

* Change result of purchase methods to PurchaseResult (#1408) via Toni Rico (@tonidero)
   * The result of the purchase methods is now a `PurchaseResult` object instead of a `CustomerInfo` object. The `PurchaseResult` object contains a `CustomerInfo` object updated with the latest customer information after the purchase is made, and the `StoreTransaction` object created by the purchase.

### New features

* Flutter Web (#1407) via Toni Rico (@tonidero)
   * Now, the SDK supports Flutter Web! This means you can create an app that works on iOS, Android, and Web with the same codebase. The web support makes use of RevenueCat's [Web Billing](https://www.revenuecat.com/docs/web/web-billing/overview) engine, so please report any issues you find.

### List of changes
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 15.0.0 (#1406) via RevenueCat Git Bot (@RCGitBot)
   * [Android 9.1.0](https://github.com/RevenueCat/purchases-android/releases/tag/9.1.0)
   * [Android 9.0.1](https://github.com/RevenueCat/purchases-android/releases/tag/9.0.1)
   * [Android 9.0.0](https://github.com/RevenueCat/purchases-android/releases/tag/9.0.0)
   * [iOS 5.33.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.33.0)
* Flutter Web + Remove freezed dependency (#1407) via Toni Rico (@tonidero)
### 📦 Dependency Updates
* [RENOVATE] Update build-dependencies to v8.11.1 (#1402) via RevenueCat Git Bot (@RCGitBot)

### 🔄 Other Changes
* Bump fastlane from 2.227.2 to 2.228.0 (#1360) via dependabot[bot] (@dependabot[bot])
* Bump fastlane-plugin-revenuecat_internal from `05ef095` to `7d97553` (#1381) via dependabot[bot] (@dependabot[bot])
