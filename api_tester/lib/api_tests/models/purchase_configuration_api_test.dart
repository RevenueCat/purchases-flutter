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
    // deprecated, but we still need to check that the API hasn't been removed.
    // ignore: deprecated_member_use
    bool usesStoreKit2IfAvailable = configuration.usesStoreKit2IfAvailable;
    // ignore: deprecated_member_use
    configuration.usesStoreKit2IfAvailable = true;
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
