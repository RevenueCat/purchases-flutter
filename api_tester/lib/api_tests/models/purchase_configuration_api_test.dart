import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _PurchaseConfigurationApiTest {
  void _checkConstructor() {
    PurchasesConfiguration configuration = PurchasesConfiguration("fakeApiKey");
  }

  void _checkProperties(PurchasesConfiguration configuration) {
    String? appUserId = configuration.appUserID;
    bool observerMode = configuration.observerMode;
    String? userDefaultsSuiteName = configuration.userDefaultsSuiteName;
    Store? store = configuration.store;
    configuration.appUserID = null;
    configuration.appUserID = "fakeUserId";
    configuration.observerMode = false;
    configuration.userDefaultsSuiteName = null;
    configuration.userDefaultsSuiteName = "fakeSuiteName";
    configuration.store = null;
    configuration.store = Store.playStore;
    StoreKitVersion storeKitVersion = configuration.storeKitVersion;
    configuration.storeKitVersion = StoreKitVersion.storeKit2;
  }

  void _checkAmazonConfigurationConstructor() {
    AmazonConfiguration configuration = AmazonConfiguration("fakeApiKey");
  }

  void _checkAmazonConfigurationProperties(AmazonConfiguration configuration) {
    String? appUserId = configuration.appUserID;
    bool observerMode = configuration.observerMode;
    String? userDefaultsSuiteName = configuration.userDefaultsSuiteName;
    Store? store = configuration.store;
    configuration.appUserID = null;
    configuration.appUserID = "fakeUserId";
    configuration.observerMode = false;
    configuration.userDefaultsSuiteName = null;
    configuration.userDefaultsSuiteName = "fakeSuiteName";
    configuration.store = null;
    configuration.store = Store.playStore;
  }
}
