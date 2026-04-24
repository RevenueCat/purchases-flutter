## RevenueCat SDK
### ✨ New Features
* `RevenueCatUI` Paywalls and Customer Center can now opt in to matching right-to-left layout when overriding the preferred UI locale by setting `preferredUILocaleOverrideHonorsLayoutDirection` at configure time or `honorLayoutDirection` at runtime. The default remains false to preserve existing layout behavior.

### 🐞 Bugfixes
* [EXTERNAL] Fix Wasm incompatibility in web error processing (#1684) contributed by @brunovsiqueira (#1722) via Toni Rico (@tonidero)
### 📦 Dependency Updates
* [AUTOMATIC BUMP] Updates purchases-hybrid-common to 18.1.0 (#1726) via RevenueCat Git Bot (@RCGitBot)
  * [Android 10.2.0](https://github.com/RevenueCat/purchases-android/releases/tag/10.2.0)
  * [iOS 5.68.0](https://github.com/RevenueCat/purchases-ios/releases/tag/5.68.0)

### 🔄 Other Changes
* Add retry mechanism to Maestro e2e tests (#1723) via Antonio Pallares (@ajpallares)
* Bump fastlane-plugin-revenuecat_internal from `20911d1` to `a1eed48` (#1725) via dependabot[bot] (@dependabot[bot])
* Skip test cases list in maestro tests using launch arguments (#1714) via Antonio Pallares (@ajpallares)
* Add CircleCI job for maestro E2E tests (#1699) via Antonio Pallares (@ajpallares)
* Add maestro E2E test for purchase through paywall (#1698) via Antonio Pallares (@ajpallares)
* Add maestro E2E test app (#1654) via Antonio Pallares (@ajpallares)
