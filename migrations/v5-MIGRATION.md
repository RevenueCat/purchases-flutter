## v5 API Changes

### Classes

| New                        |
|----------------------------|
| `SubscriptionOption`       |
| `PricingPhase`             |
| `Period`                   |
| `Price`                    ||

### StoreProduct changes

| New                 |
|---------------------|
| subscriptionOptions |
| defaultOption       |

#### Free Trial and Introductory Offers

`StoreProduct` can now have multiple free trials and introductory offers on Google PLay. There is a `defaultOption` property
on `StoreProduct` that will select the offer with the longest free trial period or the cheapest introductory offer.

If more control is needed, the free trial, intro offer, and other `SubscriptionOption`s can
be found through `subscriptionOptions` on `StoreProduct`:

```dart
final basePlan = storeProduct.subscriptionOptions?.firstWhere((option) => option.isBasePlan);
final defaultOffer = storeProduct.defaultOffer
final freeOffer = storeProduct.subscriptionOptions?.firstWhere((option) => option.freePhase != null);
final trialOffer = storeProduct.subscriptionOptions?.firstWhere((option) => option.introPhase != null);
```

#### Applying offers on a purchase
In v4, a purchase of a `Package` or `StoreProduct` represented a single purchaseable entity, and free trials or intro
prices would automatically be applied if the user was eligible.

Now, in v5, a `Package` or `StoreProduct` could contain multiple offers along with a base plan. 
When passing a `Package` or `StoreProduct` to `purchase()`, the SDK will use the following logic to choose which 
[SubscriptionOption] to purchase:
*   - Filters out offers with "rc-ignore-default-offer" tag
*   - Uses [SubscriptionOption] with the longest free trial or cheapest first phase
*   - Falls back to use base plan

For more control, find the `SubscriptionOption` to purchase on a `StoreProduct`.

| New                                                            |
|----------------------------------------------------------------|
| `purchaseSubscriptionOption(SubscriptionOption, UpgradeInfo?)` |

### Reporting undocumented issues:

Feel free to file an issue! [New RevenueCat Issue](https://github.com/RevenueCat/purchases-flutter/issues/new/).

