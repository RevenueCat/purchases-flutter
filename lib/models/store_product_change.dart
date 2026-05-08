/// Store-specific replacement information for changing products.
class StoreProductChangeInfo {
  /// The old product identifier to change from.
  final String oldProductIdentifier;

  /// The replacement mode to use when changing from the old product.
  ///
  /// Defaults to store-specific behavior when not provided.
  final StoreReplacementMode? replacementMode;

  /// Constructs a [StoreProductChangeInfo].
  const StoreProductChangeInfo(
    this.oldProductIdentifier, {
    this.replacementMode,
  });
}

/// Replacement modes for product changes.
enum StoreReplacementMode {
  /// Replacement takes effect immediately, and the remaining time will be
  /// prorated and credited to the user.
  withTimeProration,

  /// Replacement takes effect immediately, and the user is charged a prorated
  /// price for the new product for the remainder of the billing cycle.
  chargeProratedPrice,

  /// Replacement takes effect immediately, and the new price will be charged on
  /// next recurrence time. The billing cycle stays the same.
  withoutProration,

  /// Replacement takes effect immediately, and the user is charged full price
  /// of the new product and given a full billing cycle.
  chargeFullPrice,

  /// Replacement takes effect when the old product expires, and the new price
  /// will be charged at the same time.
  deferred,
}

extension StoreReplacementModeExtension on StoreReplacementMode {
  String get value {
    switch (this) {
      case StoreReplacementMode.withTimeProration:
        return 'WITH_TIME_PRORATION';
      case StoreReplacementMode.chargeProratedPrice:
        return 'CHARGE_PRORATED_PRICE';
      case StoreReplacementMode.withoutProration:
        return 'WITHOUT_PRORATION';
      case StoreReplacementMode.chargeFullPrice:
        return 'CHARGE_FULL_PRICE';
      case StoreReplacementMode.deferred:
        return 'DEFERRED';
    }
  }
}
