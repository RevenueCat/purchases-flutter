import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _PurchaseParamsApiTest {

  void _checkConstructor(
    Purchasable purchasableItem,
    GoogleProductChangeInfo? googleProductChangeInfo,
    bool? googleIsPersonalizedPrice,
    PromotionalOffer? promotionalOffer
  ) {
    PurchaseParams purchaseParams = PurchaseParams(
      purchasableItem: purchasableItem,
    );
    purchaseParams = PurchaseParams(
      purchasableItem: purchasableItem,
      googleProductChangeInfo: googleProductChangeInfo,
    );
    purchaseParams = PurchaseParams(
      purchasableItem: purchasableItem,
      googleProductChangeInfo: googleProductChangeInfo,
      googleIsPersonalizedPrice: googleIsPersonalizedPrice,
    );
    purchaseParams = PurchaseParams(
      purchasableItem: purchasableItem,
      googleProductChangeInfo: googleProductChangeInfo,
      googleIsPersonalizedPrice: googleIsPersonalizedPrice,
      promotionalOffer: promotionalOffer,
    );
  }

  void _checkProperties(PurchaseParams purchaseParams) {
    Purchasable purchasableItem = purchaseParams.purchasableItem;
    GoogleProductChangeInfo? googleProductChangeInfo = purchaseParams.googleProductChangeInfo;
    bool? googleIsPersonalizedPrice = purchaseParams.googleIsPersonalizedPrice;
    PromotionalOffer? promotionalOffer = purchaseParams.promotionalOffer;
  }
}
