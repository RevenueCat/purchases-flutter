import '../purchases_flutter.dart';
import 'store.dart';

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
  /// Default is TRUE.
  bool usesStoreKit2IfAvailable = true;

  /// Required to configure the plugin to be used in the Amazon Appstore.
  /// Values different to [Store.amazon] don't have any effect.
  Store? store;
}

/// A [PurchasesConfiguration] convenience object that
/// sets [PurchasesConfiguration.store] to [Store.amazon]
class AmazonConfiguration extends PurchasesConfiguration {
  AmazonConfiguration(String apiKey) : super(apiKey) {
    store = Store.amazon;
  }
}
