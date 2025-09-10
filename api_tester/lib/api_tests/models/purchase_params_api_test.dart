import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _PurchaseParamsApiTest {

  void _checkPackageConstructor(
    Package package,
    GoogleProductChangeInfo? googleProductChangeInfo,
    bool? googleIsPersonalizedPrice,
    PromotionalOffer? promotionalOffer
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
  }

  void _checkStoreProductConstructor(
    StoreProduct storeProduct,
    GoogleProductChangeInfo? googleProductChangeInfo,
    bool? googleIsPersonalizedPrice,
    PromotionalOffer? promotionalOffer
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
  }

  void _checkSubscriptionOptionConstructor(
    SubscriptionOption subscriptionOption,
    GoogleProductChangeInfo? googleProductChangeInfo,
    bool? googleIsPersonalizedPrice
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
  }

  void _checkProperties(PurchaseParams purchaseParams) {
    Package? package = purchaseParams.package;
    StoreProduct? product = purchaseParams.product;
    SubscriptionOption? subscriptionOption = purchaseParams.subscriptionOption;
    GoogleProductChangeInfo? googleProductChangeInfo = purchaseParams.googleProductChangeInfo;
    bool? googleIsPersonalizedPrice = purchaseParams.googleIsPersonalizedPrice;
    PromotionalOffer? promotionalOffer = purchaseParams.promotionalOffer;
  }
}
