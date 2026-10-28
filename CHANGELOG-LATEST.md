## RevenueCat SDK
### CocoaPods
Because of the CocoaPods trunk freeze (November 1 to 7), the `PurchasesHybridCommon` 20.0.0 pod this release depends on is not published yet; it will be after November 7. Until then, iOS and macOS projects that install through CocoaPods can't resolve this version. Use Swift Package Manager (Flutter 3.24+ with SPM enabled), or stay on 10.x until the pod is available.

CocoaPods trunk becomes permanently read-only on December 2, 2026, so a later major release will drop CocoaPods support. We recommend moving to Swift Package Manager.

### 💥 Breaking Changes

This release updates the Android SDK to v11, which uses Google Play Billing Library 9.1.0 and Kotlin 2.2. The iOS SDK major version does not change. See the [v11 migration guide](https://github.com/RevenueCat/purchases-flutter/blob/main/migrations/v11-MIGRATION.md).

#### New minimum versions (Android)
* Kotlin 2.1.0. Builds with an older Kotlin Gradle Plugin fail with "Module was compiled with an incompatible version of Kotlin".
* `compileSdk` 35. Flutter 3.27+ sets this by default; older Flutter versions need `compileSdk = 35` in `android/app/build.gradle`.
* `minSdk` and `targetSdk` are not affected.

#### Play Billing Library 9
The Android SDK now uses Play Billing Library 9.1.0. Any other in-app purchase plugin in the same app must support Play Billing Library 9. When the Play Store is blocked on the device (for example OEM kids modes), purchases now fail with `purchaseNotAllowedError` instead of `storeProblemError`.

#### Jetpack Compose
If your app has native Android code using Jetpack Compose, `purchases_ui_flutter` raises your Compose libraries to BOM 2026.06.01.

#### `syncAmazonPurchase` requires `purchaseTime`
`purchaseTime` (milliseconds since epoch, from the Amazon receipt) is now a required positional parameter instead of an optional named one.

#### Offerings errors during a package purchase on iOS
When offerings fail to load while purchasing a package, iOS now reports the offerings error (for example `networkError`) instead of `productNotAvailableForPurchaseError`, matching Android.

#### Paywall purchase callback on iOS
iOS paywalls no longer call `onPurchaseCompleted` for purchases completed by your own `PaywallPurchaseLogic`, since those have no store transaction. This matches Android.

* Make purchaseTime required in syncAmazonPurchase (#1920) via Toni Rico (@tonidero)

### 🔄 Other Changes
* docs: cover the iOS offerings error change in the v11 migration guide (#1982) via Álvaro Brey (@AlvaroBrey)
* ci: pause CocoaPods release checks during trunk freeze (#1986) via Antonio Pallares (@ajpallares)
* Build against purchases-hybrid-common 20.0.0-SNAPSHOT (#1969) via Álvaro Brey (@AlvaroBrey)
* Add the v11 migration guide (#1952) via Álvaro Brey (@AlvaroBrey)
* docs: bump the minimum Kotlin version + adopt purchases-android v11 (#1876) via Álvaro Brey (@AlvaroBrey)

## RevenueCatUI SDK
### 🔄 Other Changes
* Make the iOS purchase completed transaction non-optional (#1959) via Álvaro Brey (@AlvaroBrey)
