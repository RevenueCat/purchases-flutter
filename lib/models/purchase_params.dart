import 'google_product_change.dart';
import 'package_wrapper.dart';
import 'promotional_offer.dart';
import 'purchasable.dart';
import 'store_product_wrapper.dart';
import 'subscription_option_wrapper.dart';

/// Parameters for making a purchase.
class PurchaseParams {
  final Purchasable purchasableItem;
  final GoogleProductChangeInfo? googleProductChangeInfo;
  final bool? googleIsPersonalizedPrice;
  final PromotionalOffer? promotionalOffer;

  /// Creates purchase parameters for any purchasable item.
  ///
  /// [purchasableItem] The item to purchase - can be a [Package], [StoreProduct], or [SubscriptionOption]
  ///
  /// [googleProductChangeInfo] Android and Google Play only. Optional [GoogleProductChangeInfo] you wish to
  /// change from containing the googleOldProductIdentifer and the optional prorationMode.
  ///
  /// [googleIsPersonalizedPrice] Android and Google Play only. Optional boolean indicates
  /// personalized pricing on products available for purchase in the EU.
  /// For compliance with EU regulations. User will see "This price has been
  /// customize for you" in the purchase dialog when true.
  /// See https://developer.android.com/google/play/billing/integrate#personalized-price
  /// for more info.
  ///
  /// [promotionalOffer] iOS only. Promotional offer that will be applied to the product.
  /// Retrieve this offer using [Purchases.getPromotionalOffer].
  /// Note: Not supported for [SubscriptionOption] purchases.
  const PurchaseParams({
    required this.purchasableItem,
    this.googleProductChangeInfo,
    this.googleIsPersonalizedPrice,
    this.promotionalOffer,
  });
}
