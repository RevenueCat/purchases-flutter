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
