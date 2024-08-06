import './storekit_version.dart';

/// Modes for completing the purchase process.
enum PurchasesAreCompletedByType {
  /// RevenueCat will **not** automatically acknowledge any purchases.
  /// You will have to do so manually.
  /// Note that failing to acknowledge a purchase within 3 days will lead
  /// to Google Play automatically issuing a refund to the user.
  /// For more info, see [revenuecat.com](https://docs.revenuecat.com/docs/observer-mode#option-2-client-side)
  /// and [developer.android.com](https://developer.android.com/google/play/billing/integrate#process).
  myApp,

  /// RevenueCat will automatically acknowledge verified purchases.
  /// No action is required by you.
  revenueCat,
}

extension PurchasesAreCompletedByTypeExtension on PurchasesAreCompletedByType {
  String get name {
    switch (this) {
      case PurchasesAreCompletedByType.myApp:
        return 'MY_APP';
      case PurchasesAreCompletedByType.revenueCat:
        return 'REVENUECAT';
    }
  }
}

// Sealed class for PurchasesAreCompletedBy
abstract class PurchasesAreCompletedBy {
  const PurchasesAreCompletedBy();
}

class PurchasesAreCompletedByRevenueCat extends PurchasesAreCompletedBy {
  const PurchasesAreCompletedByRevenueCat();
}

class PurchasesAreCompletedByMyApp extends PurchasesAreCompletedBy {
  final StoreKitVersion storeKitVersion;

  PurchasesAreCompletedByMyApp({
    required this.storeKitVersion,
  });
}
