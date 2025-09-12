> [!WARNING]  
> If you don't have any login system in your app, please make sure your one-time purchase products have been correctly configured in the RevenueCat dashboard as either consumable or non-consumable. If they're incorrectly configured as consumables, RevenueCat will consume these purchases. This means that users won't be able to restore them from version 9.0.0 onward.
> Non-consumables are products that are meant to be bought only once, for example, lifetime subscriptions.


## RevenueCat SDK
### ✨ New Features
* Add `customerEmail` param to `PurchaseParams` (#1463) via Toni Rico (@tonidero)
### 🐞 Bugfixes
* Pass `presentedOfferingContext` to natives when presenting paywall or displaying PaywallView (#1460) via Toni Rico (@tonidero)
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 17.6.0 (#1465) via RevenueCat Git Bot (@RCGitBot)
  * [Android 9.6.0](https://github.com/RevenueCat/purchases-android/releases/tag/9.6.0)
  * [iOS 5.38.2](https://github.com/RevenueCat/purchases-ios/releases/tag/5.38.2)
  * [iOS 5.38.1](https://github.com/RevenueCat/purchases-ios/releases/tag/5.38.1)
  * [iOS 5.38.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.38.0)
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 17.5.1 (#1462) via RevenueCat Git Bot (@RCGitBot)
  * [Android 9.6.0](https://github.com/RevenueCat/purchases-android/releases/tag/9.6.0)
  * [iOS 5.38.2](https://github.com/RevenueCat/purchases-ios/releases/tag/5.38.2)
  * [iOS 5.38.1](https://github.com/RevenueCat/purchases-ios/releases/tag/5.38.1)
  * [iOS 5.38.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.38.0)
* [RENOVATE] Update build-dependencies to v8.13.0 (#1459) via RevenueCat Git Bot (@RCGitBot)

### 🔄 Other Changes
* Update bundle dependencies (#1467) via Cesar de la Vega (@vegaro)
* Add `purchase` method with `PurchaseParams` object (#1461) via Toni Rico (@tonidero)
* Default to Swift Package Manager in Purchase Tester (instead of CocoaPods) (#1454) via Antonio Pallares (@ajpallares)
