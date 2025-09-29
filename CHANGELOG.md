## 8.11.0
## RevenueCat SDK
### 📦 Dependency Updates
* Updates purchases-hybrid-common to 14.3.0 (#1486) via Antonio Pallares (@ajpallares)
  * [Android 8.24.0](https://github.com/RevenueCat/purchases-android/releases/tag/8.24.0)
  * [Android 8.23.0](https://github.com/RevenueCat/purchases-android/releases/tag/8.23.0)
  * [Android 8.22.1](https://github.com/RevenueCat/purchases-android/releases/tag/8.22.1)

### 🔄 Other Changes
* [V8] Prepare for next release (#1483) via Antonio Pallares (@ajpallares)

## 8.10.6
## RevenueCat SDK
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 14.2.0 (#1400) via RevenueCat Git Bot (@RCGitBot)
  * [Android 8.22.0](https://github.com/RevenueCat/purchases-android/releases/tag/8.22.0)
  * [Android 8.21.0](https://github.com/RevenueCat/purchases-android/releases/tag/8.21.0)
  * [iOS 5.32.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.32.0)
  * [iOS 5.31.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.31.0)
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 14.1.0 (#1396) via RevenueCat Git Bot (@RCGitBot)
  * [Android 8.22.0](https://github.com/RevenueCat/purchases-android/releases/tag/8.22.0)
  * [Android 8.21.0](https://github.com/RevenueCat/purchases-android/releases/tag/8.21.0)
  * [iOS 5.32.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.32.0)
  * [iOS 5.31.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.31.0)
* [RENOVATE] Update dependency gradle to v8.14.3 (#1394) via RevenueCat Git Bot (@RCGitBot)

### 🔄 Other Changes
* Bump danger from 9.5.1 to 9.5.3 (#1393) via dependabot[bot] (@dependabot[bot])

## 8.10.5
## RevenueCat SDK
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 14.0.2 (#1389) via RevenueCat Git Bot (@RCGitBot)
  * [iOS 5.30.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.30.0)
* [RENOVATE] Update build-dependencies (#1383) via RevenueCat Git Bot (@RCGitBot)

### 🔄 Other Changes
* Update workflows/issue-notifications.yml@v2 (#1387) via Josh Holtz (@joshdholtz)
* Add GitHub Issue Action Ack (#1385) via Josh Holtz (@joshdholtz)

## 8.10.4
## RevenueCat SDK
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.38.1 (#1382) via RevenueCat Git Bot (@RCGitBot)
  * [Android 8.20.0](https://github.com/RevenueCat/purchases-android/releases/tag/8.20.0)

### 🔄 Other Changes
* Configure Renovate (#1376) via RevenueCat Git Bot (@RCGitBot)
* Add `9.0.0-beta.3` to `CHANGELOG` (#1374) via Toni Rico (@tonidero)

## 9.0.0-beta.3
## RevenueCat SDK
### 💥 Breaking Changes
* Increased min Flutter SDK to 3.22.0 and Dart min SDK to 3.4.0
* Remove freezed in favor of manually parsed models (#1368) via Toni Rico (@tonidero)
  * This removed some APIs like `toJson`, `StoreTransaction.revenueCatIdentifier`
  * This also modified our APIs to use WebPurchaseRedemptionResult. Now you will need to do:
```
WebPurchaseRedemptionResult result;
switch (result) {
  case WebPurchaseRedemptionSuccess(:final customerInfo):
    // Handle successful redemption
    break;
  case WebPurchaseRedemptionError(:final error):
    // Handle error in redemption
    break;
  case WebPurchaseRedemptionPurchaseBelongsToOtherUser():
    // Handle case where the purchase belongs to another user
    break;
  case WebPurchaseRedemptionInvalidToken():
    // Handle case where the token is invalid
    break;
  case WebPurchaseRedemptionExpired(:final obfuscatedEmail):
    // Handle case where the redemption link has expired
    break;
};
```

### New Features
* [Beta] Flutter Web support (#1237) via Toni Rico (@tonidero)

In order to use Flutter Web, you need to create a new Web Billing project (See [docs](https://www.revenuecat.com/docs/web/web-billing/overview)), then configure the SDK with the provided API key, in the form of `rcb_xxx` or `rcb_sb_xxx`.

Web functionality is currently limited. Supported functionality includes:
- Configuration
- Login/logout
- Fetching Offerings
- Fetching CustomerInfo
- Purchasing Packages

Currently unsupported functionality includes:
- Setting attributes
- Product operations (get products/purchase products).
- Restoring purchases (Purchases can be restored using Web Billing's built-in mechanisms)

Please check this out and contact us with any feedback!

## 8.10.3
## RevenueCat SDK
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.37.0 (#1369) via RevenueCat Git Bot (@RCGitBot)
  * [iOS 5.29.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.29.0)
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.36.1 (#1367) via RevenueCat Git Bot (@RCGitBot)
  * [iOS 5.29.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.29.0)

### 🔄 Other Changes
* Update CHANGELOG with 9.0.0 betas (#1357) via Toni Rico (@tonidero)

## 8.10.2
## RevenueCat SDK
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.36.0 (#1361) via RevenueCat Git Bot (@RCGitBot)
  * [iOS 5.28.1](https://github.com/RevenueCat/purchases-ios/releases/tag/5.28.1)
  * [iOS 5.28.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.28.0)

## 8.10.1
## RevenueCat SDK
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.35.0 (#1358) via RevenueCat Git Bot (@RCGitBot)
  * [Android 8.19.2](https://github.com/RevenueCat/purchases-android/releases/tag/8.19.2)
  * [Android 8.19.1](https://github.com/RevenueCat/purchases-android/releases/tag/8.19.1)
  * [iOS 5.27.1](https://github.com/RevenueCat/purchases-ios/releases/tag/5.27.1)
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.34.0 (#1355) via RevenueCat Git Bot (@RCGitBot)
  * [Android 8.19.2](https://github.com/RevenueCat/purchases-android/releases/tag/8.19.2)
  * [Android 8.19.1](https://github.com/RevenueCat/purchases-android/releases/tag/8.19.1)
  * [iOS 5.27.1](https://github.com/RevenueCat/purchases-ios/releases/tag/5.27.1)

## 9.0.0-beta.2
## RevenueCat SDK
### 💥 Breaking Changes
* Increased min Flutter SDK to 3.22.0 and Dart min SDK to 3.4.0

### New Features
* [Beta] Flutter Web support (#1237) via Toni Rico (@tonidero)

In order to use Flutter Web, you need to create a new Web Billing project (See [docs](https://www.revenuecat.com/docs/web/web-billing/overview)), then configure the SDK with the provided API key, in the form of `rcb_xxx` or `rcb_sb_xxx`.

Web functionality is currently limited. Supported functionality includes:
- Configuration
- Login/logout
- Fetching Offerings
- Fetching CustomerInfo
- Purchasing Packages

Currently unsupported functionality includes:
- Setting attributes
- Product operations (get products/purchase products).
- Restoring purchases (Purchases can be restored using Web Billing's built-in mechanisms)

Please check this out and contact us with any feedback!

### Changes from previous beta
- Fix `Store` type parsing issues in Web
- Added all changes from major 8.7.5+

## 8.10.0
## RevenueCat SDK
### ✨ New Features
* Add `paddle` store (#1351) via Will Taylor (@fire-at-will)
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.33.0 (#1352) via RevenueCat Git Bot (@RCGitBot)
  * [Android 8.19.0](https://github.com/RevenueCat/purchases-android/releases/tag/8.19.0)
  * [Android 8.18.0](https://github.com/RevenueCat/purchases-android/releases/tag/8.18.0)
  * [iOS 5.26.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.26.0)
  * [iOS 5.25.3](https://github.com/RevenueCat/purchases-ios/releases/tag/5.25.3)
  * [iOS 5.25.2](https://github.com/RevenueCat/purchases-ios/releases/tag/5.25.2)
  * [iOS 5.25.1](https://github.com/RevenueCat/purchases-ios/releases/tag/5.25.1)
  * [iOS 5.25.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.25.0)

## 8.9.0
## RevenueCat SDK
### ✨ New Features
* Add `setTenjinAnalyticsInstallationID` API (#1347) via Toni Rico (@tonidero)

## 8.8.1
## RevenueCat SDK
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.32.0 (#1344) via RevenueCat Git Bot (@RCGitBot)
  * [iOS 5.24.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.24.0)
  * [iOS 5.23.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.23.0)

### 🔄 Other Changes
* Bump fastlane from 2.227.1 to 2.227.2 (#1338) via dependabot[bot] (@dependabot[bot])

## 8.8.0
## RevenueCat SDK
### ✨ New Features
* Add `storefront` API to obtain the country of the store account (#1335) via Toni Rico (@tonidero)

## 8.7.5
## RevenueCat SDK
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.29.1 (#1332) via RevenueCat Git Bot (@RCGitBot)
  * [Android 8.17.1](https://github.com/RevenueCat/purchases-android/releases/tag/8.17.1)
  * [Android 8.17.0](https://github.com/RevenueCat/purchases-android/releases/tag/8.17.0)
  * [iOS 5.22.2](https://github.com/RevenueCat/purchases-ios/releases/tag/5.22.2)
  * [iOS 5.22.1](https://github.com/RevenueCat/purchases-ios/releases/tag/5.22.1)
  * [iOS 5.22.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.22.0)

### 🔄 Other Changes
* Bump min supported versions and add tests for min SDK compatibility (#1328) via Toni Rico (@tonidero)

## 9.0.0-beta.1
## RevenueCat SDK
### 💥 Breaking Changes
* Increased min Flutter SDK to 3.22.0 and Dart min SDK to 3.4.0

### New Features
* [Beta] Flutter Web support (#1237) via Toni Rico (@tonidero)

In order to use Flutter Web, you need to create a new Web Billing project (See [docs](https://www.revenuecat.com/docs/web/web-billing/overview)), then configure the SDK with the provided API key, in the form of `rcb_xxx` or `rcb_sb_xxx`.

Web functionality is currently limited. Supported functionality includes:
- Configuration
- Login/logout
- Fetching Offerings
- Fetching CustomerInfo
- Purchasing Packages

Currently unsupported functionality includes:
- Setting attributes
- Product operations (get products/purchase products).
- Restoring purchases (Purchases can be restored using Web Billing's built-in mechanisms)

Please check this out and contact us with any feedback!

## 8.7.4
## RevenueCat SDK
### 🐞 Bugfixes
* Reverts version bumps done in f21e068 (#1327) via JayShortway (@JayShortway)

### 🔄 Other Changes
* Remove pubspec.lock from github (#1325) via Toni Rico (@tonidero)
* Bump nokogiri from 1.18.4 to 1.18.8 (#1323) via dependabot[bot] (@dependabot[bot])

## 8.7.3
## RevenueCat SDK
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.28.1 (#1319) via RevenueCat Git Bot (@RCGitBot)
  * [Android 8.16.1](https://github.com/RevenueCat/purchases-android/releases/tag/8.16.1)
  * [iOS 5.21.2](https://github.com/RevenueCat/purchases-ios/releases/tag/5.21.2)
  * [iOS 5.21.1](https://github.com/RevenueCat/purchases-ios/releases/tag/5.21.1)

### 🔄 Other Changes
* Bump fastlane from 2.227.0 to 2.227.1 (#1317) via dependabot[bot] (@dependabot[bot])

## 8.7.2
## RevenueCat SDK
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.28.0 (#1315) via RevenueCat Git Bot (@RCGitBot)
  * [Android 8.16.0](https://github.com/RevenueCat/purchases-android/releases/tag/8.16.0)
  * [iOS 5.21.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.21.0)
  * [iOS 5.20.3](https://github.com/RevenueCat/purchases-ios/releases/tag/5.20.3)

## 8.7.1
## RevenueCat SDK
### 🐞 Bugfixes
* Fix API Tests (#1307) via Will Taylor (@fire-at-will)
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.26.1 (#1311) via RevenueCat Git Bot (@RCGitBot)
  * [Android 8.15.1](https://github.com/RevenueCat/purchases-android/releases/tag/8.15.1)
  * [iOS 5.20.2](https://github.com/RevenueCat/purchases-ios/releases/tag/5.20.2)
  * [iOS 5.20.1](https://github.com/RevenueCat/purchases-ios/releases/tag/5.20.1)

## 8.7.0
## RevenueCat SDK
### ✨ New Features
* Add `onPurchaseCancelled` handler to `PaywallView` and `PaywallFooterView` (#1296) via Jeffrey Bunn (@Jethro87)
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.26.0 (#1298) via RevenueCat Git Bot (@RCGitBot)
  * [Android 8.15.0](https://github.com/RevenueCat/purchases-android/releases/tag/8.15.0)
  * [Android 8.14.3](https://github.com/RevenueCat/purchases-android/releases/tag/8.14.3)
  * [Android 8.14.2](https://github.com/RevenueCat/purchases-android/releases/tag/8.14.2)
  * [iOS 5.20.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.20.0)

### 🔄 Other Changes
* Bump nokogiri from 1.18.3 to 1.18.4 (#1299) via dependabot[bot] (@dependabot[bot])
* Bump fastlane from 2.226.0 to 2.227.0 (#1294) via dependabot[bot] (@dependabot[bot])
* Update fastlane plugin (#1293) via Toni Rico (@tonidero)
* Bump json from 2.10.1 to 2.10.2 (#1291) via dependabot[bot] (@dependabot[bot])

## 8.6.1
## RevenueCat SDK
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.25.0 (#1290) via RevenueCat Git Bot (@RCGitBot)
  * [Android 8.14.1](https://github.com/RevenueCat/purchases-android/releases/tag/8.14.1)
  * [Android 8.14.0](https://github.com/RevenueCat/purchases-android/releases/tag/8.14.0)
  * [iOS 5.19.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.19.0)
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.24.0 (#1287) via RevenueCat Git Bot (@RCGitBot)
  * [Android 8.14.1](https://github.com/RevenueCat/purchases-android/releases/tag/8.14.1)
  * [Android 8.14.0](https://github.com/RevenueCat/purchases-android/releases/tag/8.14.0)
  * [iOS 5.19.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.19.0)

### 🔄 Other Changes
* Increase android related versions in purchase_tester (#1281) via Cesar de la Vega (@vegaro)
* Fix new Flutter version test issues (#1289) via Toni Rico (@tonidero)

## 8.6.0
## RevenueCat SDK
### 📦 Dependency Updates
* Bump nokogiri from 1.16.7 to 1.18.3 (#1271) via dependabot[bot] (@dependabot[bot])
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.21.0 (#1280) via RevenueCat Git Bot (@RCGitBot)
  * [Android 8.13.0](https://github.com/RevenueCat/purchases-android/releases/tag/8.13.0)
* Bump cocoapods from 1.16.0 to 1.16.2 (#1200) via dependabot[bot] (@dependabot[bot])
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.20.0 (#1279) via RevenueCat Git Bot (@RCGitBot)
  * [Android 8.13.0](https://github.com/RevenueCat/purchases-android/releases/tag/8.13.0)

## RevenueCatUI SDK
### Customer Center
#### ✨ New Features
* feat: Introduce CustomerCenter (#1261) via Cesar de la Vega (@vegaro)

## 8.5.2
## RevenueCat SDK
### 🐞 Bugfixes
* Add prepaid periodType (#1277) via Will Taylor (@fire-at-will)
### 📦 Dependency Updates
* Updates purchases-hybrid-common to 13.19.0 (#1276) via RevenueCat Git Bot (@RCGitBot)
  * [iOS 5.18.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.18.0)
  * [iOS 5.17.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.17.0)

### 🔄 Other Changes
* chore: Update proguard-rules.pro like flutter_ui (#1274) via Facundo Menzella (@facumenzella)

## 8.5.1
## RevenueCat SDK
### 🐞 Bugfixes
* Add proguard-rules.pro to `purchases-ui-flutter` (#1270) via Cesar de la Vega (@vegaro)

## 8.5.0
## RevenueCat SDK
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.18.1 (#1265) via RevenueCat Git Bot (@RCGitBot)
  * [Android 8.12.2](https://github.com/RevenueCat/purchases-android/releases/tag/8.12.2)
  * [Android 8.12.1](https://github.com/RevenueCat/purchases-android/releases/tag/8.12.1)
  * [Android 8.12.0](https://github.com/RevenueCat/purchases-android/releases/tag/8.12.0)

### 🔄 Other Changes
* [Paywalls V2] Deprecate PaywallFooterView in favor of OriginalTemplatePaywallFooterView (#1256) via Toni Rico (@tonidero)
* Fix flutter doctor issue (#1263) via Toni Rico (@tonidero)

## 8.4.6
## RevenueCat SDK
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.17.1 (#1258) via RevenueCat Git Bot (@RCGitBot)
  * [iOS 5.16.1](https://github.com/RevenueCat/purchases-ios/releases/tag/5.16.1)

## 8.4.5
## RevenueCat SDK
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.17.0 (#1254) via RevenueCat Git Bot (@RCGitBot)
  * [iOS 5.16.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.16.0)
  * [iOS 5.15.1](https://github.com/RevenueCat/purchases-ios/releases/tag/5.15.1)

## 8.4.4
## RevenueCat SDK
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.16.2 (#1252) via RevenueCat Git Bot (@RCGitBot)

## 8.4.3
## RevenueCat SDK
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.16.0 (#1250) via RevenueCat Git Bot (@RCGitBot)
  * [Android 8.11.0](https://github.com/RevenueCat/purchases-android/releases/tag/8.11.0)
  * [iOS 5.15.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.15.0)
  * [iOS 5.14.6](https://github.com/RevenueCat/purchases-ios/releases/tag/5.14.6)

## 8.4.2
## RevenueCat SDK
### 📦 Dependency Updates
* Updates purchases-hybrid-common to 13.15.2 (#1244) via RevenueCat Git Bot (@RCGitBot)
* Bump fastlane from 2.225.0 to 2.226.0 (#1240) via dependabot[bot] (@dependabot[bot])

### 🔄 Other Changes
* Update CHANGELOG to include changes that expose storeError in iOS if it exists (#1243) via Toni Rico (@tonidero)

## 8.4.1
## RevenueCat SDK
### 📦 Dependency Updates
* Updates purchases-hybrid-common to 13.15.1 (#1241) via RevenueCat Git Bot (@RCGitBot)
  * [Android 8.10.8](https://github.com/RevenueCat/purchases-android/releases/tag/8.10.8)
  * [Android 8.10.7](https://github.com/RevenueCat/purchases-android/releases/tag/8.10.7)
  * [Android 8.10.6](https://github.com/RevenueCat/purchases-android/releases/tag/8.10.6)
  * [iOS 5.14.5](https://github.com/RevenueCat/purchases-ios/releases/tag/5.14.5)
  * [iOS 5.14.4](https://github.com/RevenueCat/purchases-ios/releases/tag/5.14.4)
  * [iOS 5.14.3](https://github.com/RevenueCat/purchases-ios/releases/tag/5.14.3)
  * [iOS 5.14.2](https://github.com/RevenueCat/purchases-ios/releases/tag/5.14.2)
  * [iOS 5.14.1](https://github.com/RevenueCat/purchases-ios/releases/tag/5.14.1)

### 🔄 Other Changes
* Expose storeError for iOS if any (https://github.com/RevenueCat/purchases-hybrid-common/pull/1011) via Toni Rico (@tonidero). You can use it like this:
```
try {
  offerings = await Purchases.getOfferings();
} on PlatformException catch (e) {
  final storeError = e.details['storeError'];
  // Do something with storeError if it exists
}
```

## 8.4.0
## RevenueCat SDK
### ✨ New Features
* Support Web Redemption Links (#1227) via Toni Rico (@tonidero)

## 8.3.2
## RevenueCat SDK
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.13.0 (#1226) via RevenueCat Git Bot (@RCGitBot)
  * [Android 8.10.5](https://github.com/RevenueCat/purchases-android/releases/tag/8.10.5)
  * [Android 8.10.4](https://github.com/RevenueCat/purchases-android/releases/tag/8.10.4)
  * [iOS 5.14.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.14.0)
  * [iOS 5.13.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.13.0)

## 8.3.1
## RevenueCat SDK
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.12.1 (#1222) via RevenueCat Git Bot (@RCGitBot)
  * [iOS 5.12.1](https://github.com/RevenueCat/purchases-ios/releases/tag/5.12.1)

## 8.3.0
## RevenueCat SDK
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.12.0 (#1215) via RevenueCat Git Bot (@RCGitBot)
  * [Android 8.10.3](https://github.com/RevenueCat/purchases-android/releases/tag/8.10.3)
  * [iOS 5.12.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.12.0)
  * [iOS 5.11.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.11.0)
  * [iOS 5.10.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.10.0)
  * [iOS 5.9.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.9.0)
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.11.0 (#1212) via RevenueCat Git Bot (@RCGitBot)
  * [Android 8.10.3](https://github.com/RevenueCat/purchases-android/releases/tag/8.10.3)
  * [iOS 5.12.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.12.0)
  * [iOS 5.11.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.11.0)
  * [iOS 5.10.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.10.0)
  * [iOS 5.9.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.9.0)
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.10.0 (#1211) via RevenueCat Git Bot (@RCGitBot)
  * [Android 8.10.3](https://github.com/RevenueCat/purchases-android/releases/tag/8.10.3)
  * [iOS 5.12.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.12.0)
  * [iOS 5.11.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.11.0)
  * [iOS 5.10.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.10.0)
  * [iOS 5.9.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.9.0)
### Win-back Offers
#### ✨ New Features
* Support Fetching and Redeeming Win-Back Offers on Custom Paywall #1134 (#1218) via Will Taylor (@fire-at-will)

## 8.2.2
## RevenueCat SDK
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.9.0 (#1206) via RevenueCat Git Bot (@RCGitBot)
  * [Android 8.10.2](https://github.com/RevenueCat/purchases-android/releases/tag/8.10.2)
  * [Android 8.10.1](https://github.com/RevenueCat/purchases-android/releases/tag/8.10.1)
  * [Android 8.10.0](https://github.com/RevenueCat/purchases-android/releases/tag/8.10.0)
  * [iOS 5.8.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.8.0)

## 8.2.1
## RevenueCat SDK
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.8.0 (#1201) via RevenueCat Git Bot (@RCGitBot)
  * [Android 8.9.0](https://github.com/RevenueCat/purchases-android/releases/tag/8.9.0)
  * [iOS 5.7.1](https://github.com/RevenueCat/purchases-ios/releases/tag/5.7.1)

## 8.2.0
## RevenueCat SDK
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.7.0 (#1196) via RevenueCat Git Bot (@RCGitBot)
  * [iOS 5.7.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.7.0)
* Bump cocoapods from 1.15.2 to 1.16.0 (#1195) via dependabot[bot] (@dependabot[bot])
* Bump danger from 9.5.0 to 9.5.1 (#1190) via dependabot[bot] (@dependabot[bot])
* Bump fastlane from 2.224.0 to 2.225.0 (#1189) via dependabot[bot] (@dependabot[bot])
### Win-back Offers
#### ✨ New Features
* Support displaying deferred win-back StoreKit messages (#1194) via Will Taylor (@fire-at-will)

## 8.1.6
## RevenueCat SDK
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.5.1 (#1182) via RevenueCat Git Bot (@RCGitBot)
  * [Android 8.8.1](https://github.com/RevenueCat/purchases-android/releases/tag/8.8.1)

## 8.1.5
## RevenueCat SDK
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.5.0 (#1180) via RevenueCat Git Bot (@RCGitBot)
  * [iOS 5.6.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.6.0)
  * [iOS 5.5.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.5.0)
* Bump fastlane from 2.223.1 to 2.224.0 (#1178) via dependabot[bot] (@dependabot[bot])

## RevenueCatUI SDK
### 🐞 Bugfixes
* Fix double callbacks issue in PaywallView (https://github.com/RevenueCat/purchases-ios/pull/4333)
* Fix area insets in PaywallView (#1179) via Cesar de la Vega (@vegaro)

## 8.1.4
## RevenueCat SDK
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.4.0 (#1174) via RevenueCat Git Bot (@RCGitBot)
  * [Android 8.8.0](https://github.com/RevenueCat/purchases-android/releases/tag/8.8.0)
  * [iOS 5.4.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.4.0)
* Bump fastlane from 2.222.0 to 2.223.1 (#1173) via dependabot[bot] (@dependabot[bot])

### 🔄 Other Changes
* Update fastlane plugin (#1176) via Toni Rico (@tonidero)

## 8.1.3
## RevenueCat SDK
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.3.0 (#1171) via RevenueCat Git Bot (@RCGitBot)

## 8.1.2
## RevenueCat SDK
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.2.1 (#1164) via RevenueCat Git Bot (@RCGitBot)

### 🔄 Other Changes
* Bump fastlane-plugin-revenuecat_internal from 5140dbc to 55a0455 (#1165) via Cesar de la Vega (@vegaro)
* Update allowSharingAppStoreAccount Deprecation Message (#1163) via Will Taylor (@fire-at-will)

## 8.1.1
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.2.0 (#1157) via RevenueCat Git Bot (@RCGitBot)
* Bump rexml from 3.3.4 to 3.3.6 (#1151) via dependabot[bot] (@dependabot[bot])
### Other Changes
* Update fastlane-plugin-revenuecat_internal (#1158) via Cesar de la Vega (@vegaro)

## 8.1.0
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.1.0 (#1148) via RevenueCat Git Bot (@RCGitBot)
  * [Android 8.6.0](https://github.com/RevenueCat/purchases-android/releases/tag/8.6.0)
  * [Android 8.5.0](https://github.com/RevenueCat/purchases-android/releases/tag/8.5.0)
  * [iOS 5.3.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.3.0)
### Other Changes
* Fix purchases-ui-flutter main SDK version substitution (#1147) via Toni Rico (@tonidero)

## 8.0.0
### Breaking Changes
* Remove embedding v1 support (#1141) via Toni Rico (@tonidero)

If you're using embedding v1, please check how to migrate in the [official flutter docs](https://docs.flutter.dev/release/breaking-changes/plugin-api-migration#upgrade-steps).
### Bugfixes
* Refine StoreKitVersion logging in configure function (#1143) via Will Taylor (@fire-at-will)
### Other Changes
* v7-MIGRATION.md typo fix (#1144) via Will Taylor (@fire-at-will)

## 7.0.2
### Bugfixes
* Parse recordPurchase response (#1138) via Will Taylor (@fire-at-will)
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 13.0.1 (#1136) via RevenueCat Git Bot (@RCGitBot)
### Other Changes
* Update iOS deployment target in readme (#1137) via Will Taylor (@fire-at-will)

## 7.0.1
### Other Changes
* Update fastlane-plugin-revenuecat_internal (#1133) via Mark Villacampa (@MarkVillacampa)
* update purchases_flutter dependency to 7.0.0 on purchases_ui_flutter (#1132) via Mark Villacampa (@MarkVillacampa)
## 7.0.0
This latest release updates the Android SDK dependency from v7 to [v8](https://github.com/RevenueCat/purchases-android/releases/tag/6.0.0) to use BillingClient 7 and updates the iOS SDK dependency from v4 to v5 to use StoreKit 2 by default in the SDK.

### Migration Guides

- See [Android Native - V8 API Migration Guide](https://github.com/RevenueCat/purchases-android/blob/main/migrations/v8-MIGRATION.md) for a more thorough explanation of the Android changes.
- See [iOS Native - V5 Migration Guide](https://github.com/RevenueCat/purchases-ios/blob/main/Sources/DocCDocumentation/DocCDocumentation.docc/V5_API_Migration_guide.md) for a more thorough explanation of the iOS changes. Notably, this version uses StoreKit 2 to process purchases by default.

### New Minimum OS Versions

This release raises the minumum required OS versions to the following:

- iOS 13.0
- tvOS 13.0
- watchOS 6.2
- macOS 10.15
- Android: SDK 21 (Android 5.0)

### In-App Purchase Key Required for StoreKit 2

In order to use StoreKit 2, you must configure your In-App Purchase Key in the RevenueCat dashboard. You can find instructions describing how to do this [here](https://www.revenuecat.com/docs/in-app-purchase-key-configuration).

### `usesStoreKit2IfAvailable` is now `storeKitVersion`

When configuring the SDK, the `usesStoreKit2IfAvailable` parameter has been replaced by an optional `storeKitVersion: STOREKIT_VERSION` parameter. It defaults to letting the iOS SDK determine the most appropriate version of StoreKit at runtime. If you'd like to use a specific version of StoreKit, you may provide a value for `storeKitVersion` like so:

```dart
PurchasesConfiguration configuration = PurchasesConfiguration("myAPIKey");
configuration.storeKitVersion = StoreKitVersion.storeKit1;

Purchases.configure(configuration);
```

### Observer Mode is now PurchasesAreCompletedBy

Version 7.0 of the SDK deprecates the term "Observer Mode" (and the APIs where this term was used), and replaces it with `PurchasesAreCompletedBy` (either RevenueCat or your app). When specifying that your app will complete purchases, you must provide the StoreKit version that your app is using to make purchases on iOS. If your app is only available on Android, you may provide any value since the native Android SDK ignores this value.

You can enable it when configuring the SDK:

```dart
PurchasesConfiguration configuration = PurchasesConfiguration("myAPIKey");
configuration.purchasesAreCompletedBy = PurchasesAreCompletedByMyApp(
    storeKitVersion: StoreKitVersion.storeKit2,
);

Purchases.configure(configuration);
```

#### ⚠️ Observing Purchases Completed by Your App on macOS

By default, when purchases are completed by your app using StoreKit 2 on macOS, the SDK does not detect a user's purchase until after the user foregrounds the app after the purchase has been made. If you'd like RevenueCat to immediately detect the user's purchase, call `Purchases.recordPurchase(productID)` for any new purchases, like so:

```dart
await Purchases.recordPurchase(productID);
```

#### Observing Purchases Completed by Your App with StoreKit 1

If purchases are completed by your app using StoreKit 1, you will need to explicitly configure the SDK to use StoreKit 1:

```dart
PurchasesConfiguration configuration = PurchasesConfiguration("myAPIKey");
configuration.purchasesAreCompletedBy = PurchasesAreCompletedByMyApp(
    storeKitVersion: StoreKitVersion.storeKit1,
);

Purchases.configure(configuration);
```

Full migration guide to V7: [Flutter - V7 API Migration Guide](migrations/v7-MIGRATION.md)

### Dependency Updates

- Bump danger from 9.4.3 to 9.5.0 (#1128) via dependabot[bot] (@dependabot[bot])
- Bump fastlane from 2.221.1 to 2.222.0 (#1126) via dependabot[bot] (@dependabot[bot])

### Other Changes

- [PurchaseTester] Refactor upsell screen to display all offerings (#1123) via Toni Rico (@tonidero)

## 6.30.2
### Bugfixes
* Fix `syncObserverModeAmazonPurchase` deprecation warning (#1115) via Toni Rico (@tonidero)

## 6.30.1
### Bugfixes
* Add `OptIn` annotation on paywalls code (#1112) via Cesar de la Vega (@vegaro)

## 6.30.0
### New Features
* Add support for `DEFERRED` upgrades and updates purchases-hybrid-common to 11.1.0 (#1108) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.12.0](https://github.com/RevenueCat/purchases-android/releases/tag/7.12.0)
  * [iOS 4.43.2](https://github.com/RevenueCat/purchases-ios/releases/tag/4.43.2)
  * [iOS 4.43.1](https://github.com/RevenueCat/purchases-ios/releases/tag/4.43.1)
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 11.0.0 (#1106) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.12.0](https://github.com/RevenueCat/purchases-android/releases/tag/7.12.0)
  * [iOS 4.43.2](https://github.com/RevenueCat/purchases-ios/releases/tag/4.43.2)
  * [iOS 4.43.1](https://github.com/RevenueCat/purchases-ios/releases/tag/4.43.1)
* Bump fastlane from 2.220.0 to 2.221.1 (#1102) via dependabot[bot] (@dependabot[bot])
### Other Changes
* Adds .aiexclude (#1104) via JayShortway (@JayShortway)
* get_phc_version now also checks PHC UI versions (#1100) via JayShortway (@JayShortway)
* Removes api key from integration test (#1098) via JayShortway (@JayShortway)

## 6.29.4
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 10.9.0 (#1096) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.11.1](https://github.com/RevenueCat/purchases-android/releases/tag/7.11.1)
  * [iOS 4.43.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.43.0)

## 6.29.3
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 10.8.0 (#1091) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.11.0](https://github.com/RevenueCat/purchases-android/releases/tag/7.11.0)
  * [iOS 4.42.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.42.0)

## 6.29.2
### Bugfixes
* Fix `purchaseDiscountedPackage` (#1080) via Toni Rico (@tonidero)
### Dependency Updates
* Bump rexml from 3.2.6 to 3.2.8 (#1076) via dependabot[bot] (@dependabot[bot])

## 6.29.1
### Bugfixes
* [EXTERNAL] fix: call presentPaywallIfNeeded when needed (#1066) by @danjocha (#1069) via Cesar de la Vega (@vegaro)
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 10.6.2 (#1067) via RevenueCat Git Bot (@RCGitBot)
### Other Changes
* Remove SafeArea in sample in paywall.dart (#1063) via Cesar de la Vega (@vegaro)
* Migration to applying Gradle plugins with the declarative plugins block in sample (#1062) via Cesar de la Vega (@vegaro)

## 6.29.0
### Bugfixes
* Crash on Amazon paywalls after purchasing (#1053) via Cesar de la Vega (@vegaro)
### Dependency Updates
* BillingClient has been updated to version 6.2.1
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 10.6.1 (#1059) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.10.1](https://github.com/RevenueCat/purchases-android/releases/tag/7.10.1)
  * [Android 7.10.0](https://github.com/RevenueCat/purchases-android/releases/tag/7.10.0)
  * [iOS 4.41.2](https://github.com/RevenueCat/purchases-ios/releases/tag/4.41.2)
  * [iOS 4.41.1](https://github.com/RevenueCat/purchases-ios/releases/tag/4.41.1)
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 10.6.0 (#1056) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.10.1](https://github.com/RevenueCat/purchases-android/releases/tag/7.10.1)
  * [Android 7.10.0](https://github.com/RevenueCat/purchases-android/releases/tag/7.10.0)
  * [iOS 4.41.2](https://github.com/RevenueCat/purchases-ios/releases/tag/4.41.2)
  * [iOS 4.41.1](https://github.com/RevenueCat/purchases-ios/releases/tag/4.41.1)
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 10.5.1 (#1054) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.10.1](https://github.com/RevenueCat/purchases-android/releases/tag/7.10.1)
  * [Android 7.10.0](https://github.com/RevenueCat/purchases-android/releases/tag/7.10.0)
  * [iOS 4.41.2](https://github.com/RevenueCat/purchases-ios/releases/tag/4.41.2)
  * [iOS 4.41.1](https://github.com/RevenueCat/purchases-ios/releases/tag/4.41.1)
### Other Changes
* Add `trigger_bump` lane (#1058) via Cesar de la Vega (@vegaro)

## 6.28.0
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 10.5.0 (#1051) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.9.0](https://github.com/RevenueCat/purchases-android/releases/tag/7.9.0)
  * [iOS 4.41.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.41.0)
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 10.4.2 (#1048) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.9.0](https://github.com/RevenueCat/purchases-android/releases/tag/7.9.0)
  * [iOS 4.41.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.41.0)

## 6.27.0
### Bugfixes
* Fix touches passing through paywall when using presentPaywall methods (#1044) via Toni Rico (@tonidero)
* Remove macos platform support in purchases_ui_flutter (#1041) via Cesar de la Vega (@vegaro)
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 10.4.1 and adds `externalStore` to `Store` enum (#1043) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.8.2](https://github.com/RevenueCat/purchases-android/releases/tag/7.8.2)
  * [iOS 4.40.1](https://github.com/RevenueCat/purchases-ios/releases/tag/4.40.1)

## 6.26.0
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 10.4.0 (#1037) via RevenueCat Git Bot (@RCGitBot)
  * [iOS 4.40.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.40.0)
* Bump fastlane from 2.219.0 to 2.220.0 (#1035) via dependabot[bot] (@dependabot[bot])

## 6.25.0
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 10.3.2 (#1031) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.8.1](https://github.com/RevenueCat/purchases-android/releases/tag/7.8.1)
  * [Android 7.8.0](https://github.com/RevenueCat/purchases-android/releases/tag/7.8.0)
  * [Android 7.7.3](https://github.com/RevenueCat/purchases-android/releases/tag/7.7.3)
  * [iOS 4.39.1](https://github.com/RevenueCat/purchases-ios/releases/tag/4.39.1)

## 6.24.0
### New Features
* Add `onDismiss` handler and `displayCloseButton` to `PaywallView` and `PaywallFooterView` (#1009) via Toni Rico (@tonidero)
* Add `PaywallFooterView` listeners (#1012) via Toni Rico (@tonidero)
* Add `PaywallView` listeners (#995) via Cesar de la Vega (@vegaro)
### Bugfixes
* Fix footer sizing issues in iOS (#1018) via Toni Rico (@tonidero)
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 10.2.0 (#1020) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.7.2](https://github.com/RevenueCat/purchases-android/releases/tag/7.7.2)
  * [iOS 4.39.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.39.0)
  * [iOS 4.38.1](https://github.com/RevenueCat/purchases-ios/releases/tag/4.38.1)
  * [iOS 4.38.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.38.0)
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 10.1.0 (#1013) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.7.2](https://github.com/RevenueCat/purchases-android/releases/tag/7.7.2)
  * [iOS 4.39.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.39.0)
  * [iOS 4.38.1](https://github.com/RevenueCat/purchases-ios/releases/tag/4.38.1)
  * [iOS 4.38.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.38.0)
### Other Changes
* Add 5.8.2 to changelog (#1011) via Cesar de la Vega (@vegaro)
* Add dependency_overrides to purchases_flutter_ui (#1007) via Cesar de la Vega (@vegaro)

## 6.23.0
### New Features
* `PaywallFooterView` support (#996) via Toni Rico (@tonidero)
### RevenueCatUI
* PaywallView support (#954) via Cesar de la Vega (@vegaro)
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 9.9.0 (#1003) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.7.1](https://github.com/RevenueCat/purchases-android/releases/tag/7.7.1)
  * [Android 7.7.0](https://github.com/RevenueCat/purchases-android/releases/tag/7.7.0)
### Other Changes
* Change iOS platform version of purchase_tester (#1001) via Cesar de la Vega (@vegaro)

## 6.22.0
### Bugfixes
* Make `CustomerInfo` `allPurchaseDates` values nullable (#989) via Toni Rico (@tonidero)
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 9.8.0 (#990) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.6.0](https://github.com/RevenueCat/purchases-android/releases/tag/7.6.0)
  * [iOS 4.37.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.37.0)

## 6.21.1
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 9.7.2 (#984) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.5.2](https://github.com/RevenueCat/purchases-android/releases/tag/7.5.2)
  * [iOS 4.36.3](https://github.com/RevenueCat/purchases-ios/releases/tag/4.36.3)
### Other Changes
* Fix ios integration tests (#985) via Toni Rico (@tonidero)

## 6.21.0
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 9.7.1 (#978) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.5.1](https://github.com/RevenueCat/purchases-android/releases/tag/7.5.1)
  * [iOS 4.36.2](https://github.com/RevenueCat/purchases-ios/releases/tag/4.36.2)
  * [iOS 4.36.1](https://github.com/RevenueCat/purchases-ios/releases/tag/4.36.1)
  * [iOS 4.36.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.36.0)
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 9.7.0 (#977) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.5.1](https://github.com/RevenueCat/purchases-android/releases/tag/7.5.1)
  * [iOS 4.36.2](https://github.com/RevenueCat/purchases-ios/releases/tag/4.36.2)
  * [iOS 4.36.1](https://github.com/RevenueCat/purchases-ios/releases/tag/4.36.1)
  * [iOS 4.36.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.36.0)
* Bump cocoapods from 1.15.1 to 1.15.2 (#975) via dependabot[bot] (@dependabot[bot])
### Other Changes
* Update CHANGELOG to include 5.8.1 release notes (#973) via Toni Rico (@tonidero)

## 6.20.0
### New Features
* [EXTERNAL] Adds productPlanIdentifier parameter to EntitlementInfo (#910) via @splangi (#960) via Cesar de la Vega (@vegaro)
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 9.6.0 (#971) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.5.0](https://github.com/RevenueCat/purchases-android/releases/tag/7.5.0)
  * [iOS 4.35.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.35.0)
  * [iOS 4.34.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.34.0)
* Bump danger from 9.4.2 to 9.4.3 (#967) via dependabot[bot] (@dependabot[bot])
* Bump cocoapods from 1.15.0 to 1.15.1 (#970) via dependabot[bot] (@dependabot[bot])
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 9.4.0 (#961) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.5.0](https://github.com/RevenueCat/purchases-android/releases/tag/7.5.0)
  * [iOS 4.35.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.35.0)
  * [iOS 4.34.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.34.0)
### Other Changes
* Fix freezed tests after latest freezed update (#969) via Toni Rico (@tonidero)

## 6.19.0
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 9.3.0 (#958) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.4.1](https://github.com/RevenueCat/purchases-android/releases/tag/7.4.1)
  * [iOS 4.33.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.33.0)
  * [iOS 4.32.4](https://github.com/RevenueCat/purchases-ios/releases/tag/4.32.4)
  * [iOS 4.32.3](https://github.com/RevenueCat/purchases-ios/releases/tag/4.32.3)
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 9.2.1 (#957) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.4.1](https://github.com/RevenueCat/purchases-android/releases/tag/7.4.1)
  * [iOS 4.33.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.33.0)
  * [iOS 4.32.4](https://github.com/RevenueCat/purchases-ios/releases/tag/4.32.4)
  * [iOS 4.32.3](https://github.com/RevenueCat/purchases-ios/releases/tag/4.32.3)
* Bump cocoapods from 1.14.3 to 1.15.0 (#956) via dependabot[bot] (@dependabot[bot])

## 6.18.0
### RevenueCatUI
* `Paywalls`: `displayCloseButton` parameter (#948) via NachoSoto (@NachoSoto)
* `Paywalls`: added `Offering` parameter to `presentPaywall` methods (#947) via NachoSoto (@NachoSoto)
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 9.2.0 (#952) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.4.0](https://github.com/RevenueCat/purchases-android/releases/tag/7.4.0)
  * [Android 7.3.6](https://github.com/RevenueCat/purchases-android/releases/tag/7.3.6)
  * [iOS 4.32.2](https://github.com/RevenueCat/purchases-ios/releases/tag/4.32.2)
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 9.1.0 (#951) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.4.0](https://github.com/RevenueCat/purchases-android/releases/tag/7.4.0)
  * [Android 7.3.6](https://github.com/RevenueCat/purchases-android/releases/tag/7.3.6)
  * [iOS 4.32.2](https://github.com/RevenueCat/purchases-ios/releases/tag/4.32.2)
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 9.0.1 (#949) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.4.0](https://github.com/RevenueCat/purchases-android/releases/tag/7.4.0)
  * [Android 7.3.6](https://github.com/RevenueCat/purchases-android/releases/tag/7.3.6)
  * [iOS 4.32.2](https://github.com/RevenueCat/purchases-ios/releases/tag/4.32.2)
### Other Changes
* Refactor and cleanup of purchase_tester (#950) via Cesar de la Vega (@vegaro)

## 6.17.0
### RevenueCatUI
* `Paywalls`: separate `PurchasesHybridCommonUI` (#943) via NachoSoto (@NachoSoto)
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 8.12.0 (#944) via RevenueCat Git Bot (@RCGitBot)
  * [iOS 4.32.1](https://github.com/RevenueCat/purchases-ios/releases/tag/4.32.1)

## 6.16.1
### Dependency Updates
* Updates purchases-hybrid-common to 8.11.1 (#940) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.3.5](https://github.com/RevenueCat/purchases-android/releases/tag/7.3.5)

## 6.16.0
### Dependency Updates
* Updates purchases-hybrid-common to 8.11.0 (#937) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.3.4](https://github.com/RevenueCat/purchases-android/releases/tag/7.3.4)
  * [iOS 4.32.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.32.0)

## 6.15.0
### New features
*   📱 Initial support for cross-platform RevenueCat Paywalls 🐾 🧱  (#931) 

#### Instructions:
- For Android, you need to change your `MainActivity` to subclass `FlutterFragmentActivity` instead of `FlutterActivity`. Also, the min sdk version of the new package is `24`. Please make sure your app's `android/build.gradle` minSdkVersion has that or a higher version.
- Add `purchases-ui-flutter` in your `pubspec.yaml`:
```yaml
dependencies:
  purchases_ui_flutter: 6.15.0
```

#### Usage:
```dart
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

await RevenueCatUI.presentPaywallIfNeeded("pro");
```

#### Limitations:
- Currently only full screen paywalls are supported
- There is no way to detect paywall events other than using `addCustomerInfoUpdateListener`


## 6.6.0
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 8.2.1 (#912) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.3.1](https://github.com/RevenueCat/purchases-android/releases/tag/7.3.1)
  * [Android 7.3.0](https://github.com/RevenueCat/purchases-android/releases/tag/7.3.0)
  * [Android 7.2.9](https://github.com/RevenueCat/purchases-android/releases/tag/7.2.9)
  * [Android 7.2.8](https://github.com/RevenueCat/purchases-android/releases/tag/7.2.8)
  * [iOS 4.31.6](https://github.com/RevenueCat/purchases-ios/releases/tag/4.31.6)
  * [iOS 4.31.5](https://github.com/RevenueCat/purchases-ios/releases/tag/4.31.5)
  * [iOS 4.31.4](https://github.com/RevenueCat/purchases-ios/releases/tag/4.31.4)
  * [iOS 4.31.3](https://github.com/RevenueCat/purchases-ios/releases/tag/4.31.3)
* Bump fastlane from 2.217.0 to 2.218.0 (#918) via dependabot[bot] (@dependabot[bot])
* Bump danger from 9.4.1 to 9.4.2 (#896) via dependabot[bot] (@dependabot[bot])
### Other Changes
* Fix freezed tests after latest update (#899) via Toni Rico (@tonidero)

## 6.5.1
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 8.1.1 (#892) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.2.7](https://github.com/RevenueCat/purchases-android/releases/tag/7.2.7)
  * [iOS 4.31.2](https://github.com/RevenueCat/purchases-ios/releases/tag/4.31.2)
* Bump danger from 9.4.0 to 9.4.1 (#889) via dependabot[bot] (@dependabot[bot])

## 6.5.0
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 8.1.0 (#890) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.2.6](https://github.com/RevenueCat/purchases-android/releases/tag/7.2.6)
  * [Android 7.2.5](https://github.com/RevenueCat/purchases-android/releases/tag/7.2.5)
  * [iOS 4.31.1](https://github.com/RevenueCat/purchases-ios/releases/tag/4.31.1)
  * [iOS 4.31.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.31.0)
* Bump cocoapods from 1.14.2 to 1.14.3 (#876) via dependabot[bot] (@dependabot[bot])

## 6.4.0
### New Features
* `Trusted Entitlements`: add support for setting `EntitlementVerificationMode` and getting verification result in `EntitlementInfos` and `EntitlementInfo` (#753) via NachoSoto (@NachoSoto)
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 8.0.0 (#878) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.2.4](https://github.com/RevenueCat/purchases-android/releases/tag/7.2.4)
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 7.4.0 (#871) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.2.4](https://github.com/RevenueCat/purchases-android/releases/tag/7.2.4)
* Bump fastlane from 2.216.0 to 2.217.0 (#865) via dependabot[bot] (@dependabot[bot])
* Bump danger from 9.3.2 to 9.4.0 (#866) via dependabot[bot] (@dependabot[bot])
### Other Changes
* Fix flutter analyze deprecation warnings (#872) via Toni Rico (@tonidero)
* `CI`: disable `prepare-next-version` (#869) via NachoSoto (@NachoSoto)

## 6.3.0
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 7.3.3 (#864) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.2.3](https://github.com/RevenueCat/purchases-android/releases/tag/7.2.3)
  * [Android 7.2.2](https://github.com/RevenueCat/purchases-android/releases/tag/7.2.2)
  * [Android 7.2.1](https://github.com/RevenueCat/purchases-android/releases/tag/7.2.1)
  * [Android 7.2.0](https://github.com/RevenueCat/purchases-android/releases/tag/7.2.0)
  * [Android 7.1.1](https://github.com/RevenueCat/purchases-android/releases/tag/7.1.1)
  * [Android 7.1.0](https://github.com/RevenueCat/purchases-android/releases/tag/7.1.0)
  * [Android 7.1.0-beta.2](https://github.com/RevenueCat/purchases-android/releases/tag/7.1.0-beta.2)
  * [Android 7.1.0-beta.1](https://github.com/RevenueCat/purchases-android/releases/tag/7.1.0-beta.1)
  * [iOS 4.30.5](https://github.com/RevenueCat/purchases-ios/releases/tag/4.30.5)
  * [iOS 4.30.4](https://github.com/RevenueCat/purchases-ios/releases/tag/4.30.4)
  * [iOS 4.30.3](https://github.com/RevenueCat/purchases-ios/releases/tag/4.30.3)
  * [iOS 4.30.2](https://github.com/RevenueCat/purchases-ios/releases/tag/4.30.2)
  * [iOS 4.30.1](https://github.com/RevenueCat/purchases-ios/releases/tag/4.30.1)
  * [iOS 4.30.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.30.0)
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 7.3.2 (#859) via RevenueCat Git Bot (@RCGitBot)
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 7.3.0 (#850) via RevenueCat Git Bot (@RCGitBot)
### Other Changes
* `Purchase Tester`: remove unused `Activity` (#860) via NachoSoto (@NachoSoto)
* Remove `.common_version` (#861) via NachoSoto (@NachoSoto)
* Add `3.10.1` to `VERSIONS` (#858) via NachoSoto (@NachoSoto)
* Remove unused GoogleProrationMode import (#848) via Toni Rico (@tonidero)

## 6.2.0
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 7.2.0 (#844) via RevenueCat Git Bot (@RCGitBot)
  * [iOS 4.29.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.29.0)
  * [iOS 4.28.1](https://github.com/RevenueCat/purchases-ios/releases/tag/4.28.1)
* Bump cocoapods from 1.13.0 to 1.14.2 (#843) via dependabot[bot] (@dependabot[bot])
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 7.1.1 (#840) via RevenueCat Git Bot (@RCGitBot)
  * [iOS 4.29.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.29.0)
  * [iOS 4.28.1](https://github.com/RevenueCat/purchases-ios/releases/tag/4.28.1)

## 6.1.0
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 7.1.0 (#835) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.0.1](https://github.com/RevenueCat/purchases-android/releases/tag/7.0.1)
  * [iOS 4.28.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.28.0)
  * [iOS 4.27.2](https://github.com/RevenueCat/purchases-ios/releases/tag/4.27.2)
  * [iOS 4.27.1](https://github.com/RevenueCat/purchases-ios/releases/tag/4.27.1)

## 6.0.0
**RevenueCat Flutter SDK v6** is here!! 😻

This latest release updates the SDK to use BillingClient 6 in Android. This version of BillingClient brings little change compared with BillingClient 5 which brought an entire new subscription model which resulted in large changes across the entire SDK.

The only modification at the API level involves replacing "ProrationMode" with "ReplacementMode". The specific replacement modes remain unchanged.

If your app doesn't currently use DEFERRED replacement modes, then you should be safe to upgrade to this version without changes in behavior.

If your app supports product changes using [DEFERRED replacement mode](https://www.revenuecat.com/docs/managing-subscriptions#google-play), then you can either stick with the previous major version until support for DEFERRED is re-introduced in this major version, or you can remove DEFERRED replacement options from your app.

If you are using the SDK in observer mode, you should only use v6 in Android if you're using BillingClient 6.

See the [Android Native - 6.x to 7.x Migration](https://github.com/RevenueCat/purchases-android/blob/main/migrations/v7-MIGRATION.md) for more details.

If you come from an older version of the RevenueCat SDK, see [Android Native - 5.x to 6.x Migration](https://www.revenuecat.com/docs/android-native-5x-to-6x-migration) for a more thorough explanation of the new Google subscription model announced with BillingClient 5 and how to take advantage of it.

### Bumped minimum Android SDK version

RevenueCat SDK v7 bumps minimum Android SDK version from Android 4.0 (API level 16) to Android 4.4 (API level 19).

### Support for InApp Messages

We've added new APIs to support InApp messages both in Android and iOS.
You can read more about:
* [Google Play InApp Messages](https://rev.cat/googleplayinappmessaging) which will show users a snackbar message during grace period and account hold once per day and provide them an opportunity to fix their payment without leaving the app.
* [App Store InApp messages](https://rev.cat/storekit-message) which will show a modal during grace period once per subscription.

InApp Messages are shown by default in both platforms. If you want to disable this behaviour during configuration of the RevenueCat SDK, setup the `shouldShowInAppMessagesAutomatically` property during configuration to `false`:

```dart
PurchasesConfiguration configuration = PurchasesConfiguration("api_key");
configuration.shouldShowInAppMessagesAutomatically = false;
Purchases.configure(configuration);
```

### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 7.0.0 (#828) via RevenueCat Git Bot (@RCGitBot)
  * [Android 7.0.0](https://github.com/RevenueCat/purchases-android/releases/tag/7.0.0)
  * [iOS 4.27.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.27.0)
  * [iOS 4.26.2](https://github.com/RevenueCat/purchases-ios/releases/tag/4.26.2)

## 5.8.2
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 6.3.2 (#1008) via RevenueCat Git Bot (@RCGitBot)
  * [Android 6.9.7](https://github.com/RevenueCat/purchases-android/releases/tag/6.9.7)

## 5.8.1
### Dependency Updates
* Updates purchases-hybrid-common to 6.3.1 (#965)
  * [Android 6.9.6](https://github.com/RevenueCat/purchases-android/releases/tag/6.9.6)

## 5.8.0
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 6.3.0 (#823) via RevenueCat Git Bot (@RCGitBot)
  * [Android 6.9.5](https://github.com/RevenueCat/purchases-android/releases/tag/6.9.5)
  * [iOS 4.26.1](https://github.com/RevenueCat/purchases-ios/releases/tag/4.26.1)
### Other Changes
* Fix freezed tests (#824) via Toni Rico (@tonidero)

## 5.7.0
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 6.2.0 (#814) via RevenueCat Git Bot (@RCGitBot)
  * [iOS 4.26.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.26.0)
  * [iOS 4.25.10](https://github.com/RevenueCat/purchases-ios/releases/tag/4.25.10)
  * [iOS 4.26.0-beta.4](https://github.com/RevenueCat/purchases-ios/releases/tag/4.26.0-beta.4)
  * [iOS 4.26.0-beta.3](https://github.com/RevenueCat/purchases-ios/releases/tag/4.26.0-beta.3)
  * [iOS 4.26.0-beta.2](https://github.com/RevenueCat/purchases-ios/releases/tag/4.26.0-beta.2)
  * [iOS 4.26.0-beta.1](https://github.com/RevenueCat/purchases-ios/releases/tag/4.26.0-beta.1)
* Bump fastlane from 2.214.0 to 2.215.1 (#813) via dependabot[bot] (@dependabot[bot])

## 5.6.5
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 6.1.2 (#802) via RevenueCat Git Bot (@RCGitBot)
  * [Android 6.9.4](https://github.com/RevenueCat/purchases-android/releases/tag/6.9.4)
  * [iOS 4.25.9](https://github.com/RevenueCat/purchases-ios/releases/tag/4.25.9)
  * [iOS 4.25.8](https://github.com/RevenueCat/purchases-ios/releases/tag/4.25.8)

## 5.6.4
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 6.1.0 (#797) via RevenueCat Git Bot (@RCGitBot)
* Bump activesupport from 7.0.4.3 to 7.0.7.2 (#791) via dependabot[bot] (@dependabot[bot])

## 5.6.3
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 5.6.4 (#793) via RevenueCat Git Bot (@RCGitBot)
  * [Android 6.9.3](https://github.com/RevenueCat/purchases-android/releases/tag/6.9.3)
  * [iOS 4.25.7](https://github.com/RevenueCat/purchases-ios/releases/tag/4.25.7)

## 5.6.2
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 5.6.3 (#786) via RevenueCat Git Bot (@RCGitBot)
  * [Android 6.9.2](https://github.com/RevenueCat/purchases-android/releases/tag/6.9.2)
  * [iOS 4.25.6](https://github.com/RevenueCat/purchases-ios/releases/tag/4.25.6)
  * [iOS 4.25.5](https://github.com/RevenueCat/purchases-ios/releases/tag/4.25.5)
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 5.6.2 (#785) via RevenueCat Git Bot (@RCGitBot)
  * [Android 6.9.2](https://github.com/RevenueCat/purchases-android/releases/tag/6.9.2)
  * [iOS 4.25.6](https://github.com/RevenueCat/purchases-ios/releases/tag/4.25.6)
  * [iOS 4.25.5](https://github.com/RevenueCat/purchases-ios/releases/tag/4.25.5)

## 5.6.1
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 5.6.1 (#782) via RevenueCat Git Bot (@RCGitBot)
  * [Android 6.9.1](https://github.com/RevenueCat/purchases-android/releases/tag/6.9.1)
  * [iOS 4.25.4](https://github.com/RevenueCat/purchases-ios/releases/tag/4.25.4)
  * [iOS 4.25.3](https://github.com/RevenueCat/purchases-ios/releases/tag/4.25.3)

## 5.6.0
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 5.6.0 (#778) via RevenueCat Git Bot (@RCGitBot)
  * [Android 6.9.0](https://github.com/RevenueCat/purchases-android/releases/tag/6.9.0)

## 5.5.0
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 5.5.0 (#774) via RevenueCat Git Bot (@RCGitBot)
  * [Android 6.8.0](https://github.com/RevenueCat/purchases-android/releases/tag/6.8.0)
  * [iOS 4.25.2](https://github.com/RevenueCat/purchases-ios/releases/tag/4.25.2)
### Other Changes
* [CI] Optionally run firebase tests only on non-main, non-release branches (#772) via Mark Villacampa (@MarkVillacampa)

## 5.4.0
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 5.4.1 (#769) via RevenueCat Git Bot (@RCGitBot)
  * [Android 6.7.0](https://github.com/RevenueCat/purchases-android/releases/tag/6.7.0)
  * [Android 6.6.0](https://github.com/RevenueCat/purchases-android/releases/tag/6.6.0)
  * [iOS 4.25.1](https://github.com/RevenueCat/purchases-ios/releases/tag/4.25.1)
  * [iOS 4.25.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.25.0)
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 5.4.0 (#765) via RevenueCat Git Bot (@RCGitBot)
  * [Android 6.7.0](https://github.com/RevenueCat/purchases-android/releases/tag/6.7.0)
  * [Android 6.6.0](https://github.com/RevenueCat/purchases-android/releases/tag/6.6.0)
  * [iOS 4.25.1](https://github.com/RevenueCat/purchases-ios/releases/tag/4.25.1)
  * [iOS 4.25.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.25.0)
* Bump fastlane from 2.213.0 to 2.214.0 (#764) via dependabot[bot] (@dependabot[bot])

## 5.3.0
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 5.3.0 (#759) via RevenueCat Git Bot (@RCGitBot)
  * [iOS 4.24.1](https://github.com/RevenueCat/purchases-ios/releases/tag/4.24.1)
  * [iOS 4.24.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.24.0)
### Other Changes
* Update freezed generated classes after freezed update (#760) via Toni Rico (@tonidero)

## 5.2.3
### Bugfixes
* Adds package back to AndroidManifest.xml (#749) via Cesar de la Vega (@vegaro)
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 5.2.4 (#750) via RevenueCat Git Bot (@RCGitBot)

## 5.2.2
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 5.2.3 (#744) via RevenueCat Git Bot (@RCGitBot)

## 5.2.1
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 5.2.2 (#740) via RevenueCat Git Bot (@RCGitBot)
  * [Android 6.5.2](https://github.com/RevenueCat/purchases-android/releases/tag/6.5.2)
  * [iOS 4.23.1](https://github.com/RevenueCat/purchases-ios/releases/tag/4.23.1)

## 5.2.0
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 5.2.0 (#735) via RevenueCat Git Bot (@RCGitBot)
  * [Android 6.5.1](https://github.com/RevenueCat/purchases-android/releases/tag/6.5.1)
  * [iOS 4.23.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.23.0)
  * [iOS 4.22.1](https://github.com/RevenueCat/purchases-ios/releases/tag/4.22.1)
### Other Changes
* Fix flutter static analysis in pub.dev (#726) via Toni Rico (@tonidero)

## 5.1.0
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 5.1.0 (#730) via RevenueCat Git Bot (@RCGitBot)
  * [Android 6.5.0](https://github.com/RevenueCat/purchases-android/releases/tag/6.5.0)
  * [iOS 4.22.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.22.0)
  * [iOS 4.21.1](https://github.com/RevenueCat/purchases-ios/releases/tag/4.21.1)
### Other Changes
* [EXTERNAL] v5-MIGRATION.md: replace defaultOffer w/ defaultOption (#728) (#729) via Toni Rico (@tonidero)
* Fix purchase tester reconfiguring the SDK (#722) via Toni Rico (@tonidero)

## 5.0.0
**RevenueCat Purchases Flutter v5** is here!! 😻

This latest release updates the Android SDK dependency from v5 to [v6](https://github.com/RevenueCat/purchases-android/releases/tag/6.0.0) to use BillingClient 5. This version of BillingClient brings an entire new subscription model which has resulted in large changes across the entire SDK.

### Migration Guides
- See [Android Native - 5.x to 6.x Migration](https://www.revenuecat.com/docs/android-native-5x-to-6x-migration) for a
  more thorough explanation of the new Google subscription model announced with BillingClient 5 and how to take
  advantage of it in V6. This guide includes tips on product setup with the new model.

### New `SubscriptionOption` concept

#### Purchasing
In v4, a Google Play Android `Package` or `StoreProduct` represented a single purchaseable entity, and free trials or intro
offers would automatically be applied to the purchase if the user was eligible.

Now, in Flutter v5, an Google Play Android `Package` or `StoreProduct` represents a duration of a subscription and contains all the ways to purchase that duration -- any offers and its base plan. Each of these purchase options are `SubscriptionOption`s.
When passing a `Package` to `purchasePackage()` or `StoreProduct` to `purchaseStoreProduct()`, the SDK will use the following logic to choose which
`SubscriptionOption` to purchase:
- Filters out offers with "rc-ignore-offer" tag
- Uses `SubscriptionOption` with the longest free trial or cheapest first phase
    - Only offers the user is eligible will be applied
- Falls back to base plan

For more control, purchase subscription options with the new `purchaseSubscriptionOption()` method.

#### Models

`StoreProduct` now has a few new properties use for Google Play Android:
- `defaultOption`
  - A subscription option that will automatically be applie when purchasing a `Package` or `StoreProduct`
- `subscriptionOptions`
  - A list of subscription options (could be null)

### Observer Mode

Observer mode is still supported in v5. Other than updating the SDK version, there are no changes required.

### Offline Entitlements

✨ With this new feature, even if our main and backup servers are down, the SDK can continue to process purchases. This is enabled transparently to the user, and when the servers come back online, the SDK automatically syncs the information so it can be visible in the dashboard.

### Offering Metadata

✨ Metadata allows attaching arbitrary information as key/value pairs to your Offering to control how to display your products inside your app. The metadata you configure in an Offering is available from the RevenueCat SDK. For example, you could use it to remotely configure strings on your paywall, or even URLs of images shown on the paywall.

See the [metadata documentation](https://www.revenuecat.com/docs/offering-metadata) for more info!

## 4.13.0
### Bugfixes
* Fix deprecation warning (#694) via Andy Boedo (@aboedo)
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 4.18.0 (#709) via RevenueCat Git Bot (@RCGitBot)
  * [iOS 4.21.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.21.0)
  * [iOS 4.19.1](https://github.com/RevenueCat/purchases-ios/releases/tag/4.19.1)
  * [iOS 4.20.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.20.0)
  * [iOS 4.19.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.19.0)
* Increases upper limit and removes minimum flutter version (#702) via Cesar de la Vega (@vegaro)
* Bump fastlane from 2.212.2 to 2.213.0 (#696) via dependabot[bot] (@dependabot[bot])
### Other Changes
* Fix analyzer issues (#706) via Mark Villacampa (@MarkVillacampa)
* Fix integration tests (#703) via Mark Villacampa (@MarkVillacampa)
* Support Gradle 8+ (#698) via Cesar de la Vega (@vegaro)
* Fix issues when running Flutter 3.10.2 (#699) via Cesar de la Vega (@vegaro)

## 4.12.0
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 4.15.0 (#680) via RevenueCat Git Bot (@RCGitBot)
  * [iOS 4.18.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.18.0)
* Bump cocoapods from 1.12.0 to 1.12.1 (#672) via dependabot[bot] (@dependabot[bot])
* Bump danger from 9.2.0 to 9.3.0 (#678) via dependabot[bot] (@dependabot[bot])

## 4.11.3
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 4.14.3 (#674) via RevenueCat Git Bot (@RCGitBot)
  * [iOS 4.17.11](https://github.com/RevenueCat/purchases-ios/releases/tag/4.17.11)
  * [iOS 4.17.10](https://github.com/RevenueCat/purchases-ios/releases/tag/4.17.10)
* Bump fastlane from 2.212.1 to 2.212.2 (#670) via dependabot[bot] (@dependabot[bot])
* Bump activesupport from 7.0.4.2 to 7.0.4.3 (#644) via dependabot[bot] (@dependabot[bot])
### Other Changes
* Update fastlane-plugin-revenuecat version (#669) via Cesar de la Vega (@vegaro)

## 4.11.2
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 4.14.2 (#661) via RevenueCat Git Bot (@RCGitBot)
  * [iOS 4.17.9](https://github.com/RevenueCat/purchases-ios/releases/tag/4.17.9)

## 4.11.1
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 4.14.1 (#645) via RevenueCat Git Bot (@RCGitBot)
  * [iOS 4.17.8](https://github.com/RevenueCat/purchases-ios/releases/tag/4.17.8)

## 4.11.0
### New Features
* add `immediateAndChargeFullPrice` proration mode (#639) via Andy Boedo (@aboedo)
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 4.14.0 (#640) via RevenueCat Git Bot (@RCGitBot)
  * [Android 5.8.2](https://github.com/RevenueCat/purchases-android/releases/tag/5.8.2)
### Other Changes
* Deprecate revenueCatId in favor of transactionIdentifier (#612) via Toni Rico (@tonidero)

## 4.10.4
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 4.13.5 (#631) via RevenueCat Git Bot (@RCGitBot)
* Bump cocoapods from 1.11.3 to 1.12.0 (#628) via dependabot[bot] (@dependabot[bot])
### Other Changes
* Deprecate `usesStoreKit2IfAvailable` (#632) via Andy Boedo (@aboedo)

## 4.10.3
### Dependency Updates
* Bump fastlane from 2.212.0 to 2.212.1 (#627) via dependabot[bot] (@dependabot[bot])
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 4.13.4 (#626) via RevenueCat Git Bot (@RCGitBot)
  * [iOS 4.17.7](https://github.com/RevenueCat/purchases-ios/releases/tag/4.17.7)

## 4.10.2
### Bugfixes
* Fixes NullPointerException at setUpdatedCustomerInfoListener (#621) via Cesar de la Vega (@vegaro)
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 4.13.3 (#619) via RevenueCat Git Bot (@RCGitBot)

## 4.10.1
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 4.13.2 (#617) via RevenueCat Git Bot (@RCGitBot)
  * [iOS 4.17.6](https://github.com/RevenueCat/purchases-ios/releases/tag/4.17.6)
* Bump fastlane from 2.211.0 to 2.212.0 (#615) via dependabot[bot] (@dependabot[bot])

## 4.10.0
### New Features
* Add `syncObserverModeAmazonPurchase` (#609) via Cesar de la Vega (@vegaro)
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 4.13.1 (#611) via RevenueCat Git Bot (@RCGitBot)
  * [Android 5.7.1](https://github.com/RevenueCat/purchases-android/releases/tag/5.7.1)
  * [iOS 4.17.5](https://github.com/RevenueCat/purchases-ios/releases/tag/4.17.5)
### Other Changes
* fix(example): fix LogLevel debug enum (#610) via Majid Hajian (@mhadaily)

## 4.9.1
### Bugfixes
* Sends PurchasesCustomerInfoUpdatedEvent and PurchasesReadyForPromotedProductPurchaseEvent on UiThread (#600) via Cesar de la Vega (@vegaro)
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 4.12.1 (#603) via RevenueCat Git Bot (@RCGitBot)
  * [iOS 4.17.4](https://github.com/RevenueCat/purchases-ios/releases/tag/4.17.4)

## 4.9.0
### New Features
* Added Purchases.setLogHandler (#591) via Cesar de la Vega (@vegaro)
* Added `Purchases.setLogLevel` (#589) via NachoSoto (@NachoSoto)
### Bugfixes
* Fix error code parsing from native layer (#585) via Toni Rico (@tonidero)
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 4.12.0 (#597) via RevenueCat Git Bot (@RCGitBot)
  * [Android 5.7.0](https://github.com/RevenueCat/purchases-android/releases/tag/5.7.0)
  * [iOS 4.17.3](https://github.com/RevenueCat/purchases-ios/releases/tag/4.17.3)
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 4.11.0 (#595) via RevenueCat Git Bot (@RCGitBot)
  * [Android 5.7.0](https://github.com/RevenueCat/purchases-android/releases/tag/5.7.0)
  * [iOS 4.17.3](https://github.com/RevenueCat/purchases-ios/releases/tag/4.17.3)
### Other Changes
* Adds dependabot (#599) via Cesar de la Vega (@vegaro)
* Update danger, fastlane and fastlane plugin (#598) via Cesar de la Vega (@vegaro)
* Add tests for sending customer info upon adding listener (#580) via Toni Rico (@tonidero)
* `DEVELOPMENT.md`: added section on how to run tests (#590) via NachoSoto (@NachoSoto)

## 4.8.0
### New Features
* Change default usesStoreKit2IfAvailable to false (#587) via Cesar de la Vega (@vegaro)
* Adds StoreProduct.susbcriptionPeriod (#579) via Cesar de la Vega (@vegaro)
* Send customer info to first listener added (#576) via Toni Rico (@tonidero)
* Add beginRefundRequest APIs for iOS 15+ (#577) via Toni Rico (@tonidero)
### Bugfixes
* Fix integration tests (#584) via Cesar de la Vega (@vegaro)
* Fix macOS compilation (#582) via Cesar de la Vega (@vegaro)
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 4.10.0 (#588) via RevenueCat Git Bot (@RCGitBot)
  * [Android 5.6.7](https://github.com/RevenueCat/purchases-android/releases/tag/5.6.7)
  * [iOS 4.17.2](https://github.com/RevenueCat/purchases-ios/releases/tag/4.17.2)
  * [iOS 4.17.1](https://github.com/RevenueCat/purchases-ios/releases/tag/4.17.1)
  * [iOS 4.17.0](https://github.com/RevenueCat/purchases-ios/releases/tag/4.17.0)

## 4.7.0
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 4.8.0 (#572) via RevenueCat Git Bot (@RCGitBot)
### Other Changes
* Update Gemfile.lock (#573) via Cesar de la Vega (@vegaro)
* Remove web support from description in pub.dev (#574) via Andy Boedo (@aboedo)

## 4.6.0
### Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 4.7.0 (#566) via RevenueCat Git Bot (@RCGitBot)
  * (iOS 4.16.0)[https://github.com/RevenueCat/purchases-ios/releases/tag/4.16.0]
### Other Changes
* Adds missing params for better changelogs when bumping (#569) via Cesar de la Vega (@vegaro)
* Update Gemfile.lock (#568) via Cesar de la Vega (@vegaro)
* remove stalebot in favor of SLAs in Zendesk (#563) via Andy Boedo (@aboedo)
* Update fastlane-plugin-revenuecat_internal to latest version (#561) via Cesar de la Vega (@vegaro)

## 4.5.5
### Other Changes
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 4.5.4 (#558) via RevenueCat Git Bot (@RCGitBot)

## 4.5.4
### Other Changes
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 4.5.3 (#553) via RevenueCat Git Bot (@RCGitBot)

## 4.5.3
### Other Changes
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 4.5.2 (#550) via RevenueCat Git Bot (@RCGitBot)

## 4.5.2
### Bugfixes
* Fix for java.lang.IllegalAccessError: Interface androidx.lifecycle.c  (#547) via Cesar de la Vega (@vegaro)

## 4.5.1
### Other Changes
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 4.5.1 (#544) via RevenueCat Git Bot (@RCGitBot)
* Update ReadMe.md (#524) via kmurphy-rc (@kmurphy-rc)

## 4.5.0
### Other Changes
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 4.5.0 (#539) via RevenueCat Git Bot (@RCGitBot)

## 4.4.3
### Other Changes
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 4.4.4 (#534) via RevenueCat Git Bot (@RCGitBot)

## 4.4.2
### Other Changes
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 4.4.3 (#532) via RevenueCat Git Bot (@RCGitBot)

## 4.4.1
### Other Changes
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 4.4.1 (#528) via RevenueCat Git Bot (@RCGitBot)
* Update Fastlane plugin (#525) via Cesar de la Vega (@vegaro)

## 4.4.0
### New Features
* Add setCleverTapId, setMixpanelDistinctID, setFirebaseAppInstanceId (#522) via Sergio Durban Belmonte (@sdurban)
### Other Changes
* [AUTOMATIC] Updates purchases-hybrid-common to 4.4.0 (#523) via RevenueCat Git Bot (@RCGitBot)
* Makes hold job depend on integration tests (#521) via Cesar de la Vega (@vegaro)

## 4.3.2
### Other Changes
* Update fastlane-plugin-revenuecat_internal (#518) via Cesar de la Vega (@vegaro)
* [AUTOMATIC] Updates purchases-hybrid-common to 4.3.6 (#517) via RevenueCat Git Bot (@RCGitBot)

## 4.3.1
### Other Changes
* [AUTOMATIC] Updates purchases-hybrid-common to 4.3.2 (#502) via RevenueCat Git Bot (@RCGitBot)
* Ignore Podfile.lock files (#503) via Cesar de la Vega (@vegaro)
* Update update-hybrid-common-versions parameters (#495) via Cesar de la Vega (@vegaro)

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
