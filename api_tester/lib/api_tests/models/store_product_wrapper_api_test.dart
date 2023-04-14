import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _StoreProductApiTest {
  void _checkFromJsonFactory(Map<String, dynamic> json) {
    StoreProduct product = StoreProduct.fromJson(json);
  }

  void _checkToJson(StoreProduct product) {
    Map<String, dynamic> json = product.toJson();
  }

  void _checkConstructor(
      String identifier,
      String description,
      String title,
      double price,
      String priceString,
      String currencyCode,
      IntroductoryPrice? introductoryPrice,
      List<StoreProductDiscount>? discounts,
      ProductCategory? productCategory,
      String? subscriptionPeriod,
      String? presentedOfferingIdentifier) {
    StoreProduct product = StoreProduct(
        identifier, description, title, price, priceString, currencyCode);
    product = StoreProduct(
        identifier, description, title, price, priceString, currencyCode,
        introductoryPrice: introductoryPrice,
        discounts: discounts,
        productCategory: productCategory,
        subscriptionPeriod: subscriptionPeriod,
        presentedOfferingIdentifier: presentedOfferingIdentifier);
  }

  void _checkProperties(StoreProduct product) {
    String identifier = product.identifier;
    String description = product.description;
    String title = product.title;
    double price = product.price;
    String priceString = product.priceString;
    String currencyCode = product.currencyCode;
    IntroductoryPrice? introductoryPrice = product.introductoryPrice;
    List<StoreProductDiscount>? discounts = product.discounts;
    ProductCategory? productType = product.productCategory;
    SubscriptionOption? defaultOption = product.defaultOption;
    List<SubscriptionOption>? subscriptionOptions = product.subscriptionOptions;
    String? subscriptionPeriod = product.subscriptionPeriod;
    String? presentedOfferingIdentifier = product.presentedOfferingIdentifier;
  }
}
