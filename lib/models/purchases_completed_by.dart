/// Modes for completing the purchase process.
enum PurchasesAreCompletedBy {
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

extension PurchasesAreCompletedByExtension on PurchasesAreCompletedBy {
  String get name {
    switch (this) {
      case PurchasesAreCompletedBy.myApp:
        return 'MY_APP';
      case PurchasesAreCompletedBy.revenueCat:
        return 'REVENUECAT';
    }
  }
}
