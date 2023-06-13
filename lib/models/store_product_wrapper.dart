import 'package:freezed_annotation/freezed_annotation.dart';

import 'introductory_price.dart';
import 'product_category.dart';
import 'store_product_discount.dart';
import 'subscription_option_wrapper.dart';

part 'store_product_wrapper.freezed.dart';
part 'store_product_wrapper.g.dart';

@freezed

/// Contains all the product details associated with a StoreProduct
class StoreProduct with _$StoreProduct {
  const factory StoreProduct(
    /// Product Id.
    @JsonKey(name: 'identifier') String identifier,

    /// Description of the product.
    @JsonKey(name: 'description') String description,

    /// Title of the product.
    @JsonKey(name: 'title') String title,

    /// Price of the product in the local currency.
    @JsonKey(name: 'price') double price,

    /// Formatted price of the item, including its currency sign.
    @JsonKey(name: 'priceString') String priceString,

    /// Currency code for price and original price.
    @JsonKey(name: 'currencyCode') String currencyCode, {
    /// Introductory price for product. Can be null.
    @JsonKey(name: 'introPrice') IntroductoryPrice? introductoryPrice,

    /// Collection of discount offers for a product. Null for Android.
    @JsonKey(name: 'discounts') List<StoreProductDiscount>? discounts,

    /// Product category.
    @JsonKey(name: 'productCategory') ProductCategory? productCategory,

    /// Default subscription option for a product. Google Play only.
    @JsonKey(name: 'defaultOption') SubscriptionOption? defaultOption,

    /// Collection of subscription options for a product. Google Play only.
    @JsonKey(name: 'subscriptionOptions')
    List<SubscriptionOption>? subscriptionOptions,

    /// Offering identifier the store product was presented from
    /// Null if not using offerings or if fetched directly from store via getProducts
    @JsonKey(name: 'presentedOfferingIdentifier')
    String? presentedOfferingIdentifier,

    /// Subscription period, specified in ISO 8601 format. For example,
    /// P1W equates to one week, P1M equates to one month,
    /// P3M equates to three months, P6M equates to six months,
    /// and P1Y equates to one year.
    /// Note: Not available for Amazon.
    @JsonKey(name: 'subscriptionPeriod') String? subscriptionPeriod,
  }) = _StoreProduct;

  factory StoreProduct.fromJson(Map<String, dynamic> json) =>
      _$StoreProductFromJson(json);
}
