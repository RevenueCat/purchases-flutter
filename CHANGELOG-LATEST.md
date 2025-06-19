## RevenueCat SDK
### 💥 Breaking Changes
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

### New Features
* [Beta] Flutter Web support (#1237) via Toni Rico (@tonidero)

In order to use Flutter Web, you need to create a new Web Billing project (See [docs](https://www.revenuecat.com/docs/web/web-billing/overview)), then configure the SDK with the provided API key, in the form of `rcb_xxx` or `rcb_sb_xxx`.

Web functionality is currently limited. Supported functionality includes:
- Configuration
- Login/logout
- Fetching Offerings
- Fetching CustomerInfo
- Purchasing Packages

Currently unsupported functionality includes:
- Setting attributes
- Product operations (get products/purchase products).
- Restoring purchases (Purchases can be restored using Web Billing's built-in mechanisms)

Please check this out and contact us with any feedback!

