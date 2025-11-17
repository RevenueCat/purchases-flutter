import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _PurchaseParamsApiTest {

  void _checkPackageConstructor(
    Package package,
    GoogleProductChangeInfo? googleProductChangeInfo,
    bool? googleIsPersonalizedPrice,
    PromotionalOffer? promotionalOffer,
    WinBackOffer? winBackOffer,
    String? customerEmail,
    List<StoreProduct>? addOnStoreProducts,
    List<Package>? addOnPackages,
    List<SubscriptionOption>? addOnSubscriptionOptions,
  ) {
    PurchaseParams purchaseParams = PurchaseParams.package(
      package,
    );
    purchaseParams = PurchaseParams.package(
      package,
      googleProductChangeInfo: googleProductChangeInfo,
    );
    purchaseParams = PurchaseParams.package(
      package,
      googleProductChangeInfo: googleProductChangeInfo,
      googleIsPersonalizedPrice: googleIsPersonalizedPrice,
    );
    purchaseParams = PurchaseParams.package(
      package,
      googleProductChangeInfo: googleProductChangeInfo,
      googleIsPersonalizedPrice: googleIsPersonalizedPrice,
      promotionalOffer: promotionalOffer,
    );
    purchaseParams = PurchaseParams.package(
      package,
      googleProductChangeInfo: googleProductChangeInfo,
      googleIsPersonalizedPrice: googleIsPersonalizedPrice,
      promotionalOffer: promotionalOffer,
      winBackOffer: winBackOffer,
    );
    purchaseParams = PurchaseParams.package(
      package,
      googleProductChangeInfo: googleProductChangeInfo,
      googleIsPersonalizedPrice: googleIsPersonalizedPrice,
      promotionalOffer: promotionalOffer,
      winBackOffer: winBackOffer,
      customerEmail: customerEmail,
    );
    purchaseParams = PurchaseParams.package(
      package,
      googleProductChangeInfo: googleProductChangeInfo,
      googleIsPersonalizedPrice: googleIsPersonalizedPrice,
      promotionalOffer: promotionalOffer,
      winBackOffer: winBackOffer,
      customerEmail: customerEmail,
      addOnStoreProducts: addOnStoreProducts,
    );
    purchaseParams = PurchaseParams.package(
      package,
      googleProductChangeInfo: googleProductChangeInfo,
      googleIsPersonalizedPrice: googleIsPersonalizedPrice,
      promotionalOffer: promotionalOffer,
      winBackOffer: winBackOffer,
      customerEmail: customerEmail,
      addOnPackages: addOnPackages,
    );
    purchaseParams = PurchaseParams.package(
      package,
      googleProductChangeInfo: googleProductChangeInfo,
      googleIsPersonalizedPrice: googleIsPersonalizedPrice,
      promotionalOffer: promotionalOffer,
      winBackOffer: winBackOffer,
      customerEmail: customerEmail,
      addOnSubscriptionOptions: addOnSubscriptionOptions,
    );
    purchaseParams = PurchaseParams.package(
      package,
      googleProductChangeInfo: googleProductChangeInfo,
      googleIsPersonalizedPrice: googleIsPersonalizedPrice,
      promotionalOffer: promotionalOffer,
      winBackOffer: winBackOffer,
      customerEmail: customerEmail,
      addOnStoreProducts: addOnStoreProducts,
      addOnPackages: addOnPackages,
      addOnSubscriptionOptions: addOnSubscriptionOptions,
    );
  }

  void _checkStoreProductConstructor(
    StoreProduct storeProduct,
    GoogleProductChangeInfo? googleProductChangeInfo,
    bool? googleIsPersonalizedPrice,
    PromotionalOffer? promotionalOffer,
    WinBackOffer? winBackOffer,
    String? customerEmail,
    List<StoreProduct>? addOnStoreProducts,
    List<Package>? addOnPackages,
    List<SubscriptionOption>? addOnSubscriptionOptions,
  ) {
    PurchaseParams purchaseParams = PurchaseParams.storeProduct(
      storeProduct,
    );
    purchaseParams = PurchaseParams.storeProduct(
      storeProduct,
      googleProductChangeInfo: googleProductChangeInfo,
    );
    purchaseParams = PurchaseParams.storeProduct(
      storeProduct,
      googleProductChangeInfo: googleProductChangeInfo,
      googleIsPersonalizedPrice: googleIsPersonalizedPrice,
    );
    purchaseParams = PurchaseParams.storeProduct(
      storeProduct,
      googleProductChangeInfo: googleProductChangeInfo,
      googleIsPersonalizedPrice: googleIsPersonalizedPrice,
      promotionalOffer: promotionalOffer,
    );
    purchaseParams = PurchaseParams.storeProduct(
      storeProduct,
      googleProductChangeInfo: googleProductChangeInfo,
      googleIsPersonalizedPrice: googleIsPersonalizedPrice,
      promotionalOffer: promotionalOffer,
      winBackOffer: winBackOffer,
    );
    purchaseParams = PurchaseParams.storeProduct(
      storeProduct,
      googleProductChangeInfo: googleProductChangeInfo,
      googleIsPersonalizedPrice: googleIsPersonalizedPrice,
      promotionalOffer: promotionalOffer,
      winBackOffer: winBackOffer,
      customerEmail: customerEmail,
    );
    purchaseParams = PurchaseParams.storeProduct(
      storeProduct,
      googleProductChangeInfo: googleProductChangeInfo,
      googleIsPersonalizedPrice: googleIsPersonalizedPrice,
      promotionalOffer: promotionalOffer,
      winBackOffer: winBackOffer,
      customerEmail: customerEmail,
      addOnStoreProducts: addOnStoreProducts,
    );
    purchaseParams = PurchaseParams.storeProduct(
      storeProduct,
      googleProductChangeInfo: googleProductChangeInfo,
      googleIsPersonalizedPrice: googleIsPersonalizedPrice,
      promotionalOffer: promotionalOffer,
      winBackOffer: winBackOffer,
      customerEmail: customerEmail,
      addOnPackages: addOnPackages,
    );
    purchaseParams = PurchaseParams.storeProduct(
      storeProduct,
      googleProductChangeInfo: googleProductChangeInfo,
      googleIsPersonalizedPrice: googleIsPersonalizedPrice,
      promotionalOffer: promotionalOffer,
      winBackOffer: winBackOffer,
      customerEmail: customerEmail,
      addOnSubscriptionOptions: addOnSubscriptionOptions,
    );
    purchaseParams = PurchaseParams.storeProduct(
      storeProduct,
      googleProductChangeInfo: googleProductChangeInfo,
      googleIsPersonalizedPrice: googleIsPersonalizedPrice,
      promotionalOffer: promotionalOffer,
      winBackOffer: winBackOffer,
      customerEmail: customerEmail,
      addOnStoreProducts: addOnStoreProducts,
      addOnPackages: addOnPackages,
      addOnSubscriptionOptions: addOnSubscriptionOptions,
    );
  }

  void _checkSubscriptionOptionConstructor(
    SubscriptionOption subscriptionOption,
    GoogleProductChangeInfo? googleProductChangeInfo,
    bool? googleIsPersonalizedPrice,
    String? customerEmail,
    List<StoreProduct>? addOnStoreProducts,
    List<Package>? addOnPackages,
    List<SubscriptionOption>? addOnSubscriptionOptions,
  ) {
    PurchaseParams purchaseParams = PurchaseParams.subscriptionOption(
      subscriptionOption,
    );
    purchaseParams = PurchaseParams.subscriptionOption(
      subscriptionOption,
      googleProductChangeInfo: googleProductChangeInfo,
    );
    purchaseParams = PurchaseParams.subscriptionOption(
      subscriptionOption,
      googleProductChangeInfo: googleProductChangeInfo,
      googleIsPersonalizedPrice: googleIsPersonalizedPrice,
    );
    purchaseParams = PurchaseParams.subscriptionOption(
      subscriptionOption,
      googleProductChangeInfo: googleProductChangeInfo,
      googleIsPersonalizedPrice: googleIsPersonalizedPrice,
      customerEmail: customerEmail,
    );
    purchaseParams = PurchaseParams.subscriptionOption(
      subscriptionOption,
      googleProductChangeInfo: googleProductChangeInfo,
      googleIsPersonalizedPrice: googleIsPersonalizedPrice,
      customerEmail: customerEmail,
      addOnStoreProducts: addOnStoreProducts,
    );
    purchaseParams = PurchaseParams.subscriptionOption(
      subscriptionOption,
      googleProductChangeInfo: googleProductChangeInfo,
      googleIsPersonalizedPrice: googleIsPersonalizedPrice,
      customerEmail: customerEmail,
      addOnPackages: addOnPackages,
    );
    purchaseParams = PurchaseParams.subscriptionOption(
      subscriptionOption,
      googleProductChangeInfo: googleProductChangeInfo,
      googleIsPersonalizedPrice: googleIsPersonalizedPrice,
      customerEmail: customerEmail,
      addOnSubscriptionOptions: addOnSubscriptionOptions,
    );
    purchaseParams = PurchaseParams.subscriptionOption(
      subscriptionOption,
      googleProductChangeInfo: googleProductChangeInfo,
      googleIsPersonalizedPrice: googleIsPersonalizedPrice,
      customerEmail: customerEmail,
      addOnStoreProducts: addOnStoreProducts,
      addOnPackages: addOnPackages,
      addOnSubscriptionOptions: addOnSubscriptionOptions,
    );
  }

  void _checkProperties(PurchaseParams purchaseParams) {
    Package? package = purchaseParams.package;
    StoreProduct? product = purchaseParams.product;
    SubscriptionOption? subscriptionOption = purchaseParams.subscriptionOption;
    GoogleProductChangeInfo? googleProductChangeInfo = purchaseParams.googleProductChangeInfo;
    bool? googleIsPersonalizedPrice = purchaseParams.googleIsPersonalizedPrice;
    PromotionalOffer? promotionalOffer = purchaseParams.promotionalOffer;
    WinBackOffer? winBackOffer = purchaseParams.winBackOffer;
    String? customerEmail = purchaseParams.customerEmail;
    List<StoreProduct>? addOnStoreProducts = purchaseParams.addOnStoreProducts;
    List<Package>? addOnPackages = purchaseParams.addOnPackages;
    List<SubscriptionOption>? addOnSubscriptionOptions = purchaseParams.addOnSubscriptionOptions;
  }
}
