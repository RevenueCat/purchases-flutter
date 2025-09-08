import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _PurchasableApiTest {
  void _checkSignature(Purchasable purchasable) {
    PresentedOfferingContext? context = purchasable.presentedOfferingContext;
  }
  void _checkInheritance(
      Package rcPackage,
      StoreProduct product,
      SubscriptionOption subscriptionOption,
  ) {
    Purchasable purchasable;

    purchasable = rcPackage;
    purchasable = product;
    purchasable = subscriptionOption;
  }
}
