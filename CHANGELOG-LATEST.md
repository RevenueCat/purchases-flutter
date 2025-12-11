> [!WARNING]  
> If you don't have any login system in your app, please make sure your one-time purchase products have been correctly configured in the RevenueCat dashboard as either consumable or non-consumable. If they're incorrectly configured as consumables, RevenueCat will consume these purchases. This means that users won't be able to restore them from version 9.0.0 onward.
> Non-consumables are products that are meant to be bought only once, for example, lifetime subscriptions.


## RevenueCat SDK
### ✨ New Features
* Add `diagnosticsEnabled` configuration option (#1569) via Toni Rico (@tonidero)
* [EXTERNAL] Add support for preferredUILocaleOverride to Purchases Flutter SDK (#1561) via @marcorizza (#1562) via Antonio Pallares (@ajpallares)
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 17.23.0 (#1566) via RevenueCat Git Bot (@RCGitBot)
  * [Android 9.15.3](https://github.com/RevenueCat/purchases-android/releases/tag/9.15.3)
  * [Android 9.15.2](https://github.com/RevenueCat/purchases-android/releases/tag/9.15.2)
  * [iOS 5.50.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.50.0)
  * [iOS 5.49.3](https://github.com/RevenueCat/purchases-ios/releases/tag/5.49.3)

### 🔄 Other Changes
* Updated CircleCI macOS executor from m1 to m4 to avoid deprecation (#1567) via Rick (@rickvdl)
* Bump fastlane-plugin-revenuecat_internal from `efca663` to `76a3a08` (#1565) via dependabot[bot] (@dependabot[bot])
* Fix version of PHC in Swift Package manifest for mac (#1563) via Antonio Pallares (@ajpallares)
