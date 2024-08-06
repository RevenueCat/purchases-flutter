class GoogleProductChangeInfo {
  /// The oldProductIdentifier to change from.
  String oldProductIdentifier;

  /// The [GoogleProrationMode] to use when changing from the given oldProductIdentifer.
  /// Defaults to [GoogleProrationMode.immediateWithoutProration]
  GoogleProrationMode? prorationMode;

  /// Constructs an GoogleProductChangeInfo
  GoogleProductChangeInfo(this.oldProductIdentifier, {this.prorationMode});
}

/// GoogleProductChangeInfo's ProrationMode.
enum GoogleProrationMode {
  /// Replacement takes effect immediately, and the remaining time will be
  /// prorated and credited to the user. This is the current default behavior.
  immediateWithTimeProration,

  /// Replacement takes effect immediately, and the new price will be charged on
  /// next recurrence time. The billing cycle stays the same.
  immediateWithoutProration,

  // Replacement takes effect immediately, and the user is charged full price of new plan and is
  // given a full billing cycle of subscription, plus remaining prorated time from the old plan.
  immediateAndChargeFullPrice,

  // Replacement takes effect immediately, and the billing cycle remains the same.
  immediateAndChargeProratedPrice,

  // Replacement takes effect when the old plan expires, and the new price will be charged at the same time.
  deferred,
}

extension GoogleProrationModeExtension on GoogleProrationMode {
  int? get value {
    switch (this) {
      case GoogleProrationMode.immediateWithTimeProration:
        return 1;
      case GoogleProrationMode.immediateWithoutProration:
        return 3;
      case GoogleProrationMode.immediateAndChargeFullPrice:
        return 5;
      case GoogleProrationMode.immediateAndChargeProratedPrice:
        return 2;
      case GoogleProrationMode.deferred:
        return 6;
      default:
        return null;
    }
  }
}
