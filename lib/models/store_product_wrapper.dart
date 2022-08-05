import 'package:freezed_annotation/freezed_annotation.dart';

import 'introductory_price.dart';
import 'store_product_discount.dart';

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
    @JsonKey(name: 'introPrice', nullable: true)
        IntroductoryPrice? introductoryPrice,

    /// Collection of discount offers for a product. Null for Android.
    @JsonKey(name: 'discounts', nullable: true)
        List<StoreProductDiscount>? discounts,
  }) = _StoreProduct;

  factory StoreProduct.fromJson(Map<String, dynamic> json) =>
      _$StoreProductFromJson(json);
}
