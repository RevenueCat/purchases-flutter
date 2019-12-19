import 'dart:async';

import 'package:flutter/foundation.dart';
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

  /// Deprecated in favor of getOfferings.
  @Deprecated("use getOfferings instead")
  static void getEntitlements() async {}

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
  /// [type] Optional type of products to fetch, can be PurchaseType.INAPP
  /// or PurchaseType.SUBS. Subs by default
  static Future<List<Product>> getProducts(List<String> productIdentifiers,
      {PurchaseType type = PurchaseType.subs}) async {
    List<dynamic> result = await _channel.invokeMethod('getProductInfo',
        {'productIdentifiers': productIdentifiers, 'type': describeEnum(type)});
    return result.map((item) => Product.fromJson(item)).toList();
  }

  @Deprecated("use purchaseProduct/purchasePackage instead")
  static Future<PurchaserInfo> makePurchase(String productIdentifier,
      {String oldSKU, String type = "subs"}) async {
    var purchaseType = PurchaseType.subs;
    if (type == "inapp") {
      purchaseType = PurchaseType.inapp;
    }
    return purchaseProduct(productIdentifier,
        upgradeInfo: new UpgradeInfo(oldSKU), type: purchaseType);
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
  /// [type] Android only. Optional type of product, can be PurchaseType.INAPP
  /// or PurchaseType.SUBS. Subs by default.
  static Future<PurchaserInfo> purchaseProduct(String productIdentifier,
      {UpgradeInfo upgradeInfo, PurchaseType type = PurchaseType.subs}) async {
    var response = await _channel.invokeMethod('purchaseProduct', {
      'productIdentifier': productIdentifier,
      'oldSKU': upgradeInfo != null ? upgradeInfo.oldSKU : null,
      'prorationMode': upgradeInfo != null && upgradeInfo.prorationMode != null
          ? upgradeInfo.prorationMode.index
          : null,
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
      {UpgradeInfo upgradeInfo}) async {
    var response = await _channel.invokeMethod('purchasePackage', {
      'packageIdentifier': packageToPurchase.identifier,
      'offeringIdentifier': packageToPurchase.offeringIdentifier,
      'oldSKU': upgradeInfo != null ? upgradeInfo.oldSKU : null,
      'prorationMode': upgradeInfo != null && upgradeInfo.prorationMode != null
          ? upgradeInfo.prorationMode.index
          : null
    });
    return PurchaserInfo.fromJson(response["purchaserInfo"]);
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
}

/// This class holds the information used when upgrading from another sku.
///
/// [oldSKU] The oldSKU to upgrade from.
/// [prorationMode] The [ProrationMode] to use when upgrading the given oldSKU.
class UpgradeInfo {
  String oldSKU;
  ProrationMode prorationMode;

  UpgradeInfo(this.oldSKU, {this.prorationMode});
}

/// Replace SKU's ProrationMode.
enum ProrationMode {
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

/// Supported Attribution networks.
enum PurchasesAttributionNetwork {
  appleSearchAds,
  adjust,
  appsflyer,
  branch,
  tenjin,
  facebook
}

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

  IntroEligibility.fromJson(Map<dynamic, dynamic> map)
      : status = IntroEligibilityStatus.values[map["status"]],
        description = map["description"];
}
