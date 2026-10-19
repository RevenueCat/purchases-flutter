## RevenueCat SDK
### ✨ New Features
* [SDK-4558] Add `syncPurchasesForResult` and fix `syncPurchases` not waiting for sync completion on Android (This means that this call may now fail in Android, as it did in iOS) (#1953) via Toni Rico (@tonidero)
* Add unverified rewarded ad tracking (#1937) via Pol Miro (@polmiro)
### 🐞 Bugfixes
* fix: pass productIdentifier correctly for recordPurchase (#1967) via Will Taylor (@fire-at-will)
* [EXTERNAL] Fix listeners being skipped when a listener removes itself during a callback (#1963) by @RaphaelFakhri (#1964) via Toni Rico (@tonidero)
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 19.14.0 (#1965) via RevenueCat Git Bot (@RCGitBot)
  * [Android 10.28.1](https://github.com/RevenueCat/purchases-android/releases/tag/10.28.1)
  * [Android 10.28.0](https://github.com/RevenueCat/purchases-android/releases/tag/10.28.0)
  * [Android 10.27.1](https://github.com/RevenueCat/purchases-android/releases/tag/10.27.1)
  * [iOS 5.96.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.96.0)
  * [Web 1.71.0](https://github.com/RevenueCat/purchases-js/releases/tag/1.71.0)
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 19.13.0 (#1960) via RevenueCat Git Bot (@RCGitBot)

### 🔄 Other Changes
* chore: route CODEOWNERS review requests to owning teams (#1961) via Cesar de la Vega (@vegaro)
