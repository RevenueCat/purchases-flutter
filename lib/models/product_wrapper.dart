import 'package:freezed_annotation/freezed_annotation.dart';

import 'discount.dart';
import 'introductory_price.dart';

part 'product_wrapper.freezed.dart';
part 'product_wrapper.g.dart';

@freezed

/// Contains all the product details associated with a Store product id
class Product with _$Product {
  const factory Product(
    /// Product Id.
    @JsonKey(name: 'identifier') String identifier,

    /// Description of the product.
    @JsonKey(name: 'description') String description,

    /// Title of the product.
    @JsonKey(name: 'title') String title,

    /// Price of the product in the local currency.
    @JsonKey(name: 'price') double price,

    /// Formatted price of the item, including its currency sign.
    @JsonKey(name: 'price_string') String priceString,

    /// Currency code for price and original price.
    @JsonKey(name: 'currency_code') String currencyCode, {

    /// Introductory price for product. Can be null.
    @JsonKey(name: 'introPrice', nullable: true)
        IntroductoryPrice? introductoryPrice,

    /// Collection of discount offers for a product. Null for Android.
    @JsonKey(name: 'discounts', nullable: true) List<Discount>? discounts,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
