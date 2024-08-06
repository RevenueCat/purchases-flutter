// Defines which version of StoreKit may be used
enum StoreKitVersion {
  /// Always use StoreKit 1.
  storeKit1,

  /// Always use StoreKit 2 (StoreKit 1 will be used if StoreKit 2 is not available in the current device.)
  /// - Warning: Make sure you have an In-App Purchase Key configured in your app.
  /// Please see https://rev.cat/in-app-purchase-key-configuration for more info.
  storeKit2,

  /// Let RevenueCat use the most appropriate version of StoreKit
  defaultVersion,
}

extension StoreKitVersionExtension on StoreKitVersion {
  String get name {
    switch (this) {
      case StoreKitVersion.storeKit1:
        return 'STOREKIT_1';
      case StoreKitVersion.storeKit2:
        return 'STOREKIT_2';
      case StoreKitVersion.defaultVersion:
        return 'DEFAULT';
    }
  }
}
