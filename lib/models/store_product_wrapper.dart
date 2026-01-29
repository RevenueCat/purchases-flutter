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

  /// Price per week in the local currency.
  /// Null for non-subscription products.
  final double? pricePerWeek;

  /// Price per month in the local currency.
  /// Null for non-subscription products.
  final double? pricePerMonth;

  /// Price per year in the local currency.
  /// Null for non-subscription products.
  final double? pricePerYear;

  /// Formatted price per week, including its currency sign.
  /// Null for non-subscription products.
  final String? pricePerWeekString;

  /// Formatted price per month, including its currency sign.
  /// Null for non-subscription products.
  final String? pricePerMonthString;

  /// Formatted price per year, including its currency sign.
  /// Null for non-subscription products.
  final String? pricePerYearString;

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
    this.pricePerWeek,
    this.pricePerMonth,
    this.pricePerYear,
    this.pricePerWeekString,
    this.pricePerMonthString,
    this.pricePerYearString,
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
      pricePerWeek: json['pricePerWeek'] != null ? (json['pricePerWeek'] as num).toDouble() : null,
      pricePerMonth: json['pricePerMonth'] != null ? (json['pricePerMonth'] as num).toDouble() : null,
      pricePerYear: json['pricePerYear'] != null ? (json['pricePerYear'] as num).toDouble() : null,
      pricePerWeekString: json['pricePerWeekString'] as String?,
      pricePerMonthString: json['pricePerMonthString'] as String?,
      pricePerYearString: json['pricePerYearString'] as String?,
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
    pricePerWeek,
    pricePerMonth,
    pricePerYear,
    pricePerWeekString,
    pricePerMonthString,
    pricePerYearString,
  ];
}

extension ExtendedStoreProduct on StoreProduct {
  /// Offering this package belongs to.
  /// Null if not using offerings or if fetched directly from store via getProducts
  @Deprecated('use presentedOfferingContext')
  String? get presentedOfferingIdentifier =>
      presentedOfferingContext?.offeringIdentifier;
}
