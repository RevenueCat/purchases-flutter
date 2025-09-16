> [!WARNING]  
> If you don't have any login system in your app, please make sure your one-time purchase products have been correctly configured in the RevenueCat dashboard as either consumable or non-consumable. If they're incorrectly configured as consumables, RevenueCat will consume these purchases. This means that users won't be able to restore them from version 9.0.0 onward.
> Non-consumables are products that are meant to be bought only once, for example, lifetime subscriptions.


## RevenueCat SDK
### 🐞 Bugfixes
* Fix crash when calling new purchase w/ purchase params function (#1472) via Will Taylor (@fire-at-will)

### 🔄 Other Changes
* Bump fastlane-plugin-revenuecat_internal from `489faef` to `a6dc551` (#1469) via dependabot[bot] (@dependabot[bot])
