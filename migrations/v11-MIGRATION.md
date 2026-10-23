## v11 API Changes

This release updates the Android SDK dependency from v10 to v11, which uses Google Play Billing Library 9.1.0 and Kotlin 2.2. The iOS SDK dependency does not change major version.

### Migration Guides

- See [Android Native - V11 API Migration Guide](https://github.com/RevenueCat/purchases-android/blob/main/migrations/v11-MIGRATION.md) for a more thorough explanation of the Android changes.

### New Minimum Versions

- Android: `compileSdk` 35.
- Android: Kotlin 2.1.0.

iOS and Android minimum OS versions do not change.

### Kotlin 2.1.0 or newer

Flutter builds plugins with the Kotlin version your app declares. If it is older than 2.1.0, the Android build fails with:

```
Module was compiled with an incompatible version of Kotlin.
The binary version of its metadata is 2.2.0, expected version is 2.0.0.
```

Raise the Kotlin plugin version in `android/settings.gradle` (or `settings.gradle.kts`):

```groovy
plugins {
    id "org.jetbrains.kotlin.android" version "2.1.0" apply false
}
```

### `compileSdk` 35 or higher

Your app must compile against Android API 35 or later. Flutter versions before 3.27 set `flutter.compileSdkVersion` to 34. If your `android/app/build.gradle` uses it on an older Flutter, set the value explicitly:

```groovy
android {
    compileSdk = 35
}
```

`minSdk` and `targetSdk` are not affected.

### `syncAmazonPurchase` requires `purchaseTime`

`purchaseTime` is now a required positional parameter. Pass the purchase time in milliseconds since epoch from the Amazon receipt.

```dart
// Before
await Purchases.syncAmazonPurchase(productID, receiptID, amazonUserID, isoCurrencyCode, price,
    purchaseTime: receipt.purchaseTime.millisecondsSinceEpoch);

// After
await Purchases.syncAmazonPurchase(productID, receiptID, amazonUserID, isoCurrencyCode, price,
    receipt.purchaseTime.millisecondsSinceEpoch);
```

### Jetpack Compose on Android

If your app has native Android code that uses Jetpack Compose, `purchases_ui_flutter` raises your Compose libraries to BOM 2026.06.01. See the [Android guide](https://github.com/RevenueCat/purchases-android/blob/main/migrations/v11-MIGRATION.md#jetpack-compose-revenuecatui).

### Blocked Play Store reports `purchaseNotAllowedError`

When the Play Store is blocked on the device (for example in OEM kids modes), purchases now fail with `PurchasesErrorCode.purchaseNotAllowedError` instead of `PurchasesErrorCode.storeProblemError`. `storeProblemError` is still reported for other store failures, so handle the new code alongside it rather than replacing it.

### iOS: offerings errors during a package purchase are reported as they are

When offerings fail to load while purchasing a package on iOS (`purchasePackage`, `purchaseDiscountedPackage`, `purchasePackageWithWinBackOffer` and `purchase` with a package), the call now throws the offerings error, for example `PurchasesErrorCode.networkError`, instead of `PurchasesErrorCode.productNotAvailableForPurchaseError` with the message "Couldn't find package". Android already behaved this way. A package missing from loaded offerings still reports `productNotAvailableForPurchaseError`.

### Other Play Billing libraries in your app

The Android SDK puts Play Billing Library 9.1.0 on your app's classpath. Any other in-app purchase plugin in the same app, for example one you use to complete purchases with your own code, must support Play Billing Library 9. Versions that use APIs it removed, such as `SkuDetails`, fail at build time or at runtime.

### Reporting undocumented issues:

Feel free to file an issue! [New RevenueCat Issue](https://github.com/RevenueCat/purchases-flutter/issues/new/).
