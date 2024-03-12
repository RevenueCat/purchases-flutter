import 'package:freezed_annotation/freezed_annotation.dart';

import 'introductory_price.dart';
import 'presented_offering_context_wrapper.dart';
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
    String identifier,

    /// Description of the product.
    String description,

    /// Title of the product.
    String title,

    /// Price of the product in the local currency.
    double price,

    /// Formatted price of the item, including its currency sign.
    String priceString,

    /// Currency code for price and original price.
    String currencyCode, {
    /// Introductory price for product. Can be null.
    // ignore: invalid_annotation_target
    @JsonKey(name: 'introPrice') IntroductoryPrice? introductoryPrice,

    /// Collection of discount offers for a product. Null for Android.
    List<StoreProductDiscount>? discounts,

    /// Product category.
    ProductCategory? productCategory,

    /// Default subscription option for a product. Google Play only.
    SubscriptionOption? defaultOption,

    /// Collection of subscription options for a product. Google Play only.
    List<SubscriptionOption>? subscriptionOptions,

    /// Offering context this package belongs to.
    /// Null if not using offerings or if fetched directly from store via getProducts
    PresentedOfferingContext? presentedOfferingContext,

    /// Subscription period, specified in ISO 8601 format. For example,
    /// P1W equates to one week, P1M equates to one month,
    /// P3M equates to three months, P6M equates to six months,
    /// and P1Y equates to one year.
    /// Note: Not available for Amazon.
    String? subscriptionPeriod,
  }) = _StoreProduct;

  factory StoreProduct.fromJson(Map<String, dynamic> json) =>
      _$StoreProductFromJson(json);
}

extension ExtendedStoreProduct on StoreProduct {
  /// Offering this package belongs to.
  /// Null if not using offerings or if fetched directly from store via getProducts
  @Deprecated('use presentedOfferingContext')
  String? get presentedOfferingIdentifier =>
      presentedOfferingContext?.offeringIdentifier;
}
