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
