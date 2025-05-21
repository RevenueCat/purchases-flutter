import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'object_wrappers.dart';

export 'object_wrappers.dart';

/// Used to handle async updates from [Purchases].
/// Should be implemented to receive updates when the [CustomerInfo] changes.
typedef CustomerInfoUpdateListener = void Function(
  CustomerInfo customerInfo,
);

/// iOS Only
/// Listener called when a user initiates a promoted in-app purchase from the App Store.
/// If your app is able to handle a purchase at the current time, run the startPurchase block in this method.
/// If the app is not in a state to make a purchase: cache the startPurchase block,
/// then call the startPurchase block when the app is ready to make the promoted purchase.
///
/// If the purchase should never be made, you don't need to ever call the block and
/// the plugin will not proceed with the promoted purchase.
///
/// This can be tested by opening a link like:
/// itms-services://?action=purchaseIntent&bundleId=<BUNDLE_ID>&productIdentifier=<SKPRODUCT_ID>
///
/// - Parameter productIdentifier: the productIdentifier associated with the promoted purchase
/// - Parameter startPurchase: call this block when the app is ready to handle the purchase
///
/// ### Related Articles:
/// - [Apple Documentation](https://rev.cat/testing-promoted-in-app-purchases)
typedef ReadyForPromotedProductPurchaseListener = void Function(
  String productIdentifier,
  Future<PromotedPurchaseResult> Function() startPurchase,
);

typedef LogHandler = void Function(
  LogLevel logLevel,
  String message,
);

/// Entry point for Purchases.
class Purchases {
  static final Set<CustomerInfoUpdateListener> _customerInfoUpdateListeners =
      {};

  static final Set<ReadyForPromotedProductPurchaseListener>
      _readyForPromotedProductPurchaseListeners = {};

  static CustomerInfo? _lastReceivedCustomerInfo;

  static LogHandler? _logHandler;

  static final _channel = const MethodChannel('purchases_flutter')
    ..setMethodCallHandler((call) async {
      switch (call.method) {
        case 'Purchases-CustomerInfoUpdated':
          final args = Map<String, dynamic>.from(call.arguments);
          final customerInfo = CustomerInfo.fromJson(args);
          _lastReceivedCustomerInfo = customerInfo;
          for (final listener in _customerInfoUpdateListeners) {
            listener(customerInfo);
          }
          break;
        case 'Purchases-ReadyForPromotedProductPurchase':
          for (final listener in _readyForPromotedProductPurchaseListeners) {
            final args = Map<String, dynamic>.from(call.arguments);
            final callbackID = args['callbackID'];
            final productIdentifier = args['productID'];
            listener(
              productIdentifier,
              () => _startPromotedProductPurchase(callbackID),
            );
          }
          break;
        case 'Purchases-LogHandlerEvent':
          handleLogHandlerEvent(call);
          break;
      }
    });

  /// Sets up Purchases with your API key and an app user id.
  ///
  /// [apiKey] RevenueCat API Key.
  ///
  /// [appUserID] An optional unique id for identifying the user.
  ///
  /// [purchasesAreCompletedBy] Set this to PurchasesAreCompletedByMyApp and provide a StoreKitVersion if you
  /// have your own IAP implementation and want to only use RevenueCat's backend.
  /// Defaults to PurchasesAreCompletedByRevenueCat.
  ///
  /// If you are on Android and setting this to PurchasesAreCompletedByMyApp, you will have to
  /// acknowledge the purchases yourself.
  /// If your app is only on Android, you may specify any StoreKitVersion,
  /// as it is ignored by the native Android SDK.
  ///
  /// [userDefaultsSuiteName] iOS-only, will be ignored for Android.
  /// Set this if you would like the RevenueCat SDK to store its preferences in a different
  /// NSUserDefaults suite, otherwise it will use standardUserDefaults.
  /// Default is null, which will make the SDK use standardUserDefaults.
  ///
  /// [useAmazon] Android only. Set this to true if you are building the app
  /// to be distributed in the Amazon Appstore

  /// [usesStoreKit2IfAvailable] iOS-only, will be ignored for Android.
  /// RevenueCat currently uses StoreKit 1 for purchases, as its stability in production scenarios has
  /// proven to be more performant than StoreKit 2.
  ///
  /// We're collecting more data on the best approach, but StoreKit 1 vs StoreKit 2 is an implementation detail
  /// that you shouldn't need to care about.
  ///
  /// Simply leave this parameter as default to let RevenueCat decide for you which StoreKit implementation to use.
  /// Set this to FALSE to disable StoreKit2.
  @Deprecated('Use PurchasesConfiguration')
  static Future<void> setup(
    String apiKey, {
    String? appUserId,
    PurchasesAreCompletedBy? purchasesAreCompletedBy,
    String? userDefaultsSuiteName,
    StoreKitVersion? storeKitVersion,
    bool useAmazon = false,
    bool usesStoreKit2IfAvailable = false,
  }) {
    final configuration = PurchasesConfiguration(apiKey)
      ..appUserID = appUserId
      ..purchasesAreCompletedBy =
          purchasesAreCompletedBy ?? const PurchasesAreCompletedByRevenueCat()
      ..userDefaultsSuiteName = userDefaultsSuiteName
      ..storeKitVersion = storeKitVersion ?? StoreKitVersion.defaultVersion
      ..store = useAmazon ? Store.amazon : null;

    _lastReceivedCustomerInfo = null;
    return configure(configuration);
  }

  /// Sets up Purchases with your API key and an app user id.
  ///
  /// [PurchasesConfiguration] Object containing configuration parameters
  static Future<void> configure(
    PurchasesConfiguration purchasesConfiguration,
  ) async {
    var purchasesCompletedByToUse = PurchasesAreCompletedByType.revenueCat;
    var storeKitVersionToUse = purchasesConfiguration.storeKitVersion ??
        StoreKitVersion.defaultVersion;

    if (purchasesConfiguration.purchasesAreCompletedBy
        is PurchasesAreCompletedByMyApp) {
      purchasesCompletedByToUse = PurchasesAreCompletedByType.myApp;
      storeKitVersionToUse = (purchasesConfiguration.purchasesAreCompletedBy
              as PurchasesAreCompletedByMyApp)
          .storeKitVersion;

      if (purchasesConfiguration.storeKitVersion != null &&
          purchasesConfiguration.storeKitVersion !=
              StoreKitVersion.defaultVersion &&
          storeKitVersionToUse != purchasesConfiguration.storeKitVersion) {
        debugPrint(
            'Warning: The storeKitVersion in purchasesAreCompletedBy does not match the '
            'function\'s storeKitVersion parameter. We will use the value found in purchasesAreCompletedBy.');
      }

      if (storeKitVersionToUse == StoreKitVersion.defaultVersion) {
        debugPrint(
            'Warning: You should provide the specific StoreKit version you\'re using in '
            'your implementation when configuring PurchasesAreCompletedByMyApp, '
            'and not rely on the DEFAULT.');
      }
    }

    await _channel.invokeMethod(
      'setupPurchases',
      {
        'apiKey': purchasesConfiguration.apiKey,
        'appUserId': purchasesConfiguration.appUserID,
        'purchasesAreCompletedBy': purchasesCompletedByToUse.name,
        'userDefaultsSuiteName': purchasesConfiguration.userDefaultsSuiteName,
        'storeKitVersion': storeKitVersionToUse.name,
        'useAmazon': purchasesConfiguration.store == Store.amazon,
        'shouldShowInAppMessagesAutomatically':
            purchasesConfiguration.shouldShowInAppMessagesAutomatically,
        'entitlementVerificationMode':
            purchasesConfiguration.entitlementVerificationMode.name,
        'pendingTransactionsForPrepaidPlansEnabled':
            purchasesConfiguration.pendingTransactionsForPrepaidPlansEnabled,
      },
    );
  }

  /// Deprecated. Configure behavior through the RevenueCat dashboard instead.
  /// Set this to true if you are passing in an appUserID but it is anonymous.
  ///
  /// If you have configured the Legacy restore behavior in the RevenueCat
  /// dashboard and are currently setting this to true,
  /// keep this setting active.
  ///
  /// This is true by default if you didn't pass an appUserID.
  /// If a user tries to purchase a product that is active on the current app
  /// store account, we will treat it as a restore and alias the new ID with the
  /// previous id.
  @Deprecated('Configure behavior through the RevenueCat dashboard instead.')
  static Future<void> setAllowSharingStoreAccount(bool allowSharing) =>
      _channel.invokeMethod(
        'setAllowSharingStoreAccount',
        {
          'allowSharing': allowSharing,
        },
      );

  /// Sets a function to be called on updated customer info.
  ///
  /// The function is called right away with the latest customer info as soon
  /// as it's set.
  ///
  /// [customerInfoUpdateListener] CustomerInfo update listener.
  static void addCustomerInfoUpdateListener(
    CustomerInfoUpdateListener customerInfoUpdateListener,
  ) {
    _customerInfoUpdateListeners.add(customerInfoUpdateListener);
    final lastReceivedCustomerInfo = _lastReceivedCustomerInfo;
    if (lastReceivedCustomerInfo != null) {
      customerInfoUpdateListener(lastReceivedCustomerInfo);
    }
  }

  /// Removes a given CustomerInfoUpdateListener
  ///
  /// [listenerToRemove] CustomerInfoUpdateListener reference of the listener to remove.
  static void removeCustomerInfoUpdateListener(
    CustomerInfoUpdateListener listenerToRemove,
  ) =>
      _customerInfoUpdateListeners.remove(listenerToRemove);

  /// iOS only
  /// Sets a listener to be called when a user initiates a promoted in-app
  /// purchase from the App Store.
  ///
  /// [listener] ReadyForPromotedProductPurchaseListener to be added
  static void addReadyForPromotedProductPurchaseListener(
    ReadyForPromotedProductPurchaseListener listener,
  ) {
    _readyForPromotedProductPurchaseListeners.add(listener);
  }

  /// iOS only
  /// Removes a given ReadyForPromotedProductPurchaseListener
  ///
  /// [listener] ReadyForPromotedProductPurchaseListener to be removed
  static void removeReadyForPromotedProductPurchaseListener(
    ReadyForPromotedProductPurchaseListener listenerToRemove,
  ) =>
      _readyForPromotedProductPurchaseListeners.remove(listenerToRemove);

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
    final res = await _channel.invokeMethod('getOfferings');
    return Offerings.fromJson(
      Map<String, dynamic>.from(res),
    );
  }

  /// Retrieves a current offering for a placement identifier, use this to access offerings defined by targeting
  /// placements configured in the RevenueCat dashboard.
  static Future<Offering?> getCurrentOfferingForPlacement(
    String placementIdentifier,
  ) async {
    final res = await _channel.invokeMethod(
      'getCurrentOfferingForPlacement',
      {'placementIdentifier': placementIdentifier},
    );
    if (res != null) {
      return Offering.fromJson(
        Map<String, dynamic>.from(res),
      );
    } else {
      return null;
    }
  }

  /// Syncs subscriber attributes and then fetches the configured offerings for this user. This method is intended to
  /// be called when using Targeting Rules with Custom Attributes. Any subscriber attributes should be set before
  /// calling this method to ensure the returned offerings are applied with the latest subscriber attributes.
  static Future<Offerings> syncAttributesAndOfferingsIfNeeded() async {
    final res =
        await _channel.invokeMethod('syncAttributesAndOfferingsIfNeeded');
    return Offerings.fromJson(
      Map<String, dynamic>.from(res),
    );
  }

  /// Fetch the product info. Returns a list of products or throws an error if
  /// the products are not properly configured in RevenueCat or if there is
  /// another error while retrieving them.
  ///
  /// [productIdentifiers] Array of product identifiers
  ///
  /// [productCategory] If the products are Android INAPPs, this needs to be
  /// ProductCategory.nonSubscription otherwise the products won't be found.
  /// ProductCategory.subscription by default.
  /// This parameter only has effect in Android.
  ///
  /// [type] If the products are Android INAPPs, this needs to be
  /// PurchaseType.inapp otherwise the products won't be found.
  /// PurchaseType.subs by default. This parameter only has effect in Android.
  static Future<List<StoreProduct>> getProducts(
    List<String> productIdentifiers, {
    ProductCategory productCategory = ProductCategory.subscription,
    @Deprecated('Use ProductType') PurchaseType type = PurchaseType.subs,
  }) async {
    // Use deprecated PurchasesType if using something other than default
    // Otherwise use new ProductType
    String typeString;
    // ignore: deprecated_member_use_from_same_package
    if (type != PurchaseType.subs) {
      typeString = type.name;
    } else {
      typeString = productCategory.name;
    }

    final List<dynamic> result = await _channel.invokeMethod('getProductInfo', {
      'productIdentifiers': productIdentifiers,
      'type': typeString,
    });
    return result
        .map<StoreProduct>(
          (item) => StoreProduct.fromJson(
            Map<String, dynamic>.from(item),
          ),
        )
        .toList();
  }

  /// It is now recommended to use [Purchases.purchaseStoreProduct]
  /// to make a purchase with a [StoreProduct] if you can.
  ///
  /// Makes a purchase. Returns a [CustomerInfo] object. Throws a
  /// [PlatformException] if the purchase is unsuccessful.
  /// Check if [PurchasesErrorHelper.getErrorCode] is
  /// [PurchasesErrorCode.purchaseCancelledError] to check if the user cancelled
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
  @Deprecated('Use purchaseStoreProduct')
  static Future<CustomerInfo> purchaseProduct(
    String productIdentifier, {
    UpgradeInfo? upgradeInfo,
    PurchaseType type = PurchaseType.subs,
  }) async {
    final prorationMode = upgradeInfo?.prorationMode;
    final customerInfo = await _invokeReturningCustomerInfo('purchaseProduct', {
      'productIdentifier': productIdentifier,
      'type': type.name,
      'googleOldProductIdentifier': upgradeInfo?.oldSKU,
      'googleProrationMode': prorationMode?.value,
      'googleIsPersonalizedPrice': null,
      'presentedOfferingIdentifier': null,
    });
    return customerInfo;
  }

  /// Makes a purchase. Returns a [CustomerInfo] object. Throws a
  /// [PlatformException] if the purchase is unsuccessful.
  /// Check if [PurchasesErrorHelper.getErrorCode] is
  /// [PurchasesErrorCode.purchaseCancelledError] to check if the user cancelled
  /// the purchase.
  ///
  /// [storeProduct] The [StoreProduct] you want to purchase.
  ///
  /// [googleProductChangeInfo] Android and Google Play only. Optional GoogleProductChangeInfo you wish to
  /// change from containing the googleOldProductIdentifer and the
  /// optional prorationMode.
  ///
  /// [googleIsPersonalizedPrice] Android and Google Play only. Optional isPersonalizedPrice indicates
  /// personalized pricing on products available for purchase in the EU.
  /// For compliance with EU regulations. User will see "This price has been
  /// customize for you" in the purchase dialog when true.
  /// See https://developer.android.com/google/play/billing/integrate#personalized-price
  /// for more info.
  static Future<CustomerInfo> purchaseStoreProduct(
    StoreProduct storeProduct, {
    GoogleProductChangeInfo? googleProductChangeInfo,
    bool? googleIsPersonalizedPrice,
  }) async {
    final prorationMode = googleProductChangeInfo?.prorationMode?.value;
    final customerInfo = await _invokeReturningCustomerInfo('purchaseProduct', {
      'productIdentifier': storeProduct.identifier,
      'type': storeProduct.productCategory?.name,
      'googleOldProductIdentifier':
          googleProductChangeInfo?.oldProductIdentifier,
      'googleProrationMode': prorationMode,
      'googleIsPersonalizedPrice': googleIsPersonalizedPrice,
      'presentedOfferingIdentifier':
          storeProduct.presentedOfferingContext?.offeringIdentifier,
    });

    return customerInfo;
  }

  /// Makes a purchase. Returns a [CustomerInfo] object. Throws a
  /// [PlatformException] if the purchase is unsuccessful.
  /// Check if [PurchasesErrorHelper.getErrorCode] is
  /// [PurchasesErrorCode.purchaseCancelledError] to check if the user cancelled
  /// the purchase.
  ///
  /// [packageToPurchase] The Package you wish to purchase
  ///
  /// [upgradeInfo] Android and Google Play only. Optional UpgradeInfo you wish to upgrade from
  /// containing the oldSKU and the optional prorationMode.
  ///
  /// [googleProductChangeInfo] Android and Google Play only. Optional GoogleProductChangeInfo you wish to
  /// change from containing the googleOldProductIdentifer and the
  /// optional prorationMode.
  ///
  /// [googleIsPersonalizedPrice] Android and Google Play only. Optional isPersonalizedPrice indicates
  /// personalized pricing on products available for purchase in the EU.
  /// For compliance with EU regulations. User will see "This price has been
  /// customize for you" in the purchase dialog when true.
  /// See https://developer.android.com/google/play/billing/integrate#personalized-price
  /// for more info.
  static Future<CustomerInfo> purchasePackage(
    Package packageToPurchase, {
    @Deprecated('Use GoogleProductChangeInfo') UpgradeInfo? upgradeInfo,
    GoogleProductChangeInfo? googleProductChangeInfo,
    bool? googleIsPersonalizedPrice,
  }) async {
    final prorationMode = googleProductChangeInfo?.prorationMode?.value ??
        upgradeInfo?.prorationMode?.value;
    final customerInfo = await _invokeReturningCustomerInfo('purchasePackage', {
      'packageIdentifier': packageToPurchase.identifier,
      'presentedOfferingContext':
          packageToPurchase.presentedOfferingContext.toJson(),
      'googleOldProductIdentifier':
          googleProductChangeInfo?.oldProductIdentifier ?? upgradeInfo?.oldSKU,
      'googleProrationMode': prorationMode,
      'googleIsPersonalizedPrice': googleIsPersonalizedPrice,
    });
    return customerInfo;
  }

  /// Google Play only.
  ///
  /// Makes a purchase. Returns a [CustomerInfo] object. Throws a
  /// [PlatformException] if the purchase is unsuccessful.
  /// Check if [PurchasesErrorHelper.getErrorCode] is
  /// [PurchasesErrorCode.purchaseCancelledError] to check if the user cancelled
  /// the purchase.
  ///
  /// [subscriptionOption] The [SubscriptionOption] you wish to purchase
  ///
  /// [googleProductChangeInfo] Android and Google Play only. Optional [GoogleProductChangeInfo] you wish to
  /// change from containing the googleOldProductIdentifer and the
  /// optional prorationMode.
  ///
  /// [googleIsPersonalizedPrice] Android and Google Play only. Optional boolean indicates
  /// personalized pricing on products available for purchase in the EU.
  /// For compliance with EU regulations. User will see "This price has been
  /// customize for you" in the purchase dialog when true.
  /// See https://developer.android.com/google/play/billing/integrate#personalized-price
  /// for more info.
  static Future<CustomerInfo> purchaseSubscriptionOption(
    SubscriptionOption subscriptionOption, {
    GoogleProductChangeInfo? googleProductChangeInfo,
    bool? googleIsPersonalizedPrice,
  }) async {
    if (defaultTargetPlatform != TargetPlatform.android) {
      throw UnsupportedPlatformException();
    }

    final prorationMode = googleProductChangeInfo?.prorationMode?.value;

    final customerInfo =
        await _invokeReturningCustomerInfo('purchaseSubscriptionOption', {
      'productIdentifier': subscriptionOption.productId,
      'optionIdentifier': subscriptionOption.id,
      'googleOldProductIdentifier':
          googleProductChangeInfo?.oldProductIdentifier,
      'googleProrationMode': prorationMode,
      'googleIsPersonalizedPrice': googleIsPersonalizedPrice,
      'presentedOfferingIdentifier':
          subscriptionOption.presentedOfferingContext?.offeringIdentifier,
    });
    return customerInfo;
  }

  /// iOS only. Purchase a product applying a given promotional offer.
  ///
  /// Returns a [CustomerInfo] object. Throws a
  /// [PlatformException] if the purchase is unsuccessful.
  /// Check if [PurchasesErrorHelper.getErrorCode] is
  /// [PurchasesErrorCode.purchaseCancelledError] to check if the user cancelled
  /// the purchase.
  ///
  /// [storeProduct] The product to purchase.
  ///
  /// [promotionalOffer] Promotional offer that will be applied to the product.
  /// Retrieve this offer using [getPromotionalOffer].
  static Future<CustomerInfo> purchaseDiscountedProduct(
    StoreProduct product,
    PromotionalOffer promotionalOffer,
  ) async {
    final customerInfo = await _invokeReturningCustomerInfo('purchaseProduct', {
      'productIdentifier': product.identifier,
      'signedDiscountTimestamp': promotionalOffer.timestamp.toString(),
      'presentedOfferingIdentifier':
          product.presentedOfferingContext?.offeringIdentifier,
    });
    return customerInfo;
  }

  /// iOS only. Purchase a package applying a given promotional offer.
  ///
  /// Returns a [CustomerInfo] object. Throws a
  /// [PlatformException] if the purchase is unsuccessful.
  /// Check if [PurchasesErrorHelper.getErrorCode] is
  /// [PurchasesErrorCode.purchaseCancelledError] to check if the user cancelled
  /// the purchase.
  ///
  /// [packageToPurchase] The Package you wish to purchase
  ///
  /// [promotionalOffer] Promotional offer that will be applied to the product.
  /// Retrieve this offer using [getPromotionalOffer].
  static Future<CustomerInfo> purchaseDiscountedPackage(
    Package packageToPurchase,
    PromotionalOffer promotionalOffer,
  ) async {
    final customerInfo = await _invokeReturningCustomerInfo('purchasePackage', {
      'packageIdentifier': packageToPurchase.identifier,
      'presentedOfferingContext':
          packageToPurchase.presentedOfferingContext.toJson(),
      'signedDiscountTimestamp': promotionalOffer.timestamp.toString(),
    });
    return customerInfo;
  }

  /// Restores a user's previous purchases and links their appUserIDs to any
  /// user's also using those purchases.
  ///
  /// Returns a [CustomerInfo] object, or throws a [PlatformException] if there
  /// was a problem restoring transactions.
  static Future<CustomerInfo> restorePurchases() async {
    final result = await _channel.invokeMethod('restorePurchases');
    return CustomerInfo.fromJson(Map<String, dynamic>.from(result));
  }

  /// Gets the current appUserID.
  static Future<String> get appUserID async =>
      await _channel.invokeMethod('getAppUserID') as String;

  /// Gets the current storefront for the store account.
  static Future<Storefront?> get storefront async {
    final storefrontJson = await _channel.invokeMethod('getStorefront');
    if (storefrontJson == null) {
      return null;
    }
    return Storefront.fromJson(Map<String, dynamic>.from(storefrontJson));
  }

  /// This function will logIn the current user with an appUserID.
  /// Typically this would be used after logging in a user to identify them without
  /// calling configure
  ///
  /// Returns a [LogInResult] object, or throws a [PlatformException] if there
  /// was a problem restoring transactions. LogInResult holds a [CustomerInfo] object
  /// and a bool that can be used to know if a user has just been created for the first time.
  ///
  /// [newAppUserID] The appUserID that should be linked to the currently user
  static Future<LogInResult> logIn(String appUserID) async {
    final result =
        await _channel.invokeMethod('logIn', {'appUserID': appUserID});
    final customerInfo = CustomerInfo.fromJson(
      Map<String, dynamic>.from(result['customerInfo']),
    );
    final bool created = result['created'];

    return LogInResult(customerInfo: customerInfo, created: created);
  }

  /// Logs out the  Purchases client, clearing the saved appUserID. This will
  /// generate a random user id and save it in the cache.
  ///
  /// Returns a [CustomerInfo] object, or throws a [PlatformException] if there
  /// was a problem restoring transactions or if the method is called while the
  /// current user is anonymous.
  static Future<CustomerInfo> logOut() async {
    final result = await _channel.invokeMethod('logOut');
    return CustomerInfo.fromJson(Map<String, dynamic>.from(result));
  }

  /// Enables/Disables debugs logs
  @Deprecated('Use setLogLevel')
  static Future<void> setDebugLogsEnabled(bool enabled) =>
      _channel.invokeMethod('setDebugLogsEnabled', {'enabled': enabled});

  /// Configures log level
  /// Used to set the log level. Useful for debugging issues with the lovely team @RevenueCat.
  /// The default is {LOG_LEVEL.INFO} in release builds and {LOG_LEVEL.DEBUG} in debug builds.
  static Future<void> setLogLevel(LogLevel level) => _channel.invokeMethod(
        'setLogLevel',
        {'level': level.name.toUpperCase()},
      );

  ///
  /// iOS only. Set this property to true *only* when testing the ask-to-buy / SCA purchases flow.
  /// More information: http://errors.rev.cat/ask-to-buy
  ///
  static Future<void> setSimulatesAskToBuyInSandbox(bool enabled) => _channel
      .invokeMethod('setSimulatesAskToBuyInSandbox', {'enabled': enabled});

  ///
  /// Set this property to your proxy URL before configuring Purchases *only* if you've received a proxy key value from your RevenueCat contact.
  ///
  static Future<void> setProxyURL(String url) =>
      _channel.invokeMethod('setProxyURLString', {'proxyURLString': url});

  /// Gets current customer info, which will normally be cached.
  static Future<CustomerInfo> getCustomerInfo() async {
    final result = await _channel.invokeMethod('getCustomerInfo');
    return CustomerInfo.fromJson(Map<String, dynamic>.from(result));
  }

  ///  This method will send all the purchases to the RevenueCat backend.
  ///
  ///  **WARNING**: Call this when using your own implementation of in-app
  ///  purchases.
  ///
  ///  This method should be called anytime a sync is needed, like after a
  ///  successful purchase.
  static Future<void> syncPurchases() => _channel.invokeMethod('syncPurchases');

  /// iOS only. Enable automatic collection of Apple Search Ad attribution. Disabled by
  /// default
  static Future<void> enableAdServicesAttributionTokenCollection() =>
      _channel.invokeMethod('enableAdServicesAttributionTokenCollection');

  /// If the [appUserID] has been generated by RevenueCat
  static Future<bool> get isAnonymous async =>
      await _channel.invokeMethod('isAnonymous') as bool;

  /// Returns true if RevenueCat has already been intialized through [configure].
  static Future<bool> get isConfigured async =>
      await _channel.invokeMethod('isConfigured') as bool;

  /// iOS only. Computes whether or not a user is eligible for the introductory
  /// pricing period of a given product. You should use this method to determine
  /// whether or not you show the user the normal product price or the
  /// introductory price. This also applies to trials (trials are considered a
  /// type of introductory pricing).
  ///
  /// @note Subscription groups are automatically collected for determining
  /// eligibility. If RevenueCat can't definitively compute the eligibility,
  /// most likely because of missing group information, it will return
  /// [IntroEligibilityStatus.introEligibilityStatusUnknown].
  /// The best course of action on unknown status is to display the non-intro
  /// pricing, to not create a misleading situation.
  /// To avoid this, make sure you are testing with the latest
  /// version of iOS so that the subscription group can be collected by the SDK.
  /// Android always returns introEligibilityStatusUnknown.
  ///
  /// [productIdentifiers] Array of product identifiers
  static Future<Map<String, IntroEligibility>>
      checkTrialOrIntroductoryPriceEligibility(
    List<String> productIdentifiers,
  ) async {
    final eligibilityMap = await _channel
        .invokeMethod('checkTrialOrIntroductoryPriceEligibility', {
      'productIdentifiers': productIdentifiers,
    });
    return Map<String, IntroEligibility>.from(
      eligibilityMap.map(
        (key, value) => MapEntry(
          key,
          IntroEligibility.fromJson(Map<String, dynamic>.from(value)),
        ),
      ),
    );
  }

  /// Invalidates the cache for customer information.
  ///
  /// Most apps will not need to use this method; invalidating the cache can leave your app in an invalid state.
  /// Refer to https://docs.revenuecat.com/docs/purchaserinfo#section-get-user-information for more information on
  /// using the cache properly.
  ///
  /// This is useful for cases where purchaser information might have been updated outside of the app, like if a
  /// promotional subscription is granted through the RevenueCat dashboard.
  static Future<void> invalidateCustomerInfoCache() =>
      _channel.invokeMethod('invalidateCustomerInfoCache');

  /// iOS only. Presents a code redemption sheet, useful for redeeming offer codes
  /// Refer to https://docs.revenuecat.com/docs/ios-subscription-offers#offer-codes for more information on how
  /// to configure and use offer codes
  static Future<void> presentCodeRedemptionSheet() =>
      _channel.invokeMethod('presentCodeRedemptionSheet');

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
  static Future<void> setAttributes(Map<String, String> attributes) =>
      _channel.invokeMethod('setAttributes', {'attributes': attributes});

  /// Subscriber attribute associated with the email address for the user
  ///
  /// [email] Empty String or null will delete the subscriber attribute.
  static Future<void> setEmail(String email) =>
      _channel.invokeMethod('setEmail', {'email': email});

  /// Subscriber attribute associated with the phone number for the user
  ///
  /// [phoneNumber] Empty String or null will delete the subscriber attribute.
  static Future<void> setPhoneNumber(String phoneNumber) =>
      _channel.invokeMethod('setPhoneNumber', {'phoneNumber': phoneNumber});

  /// Subscriber attribute associated with the display name for the user
  ///
  /// [displayName] Empty String or null will delete the subscriber attribute.
  static Future<void> setDisplayName(String displayName) =>
      _channel.invokeMethod('setDisplayName', {'displayName': displayName});

  /// Subscriber attribute associated with the push token for the user
  ///
  /// [pushToken] Empty String or null will delete the subscriber attribute.
  static Future<void> setPushToken(String pushToken) =>
      _channel.invokeMethod('setPushToken', {'pushToken': pushToken});

  /// Subscriber attribute associated with the Adjust Id for the user
  /// Required for the RevenueCat Adjust integration
  ///
  /// [adjustID] Empty String or null will delete the subscriber attribute.
  static Future<void> setAdjustID(String adjustID) =>
      _channel.invokeMethod('setAdjustID', {'adjustID': adjustID});

  /// Subscriber attribute associated with the Appsflyer Id for the user
  /// Required for the RevenueCat Appsflyer integration
  ///
  /// [appsflyerID] Empty String or null will delete the subscriber attribute.
  static Future<void> setAppsflyerID(String appsflyerID) =>
      _channel.invokeMethod('setAppsflyerID', {'appsflyerID': appsflyerID});

  /// Subscriber attribute associated with the Facebook SDK Anonymous Id for the user
  /// Recommended for the RevenueCat Facebook integration
  ///
  /// [fbAnonymousID] Empty String or null will delete the subscriber attribute.
  static Future<void> setFBAnonymousID(String fbAnonymousID) => _channel
      .invokeMethod('setFBAnonymousID', {'fbAnonymousID': fbAnonymousID});

  /// Subscriber attribute associated with the mParticle Id for the user
  /// Recommended for the RevenueCat mParticle integration
  ///
  /// [mparticleID] Empty String or null will delete the subscriber attribute.
  static Future<void> setMparticleID(String mparticleID) =>
      _channel.invokeMethod('setMparticleID', {'mparticleID': mparticleID});

  /// Subscriber attribute associated with the Clever Tap Id for the user
  /// Required for the RevenueCat CleverTap integration
  ///
  /// [cleverTapID] Empty String or null will delete the subscriber attribute.
  static Future<void> setCleverTapID(String cleverTapID) =>
      _channel.invokeMethod('setCleverTapID', {'cleverTapID': cleverTapID});

  /// Subscriber attribute associated with the Mixpanel Distinct Id for the user
  /// Required for the RevenueCat MixPanel integration
  ///
  /// [mixpanelDistinctID] Empty String or null will delete the subscriber attribute.
  static Future<void> setMixpanelDistinctID(String mixpanelDistinctID) =>
      _channel.invokeMethod(
        'setMixpanelDistinctID',
        {'mixpanelDistinctID': mixpanelDistinctID},
      );

  /// Subscriber attribute associated with the Firebase Instance Id for the user
  /// Required for the RevenueCat Firebase integration
  ///
  /// [firebaseAppInstanceId] Empty String or null will delete the subscriber attribute.
  static Future<void> setFirebaseAppInstanceId(String firebaseAppInstanceId) =>
      _channel.invokeMethod(
        'setFirebaseAppInstanceID',
        {'firebaseAppInstanceID': firebaseAppInstanceId},
      );

  /// Subscriber attribute associated with the Tenjin Installation ID for the user
  /// Required for the RevenueCat Tenjin integration
  ///
  /// [tenjinAnalyticsInstallationID] Empty String or null will delete the subscriber attribute.
  static Future<void> setTenjinAnalyticsInstallationID(String tenjinAnalyticsInstallationID) =>
      _channel.invokeMethod(
        'setTenjinAnalyticsInstallationID',
        {'tenjinAnalyticsInstallationID': tenjinAnalyticsInstallationID},
      );

  /// Subscriber attribute associated with the OneSignal Player Id for the user
  /// Required for the RevenueCat OneSignal integration
  ///
  /// [onesignalID] Empty String or null will delete the subscriber attribute.
  static Future<void> setOnesignalID(String onesignalID) =>
      _channel.invokeMethod('setOnesignalID', {'onesignalID': onesignalID});

  /// Subscriber attribute associated with the Airship Channel Id for the user
  /// Required for the RevenueCat Airship integration
  ///
  /// [airshipChannelID] Empty String or null will delete the subscriber attribute.
  static Future<void> setAirshipChannelID(String airshipChannelID) async {
    await _channel.invokeMethod(
      'setAirshipChannelID',
      {'airshipChannelID': airshipChannelID},
    );
  }

  /// Subscriber attribute associated with the install media source for the user
  ///
  /// [mediaSource] Empty String or null will delete the subscriber attribute.
  static Future<void> setMediaSource(String mediaSource) =>
      _channel.invokeMethod('setMediaSource', {'mediaSource': mediaSource});

  /// Subscriber attribute associated with the install campaign for the user
  ///
  /// [campaign] Empty String or null will delete the subscriber attribute.
  static Future<void> setCampaign(String campaign) =>
      _channel.invokeMethod('setCampaign', {'campaign': campaign});

  /// Subscriber attribute associated with the install ad group for the user
  ///
  /// [adGroup] Empty String or null will delete the subscriber attribute.
  static Future<void> setAdGroup(String adGroup) =>
      _channel.invokeMethod('setAdGroup', {'adGroup': adGroup});

  ///
  /// Subscriber attribute associated with the install ad for the user
  ///
  /// [ad] Empty String or null will delete the subscriber attribute.
  static Future<void> setAd(String ad) =>
      _channel.invokeMethod('setAd', {'ad': ad});

  /// Subscriber attribute associated with the install keyword for the user
  ///
  /// [keyword] Empty String or null will delete the subscriber attribute.
  static Future<void> setKeyword(String keyword) =>
      _channel.invokeMethod('setKeyword', {'keyword': keyword});

  /// Subscriber attribute associated with the install ad creative for the user
  ///
  /// [creative] Empty String or null will delete the subscriber attribute.
  static Future<void> setCreative(String creative) =>
      _channel.invokeMethod('setCreative', {'creative': creative});

  /// Automatically collect subscriber attributes associated with the device identifiers
  /// $idfa, $idfv, $ip on iOS
  /// $gpsAdId, $androidId, $ip on Android
  static Future<void> collectDeviceIdentifiers() =>
      _channel.invokeMethod('collectDeviceIdentifiers');

  /// Check if billing is supported for the current user (meaning IN-APP
  /// purchases are supported) and optionally, whether a list of specified
  /// feature types are supported.
  ///
  /// Note: BillingFeatures are only relevant to Google Play users.
  /// For other stores, BillingFeatures won't be checked.
  /// [features] An optional  list of [BillingFeature]s to check for support.
  /// By default, is an empty list and no feature support will be checked.
  static Future<bool> canMakePayments([
    List<BillingFeature> features = const [],
  ]) async {
    final result = await _channel.invokeMethod(
      'canMakePayments',
      {'features': features.map((e) => e.index).toList()},
    ) as bool;
    return result;
  }

  /// iOS only.
  ///
  /// Use this function to retrieve the [PromotionalOffer] to apply to a
  /// product. Returns a [PromotionalOffer] object which should be passed
  /// to [purchaseDiscountedProduct] or [purchaseDiscountedPackage] to complete
  /// the discounted purchase. A null [PromotionalOffer] means the user is not
  /// entitled to the discount.
  ///
  /// [product] The [StoreProduct] the user intends to purchase.
  ///
  /// [discount] The [StoreProductDiscount] to apply to the product.
  static Future<PromotionalOffer> getPromotionalOffer(
    StoreProduct product,
    StoreProductDiscount discount,
  ) async {
    final result = await _channel.invokeMethod('getPromotionalOffer', {
      'productIdentifier': product.identifier,
      'discountIdentifier': discount.identifier,
    });
    return PromotionalOffer.fromJson(Map<String, dynamic>.from(result));
  }

  /// iOS only, requires iOS 18.0 or greater with StoreKit 2.
  ///
  /// Use this function to retrieve the eligible [WinBackOffer]s that a subscriber
  /// is eligible for for a given [StoreProduct].
  ///
  /// [product] The [StoreProduct] the user intends to purchase.
  static Future<List<WinBackOffer>> getEligibleWinBackOffersForProduct(
    StoreProduct product,
  ) async {
    final result =
        await _channel.invokeMethod('eligibleWinBackOffersForProduct', {
      'productIdentifier': product.identifier,
    });

    return (result as List)
        .map((e) => WinBackOffer.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  /// iOS only, requires iOS 18.0 or greater with StoreKit 2.
  ///
  /// Use this function to retrieve the eligible [WinBackOffer]s that a subscriber
  /// is eligible for for a given [Package].
  ///
  /// [package] The [Package] the user intends to purchase.
  static Future<List<WinBackOffer>> getEligibleWinBackOffersForPackage(
    Package package,
  ) async =>
      getEligibleWinBackOffersForProduct(package.storeProduct);

  /// iOS only, requires iOS 18.0 or greater with StoreKit 2.
  /// Purchase a product applying a given win-back offer.
  ///
  /// Returns a [CustomerInfo] object. Throws a
  /// [PlatformException] if the purchase is unsuccessful.
  /// Check if [PurchasesErrorHelper.getErrorCode] is
  /// [PurchasesErrorCode.purchaseCancelledError] to check if the user cancelled
  /// the purchase.
  ///
  /// [storeProduct] The product to purchase.
  ///
  /// [winBackOffer] Win-back offer that will be applied to the product.
  /// Retrieve this offer using [getEligibleWinBackOffersForProduct]
  /// or [getEligibleWinBackOffersForPackage].
  static Future<CustomerInfo> purchaseProductWithWinBackOffer(
    StoreProduct product,
    WinBackOffer winBackOffer,
  ) async {
    final customerInfo =
        await _invokeReturningCustomerInfo('purchaseProductWithWinBackOffer', {
      'productIdentifier': product.identifier,
      'winBackOfferIdentifier': winBackOffer.identifier,
    });
    return customerInfo;
  }

  /// iOS only, requires iOS 18.0 or greater with StoreKit 2.
  /// Purchase a package applying a given win-back offer.
  ///
  /// Returns a [CustomerInfo] object. Throws a
  /// [PlatformException] if the purchase is unsuccessful.
  /// Check if [PurchasesErrorHelper.getErrorCode] is
  /// [PurchasesErrorCode.purchaseCancelledError] to check if the user cancelled
  /// the purchase.
  ///
  /// [package] The package to purchase.
  ///
  /// [winBackOffer] Win-back offer that will be applied to the package.
  /// Retrieve this offer using [getEligibleWinBackOffersForPackage].
  static Future<CustomerInfo> purchasePackageWithWinBackOffer(
    Package package,
    WinBackOffer winBackOffer,
  ) async {
    final customerInfo =
        await _invokeReturningCustomerInfo('purchasePackageWithWinBackOffer', {
      'packageIdentifier': package.identifier,
      'presentedOfferingContext': package.presentedOfferingContext.toJson(),
      'winBackOfferIdentifier': winBackOffer.identifier,
    });
    return customerInfo;
  }

  /// iOS 15+ only. Presents a refund request sheet in the current window scene for
  /// the latest transaction associated with the active entitlement.
  ///
  /// Returns [RefundRequestStatus]: The status of the refund request.
  /// Keep in mind the status could be [RefundRequestStatus.userCancelled]
  ///
  /// If the request was unsuccessful, no active entitlements could be found for
  /// the user, or multiple active entitlements were found for the user,
  /// a `PlatformException` will be thrown.
  /// If called in an unsupported platform (Android or iOS < 15) a
  /// `UnsupportedPlatformException` will be thrown.
  ///
  /// Important: This method should only be used if your user can only
  /// have a single active entitlement at a given time.
  /// If a user could have more than one entitlement at a time, use
  /// [beginRefundRequestForEntitlement] instead.
  static Future<RefundRequestStatus>
      beginRefundRequestForActiveEntitlement() async {
    final statusCode = await _channel.invokeMethod(
      'beginRefundRequestForActiveEntitlement',
    );
    if (statusCode == null) throw UnsupportedPlatformException();
    return RefundRequestStatusExtension.from(statusCode);
  }

  /// iOS only. Always returns an error on iOS < 15.
  ///
  /// Use this method only if you already have your own IAP implementation using StoreKit 2 and want to use
  /// RevenueCat's backend. If you are using StoreKit 1 for your implementation, you do not need this method.
  ///
  /// You only need to use this method with *new* purchases. Subscription updates are observed automatically.
  ///
  /// Important: This should only be used if you have set purchasesAreCompletedBy to PurchasesAreCompletedByMyApp during SDK configuration.
  ///
  /// @warning You need to finish the transaction yourself after calling this method.
  ///
  /// @param [productID] Product ID that was just purchased
  /// @returns [Future<StoreTransaction>] If there was a transaction found and handled for the provided product ID.
  static Future<StoreTransaction> recordPurchase(
    String productID,
  ) async {
    final response = await _channel.invokeMethod(
      'recordPurchaseForProductID',
      {'productID': productID},
    );
    if (response == null) throw UnsupportedPlatformException();
    return StoreTransaction.fromJson(Map<String, dynamic>.from(response));
  }

  /// iOS 15+ only. Presents a refund request sheet in the current window scene for
  /// the latest transaction associated with the `product`
  ///
  /// Returns [RefundRequestStatus]: The status of the refund request.
  /// Keep in mind the status could be [RefundRequestStatus.userCancelled]
  ///
  /// If the request was unsuccessful, a `PlatformException` will be thrown.
  /// If called in an unsupported platform (Android or iOS < 15) a
  /// `UnsupportedPlatformException` will be thrown.
  ///
  /// [product] The [StoreProduct] to begin a refund request for.
  static Future<RefundRequestStatus> beginRefundRequestForProduct(
    StoreProduct product,
  ) async {
    final statusCode = await _channel.invokeMethod(
      'beginRefundRequestForProduct',
      {'productIdentifier': product.identifier},
    );
    if (statusCode == null) throw UnsupportedPlatformException();
    return RefundRequestStatusExtension.from(statusCode);
  }

  /// iOS 15+ only. Presents a refund request sheet in the current window scene for
  /// the latest transaction associated with the `entitlement`.
  ///
  /// Returns [RefundRequestStatus]: The status of the refund request.
  /// Keep in mind the status could be [RefundRequestStatus.userCancelled]
  ///
  /// If the request was unsuccessful, a `PlatformException` will be thrown.
  /// If called in an unsupported platform (Android or iOS < 15) a
  /// `UnsupportedPlatformException` will be thrown.
  ///
  /// [entitlement] The entitlement to begin a refund request for.
  static Future<RefundRequestStatus> beginRefundRequestForEntitlement(
    EntitlementInfo entitlement,
  ) async {
    final statusCode = await _channel.invokeMethod(
      'beginRefundRequestForEntitlement',
      {'entitlementIdentifier': entitlement.identifier},
    );
    if (statusCode == null) throw UnsupportedPlatformException();
    return RefundRequestStatusExtension.from(statusCode);
  }

  /// Android only. Call close when you are done with this instance of Purchases to disconnect
  /// from the billing services and clean up resources
  static Future<void> close() => _channel.invokeMethod('close');

  /// Set a custom log handler for redirecting logs to your own logging system.
  /// By default, this sends info, warning, and error messages.
  /// If you wish to receive Debug level messages, see [setLogLevel].
  ///
  /// [logHandler] It will get called for each log event.
  /// Use this function to redirect the log to your own logging system
  static Future<void> setLogHandler(LogHandler logHandler) async {
    _logHandler = logHandler;
    return await _channel.invokeMethod('setLogHandler');
  }

  static void handleLogHandlerEvent(MethodCall call) {
    final args = Map<String, dynamic>.from(call.arguments);
    final logLevelName = args['logLevel'];
    final logLevel = LogLevel.values.firstWhere(
      (e) => e.name.toUpperCase() == logLevelName,
      orElse: () => LogLevel.info,
    );
    final msg = args['message'];
    _logHandler?.call(logLevel, msg);
  }

  /// This method will send a purchase to the RevenueCat backend. This function should only be called if you are
  /// in Amazon observer mode or performing a client side migration of your current users to RevenueCat.
  ///
  /// The receipt IDs are cached if successfully posted so they are not posted more than once.
  ///
  /// @param [productID] Product ID associated to the purchase.
  /// @param [receiptID] ReceiptId that represents the Amazon purchase.
  /// @param [amazonUserID] Amazon's userID. This parameter will be ignored when syncing a Google purchase.
  /// @param [isoCurrencyCode] Product's currency code in ISO 4217 format.
  /// @param [price] Product's price.
  @Deprecated('Use syncAmazonPurchase')
  static Future<void> syncObserverModeAmazonPurchase(
    String productID,
    String receiptID,
    String amazonUserID,
    String? isoCurrencyCode,
    double? price,
  ) =>
      syncAmazonPurchase(
        productID,
        receiptID,
        amazonUserID,
        isoCurrencyCode,
        price,
      );

  /// This method will send a purchase to the RevenueCat backend. This function should only be called if you are
  /// in Amazon observer mode or performing a client side migration of your current users to RevenueCat.
  ///
  /// The receipt IDs are cached if successfully posted so they are not posted more than once.
  ///
  /// @param [productID] Product ID associated to the purchase.
  /// @param [receiptID] ReceiptId that represents the Amazon purchase.
  /// @param [amazonUserID] Amazon's userID. This parameter will be ignored when syncing a Google purchase.
  /// @param [isoCurrencyCode] Product's currency code in ISO 4217 format.
  /// @param [price] Product's price.
  static Future<void> syncAmazonPurchase(
    String productID,
    String receiptID,
    String amazonUserID,
    String? isoCurrencyCode,
    double? price,
  ) =>
      _channel.invokeMethod(
        'syncAmazonPurchase',
        {
          'productID': productID,
          'receiptID': receiptID,
          'amazonUserID': amazonUserID,
          'isoCurrencyCode': isoCurrencyCode,
          'price': price,
        },
      );

  /// iOS only. Starts the purchase flow associated with the callback at
  /// [callbackID] index in PurchasesFlutterPlugin.m's [startPurchaseBlocks]
  /// array.
  static Future<PromotedPurchaseResult> _startPromotedProductPurchase(
    int callbackID,
  ) async {
    final result = await _channel.invokeMethod(
      'startPromotedProductPurchase',
      {
        'callbackID': callbackID,
      },
    );
    final customerInfo = CustomerInfo.fromJson(
      Map<String, dynamic>.from(result['customerInfo']),
    );
    final productIdentifier = result['productIdentifier'];
    return PromotedPurchaseResult(
      productIdentifier: productIdentifier,
      customerInfo: customerInfo,
    );
  }

  /// Displays the specified store in-app message types to the user if there are any available to be shown.
  /// - Important: This should only be used if you disabled these messages from showing automatically
  /// during SDK configuration setting ``shouldShowInAppMessagesAutomatically`` to ``false``.
  ///
  /// @param [types] The types of messages to show.
  static Future<void> showInAppMessages({
    Set<InAppMessageType>? types,
  }) =>
      _channel.invokeMethod(
        'showInAppMessages',
        {
          'types': types?.map((e) => e.index).toList(),
        },
      );

  static Future<WebPurchaseRedemption?> parseAsWebPurchaseRedemption(String urlString) async {
    final bool result = await _channel.invokeMethod('isWebPurchaseRedemptionURL', {
      'urlString': urlString,
    });
    if (result) {
      return WebPurchaseRedemption(urlString);
    } else {
      return null;
    }
  }

  static Future<WebPurchaseRedemptionResult> redeemWebPurchase(WebPurchaseRedemption webPurchaseRedemption) async {
    final result = await _channel.invokeMethod('redeemWebPurchase', {
      'redemptionLink': webPurchaseRedemption.redemptionLink,
    });
    return WebPurchaseRedemptionResult.fromJson(Map<String, dynamic>.from(result));
  }

  static Future<CustomerInfo> _invokeReturningCustomerInfo(String method,
      // ignore: require_trailing_commas
      [dynamic arguments]) async {
    final response = await _invokeReturningMap(
      method,
      arguments,
    );
    final customerInfoJson = _getCustomerInfoJsonFromMap(response);
    return CustomerInfo.fromJson(customerInfoJson);
  }

  static Map<String, dynamic> _getCustomerInfoJsonFromMap(
    Map<String, dynamic> response,
  ) =>
      Map<String, dynamic>.from(response['customerInfo']);

  static Future<Map<String, dynamic>> _invokeReturningMap(String method,
      // ignore: require_trailing_commas
      [dynamic arguments]) async {
    final result = await _channel.invokeMethod<Map<dynamic, dynamic>>(
      method,
      arguments,
    );
    final response = Map<String, dynamic>.from(result!);
    return response;
  }
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

/// Possible IntroEligibility status.
/// Use [checkTrialOrIntroductoryPriceEligibility] to determine the eligibility
enum IntroEligibilityStatus {
  /// RevenueCat doesn't have enough information to determine eligibility.
  introEligibilityStatusUnknown,

  /// The user is not eligible for a free trial or intro pricing for this product.
  introEligibilityStatusIneligible,

  /// The user is eligible for a free trial or intro pricing for this product.
  introEligibilityStatusEligible,

  /// There is no free trial or intro pricing for this product.
  introEligibilityStatusNoIntroOfferExists
}

/// Holds the introductory price status
class IntroEligibility {
  /// The introductory price eligibility status
  IntroEligibilityStatus status;

  /// Description of the status
  String description;

  /// Constructs an IntroEligibility from a JSON object
  IntroEligibility.fromJson(Map<String, dynamic> map)
      : status = IntroEligibilityStatus.values[map['status']],
        description = map['description'];
}

/// Status codes for refund requests.
enum RefundRequestStatus {
  /// User canceled submission of the refund request.
  userCancelled,

  /// Apple has received the refund request.
  success,

  /// There was an error with the request. See message for more details.
  error
}

/// Enum for in-app message types.
/// This can be used if you disable automatic in-app message from showing automatically.
/// Then, you can pass what type of messages you want to show in the `showInAppMessages`
/// method in Purchases.
enum InAppMessageType {
  /// In-app messages to indicate there has been a billing issue charging the user.
  billingIssue,

  /// iOS-only. This message will show if you increase the price of a subscription and
  /// the user needs to opt-in to the increase.
  priceIncreaseConsent,

  /// iOS-only. StoreKit generic messages.
  generic,

  /// iOS-only. This message will show if the subscriber is eligible for an iOS win-back
  /// offer and will allow the subscriber to redeem the offer.
  winBackOffer
}

/// Log levels.
enum LogLevel { verbose, debug, info, warn, error }

extension RefundRequestStatusExtension on RefundRequestStatus {
  static RefundRequestStatus from(int index) {
    switch (index) {
      case 0:
        return RefundRequestStatus.success;
      case 1:
        return RefundRequestStatus.userCancelled;
      default:
        return RefundRequestStatus.error;
    }
  }
}

/// Class used to hold the result of the logIn method
class LogInResult {
  /// true if the logged in user has been created in the
  /// RevenueCat backend for the first time
  final bool created;

  /// the [CustomerInfo] associated to the logged in user
  final CustomerInfo customerInfo;

  /// Constructs a LogInResult with its properties
  LogInResult({required this.created, required this.customerInfo});
}

/// Class used to hold the result of the startPromotedPurchase method
class PromotedPurchaseResult {
  /// the productIdentifier associated with the promoted purchase
  final String productIdentifier;

  /// the customerInfo associated with the promoted purchase
  final CustomerInfo customerInfo;

  /// Constructs a PromotedPurchaseResult with its properties
  PromotedPurchaseResult({
    required this.productIdentifier,
    required this.customerInfo,
  });
}

class UnsupportedPlatformException implements Exception {}
