import 'google_product_change.dart';
import 'package_wrapper.dart';
import 'promotional_offer.dart';
import 'store_product_wrapper.dart';
import 'subscription_option_wrapper.dart';

/// Parameters for making a purchase.
class PurchaseParams {
  final Package? package;
  final StoreProduct? product;
  final SubscriptionOption? subscriptionOption;
  final GoogleProductChangeInfo? googleProductChangeInfo;
  final bool? googleIsPersonalizedPrice;
  final PromotionalOffer? promotionalOffer;
  final String? customerEmail;

  const PurchaseParams._(
    this.package,
    this.product,
    this.subscriptionOption,
    this.googleProductChangeInfo,
    this.googleIsPersonalizedPrice,
    this.promotionalOffer,
    this.customerEmail,
  );

  /// Creates purchase parameters for a package.
  ///
  /// [package] The package to purchase.
  ///
  /// [googleProductChangeInfo] Android and Google Play only. Optional [GoogleProductChangeInfo] you wish to
  /// change from containing the googleOldProductIdentifer and the optional prorationMode.
  ///
  /// [googleIsPersonalizedPrice] Android and Google Play only. Optional boolean indicates
  /// personalized pricing on products available for purchase in the EU.
  /// For compliance with EU regulations. User will see "This price has been
  /// customized for you" in the purchase dialog when true.
  /// See https://developer.android.com/google/play/billing/integrate#personalized-price
  /// for more info.
  ///
  /// [promotionalOffer] iOS only. Promotional offer that will be applied to the product.
  /// Retrieve this offer using [Purchases.getPromotionalOffer].
  ///
  /// [customerEmail] Web only. The email of the user. If undefined, RevenueCat
  /// will ask the customer for their email.
  ///
  const PurchaseParams.package(
    Package package, {
    GoogleProductChangeInfo? googleProductChangeInfo,
    bool? googleIsPersonalizedPrice,
    PromotionalOffer? promotionalOffer,
    String? customerEmail,
  }) : this._(
        package,
        null,
        null,
        googleProductChangeInfo,
        googleIsPersonalizedPrice,
        promotionalOffer,
        customerEmail,
      );

  /// Creates purchase parameters for a store product.
  ///
  /// [storeProduct] The store product to purchase.
  ///
  /// [googleProductChangeInfo] Android and Google Play only. Optional [GoogleProductChangeInfo] you wish to
  /// change from containing the googleOldProductIdentifer and the optional prorationMode.
  ///
  /// [googleIsPersonalizedPrice] Android and Google Play only. Optional boolean indicates
  /// personalized pricing on products available for purchase in the EU.
  /// For compliance with EU regulations. User will see "This price has been
  /// customized for you" in the purchase dialog when true.
  /// See https://developer.android.com/google/play/billing/integrate#personalized-price
  /// for more info.
  ///
  /// [promotionalOffer] iOS only. Promotional offer that will be applied to the product.
  /// Retrieve this offer using [Purchases.getPromotionalOffer].
  ///
  /// [customerEmail] Web only. The email of the user. If undefined, RevenueCat
  /// will ask the customer for their email.
  ///
  const PurchaseParams.storeProduct(
    StoreProduct storeProduct, {
    GoogleProductChangeInfo? googleProductChangeInfo,
    bool? googleIsPersonalizedPrice,
    PromotionalOffer? promotionalOffer,
    String? customerEmail,
  }) : this._(
        null,
        storeProduct,
        null,
        googleProductChangeInfo,
        googleIsPersonalizedPrice,
        promotionalOffer,
        customerEmail,
      );

  /// Creates purchase parameters for a subscription option. Google Play-only.
  ///
  /// [subscriptionOption] The subscription option to purchase.
  ///
  /// [googleProductChangeInfo] Android and Google Play only. Optional [GoogleProductChangeInfo] you wish to
  /// change from containing the googleOldProductIdentifer and the optional prorationMode.
  ///
  /// [googleIsPersonalizedPrice] Android and Google Play only. Optional boolean indicates
  /// personalized pricing on products available for purchase in the EU.
  /// For compliance with EU regulations. User will see "This price has been
  /// customized for you" in the purchase dialog when true.
  /// See https://developer.android.com/google/play/billing/integrate#personalized-price
  /// for more info.
  ///
  /// [customerEmail] Web only. The email of the user. If undefined, RevenueCat
  /// will ask the customer for their email.
  ///
  const PurchaseParams.subscriptionOption(
    SubscriptionOption subscriptionOption, {
    GoogleProductChangeInfo? googleProductChangeInfo,
    bool? googleIsPersonalizedPrice,
    String? customerEmail,
  }) : this._(
        null,
        null,
        subscriptionOption,
        googleProductChangeInfo,
        googleIsPersonalizedPrice,
        null,
        customerEmail,
      );
}
