import 'package:equatable/equatable.dart';

import 'introductory_price.dart';
import 'map_helpers.dart';
import 'presented_offering_context_wrapper.dart';
import 'product_category.dart';
import 'store_product_discount.dart';
import 'subscription_option_wrapper.dart';

class StoreProduct extends Equatable {
  /// Product Id.
  final String identifier;

  /// Description of the product.
  final String description;

  /// Title of the product.
  final String title;

  /// Price of the product in the local currency.
  final double price;

  /// Formatted price of the item, including its currency sign.
  final String priceString;

  /// Currency code for price and original price.
  final String currencyCode;

  /// Introductory price for product. Can be null.
  final IntroductoryPrice? introductoryPrice;

  /// Collection of discount offers for a product. Null for Android.
  final List<StoreProductDiscount>? discounts;

  /// Product category.
  final ProductCategory? productCategory;

  /// Default subscription option for a product. Google Play only.
  final SubscriptionOption? defaultOption;

  /// Collection of subscription options for a product. Google Play only.
  final List<SubscriptionOption>? subscriptionOptions;

  /// Offering context this package belongs to.
  /// Null if not using offerings or if fetched directly from store via getProducts
  final PresentedOfferingContext? presentedOfferingContext;

  /// Subscription period, specified in ISO 8601 format. For example,
  /// P1W equates to one week, P1M equates to one month,
  /// P3M equates to three months, P6M equates to six months,
  /// and P1Y equates to one year.
  /// Note: Not available for Amazon.
  final String? subscriptionPeriod;

  const StoreProduct(
    this.identifier,
    this.description,
    this.title,
    this.price,
    this.priceString,
    this.currencyCode, {
    this.introductoryPrice,
    this.discounts,
    this.productCategory,
    this.defaultOption,
    this.subscriptionOptions,
    this.presentedOfferingContext,
    this.subscriptionPeriod,
  });

  factory StoreProduct.fromJson(Map<String, dynamic> json) => StoreProduct(
      json['identifier'] as String,
      json['description'] as String,
      json['title'] as String,
      (json['price'] as num).toDouble(),
      json['priceString'] as String,
      json['currencyCode'] as String,
      introductoryPrice: json['introPrice'] != null ? IntroductoryPrice.fromJson(Map<String, dynamic>.from(json['introPrice'])) : null,
      discounts: json['discounts'] != null ? (json['discounts'] as List).map((e) => StoreProductDiscount.fromJson(Map<String, dynamic>.from(e))).toList() : null,
      productCategory: productCategoryFromJson(json['productCategory']),
      defaultOption: json['defaultOption'] != null ? SubscriptionOption.fromJson(Map<String, dynamic>.from(json['defaultOption'])) : null,
      subscriptionOptions: json['subscriptionOptions'] != null ? (json['subscriptionOptions'] as List).map((e) => SubscriptionOption.fromJson(Map<String, dynamic>.from(e))).toList() : null,
      presentedOfferingContext: json['presentedOfferingContext'] != null ? PresentedOfferingContext.fromJson(Map<String, dynamic>.from(json['presentedOfferingContext'])) : null,
      subscriptionPeriod: json['subscriptionPeriod'] as String?,
    );

  @override
  List<Object?> get props => [
    identifier,
    description,
    title,
    price,
    priceString,
    currencyCode,
    introductoryPrice,
    discounts,
    productCategory,
    defaultOption,
    subscriptionOptions,
    presentedOfferingContext,
    subscriptionPeriod,
  ];
}

extension ExtendedStoreProduct on StoreProduct {
  /// Offering this package belongs to.
  /// Null if not using offerings or if fetched directly from store via getProducts
  @Deprecated('use presentedOfferingContext')
  String? get presentedOfferingIdentifier =>
      presentedOfferingContext?.offeringIdentifier;
}
