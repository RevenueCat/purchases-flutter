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

  static Future<void> setAllowSharingStoreAccount(bool allowSharing) async {
    await _channel.invokeMethod(
        'setAllowSharingStoreAccount', {'allowSharing': allowSharing});
  }

  static void addPurchaserInfoUpdateListener(
      PurchaserInfoUpdateListener purchaserInfoUpdateListener) async {
    _purchaserInfoUpdateListeners.add(purchaserInfoUpdateListener);
  }

  static void removePurchaserInfoUpdateListener(
      PurchaserInfoUpdateListener listenerToRemove) async {
    _purchaserInfoUpdateListeners.remove(listenerToRemove);
  }

  static Future<void> addAttributionData(
      Map<String, Object> data, PurchasesAttributionNetwork network,
      {String networkUserId}) async {
    await _channel.invokeMethod('addAttributionData',
        {'data': data, 'network': network.index, 'networkUserId': networkUserId});
  }

  static Future<Map<String, Entitlement>> getEntitlements() async {
    Map<dynamic, dynamic> result =
        await _channel.invokeMethod('getEntitlements');
    return result.map((key, jsonValue) =>
        MapEntry<String, Entitlement>(key, Entitlement.fromJson(jsonValue)));
  }

  static Future<List<Product>> getProducts(List<String> productIdentifiers,
      {String type = "subs"}) async {
    List<dynamic> result = await _channel.invokeMethod('getProductInfo',
        {'productIdentifiers': productIdentifiers, 'type': type});
    return result.map((item) => Product.fromJson(item)).toList();
  }

  static Future<SuccessfulPurchase> makePurchase(String productIdentifier,
      {List<String> oldSKUs = const [], String type = "subs"}) async {
    return SuccessfulPurchase.fromJson(await _channel.invokeMethod(
        'makePurchase', {
      'productIdentifier': productIdentifier,
      'oldSKUs': oldSKUs,
      'type': type
    }));
  }

  static Future<PurchaserInfo> restoreTransactions() async {
    Map<dynamic, dynamic> result =
        await _channel.invokeMethod('restoreTransactions');
    return PurchaserInfo.fromJson(result);
  }

  static Future<String> get appUserID async {
    return await _channel.invokeMethod('getAppUserID') as String;
  }

  static Future<PurchaserInfo> createAlias(String newAppUserID) async {
    Map<dynamic, dynamic> result = await _channel
        .invokeMethod('createAlias', {'newAppUserID': newAppUserID});
    return PurchaserInfo.fromJson(result);
  }

  static Future<PurchaserInfo> identify(String appUserID) async {
    Map<dynamic, dynamic> result =
        await _channel.invokeMethod('identify', {'appUserID': appUserID});
    return PurchaserInfo.fromJson(result);
  }

  static Future<PurchaserInfo> reset() async {
    Map<dynamic, dynamic> result = await _channel.invokeMethod('reset');
    return PurchaserInfo.fromJson(result);
  }

  static Future<void> setDebugLogsEnabled(bool enabled) async {
    return await _channel
        .invokeMethod('setDebugLogsEnabled', {'enabled': enabled});
  }

  static Future<PurchaserInfo> getPurchaserInfo() async {
    Map<dynamic, dynamic> result =
        await _channel.invokeMethod('getPurchaserInfo');
    return PurchaserInfo.fromJson(result);
  }

  static Future<void> syncPurchases() async {
    return await _channel.invokeMethod("syncPurchases");
  }

  static Future<void> setAutomaticAttributionCollection(bool enabled) async {
    return await _channel
        .invokeMethod('setAutomaticAttributionCollection', {'enabled': enabled});
  }
}

enum PurchasesAttributionNetwork {
  appleSearchAds,
  adjust,
  appsflyer,
  branch,
  tenjin
}

class SuccessfulPurchase {
  final PurchaserInfo purchaserInfo;
  final String productIdentifier;

  SuccessfulPurchase.fromJson(Map<dynamic, dynamic> map)
      : purchaserInfo = PurchaserInfo.fromJson(map["purchaserInfo"]),
        productIdentifier = map["productIdentifier"] as String;

  @override
  String toString() {
    return 'SuccessfulPurchase{purchaserInfo: $purchaserInfo, productIdentifier: $productIdentifier}';
  }
}
