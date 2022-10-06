## 4.3.0
### Other Changes
* Another fix on update_hybrid_common (#491) via Cesar de la Vega (@vegaro)
* Fix dirty repository when upgrading phc version (#483) via Cesar de la Vega (@vegaro)
* [AUTOMATIC] Updates purchases-hybrid-common from 4.2.2 to 4.3.1 (#490) via Cesar de la Vega (@vegaro)
* Run flutter pub get before pod install when upgrading phc (#481) via Cesar de la Vega (@vegaro)
* Calls correct lane when automatically upgrading phc (#478) via Cesar de la Vega (@vegaro)

## 4.2.2
### Other Changes
* [AUTOMATIC] Updates purchases-hybrid-common to 4.2.2 (#476) via RevenueCat Git Bot (@RCGitBot)
* Creates update-hybrid-common-versions and updated manual bump (#473) via Cesar de la Vega (@vegaro)
* Adds lane to update purchases-hybrid-common (#468) via Cesar de la Vega (@vegaro)
* Remove wrong link from Changelog (#464) via Cesar de la Vega (@vegaro)
* Move to SNAPSHOT version on every commit to main if needed (#466) via Toni Rico (@tonidero)
* add SDK reference docs link (#461) via Andy Boedo (@aboedo)

## 4.2.1
### Fixes
* `purchaseProduct` not working when SK2 is enabled (https://github.com/RevenueCat/react-native-purchases/issues/402)

### Other Changes
* Updated purchases-hybrid-common to 4.2.1
* Skip release if needed and change type of message (#460) via Cesar de la Vega (@vegaro)
* Update fastlane-plugin-revenuecat_internal (#456) via Cesar de la Vega (@vegaro)
* Update RELEASING docs (#458) via Cesar de la Vega (@vegaro)
* Add `next_version` and `automatic_release` to automatic_bump (#457) via Cesar de la Vega (@vegaro)
* Release train (#454) via Cesar de la Vega (@vegaro)
* Configures Danger (#452) via Cesar de la Vega (@vegaro)

## 4.2.0
### Fixes
- Fixed crash when cancelling purchases (#403) via NachoSoto (@NachoSoto)

### Other Changes
* Updated `purchases-ios` to 4.10.2
* Re-enabled `SK2` as the default on iOS
* `PurchasesFlutterPlugin`: silenced unused warning (#444) via NachoSoto (@NachoSoto)
* `README`: removed `Amazon` note since it's now supported. (#442) via NachoSoto (@NachoSoto)
* Update fastlane plugin (#440) via Toni Rico (@tonidero)

## 4.1.2
### Fixes
* Bump compileSdkVersion to version 31 (#436) via Toni Rico (@tonidero)

## 4.1.1
### Fixes
* Fix for no-op calls on Android (enableAdServicesAttributionTokenCollection) (#434) via Josh Holtz (@joshdholtz)

### Other Changes
* Setup credentials in prepare_next_version job (#430) via Toni Rico (@tonidero)

## 4.1.0
### New features
* New method for automatic collecting of attribution tokens on iOS and macOS using AdServices - `Purchases.enableAdServicesAttributionTokenCollection()` (https://github.com/RevenueCat/purchases-ios/pull/1727)

### Other Changes
* Updating Hybrid Common to 4.1.0 (#424)

## 4.0.1

### Bumped dependencies
- Kotlin to 1.6.21
- purchases-hybrid-common to 4.0.2
- purchases-ios to 4.9.1
- purchases-android to 5.4.1

In addition to all the changes included in the latest major release [4.0.0](https://github.com/RevenueCat/purchases-flutter/releases/tag/4.0.0)!

## 4.0.0

RevenueCat Flutter SDK v4 is here!!

![Dancing cats](https://media.giphy.com/media/lkbNG2zqzHZUA/giphy.gif)

[Full Changelog](https://github.com/revenuecat/purchases-flutter/compare/3.10.0...4.0.0)

⚠️ ⚠️ Important ⚠️ ⚠️ Observer mode for Amazon is not supported yet.

### Features

#### Amazon Appstore Support
We have introduced support for using the Amazon Appstore. We have extensively tested this, and there are some apps using our pre-release Amazon versions in production.

However, we have found some inconsistencies in the way Amazon Appstore prices are reported. We are actively working on patching these inconsistencies.

Please help us help you by reporting any issues you find. [New RevenueCat Issue](https://github.com/RevenueCat/purchases-flutter/issues/new/).

You can enable Amazon Appstore support by configuring the SDK using the new `RevenueCatAPIKeyAmazon` field.

For more information around configuration please take a look at the [Amazon Appstore section in our docs](https://docs.revenuecat.com/docs/amazon-platform-resources). The official [Amazon In-App Purchasing docs](https://developer.amazon.com/docs/in-app-purchasing/iap-overview.html) also contain very valuable information, especially around testing and best practices.

#### StoreKit 2 support
This version of the SDK automatically uses StoreKit 2 APIs under the hood only for APIs that the RevenueCat team has determined work better than StoreKit 1.

#### New types and cleaned up naming
New types that wrap native types from Apple, Google and Amazon, and we cleaned up the naming of other types and methods for a more consistent experience.

### Deprecated APIs
| 3.x | 4.0.0 |
| :-: | :-: |
| `Purchases.setup` | `Purchases.configure` |

### Removed APIs
| 3.x | 4.0.0 |
| :-: | :-: |
| `IntroductoryPrice.periodUnit` (`String`) | `IntroductoryPrice.periodUnit` (`PeriodUnit`) |
| `IntroductoryPrice.introPrice` | `IntroductoryPrice.price` |
| `IntroductoryPrice.introPriceString` | `IntroductoryPrice.priceString` |
| `IntroductoryPrice.introPricePeriod` | `IntroductoryPrice.period` |
| `IntroductoryPrice.introPricePeriodNumberOfUnits` | `IntroductoryPrice.periodNumberOfUnits` |
| `IntroductoryPrice.introPriceCycles` | `IntroductoryPrice.cycles` |
| `Purchases.addAttributionData` | `Set<NetworkID>` |
| `Purchases.identify` | `Purchases.logIn` |
| `Purchases.createAlias` | `Purchases.logIn` |
| `Purchases.reset` | `Purchases.logOut` |
| `PurchasesAttributionNetwork` | `Set<NetworkID>` |

### Renamed APIs
| 3.x | 4.0.0 |
| :-: | :-: |
| `PurchaserInfo` | `CustomerInfo` |
| `Transaction` | `StoreTransaction` |
| `Product` | `StoreProduct` |
| `Discount` | `StoreProductDiscount` |
| `PaymentDiscount` | `PromotionalOffer` |
| `Package.product` | `Package.storeProduct` |
| `Purchases.PurchaserInfoUpdateListener` | `Purchases.CustomerInfoUpdateListener` |
| `Purchases.removePurchaserInfoUpdateListener` | `Purchases.removeCustomerInfoUpdateListener` |
| `Purchases.restoreTransactions` | `Purchases.restorePurchases` |
| `Purchases.getPurchaseInfo` | `Purchases.getCustomerInfo` |
| `Purchases.invalidatePurchaserInfoCache` | `Purchases.invalidateCustomerInfoCache` |
| `Purchases.getPaymentDiscount` | `Purchases.getPromotionalOffer` |

### Moved classes
- `Store` enum has been moved from `entitlement_info_wrapper.dart` to `store.dart`

## 4.0.0-rc.2

- Fixes [userCancelled crash](https://github.com/RevenueCat/purchases-flutter/issues/403): [PR](https://github.com/RevenueCat/purchases-flutter/pull/404)

## 4.0.0-rc.1
⚠️ ⚠️ Important ⚠️ ⚠️ Observer mode for Amazon is not supported yet.

### Features

#### Amazon Appstore Support
We have introduced support for using the Amazon Appstore. We have extensively tested this, and there are some apps using our pre-release Amazon versions in production.

However, we have found some inconsistencies in the way Amazon Appstore prices are reported. We are actively working on patching these inconsistencies.

Please help us help you by reporting any issues you find. [New RevenueCat Issue](https://github.com/RevenueCat/purchases-flutter/issues/new/).

You can enable Amazon Appstore support by configuring the SDK using the new `RevenueCatAPIKeyAmazon` field.

For more information around configuration please take a look at the [Amazon Appstore section in our docs](https://docs.revenuecat.com/docs/amazon-platform-resources). The official [Amazon In-App Purchasing docs](https://developer.amazon.com/docs/in-app-purchasing/iap-overview.html) also contain very valuable information, especially around testing and best practices.

#### StoreKit 2 support
This version of the SDK automatically uses StoreKit 2 APIs under the hood only for APIs that the RevenueCat team has determined work better than StoreKit 1.

#### New types and cleaned up naming
New types that wrap native types from Apple, Google and Amazon, and we cleaned up the naming of other types and methods for a more consistent experience.

### Deprecated APIs
| 3.x | 4.0.0 |
| :-: | :-: |
| `Purchases.setup` | `Purchases.configure` |

### Removed APIs
| 3.x | 4.0.0 |
| :-: | :-: |
| `IntroductoryPrice.periodUnit` (`String`) | `IntroductoryPrice.periodUnit` (`PeriodUnit`) |
| `IntroductoryPrice.introPrice` | `IntroductoryPrice.price` |
| `IntroductoryPrice.introPriceString` | `IntroductoryPrice.priceString` |
| `IntroductoryPrice.introPricePeriod` | `IntroductoryPrice.period` |
| `IntroductoryPrice.introPricePeriodNumberOfUnits` | `IntroductoryPrice.periodNumberOfUnits` |
| `IntroductoryPrice.introPriceCycles` | `IntroductoryPrice.cycles` |
| `Purchases.addAttributionData` | `Set<NetworkID>` |
| `Purchases.identify` | `Purchases.logIn` |
| `Purchases.createAlias` | `Purchases.logIn` |
| `Purchases.reset` | `Purchases.logOut` |
| `PurchasesAttributionNetwork` | `Set<NetworkID>` |

### Renamed APIs
| 3.x | 4.0.0 |
| :-: | :-: |
| `PurchaserInfo` | `CustomerInfo` |
| `Transaction` | `StoreTransaction` |
| `Product` | `StoreProduct` |
| `Discount` | `StoreProductDiscount` |
| `PaymentDiscount` | `PromotionalOffer` |
| `Package.product` | `Package.storeProduct` |
| `Purchases.PurchaserInfoUpdateListener` | `Purchases.CustomerInfoUpdateListener` |
| `Purchases.removePurchaserInfoUpdateListener` | `Purchases.removeCustomerInfoUpdateListener` |
| `Purchases.restoreTransactions` | `Purchases.restorePurchases` |
| `Purchases.getPurchaseInfo` | `Purchases.getCustomerInfo` |
| `Purchases.invalidatePurchaserInfoCache` | `Purchases.invalidateCustomerInfoCache` |
| `Purchases.getPaymentDiscount` | `Purchases.getPromotionalOffer` |

### Moved classes
- `Store` enum has been moved from `entitlement_info_wrapper.dart` to `store.dart`

## 4.0.0-rc.1
⚠️ ⚠️ Important ⚠️ ⚠️ Observer mode for Amazon is not supported yet.

### Features

#### Amazon Appstore Support
We have introduced support for using the Amazon Appstore. We have extensively tested this, and there are some apps using our pre-release Amazon versions in production.

However, we have found some inconsistencies in the way Amazon Appstore prices are reported. We are actively working on patching these inconsistencies.

Please help us help you by reporting any issues you find. [New RevenueCat Issue](https://github.com/RevenueCat/purchases-flutter/issues/new/).

You can enable Amazon Appstore support by configuring the SDK using the new `RevenueCatAPIKeyAmazon` field.

For more information around configuration please take a look at the [Amazon Appstore section in our docs](https://docs.revenuecat.com/docs/amazon-platform-resources). The official [Amazon In-App Purchasing docs](https://developer.amazon.com/docs/in-app-purchasing/iap-overview.html) also contain very valuable information, especially around testing and best practices.

#### StoreKit 2 support
This version of the SDK automatically uses StoreKit 2 APIs under the hood only for APIs that the RevenueCat team has determined work better than StoreKit 1.

#### New types and cleaned up naming
New types that wrap native types from Apple, Google and Amazon, and we cleaned up the naming of other types and methods for a more consistent experience.

### Deprecated APIs
| 3.x | 4.0.0 |
| :-: | :-: |
| `Purchases.setup` | `Purchases.configure` |

### Removed APIs
| 3.x | 4.0.0 |
| :-: | :-: |
| `IntroductoryPrice.periodUnit` (`String`) | `IntroductoryPrice.periodUnit` (`PeriodUnit`) |
| `IntroductoryPrice.introPrice` | `IntroductoryPrice.price` |
| `IntroductoryPrice.introPriceString` | `IntroductoryPrice.priceString` |
| `IntroductoryPrice.introPricePeriod` | `IntroductoryPrice.period` |
| `IntroductoryPrice.introPricePeriodNumberOfUnits` | `IntroductoryPrice.periodNumberOfUnits` |
| `IntroductoryPrice.introPriceCycles` | `IntroductoryPrice.cycles` |
| `Purchases.addAttributionData` | `Set<NetworkID>` |
| `Purchases.identify` | `Purchases.logIn` |
| `Purchases.createAlias` | `Purchases.logIn` |
| `Purchases.reset` | `Purchases.logOut` |
| `PurchasesAttributionNetwork` | `Set<NetworkID>` |

### Renamed APIs
| 3.x | 4.0.0 |
| :-: | :-: |
| `PurchaserInfo` | `CustomerInfo` |
| `Transaction` | `StoreTransaction` |
| `Product` | `StoreProduct` |
| `Discount` | `StoreProductDiscount` |
| `PaymentDiscount` | `PromotionalOffer` |
| `Package.product` | `Package.storeProduct` |
| `Purchases.PurchaserInfoUpdateListener` | `Purchases.CustomerInfoUpdateListener` |
| `Purchases.removePurchaserInfoUpdateListener` | `Purchases.removeCustomerInfoUpdateListener` |
| `Purchases.restoreTransactions` | `Purchases.restorePurchases` |
| `Purchases.getPurchaseInfo` | `Purchases.getCustomerInfo` |
| `Purchases.invalidatePurchaserInfoCache` | `Purchases.invalidateCustomerInfoCache` |
| `Purchases.getPaymentDiscount` | `Purchases.getPromotionalOffer` |

### Moved classes
- `Store` enum has been moved from `entitlement_info_wrapper.dart` to `store.dart`

## 4.0.0-beta.1

⚠️⚠️ This is a pre-release version. ⚠️⚠️
- `purchaserInfo` renamed to `customerInfo`
- Renamed `StoreProduct`, `StoreTransaction` and `StoreProductDiscount`. `package.product` to `package.storeProduct`
- Store enum has been moved into store.dart
- `setup` changed with `configure`

**Known issues:** Amazon support currently doesn't work correctly in the Live App Testing and production environments.
The purchase modal will not show correctly for Amazon in these environments.

## 3.10.0

- Add support for iOS promoted purchases (https://github.com/RevenueCat/purchases-flutter/pull/344)
  New type: `ReadyForPromotedProductPurchaseListener`
  New methods: `addReadyForPromotedProductPurchaseListener(ReadyForPromotedProductPurchaseListener listener)`
  `removeReadyForPromotedProductPurchaseListener(ReadyForPromotedProductPurchaseListener listenerToRemove)`

## 3.9.5

- Add instructions for how to install Amazon Store version in README (https://github.com/RevenueCat/purchases-flutter/pull/330)

## 3.9.4

- Add back IntroductoryPrice fields that were accidentally removed without a major release (https://github.com/RevenueCat/purchases-flutter/pull/319)
- Fields added back:
  `IntroductoryPrice.introPricePeriodUnit `
  `IntroductoryPrice.introPrice`
  `IntroductoryPrice.introPriceString`
  `IntroductoryPrice.introPriceCycles`
  `IntroductoryPrice.introPricePeriodNumberOfUnits`

## 3.9.3

- Fix missing IntroductoryPrice export (https://github.com/RevenueCat/purchases-flutter/pull/310)

## 3.9.2

- Fix `purchasePackage`, `purchaseProduct`, `purchaseDiscountedPackage` and `purchaseDiscountedProduct` crashes due to a wrong type.
- Added missing freezed files.
    https://github.com/RevenueCat/purchases-flutter/pull/301
- CI fail if missing freezed files
    https://github.com/RevenueCat/purchases-flutter/pull/302

## 3.9.1

- Fixed a crash in `getOfferings` on Android for products that don't have intro pricing
    https://github.com/RevenueCat/purchases-flutter/pull/294
- Update Freezed dependency to 1.1.0, updated freezed-annotation and other dependencies
    https://github.com/RevenueCat/purchases-flutter/pull/297

## 3.9.0

- Updated Android to compile with SDK 30
    https://github.com/RevenueCat/purchases-flutter/pull/285
- Removed all references to JCenter (More on the [JCenter Shutdown](https://blog.gradle.org/jcenter-shutdown))
    https://github.com/RevenueCat/purchases-flutter/pull/285
- Updated JSON serialization using Freezed
    https://github.com/RevenueCat/purchases-flutter/pull/270
- Breaking changes (these were unintended and fixed in 3.9.4):
  `IntroductoryPrice.introPricePeriodUnit` -> `IntroductoryPrice.periodUnit` (+ changed from string to PeriodUnit enum type)
  `IntroductoryPrice.introPrice` -> `IntroductoryPrice.price`
  `IntroductoryPrice.introPriceString` -> `IntroductoryPrice.priceString`
  `IntroductoryPrice.introPriceCycles` -> `IntroductoryPrice.cycles`
  `IntroductoryPrice.introPricePeriodNumberOfUnits` -> `IntroductoryPrice.periodNumberOfUnits`

## 3.8.0

- Added `isConfigured`, which returns `true` if the SDK has already been configured through `setup`.
- Added compatibility for `EntitlementInfo.ownershipType` for Android
    https://github.com/RevenueCat/purchases-hybrid-common/pulls/106
- Bump`purchases-hybrid-common` to `1.11.1` [Changelog here](https://github.com/RevenueCat/purchases-hybrid-common/releases/tag/1.11.1)
- Bump `purchases-ios` to `3.13.1` ([Changelog here](https://github.com/RevenueCat/purchases-ios/releases/3.13.1))
- Bump `purchases-android` to `4.6.0` ([Changelog here](https://github.com/RevenueCat/purchases-android/releases/4.6.0))

## 3.7.0

- Bump`purchases-hybrid-common` to `1.11.0` [Changelog here](https://github.com/RevenueCat/purchases-hybrid-common/releases/tag/1.11.0)
     Add ownershipType to EntitlementInfo

## 3.6.0

- Bump`purchases-hybrid-common` to `1.10.0` [Changelog here](https://github.com/RevenueCat/purchases-hybrid-common/releases/tag/1.10.0)
- Bump `purchases-ios` to `3.13.0` ([Changelog here](https://github.com/RevenueCat/purchases-ios/releases/3.13.0))
- Bump `purchases-android` to `4.4.0` ([Changelog here](https://github.com/RevenueCat/purchases-android/releases/4.4.0))
- Added support for Airship integration via `setAirshipChannelID`
     https://github.com/RevenueCat/purchases-flutter/pull/272

## 3.5.0

- Removed call to `Purchases.getSharedInstance().close();` in `onDetachedFromEngine`. This should fix an incompatibility with `workmanager` Flutter plugin that was causing the BillingClient to get disconnected after a task would finish.
- Added a new `close()` function to be called in Android whenever the resources used by Purchases should be released.
    https://github.com/RevenueCat/purchases-flutter/pull/268
    https://github.com/RevenueCat/purchases-flutter/issues/257
- Bump`purchases-hybrid-common` to 1.9.3 [Changelog here](https://github.com/RevenueCat/purchases-hybrid-common/releases/tag/1.9.3)
- Bump `purchases-ios` to 3.12.8
  [3.12.8 Changelog here](https://github.com/RevenueCat/purchases-ios/releases/tag/3.12.8)
  [3.12.7 Changelog here](https://github.com/RevenueCat/purchases-ios/releases/tag/3.12.7)

## 3.4.6

- Bump`purchases-hybrid-common` to 1.9.2 [Changelog here](https://github.com/RevenueCat/purchases-hybrid-common/releases/tag/1.9.2)
- Bump `purchases-android` to `4.3.3`
  [4.3.3 Changelog here](https://github.com/RevenueCat/purchases-android/releases/tag/4.3.3)
  [4.3.2 Changelog here](https://github.com/RevenueCat/purchases-android/releases/tag/4.3.2)
- Bump `purchases-ios` to 3.12.6
  [3.12.6 Changelog here](https://github.com/RevenueCat/purchases-ios/releases/tag/3.12.6)
  [3.12.5 Changelog here](https://github.com/RevenueCat/purchases-ios/releases/tag/3.12.5)
  [3.12.4 Changelog here](https://github.com/RevenueCat/purchases-ios/releases/tag/3.12.4)

## 3.4.5

- Bumped purchases-android to 4.3.1 [Changelog here](https://github.com/RevenueCat/purchases-android/releases/4.3.1),
which fixes canMakePayments not returning (see related issue: https://github.com/RevenueCat/purchases-unity/issues/61)
- Bumped purchases-hybrid-common to 1.9.1 [Changelog here](https://github.com/RevenueCat/purchases-hybrid-common/releases/tag/1.9.1)

## 3.4.4

- Buggy release - meant to update purchases-hybrid-common to 1.9.1 (and therefore purchases-android to 4.3.1),
    but didn't end up actually pulling it in...fixed in 3.4.5

## 3.4.3

- Fixed more deprecation warnings for types used for compatibility with Flutter apps using Flutter < 1.12.
    https://github.com/RevenueCat/purchases-flutter/pull/235

## 3.4.2

- Fixed deprecation warnings for types used for compatibility with Flutter apps using Flutter < 1.12.
    https://github.com/RevenueCat/purchases-flutter/pull/232
- Bumped `purchases-hybrid-common` to 1.8.2. [Changelog here](https://github.com/RevenueCat/purchases-hybrid-common/releases/1.8.2)
    https://github.com/RevenueCat/purchases-flutter/pull/233

## 3.4.1

- Fixed a bug where the wrong error code would be returned when mapping to JSON in Android.
- Bumped `purchases-hybrid-common` to 1.8.1. [Changelog here](https://github.com/RevenueCat/purchases-hybrid-common/releases/1.8.1)
    https://github.com/RevenueCat/purchases-flutter/pull/225

## 3.4.0

### Identity V3:

In this version, we’ve redesigned the way that user identification works.
Detailed docs about the new system are available [here](https://docs.revenuecat.com/v3.2/docs/user-ids).

#### New methods
- Introduces `logIn`, a new way of identifying users, which also returns whether a new user has been registered in the system.
`logIn` uses a new backend endpoint.
- Introduces `logOut`, a replacement for `reset`.

#### Deprecations
- deprecates `createAlias` in favor of `logIn`.
- deprecates `identify` in favor of `logIn`.
- deprecates `reset` in favor of `logOut`.
- deprecates `setAllowSharingStoreAccount` in favor of dashboard-side configuration.
    https://github.com/RevenueCat/purchases-flutter/pull/180

#### Other
- Updated BillingClient to version [4.0.0](https://developer.android.com/google/play/billing/release-notes#4-0).
     https://github.com/RevenueCat/purchases-android/commit/f6554bbf7376c3fd492f0bc67183a9f35889ae78
- Bumped purchases-ios to 3.12.2 [Changelog here](https://github.com/RevenueCat/purchases-ios/releases/3.12.2)
- Bumped purchases-android to 4.3.0 [Changelog here](https://github.com/RevenueCat/purchases-android/releases/4.3.0)

## 3.3.1
- Update MacOS dependency on PurchasesHybridCommon to 1.7.1 (https://github.com/RevenueCat/purchases-flutter/pull/209)

## 3.3.0
- Bump gradle to 4.0.1 (https://github.com/RevenueCat/purchases-flutter/pull/195)
- Add `canMakePayments` method (https://github.com/RevenueCat/purchases-flutter/pull/193)
- Bump `purchases-hybrid-common` to 1.7.1 [Changelog here](https://github.com/RevenueCat/purchases-hybrid-common/releases/1.7.1)
- Update PR template (https://github.com/RevenueCat/purchases-flutter/pull/199)

## 3.2.2
- Bumped purchases-hybrid-common to 1.6.3 to fix issues with overlapping Foundation extensions names in iOS [Changelog here](https://github.com/RevenueCat/purchases-hybrid-common/releases/1.6.3)

## 3.2.1
- Added link to examples in GitHub
    https://github.com/RevenueCat/purchases-flutter/pull/185

## 3.2.0
- Added new Magic Weather sample app, available in `revenuecat_examples/MagicWeather`
    https://github.com/RevenueCat/purchases-flutter/pull/170

## 3.1.1

- Fixed an issue that would cause an error saying `type 'Null' is not a subtype of type 'String' in type cast` in `allExpirationDates` when null-safety is enabled.
    https://github.com/RevenueCat/purchases-flutter/pull/177
- Bumped purchases-hybrid-common to 1.6.2 [Changelog here](https://github.com/RevenueCat/purchases-hybrid-common/releases/1.6.2)
- Bumped purchases-ios to 3.10.7 [Changelog here](https://github.com/RevenueCat/purchases-ios/releases/3.10.7)
- Bumped purchases-android to 4.0.5 [Changelog here](https://github.com/RevenueCat/purchases-hybrid-common/releases/4.0.5)
    https://github.com/RevenueCat/purchases-flutter/pull/171

## 3.1.0

- iOS:
    - Added a new method `setSimulatesAskToBuyInSandbox`, that allows developers to test deferred purchases easily.
- Bumped purchases-hybrid-common to 1.6.1 [Changelog here](https://github.com/RevenueCat/purchases-hybrid-common/releases/1.6.1)
- Bumped purchases-ios to 3.10.6 [Changelog here](https://github.com/RevenueCat/purchases-ios/releases/3.10.6)
- Bumped purchases-android to 4.0.4 [Changelog here](https://github.com/RevenueCat/purchases-hybrid-common/releases/4.0.4)
    https://github.com/RevenueCat/purchases-flutter/pull/171

## 3.0.2

- Fixes versions number in plugin files
    https://github.com/RevenueCat/purchases-flutter/pull/166

## 3.0.1

- Fixes exception when calling `getProducts` and `checkTrialOrIntroductoryPriceEligibility`
    https://github.com/RevenueCat/purchases-flutter/issues/163
    https://github.com/RevenueCat/purchases-flutter/pull/164

## 3.0.0

- Adds null safety support and increases minimum Dart SDK version to 2.12.0
    https://github.com/RevenueCat/purchases-flutter/pull/155
    https://github.com/RevenueCat/purchases-flutter/pull/161
- Removes all analyzer warnings.
    https://github.com/RevenueCat/purchases-flutter/pull/154

## 2.0.3

- Fixed build issue on macOS targets
    https://github.com/RevenueCat/purchases-flutter/pull/151

## 2.0.2

- Updated pubspec.yaml
    https://github.com/RevenueCat/purchases-flutter/pull/147

## 2.0.1

- Updated pubspec.yaml
    https://github.com/RevenueCat/purchases-flutter/pull/143

## 2.0.0

- removes deprecated `getEntitlements`, replaced by `getOfferings`
- removes deprecated `makePurchase`, replaced by `purchaseProduct`

- iOS:
    - added new method, `syncPurchases`, that enables syncing the purchases in the local receipt with the backend without risking a password prompt. The method was already available on Android.
    - added a new method, `presentCodeRedemptionSheet`, for offer codes redemption.
- Bumped purchases-hybrid-common to 1.5.0 [Changelog here](https://github.com/RevenueCat/purchases-hybrid-common/releases/1.5.0)
- Bumped purchases-ios to 3.9.2 [Changelog here](https://github.com/RevenueCat/purchases-ios/releases/3.9.1)
- Bumped purchases-android to 4.0.1 [Changelog here](https://github.com/RevenueCat/purchases-hybrid-common/releases/4.0.1)

## 1.4.3

- Explicitly added `Purchases` framework to podspec's linker flags so it gets correctly linked in the plugin pod.
Fixed mapping of xcconfig files in Runner example.
    https://github.com/RevenueCat/purchases-flutter/pull/128

## 1.4.2

- Moved from valid architectures to excluded architectures in the Podfile, following Flutter's example.
    https://github.com/RevenueCat/purchases-flutter/pull/127

## 1.4.1

- Bumped common files to 1.4.5 [Changelog here](https://github.com/RevenueCat/purchases-hybrid-common/releases)
    https://github.com/RevenueCat/purchases-flutter/pull/121

## 1.4.0

- Bumped common files to 1.4.4 [Changelog here](https://github.com/RevenueCat/purchases-hybrid-common/releases)
- Added MacOS support
    - https://github.com/RevenueCat/purchases-flutter/pull/103
- Added subscription offers support
    - https://github.com/RevenueCat/purchases-flutter/pull/104

## 1.3.1

- Build config updates to fix build issues on iOS:
  - Added DEFINES_MODULE build setting for cocoapods projects
  - added swift version
  - made framework compile statically
  - replaced #import with @import
         https://github.com/RevenueCat/purchases-flutter/pull/100
  - bumped iOS version to 3.7.2
  - bumped `purchases-hybrid-common` version to 1.4.3


## 1.3.0

- Attribution V2:
    - Deprecated `addAttribution` in favor of `setAdjustId`, `setAppsflyerId`, `setFBAnonymousId`, `setMparticleId`.
    - Added support for OneSignal via `setOnesignalId`
    - Added `setMediaSource`, `setCampaign`, `setAdGroup`, `setAd`, `setKeyword`, `setCreative`, and `collectDeviceIdentifiers`
         https://github.com/RevenueCat/purchases-android/pull/184
- Bumped `purchases-hybrid-common` to 1.4.2 [Changelog here](https://github.com/RevenueCat/purchases-hybrid-common/releases)
- Bumped `purchases-ios` to 3.7.1 [Changelog here](https://github.com/RevenueCat/purchases-ios/releases)
- Bumped `purchases-android` to 3.5.0 [Changelog here](https://github.com/RevenueCat/purchases-android/releases)


## 1.2.1

- Fix a NullPointerException in the Android plugin (https://github.com/RevenueCat/purchases-flutter/pull/83)
- Made some clarifications on the docs for the type parameter in getProducts and purchaseProduct (https://github.com/RevenueCat/purchases-flutter/pull/81)

## 1.2.0

- Bumped iOS to 3.4.0 [Changelog here](https://github.com/RevenueCat/purchases-ios/releases)
- Bumped Android to 3.2.0 [Changelog here](https://github.com/RevenueCat/purchases-android/releases)
- Upgrade Flutter Android APIs (https://github.com/RevenueCat/purchases-flutter/pull/74)
- Adds userDefaultsSuiteName as an option when setting up the SDK (https://github.com/RevenueCat/purchases-flutter/pull/70)
- Added managementURL to PurchaserInfo (https://github.com/RevenueCat/purchases-flutter/pull/67)
- Added originalPurchaseDate to PurchaserInfo (https://github.com/RevenueCat/purchases-flutter/pull/66)
- Added `setProxyURL` (https://github.com/RevenueCat/purchases-flutter/pull/63)
- Exposes `setFinishTransactions` (https://github.com/RevenueCat/purchases-flutter/pull/45)
- Adds missing error codes (https://github.com/RevenueCat/purchases-flutter/pull/64)
- Adds new headers for platformFlavor and platformFlavorVersion (https://github.com/RevenueCat/purchases-flutter/pull/57, https://github.com/RevenueCat/purchases-flutter/pull/46)

## 1.1.1

- Update README.md to remove macOS support (#52)
- Await setDebugLogsEnabled before next steps in the sample app (#38)

## 1.1.0

- Adds Subscriber Attributes, which allow developers to store additional, structured information
for a user in RevenueCat. More info: https://docs.revenuecat.com/docs/user-attributes.

## 1.0.5

- Updates README.md
- Specifies compatible platforms

## 1.0.4

- Fixes `getOffering` always returns null #19

## 1.0.3

- Fixes crash when there's no offerings #17

## 1.0.2

- Fixes issue with older versions of Kotlin (#15)
- Updates README.md
- Adds checkTrialOrIntroductoryPriceEligibility

## 1.0.1

- Android updated to 3.0.3

## 1.0.0

- Added `PurchasesErrorHelper.getErrorCode(PlatformException)` and enum of `PurchasesErrorCode` to make handling errors easier. (#3)
- Support for new Offerings system.
- Deprecates `makePurchase` methods. Replaces with `purchasePackage`
- Deprecates `getEntitlements` method. Replaces with `getOfferings`
- See our migration guide for more info: https://docs.revenuecat.com/v3.0/docs/offerings-migration
- Updates to BillingClient 2.0.3. If finishTransactions is set to false (or observerMode is true when configuring the SDK), this SDK won't acknowledge any purchase.
- Adds proration mode support on upgrades/downgrades (#14)
- Adds `requestDate` and PurchaserInfo missing properties #12
- New identity changes:
 - The .createAlias() method is no longer required, use .identify() instead
 - .identify() will create an alias if being called from an anonymous ID generated by RevenueCat
 - Added an isAnonymous property to Purchases.sharedInstance
 - Improved offline use

## 0.3.3

- Dynamically access context and activity from registrar (https://github.com/RevenueCat/purchases-flutter/pull/11)

## 0.3.2

- Fixes `expirationDate` in EntitlementInfo for iOS.

## 0.3.1

- Fixes crash when there's a trial period and not an introductory price on Android.

## 0.3.0

- Deprecates `activeEntitlements` in PurchaserInfo and adds `entitlements` object to PurchaserInfo. For more info check out https://docs.revenuecat.com/docs/purchaserinfo
- Fixes exception when calling `makePurchase` with a bad product identifier in iOS
- Fixes `makePurchase` missing the `userCancelled` boolean in Android
- Fixes `makePurchase` not working in Android when calling with `oldSkus` parameter
- Fixes trial info being lost in Android. Access `introductoryPrice` in the product information to get information around the trial period.

## 0.2.2

- Upgrades Android SDK to https://github.com/RevenueCat/purchases-android/releases/tag/2.3.1

## 0.2.1

- Makes some changes to the introductory pricing due to some inconsistencies introduced in 0.2.0.
  Introductory pricing is now an object part of the product.

## 0.2.0

- Upgrades iOS SDK to https://github.com/RevenueCat/purchases-ios/releases/tag/2.5.0
- Upgrades Android SDK to https://github.com/RevenueCat/purchases-android/releases/tag/2.3.0.
- Adds Facebook as supported attribution network.
- Adds automatic Apple Search Ads attribution collection. Disabled by default.
- Adds introductory pricing to the iOS product.

## 0.1.4

- Fixes UninitializedPropertyAccessException when trying to close the instance onDestroy of the Android Activity.

## 0.1.3

- Formats files

## 0.1.2

- Adds more docs to custom types
- Fixes report issue link

## 0.1.1

- Fixes userCancelled in Android
- Adds docs

## 0.1.0

- Initial release
