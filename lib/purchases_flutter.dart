import 'dart:async';

import 'package:flutter/services.dart';

import 'object_wrappers.dart';
export 'object_wrappers.dart';

typedef void PurchaserInfoUpdateListener(PurchaserInfo purchaserInfo);

class Purchases {
  static final Set<PurchaserInfoUpdateListener> _purchaserInfoUpdateListeners =
      Set();

  static final _channel = new MethodChannel('purchases_flutter')
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
  static Future<void> setup(String apiKey,
      {String appUserId, bool observerMode = false}) async {
    if (appUserId == null) {
      return await _channel.invokeMethod('setupPurchases', {'apiKey': apiKey});
    } else {
      return await _channel.invokeMethod('setupPurchases', {
        'apiKey': apiKey,
        'appUserId': appUserId,
        'observerMode': observerMode
      });
    }
  }

  /// Set this to true if you are passing in an appUserID but it is anonymous.
  ///
  /// This is true by default if you didn't pass an appUserID.
  /// If a user tries to purchase a product that is active on the current app
  /// store account, we will treat it as a restore and alias the new ID with the
  /// previous id.
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

  /// Add a dict of attribution information
  ///
  /// [data] Attribution data from any of the [PurchasesAttributionNetwork].
  ///
  /// [network] Which network, see [PurchasesAttributionNetwork].
  ///
  /// [networkUserId] An optional unique id for identifying the user.
  static Future<void> addAttributionData(
      Map<String, Object> data, PurchasesAttributionNetwork network,
      {String networkUserId}) async {
    await _channel.invokeMethod('addAttributionData', {
      'data': data,
      'network': network.index,
      'networkUserId': networkUserId
    });
  }

  /// Gets the map of entitlements -> offerings -> products
  static Future<Map<String, Entitlement>> getEntitlements() async {
    Map<dynamic, dynamic> result =
        await _channel.invokeMethod('getEntitlements');
    return result.map((key, jsonValue) =>
        MapEntry<String, Entitlement>(key, Entitlement.fromJson(jsonValue)));
  }

  /// Fetch the product info. Returns a list of products or throws an error if
  /// the products are not properly configured in RevenueCat or if there is
  /// another error while retrieving them.
  ///
  /// [productIdentifiers] Array of product identifiers
  ///
  /// [type] Optional type of products to fetch, can be inapp or subs. Subs by default
  static Future<List<Product>> getProducts(List<String> productIdentifiers,
      {String type = "subs"}) async {
    List<dynamic> result = await _channel.invokeMethod('getProductInfo',
        {'productIdentifiers': productIdentifiers, 'type': type});
    return result.map((item) => Product.fromJson(item)).toList();
  }

  /// Makes a purchase. Returns a [PurchaserInfo] object. Throws an error if the
  /// purchase is unsuccessful. The error contains a userCancelled boolean
  /// inside the details map indicating if the user has cancelled the purchase.
  ///
  /// [productIdentifier] The product identifier of the product you want to
  /// purchase.
  ///
  /// [oldSKU] Android only. Optional sku you wish to upgrade from.
  ///
  /// [type] Android only. Optional type of product, can be inapp or subs. Subs by default.
  static Future<PurchaserInfo> makePurchase(String productIdentifier,
      {List<String> oldSKUs = const [], String type = "subs"}) async {
    return PurchaserInfo.fromJson(await _channel.invokeMethod('makePurchase', {
      'productIdentifier': productIdentifier,
      'oldSKUs': oldSKUs,
      'type': type
    }));
  }

  /// Restores a user's previous purchases and links their appUserIDs to any
  /// user's also using those purchases.
  ///
  /// Returns a [PurchaserInfo] object, or throws a [PlatformException] if there
  /// was a problem restoring transactions.
  static Future<PurchaserInfo> restoreTransactions() async {
    Map<dynamic, dynamic> result =
        await _channel.invokeMethod('restoreTransactions');
    return PurchaserInfo.fromJson(result);
  }

  /// Gets the current appUserID.
  static Future<String> get appUserID async {
    return await _channel.invokeMethod('getAppUserID') as String;
  }

  /// This function will alias two appUserIDs together.
  ///
  /// Returns a [PurchaserInfo] object, or throws a [PlatformException] if there
  /// was a problem restoring transactions.
  ///
  /// [newAppUserID] The new appUserID that should be linked to the currently
  /// identified appUserID.
  static Future<PurchaserInfo> createAlias(String newAppUserID) async {
    Map<dynamic, dynamic> result = await _channel
        .invokeMethod('createAlias', {'newAppUserID': newAppUserID});
    return PurchaserInfo.fromJson(result);
  }

  /// This function will identify the current user with an appUserID.
  /// Typically this would be used after a logout to identify a new user without
  /// calling configure
  ///
  /// Returns a [PurchaserInfo] object, or throws a [PlatformException] if there
  /// was a problem restoring transactions.
  ///
  /// [newAppUserID] The appUserID that should be linked to the currently user
  static Future<PurchaserInfo> identify(String appUserID) async {
    Map<dynamic, dynamic> result =
        await _channel.invokeMethod('identify', {'appUserID': appUserID});
    return PurchaserInfo.fromJson(result);
  }

  /// Resets the Purchases client clearing the saved appUserID. This will
  /// generate a random user id and save it in the cache.
  ///
  /// Returns a [PurchaserInfo] object, or throws a [PlatformException] if there
  /// was a problem restoring transactions.
  static Future<PurchaserInfo> reset() async {
    Map<dynamic, dynamic> result = await _channel.invokeMethod('reset');
    return PurchaserInfo.fromJson(result);
  }

  /// Enables/Disables debugs logs
  static Future<void> setDebugLogsEnabled(bool enabled) async {
    return await _channel
        .invokeMethod('setDebugLogsEnabled', {'enabled': enabled});
  }

  /// Gets current purchaser info, which will normally be cached.
  static Future<PurchaserInfo> getPurchaserInfo() async {
    Map<dynamic, dynamic> result =
        await _channel.invokeMethod('getPurchaserInfo');
    return PurchaserInfo.fromJson(result);
  }

  ///  This method will send all the purchases to the RevenueCat backend.
  ///
  ///  **WARNING**: Call this when using your own implementation of iaps.
  ///
  ///  This method should be called anytime a sync is needed, like after a
  ///  successful purchase.
  static Future<void> syncPurchases() async {
    return await _channel.invokeMethod("syncPurchases");
  }

  /// iOS only. Enable automatic collection of Apple Search Ad attribution. Disabled by
  /// default
  ///
  /// Deprecated in favor of setAutomaticAppleSearchAdsAttributionCollection.
  @Deprecated("use setAutomaticAppleSearchAdsAttributionCollection instead")
  static Future<void> setAutomaticAttributionCollection(bool enabled) async {
    return await _channel.invokeMethod(
        'setAutomaticAppleSearchAdsAttributionCollection',
        {'enabled': enabled});
  }

  /// iOS only. Enable automatic collection of Apple Search Ad attribution. Disabled by
  /// default
  static Future<void> setAutomaticAppleSearchAdsAttributionCollection(
      bool enabled) async {
    return await _channel.invokeMethod(
        'setAutomaticAppleSearchAdsAttributionCollection',
        {'enabled': enabled});
  }
}

enum PurchasesAttributionNetwork {
  appleSearchAds,
  adjust,
  appsflyer,
  branch,
  tenjin,
  facebook
}
