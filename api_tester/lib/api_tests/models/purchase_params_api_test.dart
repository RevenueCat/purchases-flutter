import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
// ignore_for_file: deprecated_member_use

class _PurchaseParamsApiTest {
  void _checkPackageConstructor(
    Package package,
    StoreProductChangeInfo? productChangeInfo,
    GoogleProductChangeInfo? googleProductChangeInfo,
    bool? googleIsPersonalizedPrice,
    PromotionalOffer? promotionalOffer,
    WinBackOffer? winBackOffer,
    String? customerEmail,
  ) {
    PurchaseParams purchaseParams = PurchaseParams.package(
      package,
    );
    purchaseParams = PurchaseParams.package(
      package,
      productChangeInfo: productChangeInfo,
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
  }

  void _checkStoreProductConstructor(
    StoreProduct storeProduct,
    StoreProductChangeInfo? productChangeInfo,
    GoogleProductChangeInfo? googleProductChangeInfo,
    bool? googleIsPersonalizedPrice,
    PromotionalOffer? promotionalOffer,
    WinBackOffer? winBackOffer,
    String? customerEmail,
  ) {
    PurchaseParams purchaseParams = PurchaseParams.storeProduct(
      storeProduct,
    );
    purchaseParams = PurchaseParams.storeProduct(
      storeProduct,
      productChangeInfo: productChangeInfo,
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
  }

  void _checkSubscriptionOptionConstructor(
    SubscriptionOption subscriptionOption,
    StoreProductChangeInfo? productChangeInfo,
    GoogleProductChangeInfo? googleProductChangeInfo,
    bool? googleIsPersonalizedPrice,
    String? customerEmail,
  ) {
    PurchaseParams purchaseParams = PurchaseParams.subscriptionOption(
      subscriptionOption,
    );
    purchaseParams = PurchaseParams.subscriptionOption(
      subscriptionOption,
      productChangeInfo: productChangeInfo,
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
  }

  void _checkProperties(PurchaseParams purchaseParams) {
    Package? package = purchaseParams.package;
    StoreProduct? product = purchaseParams.product;
    SubscriptionOption? subscriptionOption = purchaseParams.subscriptionOption;
    StoreProductChangeInfo? productChangeInfo =
        purchaseParams.productChangeInfo;
    GoogleProductChangeInfo? googleProductChangeInfo =
        purchaseParams.googleProductChangeInfo;
    bool? googleIsPersonalizedPrice = purchaseParams.googleIsPersonalizedPrice;
    PromotionalOffer? promotionalOffer = purchaseParams.promotionalOffer;
    WinBackOffer? winBackOffer = purchaseParams.winBackOffer;
    String? customerEmail = purchaseParams.customerEmail;
  }
}
