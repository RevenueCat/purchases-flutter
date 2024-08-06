/// This class holds the information used when upgrading from another sku.
/// To be used with purchaseProduct and purchasePackage.
@Deprecated('Use GoogleProductChangeInfo')
class UpgradeInfo {
  /// The oldSKU to upgrade from.
  String oldSKU;

  /// The [ProrationMode] to use when upgrading the given oldSKU.
  ProrationMode? prorationMode;

  /// Constructs an UpgradeInfo
  @Deprecated('Use GoogleProductChangeInfo')
  UpgradeInfo(this.oldSKU, {this.prorationMode});
}

/// Replace SKU's ProrationMode.
@Deprecated('Use GoogleProrationMode on GoogleProductChangeInfo')
enum ProrationMode {
  /// The Upgrade or Downgrade policy is unknown.
  unknownSubscriptionUpgradeDowngradePolicy,

  /// Replacement takes effect immediately, and the remaining time will be
  /// prorated and credited to the user. This is the current default behavior.
  immediateWithTimeProration,

  /// Replacement takes effect immediately, and the billing cycle remains the
  /// same. The price for the remaining period will be charged. This option is
  /// only available for subscription upgrade.
  immediateAndChargeProratedPrice,

  /// Replacement takes effect immediately, and the new price will be charged on
  /// next recurrence time. The billing cycle stays the same.
  immediateWithoutProration,

  /// Replacement takes effect immediately, and the user is charged full price
  /// of new plan and is given a full billing cycle of subscription,
  /// plus remaining prorated time from the old plan.
  immediateAndChargeFullPrice
}

// ignore_for_file: deprecated_member_use_from_same_package
extension ProrationModeExtension on ProrationMode {
  int? get value {
    switch (this) {
      case ProrationMode.immediateWithTimeProration:
        return 1;
      case ProrationMode.immediateWithoutProration:
        return 3;
      case ProrationMode.immediateAndChargeFullPrice:
        return 5;
      case ProrationMode.immediateAndChargeProratedPrice:
        return 2;
      default:
        return null;
    }
  }
}
