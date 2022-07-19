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
