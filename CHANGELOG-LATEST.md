We have opened a channel in our Discord server for participants in the Beta to ask questions and give feedback: https://discord.gg/wXEfBGem5n.

# iOS Updates

## StoreKit 2

Version 7.0 of the RevenueCat SDK enables full StoreKit 2 flow on the SDK and the RevenueCat backend by default.

We have been testing StoreKit 2 support in parallel to StoreKit 1 in our backend for a while and we believe it is ready for widespread use.

Here's some of the benefits you get with StoreKit 2:

- Better handling of a few specific edge cases which were unfixable with StoreKit 1:
- No more "Missing receipt" errors in Sandbox that could result in failure restoring purchases or getting trial eligibility status "unknown".
- No more "The purchased product was missing in the receipt" error that could cause an invalid receipt error when making a purchase.
- Future proofing:  StoreKit 1 APIs are being progressively deprecated by Apple, and new features are being added to StoreKit 2.

In order to use StoreKit 2, you will need to configure your [In-App Purchase Key](https://www.revenuecat.com/docs/in-app-purchase-key-configuration) in the RevenueCat dashboard.

The previously deprecated configuration option `usesStoreKit2IfAvailable` has been removed. Remove it from your configuration option to continue using StoreKit 2.

The SDK will automatically use StoreKit 1 where StoreKit 2 is not supported, in iOS 14 and earlier.

If for any reason you need to always use StoreKit 1, it is possible to switch back using the following configuration API:

```dart
await Purchases.configure(
    PurchasesConfiguration('api_key')
    ..storeKitVersion = StoreKitVersion.storeKit1,
);
```

### 3rd Party Analytics SDKs

If you are using any 3rd party analytics SDKs to automatically track in-app purchases, you need to be aware most of them do not completely support logging purchases made with StoreKit 2. This is the case for some popular SDKs like Facebook, Mixpanel, OneSignal, Segment or Firebase. For these services, we recommend you use our [data integrations](https://www.revenuecat.com/integrations/).

If you're using the Firebase SDK, you'll need to follow [these instructions](https://firebase.google.com/docs/analytics/measure-in-app-purchases#swift) to log purchases made with StoreKit 2.

### Observer Mode

Version 7.0 of the SDK introduces support for observer mode when making purchases with StoreKit 2. You can enable it when configuring the SDK:

```dart
await Purchases.configure(
    PurchasesConfiguration('api_key')
    ..storeKitVersion = StoreKitVersion.storeKit2,
    ..observerMode = true,
);
```

Additionally, because of the way in which StoreKit 2 operates, you must manually handle newly purchased transactions by calling `Purchases.handleObserverModeTransaction()`. Subscription updates will be automatically tracked.

```dart
# Your existing code to purchase a product with ID "product_id"
await purchaseProduct("product_id")

# Inform the SDK about the new purchase
await Purchases.handleObserverModeTransaction("product_id");
```

If you're using observer mode with StoreKit 1, you will need to explicitly configure the SDK to use StoreKit 1:

```dart
await Purchases.configure(
    PurchasesConfiguration('api_key')
    ..storeKitVersion = StoreKitVersion.storeKit1,
    ..observerMode = true,
);
```

### Original Application Version

If you're converting a paid app to in-app subscriptions, and want to provide existing customers with certain features, [we recommend](https://www.revenuecat.com/blog/engineering/converting-a-paid-ios-app-to-subscriptions/) using the "original app version" field in customer info.

Because of a limitation of StoreKit 2, this field is not available. If this is a requirement for you, we recommend switching back to StoreKit 1.

## Deployment Target

The minimum target has been raised to iOS 13.0 and macOS 10.15.

### Other Changes
* Update to PHC 10.0 via Mark Villacampa (@MarkVillacampa)