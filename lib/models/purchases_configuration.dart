import '../purchases_flutter.dart';

/// Used when calling [configure] to configure the RevenueCat plugin
class PurchasesConfiguration {
  /// RevenueCat API Key.
  final String apiKey;

  PurchasesConfiguration(this.apiKey);

  /// An optional unique id for identifying the user.
  String? appUserID;

  /// Set this to PurchasesAreCompletedByMyApp and provide a StoreKitVersion
  /// if you have your own IAP implementation and want to only use RevenueCat's
  /// backend. Defaults to PurchasesAreCompletedByRevenueCat.
  ///
  /// If you are on Android and setting this to PurchasesAreCompletedByMyApp, you will have to
  /// acknowledge the purchases yourself.
  /// If your app is only on Android, you may specify any StoreKitVersion,
  /// as it is ignored by the native Android SDK.
  PurchasesAreCompletedBy? purchasesAreCompletedBy;

  /// iOS-only, will be ignored for Android.
  /// Set this if you would like the RevenueCat SDK to store its preferences in
  /// a different NSUserDefaults suite, otherwise it will use
  /// standardUserDefaults. Default is null, which will make the SDK
  /// use standardUserDefaults.
  String? userDefaultsSuiteName;

  /// iOS-only, will be ignored for Android.
  /// By providing StoreKitVersion.defaultVersion, RevenueCat will automatically select the most appropriate StoreKit version
  /// for the app's runtime environment.
  ///
  /// - Warning: Make sure you have an In-App Purchase Key configured in your app.
  /// Please see https://rev.cat/in-app-purchase-key-configuration for more info.
  ///
  /// - Note: StoreKit 2 is only available on iOS 16+. StoreKit 1 will be used for previous iOS versions
  /// regardless of this setting.
  StoreKitVersion? storeKitVersion;

  /// Whether we should show store in-app messages automatically. Both Google Play and the App Store provide in-app
  /// messages for some situations like billing issues. By default, those messages will be shown automatically.
  /// This allows to disable that behavior, so you can display those messages at your convenience. For more information,
  /// check: https://rev.cat/storekit-message and https://rev.cat/googleplayinappmessaging
  bool shouldShowInAppMessagesAutomatically = true;

  /// Required to configure the plugin to be used in the Amazon Appstore.
  /// Values different to [Store.amazon] don't have any effect.
  Store? store;

  /// Verification strictness levels for [EntitlementInfo].
  /// See https://rev.cat/trusted-entitlements for more info.
  EntitlementVerificationMode entitlementVerificationMode =
      EntitlementVerificationMode.disabled;

  /// Enable this setting if you want to allow pending purchases for prepaid subscriptions (only supported
  /// in Google Play). Note that entitlements are not granted until payment is done.
  /// Disabled by default.
  bool pendingTransactionsForPrepaidPlansEnabled = false;
}

/// A [PurchasesConfiguration] convenience object that
/// sets [PurchasesConfiguration.store] to [Store.amazon]
class AmazonConfiguration extends PurchasesConfiguration {
  AmazonConfiguration(String apiKey) : super(apiKey) {
    store = Store.amazon;
  }
}
