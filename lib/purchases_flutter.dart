import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'object_wrappers.dart';

export 'object_wrappers.dart';

/// Used to handle async updates from [Purchases].
/// Should be implemented to receive updates when the [PurchaserInfo] changes.
typedef void PurchaserInfoUpdateListener(PurchaserInfo purchaserInfo);

/// Entry point for Purchases.
class Purchases {
  static final Set<PurchaserInfoUpdateListener> _purchaserInfoUpdateListeners =
      Set();

  static final _channel = MethodChannel('purchases_flutter')
    ..setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case "Purchases-PurchaserInfoUpdated":
          _purchaserInfoUpdateListeners.forEach(
              (listener) => listener(PurchaserInfo.fromJson(call.arguments)));
          break;
      }
    });

  /// Sets up Purchases with your API key and an app user id.
  ///
  /// [apiKey] RevenueCat API Key.
  ///
  /// [appUserID] An optional unique id for identifying the user.
  ///
  /// [observerMode] An optional boolean. Set this to TRUE if you have your own
  /// IAP implementation and want to use only RevenueCat's backend.
  /// Default is FALSE.
  ///
  /// [userDefaultsSuiteName] iOS-only, will be ignored for Android.
  /// Set this if you would like the RevenueCat SDK to store its preferences in a different
  /// NSUserDefaults suite, otherwise it will use standardUserDefaults.
  /// Default is null, which will make the SDK use standardUserDefaults.
  static Future<void> setup(String apiKey,
      {String? appUserId,
      bool observerMode = false,
      String? userDefaultsSuiteName}) async {
    return await _channel.invokeMethod('setupPurchases', {
      'apiKey': apiKey,
      'appUserId': appUserId,
      'observerMode': observerMode,
      'userDefaultsSuiteName': userDefaultsSuiteName
    });
  }

  // Default to TRUE, set this to FALSE if you are consuming and acknowledging transactions outside of the Purchases SDK.
  ///
  /// [finishTransactions] The value to be passed to finishTransactions.
  ///
  static Future<void> setFinishTransactions(bool finishTransactions) async {
    await _channel.invokeMethod(
        'setFinishTransactions', {'finishTransactions': finishTransactions});
  }

  /// Deprecated. Configure behavior through the RevenueCat dashboard instead.
  /// Set this to true if you are passing in an appUserID but it is anonymous.
  ///
  /// This is true by default if you didn't pass an appUserID.
  /// If a user tries to purchase a product that is active on the current app
  /// store account, we will treat it as a restore and alias the new ID with the
  /// previous id.
  @Deprecated("Configure behavior through the RevenueCat dashboard instead.")
  static Future<void> setAllowSharingStoreAccount(bool allowSharing) async {
    await _channel.invokeMethod(
        'setAllowSharingStoreAccount', {'allowSharing': allowSharing});
  }

  /// Sets a function to be called on updated purchaser info.
  ///
  /// The function is called right away with the latest purchaser info as soon
  /// as it's set.
  ///
  /// [purchaserInfoUpdateListener] PurchaserInfo update listener.
  static void addPurchaserInfoUpdateListener(
      PurchaserInfoUpdateListener purchaserInfoUpdateListener) async {
    _purchaserInfoUpdateListeners.add(purchaserInfoUpdateListener);
  }

  /// Removes a given PurchaserInfoUpdateListener
  ///
  /// [listenerToRemove] PurchaserInfoListener reference of the listener to remove.
  static void removePurchaserInfoUpdateListener(
      PurchaserInfoUpdateListener listenerToRemove) async {
    _purchaserInfoUpdateListeners.remove(listenerToRemove);
  }

  /// Deprecated in favor of set<NetworkId> functions.
  /// Add a dict of attribution information
  ///
  /// [data] Attribution data from any of the [PurchasesAttributionNetwork].
  ///
  /// [network] Which network, see [PurchasesAttributionNetwork].
  ///
  /// [networkUserId] An optional unique id for identifying the user.
  @Deprecated("Use the set<NetworkId> functions instead.")
  static Future<void> addAttributionData(
      Map<String, Object> data, PurchasesAttributionNetwork network,
      {String? networkUserId}) async {
    await _channel.invokeMethod('addAttributionData', {
      'data': data,
      'network': network.index,
      'networkUserId': networkUserId
    });
  }

  /// Fetch the configured offerings for this users. Offerings allows you to
  /// configure your in-app products via RevenueCat and greatly simplifies
  /// management. See [the guide](https://docs.revenuecat.com/offerings) for
  /// more info.
  ///
  /// Offerings will be fetched and cached on instantiation so that, by the time
  /// they are needed, your prices are loaded for your purchase flow.
  ///
  /// Time is money.
  static Future<Offerings> getOfferings() async {
    return Offerings.fromJson(await _channel.invokeMethod('getOfferings'));
  }

  /// Fetch the product info. Returns a list of products or throws an error if
  /// the products are not properly configured in RevenueCat or if there is
  /// another error while retrieving them.
  ///
  /// [productIdentifiers] Array of product identifiers
  ///
  /// [type] If the products are Android INAPPs, this needs to be
  /// PurchaseType.INAPP otherwise the products won't be found.
  /// PurchaseType.Subs by default. This parameter only has effect in Android.
  static Future<List<Product>> getProducts(List<String> productIdentifiers,
      {PurchaseType type = PurchaseType.subs}) async {
    final List<dynamic> result = await _channel.invokeMethod('getProductInfo',
        {'productIdentifiers': productIdentifiers, 'type': describeEnum(type)});
    return result.map<Product>((item) => Product.fromJson(item)).toList();
  }

  /// Makes a purchase. Returns a [PurchaserInfo] object. Throws a
  /// [PlatformException] if the purchase is unsuccessful.
  /// Check if `PurchasesErrorHelper.getErrorCode(e)` is
  /// `PurchasesErrorCode.purchaseCancelledError` to check if the user cancelled
  /// the purchase.
  ///
  /// [productIdentifier] The product identifier of the product you want to
  /// purchase.
  ///
  /// [upgradeInfo] Android only. Optional UpgradeInfo you wish to upgrade from
  /// containing the oldSKU and the optional prorationMode.
  ///
  /// [type] If the product is an Android INAPP, this needs to be
  /// PurchaseType.INAPP otherwise the product won't be found.
  /// PurchaseType.Subs by default. This parameter only has effect in Android.
  static Future<PurchaserInfo> purchaseProduct(String productIdentifier,
      {UpgradeInfo? upgradeInfo, PurchaseType type = PurchaseType.subs}) async {
    final prorationMode = upgradeInfo?.prorationMode;
    final response = await _channel.invokeMethod('purchaseProduct', {
      'productIdentifier': productIdentifier,
      'oldSKU': upgradeInfo?.oldSKU,
      'prorationMode': prorationMode != null ? prorationMode.index : null,
      'type': describeEnum(type)
    });
    return PurchaserInfo.fromJson(response["purchaserInfo"]);
  }

  /// Makes a purchase. Returns a [PurchaserInfo] object. Throws a
  /// [PlatformException] if the purchase is unsuccessful.
  /// Check if `PurchasesErrorHelper.getErrorCode(e)` is
  /// `PurchasesErrorCode.purchaseCancelledError` to check if the user cancelled
  /// the purchase.
  ///
  /// [packageToPurchase] The Package you wish to purchase
  ///
  /// [upgradeInfo] Android only. Optional UpgradeInfo you wish to upgrade from
  /// containing the oldSKU and the optional prorationMode.
  static Future<PurchaserInfo> purchasePackage(Package packageToPurchase,
      {UpgradeInfo? upgradeInfo}) async {
    final prorationMode = upgradeInfo?.prorationMode;
    final response = await _channel.invokeMethod('purchasePackage', {
      'packageIdentifier': packageToPurchase.identifier,
      'offeringIdentifier': packageToPurchase.offeringIdentifier,
      'oldSKU': upgradeInfo?.oldSKU,
      'prorationMode': prorationMode != null ? prorationMode.index : null
    });
    return PurchaserInfo.fromJson(response["purchaserInfo"]);
  }

  /// iOS only. Purchase a product applying a given discount.
  ///
  /// Returns a [PurchaserInfo] object. Throws a
  /// [PlatformException] if the purchase is unsuccessful.
  /// Check if `PurchasesErrorHelper.getErrorCode(e)` is
  /// `PurchasesErrorCode.purchaseCancelledError` to check if the user cancelled
  /// the purchase.
  ///
  /// [product] The product to purchase.
  ///
  /// [paymentDiscount] Discount to apply to the product. Retrieve this discount
  /// using [getPaymentDiscount].
  static Future<PurchaserInfo> purchaseDiscountedProduct(
      Product product, PaymentDiscount discount) async {
    final response = await _channel.invokeMethod('purchaseProduct', {
      'productIdentifier': product.identifier,
      'signedDiscountTimestamp': discount.timestamp.toString()
    });
    return PurchaserInfo.fromJson(response["purchaserInfo"]);
  }

  /// iOS only. Purchase a package applying a given discount.
  ///
  /// Returns a [PurchaserInfo] object. Throws a
  /// [PlatformException] if the purchase is unsuccessful.
  /// Check if `PurchasesErrorHelper.getErrorCode(e)` is
  /// `PurchasesErrorCode.purchaseCancelledError` to check if the user cancelled
  /// the purchase.
  ///
  /// [packageToPurchase] The Package you wish to purchase
  ///
  /// [paymentDiscount] Discount to apply to the product. Retrieve this discount
  /// using [getPaymentDiscount].
  static Future<PurchaserInfo> purchaseDiscountedPackage(
      Package packageToPurchase, PaymentDiscount discount) async {
    final response = await _channel.invokeMethod('purchasePackage', {
      'packageIdentifier': packageToPurchase.identifier,
      'offeringIdentifier': packageToPurchase.offeringIdentifier,
      'signedDiscountTimestamp': discount.timestamp.toString()
    });
    return PurchaserInfo.fromJson(response["purchaserInfo"]);
  }

  /// Restores a user's previous purchases and links their appUserIDs to any
  /// user's also using those purchases.
  ///
  /// Returns a [PurchaserInfo] object, or throws a [PlatformException] if there
  /// was a problem restoring transactions.
  static Future<PurchaserInfo> restoreTransactions() async {
    final result = await _channel.invokeMethod('restoreTransactions');
    return PurchaserInfo.fromJson(result);
  }

  /// Gets the current appUserID.
  static Future<String> get appUserID async {
    return await _channel.invokeMethod('getAppUserID') as String;
  }

  /// Deprecated in favor of logIn.
  /// This function will alias two appUserIDs together.
  ///
  /// Returns a [PurchaserInfo] object, or throws a [PlatformException] if there
  /// was a problem restoring transactions.
  ///
  /// [newAppUserID] The new appUserID that should be linked to the currently
  /// identified appUserID.
  @Deprecated("Use logIn instead.")
  static Future<PurchaserInfo> createAlias(String newAppUserID) async {
    Map<dynamic, dynamic> result = await _channel
        .invokeMethod('createAlias', {'newAppUserID': newAppUserID});
    return PurchaserInfo.fromJson(result);
  }

  /// This function will logIn the current user with an appUserID.
  /// Typically this would be used after logging in a user to identify them without
  /// calling configure
  ///
  /// Returns a [LogInResult] object, or throws a [PlatformException] if there
  /// was a problem restoring transactions. LogInResult holds a PurchaserInfo object
  /// and a bool that can be used to know if a user has just been created for the first time.
  ///
  /// [newAppUserID] The appUserID that should be linked to the currently user
  static Future<LogInResult> logIn(String appUserID) async {
    Map<dynamic, dynamic> result =
        await _channel.invokeMethod('logIn', {'appUserID': appUserID});
    PurchaserInfo purchaserInfo =
        PurchaserInfo.fromJson(result["purchaserInfo"]);
    bool created = result["created"];

    return LogInResult(purchaserInfo: purchaserInfo, created: created);
  }

  /// Deprecated in favor of logIn.
  /// This function will identify the current user with an appUserID.
  /// Typically this would be used after a logout to identify a new user without
  /// calling configure
  ///
  /// Returns a [PurchaserInfo] object, or throws a [PlatformException] if there
  /// was a problem restoring transactions.
  ///
  /// [newAppUserID] The appUserID that should be linked to the currently user
  @Deprecated("Use logIn instead.")
  static Future<PurchaserInfo> identify(String appUserID) async {
    Map<dynamic, dynamic> result =
        await _channel.invokeMethod('identify', {'appUserID': appUserID});
    return PurchaserInfo.fromJson(result);
  }

  /// Logs out the  Purchases client, clearing the saved appUserID. This will
  /// generate a random user id and save it in the cache.
  ///
  /// Returns a [PurchaserInfo] object, or throws a [PlatformException] if there
  /// was a problem restoring transactions or if the method is called while the
  /// current user is anonymous.
  static Future<PurchaserInfo> logOut() async {
    Map<dynamic, dynamic> result = await _channel.invokeMethod('logOut');
    return PurchaserInfo.fromJson(result);
  }

  /// Deprecated in favor of logOut.
  /// Resets the Purchases client clearing the saved appUserID. This will
  /// generate a random user id and save it in the cache.
  ///
  /// Returns a [PurchaserInfo] object, or throws a [PlatformException] if there
  /// was a problem restoring transactions.
  @Deprecated("Use logOut instead.")
  static Future<PurchaserInfo> reset() async {
    Map<dynamic, dynamic> result = await _channel.invokeMethod('reset');
    return PurchaserInfo.fromJson(result);
  }

  /// Enables/Disables debugs logs
  static Future<void> setDebugLogsEnabled(bool enabled) async {
    return await _channel
        .invokeMethod('setDebugLogsEnabled', {'enabled': enabled});
  }

  ///
  /// iOS only. Set this property to true *only* when testing the ask-to-buy / SCA purchases flow.
  /// More information: http://errors.rev.cat/ask-to-buy
  ///
  static Future<void> setSimulatesAskToBuyInSandbox(bool enabled) async {
    return await _channel
        .invokeMethod('setSimulatesAskToBuyInSandbox', {'enabled': enabled});
  }

  ///
  /// Set this property to your proxy URL before configuring Purchases *only* if you've received a proxy key value from your RevenueCat contact.
  ///
  static Future<void> setProxyURL(String url) async {
    return await _channel
        .invokeMethod('setProxyURLString', {'proxyURLString': url});
  }

  /// Gets current purchaser info, which will normally be cached.
  static Future<PurchaserInfo> getPurchaserInfo() async {
    Map<dynamic, dynamic> result =
        await _channel.invokeMethod('getPurchaserInfo');
    return PurchaserInfo.fromJson(result);
  }

  ///  This method will send all the purchases to the RevenueCat backend.
  ///
  ///  **WARNING**: Call this when using your own implementation of in-app
  ///  purchases.
  ///
  ///  This method should be called anytime a sync is needed, like after a
  ///  successful purchase.
  static Future<void> syncPurchases() async {
    return await _channel.invokeMethod("syncPurchases");
  }

  /// iOS only. Enable automatic collection of Apple Search Ad attribution. Disabled by
  /// default
  static Future<void> setAutomaticAppleSearchAdsAttributionCollection(
      bool enabled) async {
    return await _channel.invokeMethod(
        'setAutomaticAppleSearchAdsAttributionCollection',
        {'enabled': enabled});
  }

  /// If the `appUserID` has been generated by RevenueCat
  static Future<bool> get isAnonymous async {
    return await _channel.invokeMethod('isAnonymous') as bool;
  }

  /// Returns `true` if RevenueCat has already been intialized through `setup()`.
  static Future<bool> get isConfigured async {
    return await _channel.invokeMethod('isConfigured') as bool;
  }

  /// iOS only. Computes whether or not a user is eligible for the introductory
  /// pricing period of a given product. You should use this method to determine
  /// whether or not you show the user the normal product price or the
  /// introductory price. This also applies to trials (trials are considered a
  /// type of introductory pricing).
  ///
  /// @note Subscription groups are automatically collected for determining
  /// eligibility. If RevenueCat can't definitively compute the eligibility,
  /// most likely because of missing group information, it will return
  /// `introEligibilityStatusUnknown`. The best course of action on unknown
  /// status is to display the non-intro pricing, to not create a misleading
  /// situation. To avoid this, make sure you are testing with the latest
  /// version of iOS so that the subscription group can be collected by the SDK.
  /// Android always returns introEligibilityStatusUnknown.
  ///
  /// [productIdentifiers] Array of product identifiers
  static Future<Map<String, IntroEligibility>>
      checkTrialOrIntroductoryPriceEligibility(
          List<String> productIdentifiers) async {
    Map<dynamic, dynamic> eligibilityMap = await _channel.invokeMethod(
        'checkTrialOrIntroductoryPriceEligibility',
        {'productIdentifiers': productIdentifiers});
    return eligibilityMap.map((key, value) =>
        MapEntry(key as String, IntroEligibility.fromJson(value)));
  }

  /// Invalidates the cache for purchaser information.
  ///
  /// Most apps will not need to use this method; invalidating the cache can leave your app in an invalid state.
  /// Refer to https://docs.revenuecat.com/docs/purchaserinfo#section-get-user-information for more information on
  /// using the cache properly.
  ///
  /// This is useful for cases where purchaser information might have been updated outside of the app, like if a
  /// promotional subscription is granted through the RevenueCat dashboard.
  static Future<void> invalidatePurchaserInfoCache() async {
    return await _channel.invokeMethod('invalidatePurchaserInfoCache');
  }

  /// iOS only. Presents a code redemption sheet, useful for redeeming offer codes
  /// Refer to https://docs.revenuecat.com/docs/ios-subscription-offers#offer-codes for more information on how
  /// to configure and use offer codes
  static Future<void> presentCodeRedemptionSheet() async {
    return await _channel.invokeMethod('presentCodeRedemptionSheet');
  }

  ///================================================================================
  /// Subscriber Attributes
  ///================================================================================

  /// Subscriber attributes are useful for storing additional, structured information on a user.
  /// Since attributes are writable using a public key they should not be used for
  /// managing secure or sensitive information such as subscription status, coins, etc.
  ///
  /// Key names starting with "$" are reserved names used by RevenueCat. For a full list of key
  /// restrictions refer to our guide: https://docs.revenuecat.com/docs/subscriber-attributes
  ///
  /// [attributes] Map of attributes by key. Set the value as an empty string to delete an attribute.
  static Future<void> setAttributes(Map<String, String> attributes) async {
    await _channel.invokeMethod('setAttributes', {'attributes': attributes});
  }

  /// Subscriber attribute associated with the email address for the user
  ///
  /// [email] Empty String or null will delete the subscriber attribute.
  static Future<void> setEmail(String email) async {
    await _channel.invokeMethod('setEmail', {'email': email});
  }

  /// Subscriber attribute associated with the phone number for the user
  ///
  /// [phoneNumber] Empty String or null will delete the subscriber attribute.
  static Future<void> setPhoneNumber(String phoneNumber) async {
    await _channel.invokeMethod('setPhoneNumber', {'phoneNumber': phoneNumber});
  }

  /// Subscriber attribute associated with the display name for the user
  ///
  /// [displayName] Empty String or null will delete the subscriber attribute.
  static Future<void> setDisplayName(String displayName) async {
    await _channel.invokeMethod('setDisplayName', {'displayName': displayName});
  }

  /// Subscriber attribute associated with the push token for the user
  ///
  /// [pushToken] Empty String or null will delete the subscriber attribute.
  static Future<void> setPushToken(String pushToken) async {
    await _channel.invokeMethod('setPushToken', {'pushToken': pushToken});
  }

  /// Subscriber attribute associated with the Adjust Id for the user
  /// Required for the RevenueCat Adjust integration
  ///
  /// [adjustID] Empty String or null will delete the subscriber attribute.
  static Future<void> setAdjustID(String adjustID) async {
    await _channel.invokeMethod('setAdjustID', {'adjustID': adjustID});
  }

  /// Subscriber attribute associated with the Appsflyer Id for the user
  /// Required for the RevenueCat Appsflyer integration
  ///
  /// [appsflyerID] Empty String or null will delete the subscriber attribute.
  static Future<void> setAppsflyerID(String appsflyerID) async {
    await _channel.invokeMethod('setAppsflyerID', {'appsflyerID': appsflyerID});
  }

  /// Subscriber attribute associated with the Facebook SDK Anonymous Id for the user
  /// Recommended for the RevenueCat Facebook integration
  ///
  /// [fbAnonymousID] Empty String or null will delete the subscriber attribute.
  static Future<void> setFBAnonymousID(String fbAnonymousID) async {
    await _channel
        .invokeMethod('setFBAnonymousID', {'fbAnonymousID': fbAnonymousID});
  }

  /// Subscriber attribute associated with the mParticle Id for the user
  /// Recommended for the RevenueCat mParticle integration
  ///
  /// [mparticleID] Empty String or null will delete the subscriber attribute.
  static Future<void> setMparticleID(String mparticleID) async {
    await _channel.invokeMethod('setMparticleID', {'mparticleID': mparticleID});
  }

  /// Subscriber attribute associated with the OneSignal Player Id for the user
  /// Required for the RevenueCat OneSignal integration
  ///
  /// [onesignalID] Empty String or null will delete the subscriber attribute.
  static Future<void> setOnesignalID(String onesignalID) async {
    await _channel.invokeMethod('setOnesignalID', {'onesignalID': onesignalID});
  }

  /// Subscriber attribute associated with the Airship Channel Id for the user
  /// Required for the RevenueCat Airship integration
  ///
  /// [airshipChannelID] Empty String or null will delete the subscriber attribute.
  static Future<void> setAirshipChannelID(String airshipChannelID) async {
    await _channel.invokeMethod(
        'setAirshipChannelID', {'airshipChannelID': airshipChannelID});
  }

  /// Subscriber attribute associated with the install media source for the user
  ///
  /// [mediaSource] Empty String or null will delete the subscriber attribute.
  static Future<void> setMediaSource(String mediaSource) async {
    await _channel.invokeMethod('setMediaSource', {'mediaSource': mediaSource});
  }

  /// Subscriber attribute associated with the install campaign for the user
  ///
  /// [campaign] Empty String or null will delete the subscriber attribute.
  static Future<void> setCampaign(String campaign) async {
    await _channel.invokeMethod('setCampaign', {'campaign': campaign});
  }

  /// Subscriber attribute associated with the install ad group for the user
  ///
  /// [adGroup] Empty String or null will delete the subscriber attribute.
  static Future<void> setAdGroup(String adGroup) async {
    await _channel.invokeMethod('setAdGroup', {'adGroup': adGroup});
  }

  ///
  /// Subscriber attribute associated with the install ad for the user
  ///
  /// [ad] Empty String or null will delete the subscriber attribute.
  static Future<void> setAd(String ad) async {
    await _channel.invokeMethod('setAd', {'ad': ad});
  }

  /// Subscriber attribute associated with the install keyword for the user
  ///
  /// [keyword] Empty String or null will delete the subscriber attribute.
  static Future<void> setKeyword(String keyword) async {
    await _channel.invokeMethod('setKeyword', {'keyword': keyword});
  }

  /// Subscriber attribute associated with the install ad creative for the user
  ///
  /// [creative] Empty String or null will delete the subscriber attribute.
  static Future<void> setCreative(String creative) async {
    await _channel.invokeMethod('setCreative', {'creative': creative});
  }

  /// Automatically collect subscriber attributes associated with the device identifiers
  /// $idfa, $idfv, $ip on iOS
  /// $gpsAdId, $androidId, $ip on Android
  static Future<void> collectDeviceIdentifiers() async {
    await _channel.invokeMethod('collectDeviceIdentifiers');
  }

  /// Check if billing is supported for the current user (meaning IN-APP
  /// purchases are supported) and optionally, whether a list of specified
  /// feature types are supported.
  ///
  /// Note: BillingFeatures are only relevant to Google Play users.
  /// For other stores, BillingFeatures won't be checked.
  /// [features] An optional  list of [BillingFeature]s to check for support.
  /// By default, is an empty list and no feature support will be checked.
  static Future<bool> canMakePayments(
      [List<BillingFeature> features = const []]) async {
    return await _channel.invokeMethod(
        'canMakePayments', {'features': features.map((e) => e.index).toList()});
  }

  /// iOS only. Use this function to retrieve the `PurchasesPaymentDiscount`
  /// for a given `PurchasesPackage`.
  ///
  /// Returns a [PaymentDiscount] object. Pass this object
  /// to [purchaseDiscountedProduct] or [purchaseDiscountedPackage] to complete
  /// the purchase. A null PaymentDiscount means
  ///
  /// [product] The `Product` the user intends to purchase.
  ///
  /// [discount] The `Discount` to apply to the product.
  static Future<PaymentDiscount> getPaymentDiscount(
      Product product, Discount discount) async {
    Map<dynamic, dynamic> result =
        await _channel.invokeMethod('getPaymentDiscount', {
      'productIdentifier': product.identifier,
      'discountIdentifier': discount.identifier
    });
    return PaymentDiscount.fromJson(result);
  }

  /// Android only. Call close when you are done with this instance of Purchases to disconnect
  /// from the billing services and clean up resources
  static Future<void> close() async {
    await _channel.invokeMethod('close');
  }
}

/// This class holds the information used when upgrading from another sku.
/// To be used with purchaseProduct and purchasePackage.
class UpgradeInfo {
  /// The oldSKU to upgrade from.
  String oldSKU;

  /// The [ProrationMode] to use when upgrading the given oldSKU.
  ProrationMode? prorationMode;

  /// Constructs an UpgradeInfo
  UpgradeInfo(this.oldSKU, {this.prorationMode});
}

/// Replace SKU's ProrationMode.
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

  /// Replacement takes effect when the old plan expires, and the new price will
  /// be charged at the same time.
  deferred
}

/// Supported SKU types.
enum PurchaseType {
  /// A type of SKU for in-app products.
  inapp,

  /// A type of SKU for subscriptions.
  subs
}

/// Billing Feature types
enum BillingFeature {
  /// [https://developer.android.com/reference/com/android/
  /// billingclient/api/BillingClient.FeatureType#SUBSCRIPTIONS]
  subscriptions,

  /// [https://developer.android.com/reference/com/android/
  /// billingclient/api/BillingClient.FeatureType#SUBSCRIPTIONS_UPDATE]
  subscriptionsUpdate,

  /// [https://developer.android.com/reference/com/android/
  /// billingclient/api/BillingClient.FeatureType#IN_APP_ITEMS_ON_VR]
  inAppItemsOnVr,

  /// [https://developer.android.com/reference/com/android/
  /// billingclient/api/BillingClient.FeatureType#SUBSCRIPTIONS_ON_VR]
  subscriptionsOnVr,

  /// [https://developer.android.com/reference/com/android/
  /// billingclient/api/BillingClient.FeatureType#PRICE_CHANGE_CONFIRMATION]
  priceChangeConfirmation
}

/// Supported Attribution networks.
enum PurchasesAttributionNetwork {
  /// [https://searchads.apple.com/]
  appleSearchAds,

  /// [https://www.adjust.com/]
  adjust,

  /// [https://www.appsflyer.com/]
  appsflyer,

  /// [http://branch.io/]
  branch,

  /// [http://tenjin.io/]
  tenjin,

  /// [https://developers.facebook.com/]
  facebook
}

/// Possible IntroEligibility status.
/// Use [checkTrialOrIntroductoryPriceEligibility] to determine the eligibility
enum IntroEligibilityStatus {
  /// RevenueCat doesn't have enough information to determine eligibility.
  introEligibilityStatusUnknown,

  /// The user is not eligible for a free trial or intro pricing for this product.
  introEligibilityStatusIneligible,

  /// The user is eligible for a free trial or intro pricing for this product.
  introEligibilityStatusEligible
}

/// Holds the introductory price status
class IntroEligibility {
  /// The introductory price eligibility status
  IntroEligibilityStatus status;

  /// Description of the status
  String description;

  /// Constructs an Transaction from a JSON object
  IntroEligibility.fromJson(Map<dynamic, dynamic> map)
      : status = IntroEligibilityStatus.values[map["status"]],
        description = map["description"];
}

/// Class used to hold the result of the logIn method
class LogInResult {
  /// true if the logged in user has been created in the
  /// RevenueCat backend for the first time
  final bool created;

  /// the purchaserInfo associated to the logged in user
  final PurchaserInfo purchaserInfo;

  /// Constructs a LogInResult with its properties
  LogInResult({required this.created, required this.purchaserInfo});
}
