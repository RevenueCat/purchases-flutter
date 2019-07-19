<p align="center">
  <img src="https://www.revenuecat.com/assets/images/build.svg" alt="RevenueCat"/>
</p>
<h3 align="center">😻 In-app Subscriptions Made Easy 😻</h1>

[![pub package](https://img.shields.io/pub/v/purchases_flutter.svg)](https://pub.dartlang.org/packages/purchases_flutter)

## purchases_flutter

*purchases_flutter* is a client for the [RevenueCat](https://www.revenuecat.com/) subscription and purchase tracking system. It is an open source framework that provides a wrapper around `StoreKit`, `Google Play Billing` and the RevenueCat backend to make implementing in-app subscriptions in `Flutter` easy - receipt validation and status tracking included!

## Features
|   | RevenueCat |
| --- | --- |
✅ | Server-side receipt validation
➡️ | [Webhooks](https://docs.revenuecat.com/docs/webhooks) - enhanced server-to-server communication with events for purchases, renewals, cancellations, and more  
🖥 | macOS support  
🎯 | Subscription status tracking - know whether a user is subscribed whether they're on iOS, Android or web  
📊 | Analytics - automatic calculation of metrics like conversion, mrr, and churn  
📝 | [Online documentation](https://docs.revenuecat.com/docs) up to date  
🔀 | [Integrations](https://www.revenuecat.com/integrations) - over a dozen integrations to easily send purchase data where you need it  
💯 | Well maintained - [frequent releases](https://github.com/RevenueCat/purchases-flutter/releases)  
📮 | Great support - [Help Center](https://docs.revenuecat.com/discuss)  
🤩 | Awesome [new features](https://trello.com/b/RZRnWRbI/revenuecat-product-roadmap)  

## Installation

To use this plugin, add `purchases_flutter` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

### Requirements
*purchases_flutter* requires XCode 10.2+ and minimum targets iOS 9.0+ and macOS 10.12+

## Getting Started
For more detailed information, you can view our complete documentation at [docs.revenuecat.com](https://docs.revenuecat.com/docs).

#### 1. Get a RevenueCat API key

Log in to the [RevenueCat dashboard](https://app.revenuecat.com) and obtain a free API key for your application.

#### 2. Initialize an `Purchases` object
> Don't forget to enable the In-App Purchase capability for your project under `Project Target -> Capabilities -> In-App Purchase`

You should only configure *Purchases* once (usually on app launch) as soon as your app has a unique user id for your user. This can be when a user logs in if you have accounts or on launch if you can generate a random user identifier.

```dart
import 'package:purchases_flutter/purchases_flutter.dart';

Purchases.setDebugLogsEnabled(true);
await Purchases.setup("my_api_key");
```

#### 3. Displaying Available Products
*Purchases* will automatically fetch the latest *active* entitlements and get the product information from Apple or Google. This means when users launch your purchase screen, products will already be loaded.

Below is an example of fetching entitlements and launching an upsell screen.

```dart
try {
  Map<String, Entitlement> entitlements = await Purchases.getEntitlements();
} on PlatformException catch(e) {
  
}
```

#### 4. Make a purchase
When it comes time to make a purchase, *Purchases* has a simple method, `makePurchase`. The code sample below shows the process of purchasing a product and confirming it unlocks the "my_entitlement_identifier" content.

```dart
try {
  PurchaserInfo purchaserInfo = await Purchases.makePurchase(product.identifier);
  var isPro = purchaserInfo.activeEntitlements.contains("my_entitlement_identifier");
  if (isPro) {
    // Unlock that great "pro" content
  }
} on PlatformException catch (e) {
  if (!(e.details as Map)["userCancelled"]) {
    showError(e);
  }
}
```
>`makePurchase` handles the underlying framework interaction and automatically validates purchases with Apple and Google through our secure servers. This helps reduce in-app purchase fraud and decreases the complexity of your app. Receipt tokens are stored remotely and always kept up-to-date.

#### 5. Get Subscription Status
*Purchases* makes it easy to check what active subscriptions the current user has. This can be done two ways within the `.purchaserInfo` method:
1. Checking active Entitlements - this lets you see what entitlements ([from RevenueCat dashboard](https://app.revenuecat.com)) are active for the user.
2. Checking the active subscriptions - this lets you see what product ids (from iTunes Connect or Play Store) are active for the user.

```dart
// Get purchaser info
try {
  PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
  if (purchaserInfo.activeEntitlements.contains("my_entitlement_identifier")) {
    // Grant user "pro" access
  }
  // Option 2: Check if user has active subscription (from App Store Connect or Play Store)
  if (purchaserInfo.activeSubscriptions.contains("my_product_identifier")) {
    // Grant user "pro" access
  }
} on PlatformException catch (e) {
  // Error fetching purchaser info
}
```

>Since the SDK updates and caches the latest PurchaserInfo when the app becomes active, the completion block in `.purchaserInfo` won't need to make a network request in most cases.

##### Listening For Purchaser Info Updates
Since Purchases SDK works seamlessly on any platform, a user's purchase info may change from a variety of sources. You can respond to any changes in purchaser info by conforming to an optional listener. This will fire whenever we receive a change in purchaser info and you should expect it to be called at launch and throughout the life of the app.

Depending on your app, it may be sufficient to ignore the delegate and simply handle changes to purchaser information the next time your app is launched.

```dart
Purchases.addPurchaserInfoUpdateListener((purchaserInfo) => {
  // handle any changes to purchaserInfo
});
```

### Restoring Purchases
Restoring purchases is a mechanism by which your user can restore their in-app purchases, reactivating any content that had previously been purchased from the same store account (Apple or Google).

If two different App User IDs try to restore transactions from the same underlying store account (Apple or Google) RevenueCat will create an alias between the two App User IDs and count them as the same user going forward.

This is a common if your app does not have accounts and is relying on RevenueCat's random App User IDs.

```dart
try {
  PurchaserInfo purchaserInfo = Purchases.restoreTransactions();
} on PlatformException catch (e) {
 // Error restoring
}
```

**Restoring purchases for logged in users:**  
>If you've provided your own App User ID, calling restoreTransactions could alias the logged in user to another generated App User ID that has made a purchase on the same device.

**Allow Sharing App or Play Store Accounts**
>By default, RevenueCat will not let you reuse an App or Play Store account that already has an active subscription. If you set allowSharingAppStoreAccount = True the SDK will be permissive in accepting shared accounts, creating aliases as needed.

>By default allowSharingAppStoreAccount is True for RevenueCat random App User IDs but must be enabled manually if you want to allow permissive sharing for your own App User IDs.

## Error Handling
When an error has occurred, an `PlatformException` will be thrown. For a complete list of errors, see our online error handling documentation: https://docs.revenuecat.com/docs/errors

When investigating or logging errors, review the `details` dictionary, paying attention to the following keys:

- `readableErrorCode` contains a cross-platform error name string that can be used for identifying the error.
- `underlyingErrorMessage` contains the underlying error that caused the error in question, if an underlying error is present.

## Debugging
You can enabled detailed debug logs by setting `setDebugLogsEnabled(true)`. You can set this **before** you configure Purchases.

```dart
Purchases.setDebugLogsEnabled(true);
await Purchases.setup("my_api_key");
```

**OS_ACTIVITY_MODE**
>On iOS, disabling `OS_ACTIVITY_MODE` in your XCode scheme will block debug logs from printing in the console. If you have debug logs enabled, but don't see any output, go to `Product -> Scheme -> Edit Scheme...` in Xcode and uncheck the `OS_ACTIVITY_MODE` environment variable.

Example output:
```
[Purchases] - DEBUG: Debug logging enabled.
[Purchases] - DEBUG: SDK Version - 2.5.0
[Purchases] - DEBUG: Initial App User ID - (null)
[Purchases] - DEBUG: GET /v1/subscribers/<APP_USER_ID>
[Purchases] - DEBUG: GET /v1/subscribers/<APP_USER_ID>/products
[Purchases] - DEBUG: No cached entitlements, fetching
[Purchases] - DEBUG: Vending purchaserInfo from cache
[Purchases] - DEBUG: applicationDidBecomeActive
[Purchases] - DEBUG: GET /v1/subscribers/<APP_USER_ID>/products 200
```

## Entitlements
An entitlement represents features or content that a user is "entitled" to. With Entitlements, you can set up your available in-app products remotely and control their availability without the need to update your app. For more information on configuring entitlements, look at our [entitlements documetation](https://docs.revenuecat.com/docs/entitlements).

## Sample App
We've added an example in this project showing a simple example using *Purchases* with the RevenueCat backend. Note that the pre-registered in app purchases in the demo apps are for illustration purposes only and may not be valid in App Store Connect. [Set up your own purchases](https://docs.revenuecat.com/docs/entitlements) with RevenueCat when running the example.

## Next Steps
- Head over to our **[online documentation](https://docs.revenuecat.com/docs)** for complete setup guides
- If you haven't already, make sure your products are configured correctly in the RevenueCat dashboard by checking out our [guide on entitlements](https://docs.revenuecat.com/docs/entitlements)
- If you want to use your own user identifiers, read about [setting app user ids](https://docs.revenuecat.com/docs/user-ids)
- If you're moving to RevenueCat from another system, see our guide on [migrating your existing subscriptions](https://docs.revenuecat.com/docs/migrating-existing-subscriptions)
- Once you're ready to test your integration, you can follow our guides on [testing purchases](https://docs.revenuecat.com/docs/testing-purchases)


## Reporting Issues
You can use Github Issues to report any bugs and issues with *Purchases*. Here is some advice for users that want to report an issue:

1. Make sure that you are using the latest version of *Purchases*. The issue that you are about to report may be already fixed in the latest master branch version: https://github.com/revenuecat/purchases-flutter/tree/master.
2. Providing reproducible steps for the issue will shorten the time it takes for it to be fixed - a Gist is always welcomed!
3. Since some issues are Sandbox specific, specifying what environment you encountered the issue might help.
​

## Technical Support or Questions
If you have questions or need help integrating *Purchases* please start by heading to our [online documentation](https://docs.revenuecat.com/docs/welcome) and checking out the guides and support resources we have there.


## Feature Requests
If there is something you'd like to see included or feel anything is missing you can add a feature to our [public roadmap](https://trello.com/b/RZRnWRbI/revenuecat-product-roadmap). If the feature already exists, or you see something else you'd like, upvote it.


## Pricing
*Purchases* SDK is free to use but some features require a paid plan. You can find more about that on our website on the [pricing plan page](https://www.revenuecat.com/pricing).
