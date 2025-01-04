import 'dart:async';
import 'dart:html' as html;
import 'dart:js' as js;
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

const String rcLifetime = '\$rc_lifetime';
const String rcAnnual = '\$rc_annual';
const String rcSixMonth = '\$rc_six_month';
const String rcThreeMonth = '\$rc_three_month';
const String rcTwoMonth = '\$rc_two_month';
const String rcMonthly = '\$rc_monthly';
const String rcWeekly = '\$rc_weekly';
const String rcPrefix = '\$rc_';

enum LogLevel {
  verbose,
  debug,
  info,
  warn,
  error,
  silent,
}

class PurchasesFlutterPlugin {
  static void registerWith(Registrar registrar) {
    final channel = MethodChannel(
      'purchases_flutter',
      const StandardMethodCodec(),
      registrar,
    );

    final instance = PurchasesFlutterPlugin();
    channel.setMethodCallHandler(instance.handleMethodCall);

    void injectScript() {
      final script = html.ScriptElement()
        ..src =
            'https://unpkg.com/@revenuecat/purchases-js@0.15.1/dist/Purchases.umd.js'
        ..type = 'text/javascript';

      final completer = Completer<void>();

      script.onLoad.listen((_) {
        if (js.context.hasProperty('Purchases')) {
          completer.complete();
        } else {
          completer.completeError('Purchases object not found on window');
        }
      });

      script.onError.listen((event) {
        final error = event as html.ErrorEvent;
        completer.completeError('Failed to load SDK: ${error.message}');
      });

      html.document.head!.append(script);
      js.context['purchasesLoaded'] = completer.future;
    }

    // Check if SDK is already loaded
    if (js.context.hasProperty('Purchases')) {
      js.context['purchasesLoaded'] = Future.value();
    } else {
      injectScript();
    }
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    try {
      switch (call.method) {
        case 'setupPurchases':
          return await _setupPurchases(call.arguments);
        case 'setLogLevel':
          return _setLogLevel(call.arguments);
        case 'getCustomerInfo':
          return _getCustomerInfo();
        case 'getOfferings':
          return _getOfferings();
        case 'getCurrentOfferingForPlacement':
          return _getCurrentOfferingForPlacement(call.arguments);
        case 'getAppUserID':
          return _getAppUserID();
        case 'logIn':
          return _logIn(call.arguments);
        case 'logOut':
          return _logOut();
        case 'preload':
          return _preload();
        case 'generateAnonymousId':
          return _generateAnonymousId();
        case 'purchase':
          return _purchase(call.arguments);
        case 'purchaseProduct':
          return _purchaseProduct(call.arguments);
        case 'purchasePackage':
          return _purchasePackage(call.arguments);
        case 'restorePurchases':
          return _restorePurchases();
        case 'close':
          return _close();
        case 'isAnonymous':
          return _isAnonymous();
        case 'isSandbox':
          return _isSandbox();
        case 'isConfigured':
          return _isConfigured();
        case 'syncPurchases':
          return _syncPurchases();
        case 'checkTrialOrIntroductoryPriceEligibility':
          return _checkTrialOrIntroductoryPriceEligibility(call.arguments);
        case 'invalidateCustomerInfoCache':
          return _invalidateCustomerInfoCache();
        case 'setAttributes':
          return _setAttributes(call.arguments);
        case 'collectDeviceIdentifiers':
          return _collectDeviceIdentifiers();
        case 'canMakePayments':
          return _canMakePayments(call.arguments);
        case 'setAllowSharingStoreAccount':
          return _setAllowSharingStoreAccount(call.arguments);
        case 'setSimulatesAskToBuyInSandbox':
          return _setSimulatesAskToBuyInSandbox(call.arguments);
        case 'setProxyURL':
          return _setProxyURL(call.arguments);
        case 'enableAdServicesAttributionTokenCollection':
          return _enableAdServicesAttributionTokenCollection();
        case 'presentCodeRedemptionSheet':
          return _presentCodeRedemptionSheet();
        case 'purchaseSubscriptionOption':
          return _purchaseSubscriptionOption(call.arguments);
        case 'purchaseDiscountedProduct':
          return _purchaseDiscountedProduct(call.arguments);
        case 'purchaseDiscountedPackage':
          return _purchaseDiscountedPackage(call.arguments);
        case 'getPromotionalOffer':
          return _getPromotionalOffer(call.arguments);
        case 'getEligibleWinBackOffersForProduct':
          return _getEligibleWinBackOffersForProduct(call.arguments);
        case 'purchaseProductWithWinBackOffer':
          return _purchaseProductWithWinBackOffer(call.arguments);
        case 'purchasePackageWithWinBackOffer':
          return _purchasePackageWithWinBackOffer(call.arguments);
        case 'beginRefundRequestForActiveEntitlement':
          return _beginRefundRequestForActiveEntitlement();
        case 'beginRefundRequestForProduct':
          return _beginRefundRequestForProduct(call.arguments);
        case 'beginRefundRequestForEntitlement':
          return _beginRefundRequestForEntitlement(call.arguments);
        case 'recordPurchase':
          return _recordPurchase(call.arguments);
        case 'showInAppMessages':
          return _showInAppMessages(call.arguments);
        case 'isWebPurchaseRedemptionURL':
          return _isWebPurchaseRedemptionURL(call.arguments);
        case 'redeemWebPurchase':
          return _redeemWebPurchase(call.arguments);

        default:
          throw PlatformException(
            code: 'Unimplemented',
            details: '${call.method} not implemented on web platform.',
          );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _setupPurchases(dynamic arguments) async {
    try {
      await js.context['purchasesLoaded'];

      if (!js.context.hasProperty('Purchases')) {
        throw PlatformException(
          code: 'SDKNotLoaded',
          message:
              'Purchases JS SDK not found on window object. Make sure the SDK is properly loaded.',
        );
      }

      var purchases = js.context['Purchases'];

      if (purchases.hasProperty('Purchases')) {
        purchases = purchases['Purchases'];
      }

      // Check if SDK is already configured
      final isConfigured = purchases.callMethod('isConfigured') as bool;
      if (isConfigured) {
        return;
      }

      final apiKey = arguments['apiKey'] as String?;
      if (apiKey == null) {
        throw PlatformException(
          code: 'ConfigurationError',
          message: 'API key is required',
        );
      }

      var appUserId = arguments['appUserId'] as String?;
      appUserId ??= purchases
          .callMethod('generateRevenueCatAnonymousAppUserId')
          .toString();

      purchases.callMethod('configure', [apiKey, appUserId]);
    } catch (e) {
      throw PlatformException(
        code: 'ConfigureError',
        message: 'Error calling configure: $e',
      );
    }
  }

  Future<void> _setLogLevel(dynamic arguments) async {
    try {
      await js.context['purchasesLoaded'];
      final logLevel = arguments['level'] as String;
      var purchases = js.context['Purchases'];

      if (purchases == null) {
        throw PlatformException(
          code: 'SDKNotLoaded',
          message: 'Purchases SDK not found on window object after loading.',
        );
      }

      if (purchases.hasProperty('Purchases')) {
        purchases = purchases['Purchases'];
      }

      final jsLogLevel = _convertLogLevel(logLevel);
      purchases.callMethod('setLogLevel', [jsLogLevel]);
    } catch (e) {
      throw PlatformException(
        code: 'LogLevelError',
        message: 'Error setting log level: $e',
      );
    }
  }

  String _convertLogLevel(String logLevel) {
    switch (logLevel.toLowerCase()) {
      case 'verbose':
        return 'verbose';
      case 'debug':
        return 'debug';
      case 'info':
        return 'info';
      case 'warn':
        return 'warn';
      case 'error':
        return 'error';
      default:
        return 'silent';
    }
  }

  bool _isConfigured() {
    var purchases = js.context['Purchases'];
    if (purchases.hasProperty('Purchases')) {
      purchases = purchases['Purchases'];
    }

    return purchases.callMethod('isConfigured') as bool;
  }

  js.JsObject _getInstance() {
    var purchases = js.context['Purchases'];
    if (purchases.hasProperty('Purchases')) {
      purchases = purchases['Purchases'];
    }

    if (!_isConfigured()) {
      throw PlatformException(
        code: 'NotConfigured',
        message: 'Purchases SDK not configured. Call configure first.',
      );
    }

    return purchases.callMethod('getSharedInstance');
  }

  Future<Map<String, dynamic>> _getCustomerInfo() async {
    final completer = Completer<Map<String, dynamic>>();
    final instance = _getInstance();

    final promise = instance.callMethod('getCustomerInfo', []);
    promise.callMethod(
      'then',
      [
        js.allowInterop(
          (result) => completer.complete(_convertJsCustomerInfo(result)),
        ),
      ],
    ).callMethod('catch', [
      js.allowInterop(
        (error) => completer.completeError(
          PlatformException(
            code: 'CustomerInfoError',
            message: error.toString(),
          ),
        ),
      ),
    ]);

    return completer.future;
  }

  Future<Map<String, dynamic>> _getOfferings() async {
    final completer = Completer<Map<String, dynamic>>();
    final instance = _getInstance();

    final promise = instance.callMethod('getOfferings', []);
    promise.callMethod(
      'then',
      [
        js.allowInterop(
          (result) => completer.complete(_convertJsOfferings(result)),
        ),
      ],
    ).callMethod('catch', [
      js.allowInterop(
        (error) => completer.completeError(
          PlatformException(
            code: 'OfferingsError',
            message: error.toString(),
          ),
        ),
      ),
    ]);

    return completer.future;
  }

  Future<Map<String, dynamic>?> _getCurrentOfferingForPlacement(
    dynamic arguments,
  ) async {
    final placementIdentifier = arguments['placementIdentifier'] as String;
    final completer = Completer<Map<String, dynamic>?>();
    final instance = _getInstance();

    final promise = instance
        .callMethod('getCurrentOfferingForPlacement', [placementIdentifier]);
    promise.callMethod(
      'then',
      [
        js.allowInterop((result) {
          if (result == null) {
            completer.complete(null);
          } else {
            completer.complete(_convertJsOffering(result));
          }
        }),
      ],
    ).callMethod('catch', [
      js.allowInterop(
        (error) => completer.completeError(
          PlatformException(
            code: 'OfferingsError',
            message: error.toString(),
          ),
        ),
      ),
    ]);

    return completer.future;
  }

  Future<String> _getAppUserID() async {
    try {
      final instance = _getInstance();
      final result = instance.callMethod('getAppUserId', []);
      return result.toString();
    } catch (e) {
      throw PlatformException(
        code: 'AppUserIDError',
        message: 'Error getting app user ID: $e',
      );
    }
  }

  Future<Map<String, dynamic>> _logIn(dynamic arguments) async {
    final appUserId = arguments['appUserId'] as String;
    final completer = Completer<Map<String, dynamic>>();
    final instance = _getInstance();

    final promise = instance.callMethod('changeUser', [appUserId]);
    promise.callMethod(
      'then',
      [
        js.allowInterop(
          (result) => completer.complete(_convertJsCustomerInfo(result)),
        ),
      ],
    ).callMethod('catch', [
      js.allowInterop(
        (error) => completer.completeError(
          PlatformException(
            code: 'LoginError',
            message: error.toString(),
          ),
        ),
      ),
    ]);

    return completer.future;
  }

  Future<void> _logOut() async {
    throw PlatformException(
      code: 'UnsupportedOperation',
      message:
          'logOut is not supported on web platform. To change users, use logIn instead.',
    );
  }

  Future<void> _preload() async {
    try {
      final instance = _getInstance();

      final completer = Completer<void>();
      final promise = instance.callMethod('preload');

      promise.callMethod(
        'then',
        [js.allowInterop((_) => completer.complete())],
      ).callMethod('catch', [
        js.allowInterop(
          (error) => completer.completeError(error.toString()),
        ),
      ]);

      await completer.future;
    } catch (e) {
      // We don't want to throw an error if preload fails
    }
  }

  Future<String> _generateAnonymousId() async {
    try {
      var purchases = js.context['Purchases'];
      if (purchases.hasProperty('Purchases')) {
        purchases = purchases['Purchases'];
      }

      final anonymousId =
          purchases.callMethod('generateRevenueCatAnonymousAppUserId');
      return anonymousId.toString();
    } catch (e) {
      throw PlatformException(
        code: 'GenerateAnonymousIdError',
        message: 'Error generating anonymous ID: $e',
      );
    }
  }

  Future<Map<String, dynamic>> _purchase(dynamic arguments) async {
    throw PlatformException(
      code: 'Unimplemented',
      message: 'purchase is not yet implemented on web platform.',
    );
  }

  Future<Map<String, dynamic>> _purchaseProduct(dynamic arguments) async {
    throw PlatformException(
      code: 'Unimplemented',
      message: 'purchaseProduct is not yet implemented on web platform.',
    );
  }

  Future<Map<String, dynamic>> _purchasePackage(dynamic arguments) async {
    throw PlatformException(
      code: 'Unimplemented',
      message: 'purchasePackage is not yet implemented on web platform.',
    );
  }

  Future<Map<String, dynamic>> _restorePurchases() async {
    // Web SDK doesn't support restore purchases, but returns current customer info
    // to match behavior with other platforms
    try {
      return await _getCustomerInfo();
    } catch (e) {
      throw PlatformException(
        code: 'RestoreError',
        message: 'Error restoring purchases: $e',
      );
    }
  }

  Future<void> _close() async {
    // Web SDK's close() just unsets the instance
    js.context['Purchases'] = null;
  }

  Future<bool> _isAnonymous() async {
    final appUserId = await _getAppUserID();
    return appUserId.startsWith('\$RCAnonymousID:');
  }

  Future<bool> _isSandbox() async {
    try {
      final instance = _getInstance();
      return instance.callMethod('isSandbox') as bool;
    } catch (e) {
      throw PlatformException(
        code: 'SandboxCheckError',
        message: 'Error checking sandbox status: $e',
      );
    }
  }

  Future<void> _syncPurchases() async {
    // Web SDK doesn't have a syncPurchases method
    // No-op to match behavior with other platforms
    return;
  }

  Future<Map<String, dynamic>> _checkTrialOrIntroductoryPriceEligibility(
    dynamic arguments,
  ) async {
    // Web SDK doesn't support trial/intro eligibility checking
    // Return unknown status for all products
    final productIdentifiers =
        List<String>.from(arguments['productIdentifiers']);
    return Map.fromEntries(
      productIdentifiers.map(
        (id) => MapEntry(
          id,
          {
            'status': 0, // introEligibilityStatusUnknown
            'description':
                'Trial or intro price eligibility checking not supported on web',
          },
        ),
      ),
    );
  }

  Future<void> _invalidateCustomerInfoCache() async {
    // Web SDK doesn't have a cache invalidation method
    // Just get fresh customer info
    await _getCustomerInfo();
  }

  Future<void> _setAttributes(dynamic arguments) async {
    // Web SDK doesn't support subscriber attributes
    // No-op to match behavior with other platforms
    return;
  }

  Future<void> _collectDeviceIdentifiers() async {
    // Web SDK doesn't support device identifiers
    // No-op to match behavior with other platforms
    return;
  }

  // ignore: prefer_expression_function_bodies
  Future<bool> _canMakePayments(dynamic arguments) async {
    // Web SDK doesn't have a canMakePayments check
    // Always return true since if the SDK loaded, payments should be possible
    return true;
  }

  Future<void> _setAllowSharingStoreAccount(dynamic arguments) async {
    // Web doesn't have store account sharing concept
    return;
  }

  Future<void> _setSimulatesAskToBuyInSandbox(dynamic arguments) async {
    // iOS only feature, no-op on web
    return;
  }

  Future<void> _setProxyURL(dynamic arguments) async {
    // final proxyURL = arguments['proxyURLString'] as String;
    throw PlatformException(
      code: 'Unimplemented',
      message: 'setProxyURL is not yet implemented on web platform.',
    );
  }

  Future<void> _enableAdServicesAttributionTokenCollection() async {
    // iOS only feature, no-op on web
    return;
  }

  Future<void> _presentCodeRedemptionSheet() async {
    // iOS only feature, no-op on web
    throw PlatformException(
      code: 'Unimplemented',
      message: 'Code redemption is not supported on web platform.',
    );
  }

  Future<Map<String, dynamic>> _purchaseSubscriptionOption(
    dynamic arguments,
  ) async {
    // Google Play only feature
    throw PlatformException(
      code: 'Unimplemented',
      message:
          'Subscription option purchases are not supported on web platform.',
    );
  }

  Future<Map<String, dynamic>> _purchaseDiscountedProduct(
    dynamic arguments,
  ) async {
    // iOS only feature
    throw PlatformException(
      code: 'Unimplemented',
      message:
          'Discounted product purchases are not supported on web platform.',
    );
  }

  Future<Map<String, dynamic>> _purchaseDiscountedPackage(
    dynamic arguments,
  ) async {
    // iOS only feature
    throw PlatformException(
      code: 'Unimplemented',
      message:
          'Discounted package purchases are not supported on web platform.',
    );
  }

  Future<Map<String, dynamic>> _getPromotionalOffer(dynamic arguments) async {
    // iOS only feature
    throw PlatformException(
      code: 'Unimplemented',
      message: 'Promotional offers are not supported on web platform.',
    );
  }

  Future<List<dynamic>> _getEligibleWinBackOffersForProduct(
    dynamic arguments,
  ) async {
    // iOS only feature
    throw PlatformException(
      code: 'Unimplemented',
      message: 'Win-back offers are not supported on web platform.',
    );
  }

  Future<Map<String, dynamic>> _purchaseProductWithWinBackOffer(
    dynamic arguments,
  ) async {
    // iOS only feature
    throw PlatformException(
      code: 'Unimplemented',
      message: 'Win-back offer purchases are not supported on web platform.',
    );
  }

  Future<Map<String, dynamic>> _purchasePackageWithWinBackOffer(
    dynamic arguments,
  ) async {
    // iOS only feature
    throw PlatformException(
      code: 'Unimplemented',
      message: 'Win-back offer purchases are not supported on web platform.',
    );
  }

  Future<int> _beginRefundRequestForActiveEntitlement() async {
    // iOS only feature
    throw PlatformException(
      code: 'Unimplemented',
      message: 'Refund requests are not supported on web platform.',
    );
  }

  Future<int> _beginRefundRequestForProduct(dynamic arguments) async {
    // iOS only feature
    throw PlatformException(
      code: 'Unimplemented',
      message: 'Refund requests are not supported on web platform.',
    );
  }

  Future<int> _beginRefundRequestForEntitlement(dynamic arguments) async {
    // iOS only feature
    throw PlatformException(
      code: 'Unimplemented',
      message: 'Refund requests are not supported on web platform.',
    );
  }

  Future<Map<String, dynamic>> _recordPurchase(dynamic arguments) async {
    // iOS only feature
    throw PlatformException(
      code: 'Unimplemented',
      message: 'Record purchase is not supported on web platform.',
    );
  }

  Future<void> _showInAppMessages(dynamic arguments) async {
    // No in-app messages on web
    return;
  }

  // ignore: prefer_expression_function_bodies
  Future<bool> _isWebPurchaseRedemptionURL(dynamic arguments) async {
    // Web doesn't use redemption URLs
    return false;
  }

  Future<Map<String, dynamic>> _redeemWebPurchase(dynamic arguments) async {
    // Web doesn't use redemption URLs
    throw PlatformException(
      code: 'Unimplemented',
      message: 'Web purchase redemption is not supported on web platform.',
    );
  }

  Map<String, dynamic> _convertJsEntitlement(dynamic jsEntitlement) => {
        'identifier': jsEntitlement['identifier']?.toString() ?? '',
        'isActive': jsEntitlement['isActive'] ?? false,
        'willRenew': jsEntitlement['willRenew'] ?? false,
        'latestPurchaseDate':
            jsEntitlement['latestPurchaseDate']?.toString() ?? '',
        'originalPurchaseDate':
            jsEntitlement['originalPurchaseDate']?.toString() ?? '',
        'productIdentifier':
            jsEntitlement['productIdentifier']?.toString() ?? '',
        'isSandbox': jsEntitlement['isSandbox'] ?? false,
        'ownershipType': 'UNKNOWN',
        'store': _convertStore(jsEntitlement['store']),
        'periodType': _convertPeriodType(jsEntitlement['periodType']),
        'expirationDate': jsEntitlement['expirationDate']?.toString(),
        'unsubscribeDetectedAt':
            jsEntitlement['unsubscribeDetectedAt']?.toString(),
        'billingIssueDetectedAt':
            jsEntitlement['billingIssueDetectedAt']?.toString(),
        'productPlanIdentifier': null,
        'verification': 'NOT_REQUESTED',
      };

  String _convertStore(dynamic store) {
    final storeStr = (store?.toString() ?? 'unknown').toLowerCase();
    switch (storeStr) {
      case 'app_store':
        return 'APP_STORE';
      case 'mac_app_store':
        return 'MAC_APP_STORE';
      case 'play_store':
        return 'PLAY_STORE';
      case 'amazon':
        return 'AMAZON';
      case 'stripe':
        return 'STRIPE';
      case 'rc_billing':
        return 'RC_BILLING';
      case 'promotional':
        return 'PROMOTIONAL';
      case 'web':
        return 'WEB';
      default:
        return 'unknownStore';
    }
  }

  String _convertPeriodType(dynamic periodType) {
    final typeStr = (periodType?.toString() ?? 'normal').toLowerCase();
    switch (typeStr) {
      case 'normal':
        return 'NORMAL';
      case 'intro':
        return 'INTRO';
      case 'trial':
        return 'TRIAL';
      default:
        return 'unknown';
    }
  }

  Map<String, dynamic> _convertJsCustomerInfo(dynamic jsCustomerInfo) {
    if (jsCustomerInfo == null) {
      throw PlatformException(
        code: 'CustomerInfoError',
        message: 'Customer info is null',
      );
    }

    final entitlements = jsCustomerInfo['entitlements'];
    final activeEntitlements = <String, dynamic>{};
    final allEntitlements = <String, dynamic>{};

    if (entitlements != null && entitlements is js.JsObject) {
      if (entitlements['active'] != null) {
        final active = entitlements['active'] as js.JsObject;
        final activeKeys = js.context['Object'].callMethod('keys', [active]);
        for (final key in activeKeys) {
          final ent = active[key];
          activeEntitlements[key.toString()] = _convertJsEntitlement(ent);
        }
      }

      if (entitlements['all'] != null) {
        final all = entitlements['all'] as js.JsObject;
        final allKeys = js.context['Object'].callMethod('keys', [all]);
        for (final key in allKeys) {
          final ent = all[key];
          allEntitlements[key.toString()] = _convertJsEntitlement(ent);
        }
      }
    }

    final activeSubscriptions = jsCustomerInfo['activeSubscriptions'];
    var activeSubscriptionsList = <String>[];
    if (activeSubscriptions != null && activeSubscriptions is js.JsObject) {
      final values =
          js.context['Array'].callMethod('from', [activeSubscriptions]);
      activeSubscriptionsList =
          List<String>.from(values.map((x) => x.toString()));
    }

    final allPurchaseDatesByProduct =
        jsCustomerInfo['allPurchaseDatesByProduct'];
    final purchaseDates = <String, String?>{};
    if (allPurchaseDatesByProduct != null &&
        allPurchaseDatesByProduct is js.JsObject) {
      final keys =
          js.context['Object'].callMethod('keys', [allPurchaseDatesByProduct]);
      for (final key in keys) {
        final date = allPurchaseDatesByProduct[key];
        purchaseDates[key.toString()] = date?.toString();
      }
    }

    final allExpirationDatesByProduct =
        jsCustomerInfo['allExpirationDatesByProduct'];
    final expirationDates = <String, String?>{};
    if (allExpirationDatesByProduct != null &&
        allExpirationDatesByProduct is js.JsObject) {
      final keys = js.context['Object']
          .callMethod('keys', [allExpirationDatesByProduct]);
      for (final key in keys) {
        final date = allExpirationDatesByProduct[key];
        expirationDates[key.toString()] = date?.toString();
      }
    }

    return {
      'entitlements': {
        'active': activeEntitlements,
        'all': allEntitlements,
        'verification': 'NOT_REQUESTED',
      },
      'allPurchaseDates': purchaseDates,
      'activeSubscriptions': activeSubscriptionsList,
      'allPurchasedProductIdentifiers': [],
      'nonSubscriptionTransactions': [],
      'firstSeen': jsCustomerInfo['firstSeenDate']?.toString() ?? '',
      'originalAppUserId':
          jsCustomerInfo['originalAppUserId']?.toString() ?? '',
      'allExpirationDates': expirationDates,
      'requestDate': jsCustomerInfo['requestDate']?.toString() ?? '',
      'latestExpirationDate': null,
      'originalPurchaseDate':
          jsCustomerInfo['originalPurchaseDate']?.toString(),
      'originalApplicationVersion': null,
      'managementURL': jsCustomerInfo['managementURL']?.toString(),
    };
  }

  Map<String, dynamic> _convertJsOfferings(dynamic jsOfferings) {
    final allOfferings = jsOfferings['all'];
    final currentOffering = jsOfferings['current'];

    final allOfferingsMap = <String, dynamic>{};

    if (allOfferings != null) {
      final jsAll = allOfferings as js.JsObject;
      final keys = js.context['Object'].callMethod('keys', [jsAll]);
      for (final key in keys) {
        final offering = jsAll[key];
        allOfferingsMap[key.toString()] = {
          'identifier': offering['identifier'],
          'serverDescription': offering['serverDescription'],
          'metadata': offering['metadata'],
          'availablePackages':
              _convertJsPackages(offering['availablePackages']),
          'lifetime':
              _findPackageByType(offering['availablePackages'], rcLifetime),
          'annual': _findPackageByType(offering['availablePackages'], rcAnnual),
          'sixMonth':
              _findPackageByType(offering['availablePackages'], rcSixMonth),
          'threeMonth':
              _findPackageByType(offering['availablePackages'], rcThreeMonth),
          'twoMonth':
              _findPackageByType(offering['availablePackages'], rcTwoMonth),
          'monthly':
              _findPackageByType(offering['availablePackages'], rcMonthly),
          'weekly': _findPackageByType(offering['availablePackages'], rcWeekly),
        };
      }
    }

    return {
      'current': currentOffering != null
          ? {
              'identifier': currentOffering['identifier'],
              'serverDescription': currentOffering['serverDescription'],
              'metadata': currentOffering['metadata'],
              'availablePackages':
                  _convertJsPackages(currentOffering['availablePackages']),
              'lifetime': _findPackageByType(
                currentOffering['availablePackages'],
                rcLifetime,
              ),
              'annual': _findPackageByType(
                currentOffering['availablePackages'],
                rcAnnual,
              ),
              'sixMonth': _findPackageByType(
                currentOffering['availablePackages'],
                rcSixMonth,
              ),
              'threeMonth': _findPackageByType(
                currentOffering['availablePackages'],
                rcThreeMonth,
              ),
              'twoMonth': _findPackageByType(
                currentOffering['availablePackages'],
                rcTwoMonth,
              ),
              'monthly': _findPackageByType(
                currentOffering['availablePackages'],
                rcMonthly,
              ),
              'weekly': _findPackageByType(
                currentOffering['availablePackages'],
                rcWeekly,
              ),
            }
          : null,
      'all': allOfferingsMap,
    };
  }

  List<Map<String, dynamic>> _convertJsPackages(dynamic jsPackages) {
    if (jsPackages == null) return [];

    final packages = <Map<String, dynamic>>[];
    final List packagesList = js.JsArray.from(jsPackages);

    for (final jsPackage in packagesList) {
      packages.add({
        'identifier': jsPackage['identifier'],
        'packageType': jsPackage['packageType'],
        'product': _convertJsProduct(jsPackage['product']),
        'offeringIdentifier': jsPackage['offeringIdentifier'],
      });
    }

    return packages;
  }

  Map<String, dynamic> _convertJsProduct(dynamic jsProduct) => {
        'identifier': jsProduct['identifier'],
        'title': jsProduct['title'],
        'description': jsProduct['description'],
        'price': jsProduct['currentPrice']?['amountMicros'] ?? 0,
        'priceString': jsProduct['currentPrice']?['formattedPrice'],
        'currencyCode': jsProduct['currentPrice']?['currency'],
        'productType': _convertProductType(jsProduct['productType']),
        'subscriptionOptions':
            _convertSubscriptionOptions(jsProduct['subscriptionOptions']),
        'presentedOfferingIdentifier': jsProduct['presentedOfferingContext']
            ?['offeringIdentifier'],
      };

  String _convertPackageType(String identifier) {
    switch (identifier) {
      case rcLifetime:
        return 'LIFETIME';
      case rcAnnual:
        return 'ANNUAL';
      case rcSixMonth:
        return 'SIX_MONTH';
      case rcThreeMonth:
        return 'THREE_MONTH';
      case rcTwoMonth:
        return 'TWO_MONTH';
      case rcMonthly:
        return 'MONTHLY';
      case rcWeekly:
        return 'WEEKLY';
      default:
        if (identifier.startsWith(rcPrefix)) {
          return 'UNKNOWN';
        }
        return 'CUSTOM';
    }
  }

  String _convertProductType(String type) {
    switch (type.toLowerCase()) {
      case 'subscription':
        return 'SUBS';
      case 'consumable':
        return 'CONSUMABLE';
      case 'non_consumable':
        return 'NON_CONSUMABLE';
      default:
        return 'UNKNOWN';
    }
  }

  Map<String, dynamic> _convertJsPackage(dynamic jsPackage) => {
        'identifier': jsPackage['identifier'],
        'packageType': _convertPackageType(jsPackage['identifier']),
        'product': _convertJsProduct(jsPackage['rcBillingProduct']),
        'offeringIdentifier': jsPackage['presentedOfferingContext']
            ?['offeringIdentifier'],
      };

  Map<String, dynamic>? _findPackageByType(dynamic packages, String type) {
    if (packages == null) return null;

    final List packagesList = js.JsArray.from(packages);
    final package = packagesList.firstWhere(
      (p) => p['identifier'] == type,
      orElse: () => null,
    );

    if (package == null) return null;
    return _convertJsPackage(package);
  }

  Map<String, dynamic> _convertSubscriptionOptions(
    dynamic jsSubscriptionOptions,
  ) {
    if (jsSubscriptionOptions == null) return {};

    final options = <String, dynamic>{};
    final jsOptions = jsSubscriptionOptions as js.JsObject;
    final keys = js.context['Object'].callMethod('keys', [jsOptions]);

    for (final key in keys) {
      final option = jsOptions[key];
      options[key.toString()] = {
        'id': option['id'],
        'priceId': option['priceId'],
        'base': _convertPricingPhase(option['base']),
        'trial': option['trial'] != null
            ? _convertPricingPhase(option['trial'])
            : null,
      };
    }

    return options;
  }

  Map<String, dynamic> _convertPricingPhase(dynamic phase) => {
        'periodDuration': phase['periodDuration'],
        'period': phase['period'],
        'price': phase['price'] != null
            ? {
                'amountMicros': phase['price']['amountMicros'],
                'currency': phase['price']['currency'],
                'formattedPrice': phase['price']['formattedPrice'],
              }
            : null,
        'cycleCount': phase['cycleCount'] ?? 0,
      };

  Map<String, dynamic> _convertJsOffering(dynamic jsOffering) => {
        'identifier': jsOffering['identifier'],
        'serverDescription': jsOffering['serverDescription'],
        'metadata': jsOffering['metadata'],
        'availablePackages':
            _convertJsPackages(jsOffering['availablePackages']),
        'lifetime':
            _findPackageByType(jsOffering['availablePackages'], rcLifetime),
        'annual': _findPackageByType(jsOffering['availablePackages'], rcAnnual),
        'sixMonth':
            _findPackageByType(jsOffering['availablePackages'], rcSixMonth),
        'threeMonth':
            _findPackageByType(jsOffering['availablePackages'], rcThreeMonth),
        'twoMonth':
            _findPackageByType(jsOffering['availablePackages'], rcTwoMonth),
        'monthly':
            _findPackageByType(jsOffering['availablePackages'], rcMonthly),
        'weekly': _findPackageByType(jsOffering['availablePackages'], rcWeekly),
      };
}
