## 3.0.0

- Adds null safety support and increases minimum Dart SDK version to 2.12.0
    https://github.com/RevenueCat/purchases-flutter/pull/155
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
