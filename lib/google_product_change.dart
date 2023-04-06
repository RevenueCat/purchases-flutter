class GoogleProductChangeInfo {
  /// The oldProductIdentifer to change from.
  String oldProductIdentifer;

  /// The [GoogleProrationMode] to use when changing from the given oldProductIdentifer.
  GoogleProrationMode? prorationMode;

  /// Constructs an GoogleProductChangeInfo
  GoogleProductChangeInfo(this.oldProductIdentifer, {this.prorationMode});
}

/// GoogleProductChangeInfo's ProrationMode.
enum GoogleProrationMode {
  /// Replacement takes effect immediately, and the remaining time will be
  /// prorated and credited to the user. This is the current default behavior.
  immediateWithTimeProration,

  /// Replacement takes effect immediately, and the new price will be charged on
  /// next recurrence time. The billing cycle stays the same.
  immediateWithoutProration,
}
