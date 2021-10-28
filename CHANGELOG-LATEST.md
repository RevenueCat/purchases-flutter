## 3.5.0

- Removed call to `Purchases.getSharedInstance().close();` in `onDetachedFromEngine`. This should fix an incompatibility with `workmanager` Flutter plugin that was causing the BillingClient to get disconnected after a task would finish.
- Added a new `close()` function to be called in Android whenever the resources used by Purchases should be released.
    https://github.com/RevenueCat/purchases-flutter/pull/268
    https://github.com/RevenueCat/purchases-flutter/issues/257
- Bump`purchases-hybrid-common` to 1.9.3 [Changelog here](https://github.com/RevenueCat/purchases-hybrid-common/releases/tag/1.9.3)
- Bump `purchases-ios` to 3.12.8
  [3.12.8 Changelog here](https://github.com/RevenueCat/purchases-ios/releases/tag/3.12.8)
  [3.12.7 Changelog here](https://github.com/RevenueCat/purchases-ios/releases/tag/3.12.7)
