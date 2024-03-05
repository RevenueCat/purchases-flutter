import '../purchases_flutter.dart';

/// Used when calling [configure] to configure the RevenueCat plugin
class PurchasesConfiguration {
  /// RevenueCat API Key.
  final String apiKey;

  PurchasesConfiguration(this.apiKey);

  /// An optional unique id for identifying the user.
  String? appUserID;

  /// An optional boolean. Set this to TRUE if you have your own
  /// IAP implementation and want to use only RevenueCat's backend.
  /// Default is FALSE.
  bool observerMode = false;

  /// iOS-only, will be ignored for Android.
  /// Set this if you would like the RevenueCat SDK to store its preferences in
  /// a different NSUserDefaults suite, otherwise it will use
  /// standardUserDefaults. Default is null, which will make the SDK
  /// use standardUserDefaults.
  String? userDefaultsSuiteName;

  /// iOS-only, will be ignored for Android.
  /// Set this to FALSE to disable StoreKit2.
  /// Default is FALSE.
  ///
  /// RevenueCat currently uses StoreKit 1 for purchases, as its stability in production scenarios has
  /// proven to be more performant than StoreKit 2.
  /// We're collecting more data on the best approach, but StoreKit 1 vs StoreKit 2 is an implementation detail
  /// that you shouldn't need to care about.
  /// Simply remove this method call to let RevenueCat decide for you which StoreKit implementation to use.
  StoreKitVersion storeKitVersion = StoreKitVersion.defaultVersion;

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
  EntitlementVerificationMode entitlementVerificationMode = EntitlementVerificationMode.disabled;
}

/// A [PurchasesConfiguration] convenience object that
/// sets [PurchasesConfiguration.store] to [Store.amazon]
class AmazonConfiguration extends PurchasesConfiguration {
  AmazonConfiguration(String apiKey) : super(apiKey) {
    store = Store.amazon;
  }
}
