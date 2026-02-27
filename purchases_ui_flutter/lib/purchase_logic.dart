import 'package:purchases_flutter/models/package_wrapper.dart';

/// Result of a custom purchase or restore operation performed by the app.
enum PurchaseLogicResult {
  /// The purchase or restore completed successfully.
  success,

  /// The user cancelled the purchase.
  cancellation,

  /// An error occurred during the purchase or restore.
  error,
}

/// Interface for custom purchase logic when `purchasesAreCompletedBy` is
/// set to `myApp`.
///
/// When provided to a [PaywallView], the paywall will delegate purchase and
/// restore operations to this implementation instead of using RevenueCat's
/// default flow.
abstract class PaywallPurchaseLogic {
  /// Called when the user initiates a purchase from the paywall.
  ///
  /// [packageToPurchase] is the package the user selected.
  /// Return the result of the purchase operation.
  Future<PurchaseLogicResult> performPurchase(Package packageToPurchase);

  /// Called when the user initiates a restore from the paywall.
  ///
  /// Return the result of the restore operation.
  Future<PurchaseLogicResult> performRestore();
}
