import 'dart:async';
import 'dart:html' as html;
import 'dart:js' as js;
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import '../errors.dart';

const String rcPrefix = '\$rc_';

class WebPackageType {
  static const String unknown = 'unknown';
  static const String custom = 'custom';
  static const String lifetime = '${rcPrefix}lifetime';
  static const String annual = '${rcPrefix}annual';
  static const String sixMonth = '${rcPrefix}six_month';
  static const String threeMonth = '${rcPrefix}three_month';
  static const String twoMonth = '${rcPrefix}two_month';
  static const String monthly = '${rcPrefix}monthly';
  static const String weekly = '${rcPrefix}weekly';
}

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
            'https://unpkg.com/@revenuecat/purchases-js@0.18.1/dist/Purchases.umd.js'
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
        code: PurchasesErrorCode.configurationError.index.toString(),
        message: 'Purchases SDK not configured. Call configure first.',
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
        code: PurchasesErrorCode.configurationError.index.toString(),
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
        (error) {
          final code = _mapJsErrorToPurchasesErrorCode(error);
          completer.completeError(
            PlatformException(
              code: code.index.toString(),
              message: error.toString(),
            ),
          );
        },
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
    final instance = _getInstance();

    final completer = Completer<Map<String, dynamic>>();
    final nativePackageJsified = js.JsObject.jsify(arguments['nativePackage']);
    final promise =
        instance.callMethod('purchasePackage', [nativePackageJsified]);
    promise.callMethod(
      'then',
      [
        js.allowInterop(
          (result) => completer.complete({
            'customerInfo': _convertJsCustomerInfo(result['customerInfo']),
            // TODO: Need to expose redemption info
          }),
        ),
      ],
    ).callMethod('catch', [
      js.allowInterop(
        (error) {
          final errorMap = _jsObjectToMap(error);
          completer.completeError(
            PlatformException(
              code: "${errorMap['errorCode']}",
              message: errorMap['underlyingErrorMessage'],
            ),
          );
        },
      ),
    ]);

    return completer.future;
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
      default:
        return 'unknown';
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
    final allPurchasedProductIdentifiers = <String>[];

    if (allPurchaseDatesByProduct != null &&
        allPurchaseDatesByProduct is js.JsObject) {
      final keys =
          js.context['Object'].callMethod('keys', [allPurchaseDatesByProduct]);
      for (final key in keys) {
        final date = allPurchaseDatesByProduct[key];
        final productId = key.toString();
        purchaseDates[productId] = date?.toString();
        allPurchasedProductIdentifiers.add(productId);
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

    String? latestExpirationDate;
    if (expirationDates.isNotEmpty) {
      latestExpirationDate = expirationDates.values
          .where((date) => date != null)
          .reduce((a, b) => a!.compareTo(b!) > 0 ? a : b);
    }

    return {
      'entitlements': {
        'active': activeEntitlements,
        'all': allEntitlements,
        'verification': 'NOT_REQUESTED',
      },
      'allPurchaseDates': purchaseDates,
      'activeSubscriptions': activeSubscriptionsList,
      'allPurchasedProductIdentifiers': allPurchasedProductIdentifiers,
      'nonSubscriptionTransactions': [],
      'firstSeen': jsCustomerInfo['firstSeenDate']?.toString() ?? '',
      'originalAppUserId':
          jsCustomerInfo['originalAppUserId']?.toString() ?? '',
      'allExpirationDates': expirationDates,
      'requestDate': jsCustomerInfo['requestDate']?.toString() ?? '',
      'latestExpirationDate': latestExpirationDate,
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
        allOfferingsMap[key.toString()] = _convertJsOffering(offering);
      }
    }

    return {
      'all': allOfferingsMap,
      'current':
          currentOffering != null ? _convertJsOffering(currentOffering) : null,
    };
  }

  List<Map<String, dynamic>> _convertJsPackages(dynamic jsPackages) {
    if (jsPackages == null) return [];

    final packages = <Map<String, dynamic>>[];
    final packagesList = js.JsArray.from(jsPackages).toList();

    for (final jsPackage in packagesList) {
      packages.add(_convertJsPackage(jsPackage));
    }

    return packages;
  }

  Map<String, dynamic> _convertJsProduct(dynamic jsProduct) {
    final presentedOfferingContext = _convertPresentedOfferingContext(
      jsProduct['presentedOfferingContext'],
    );

    return {
      'identifier': jsProduct['identifier'],
      'title': jsProduct['title'],
      'description': jsProduct['description'] ??
          '', // TODO: Dart [StoreProduct] doesn't support a null description while JS does
      'price': jsProduct['currentPrice']?['amountMicros'] ?? 0,
      'priceString': jsProduct['currentPrice']?['formattedPrice'],
      'currencyCode': jsProduct['currentPrice']?['currency'],
      'productType': _convertProductType(jsProduct['productType']),
      'subscriptionOptions': _convertSubscriptionOptions(
        jsProduct['subscriptionOptions'],
        jsProduct['identifier'],
      ),
      'presentedOfferingContext': presentedOfferingContext,
      'presentedOfferingIdentifier':
          presentedOfferingContext?['offeringIdentifier'],
    };
  }

  String _convertPackageType(String identifier) {
    switch (identifier) {
      case WebPackageType.lifetime:
        return 'LIFETIME';
      case WebPackageType.annual:
        return 'ANNUAL';
      case WebPackageType.sixMonth:
        return 'SIX_MONTH';
      case WebPackageType.threeMonth:
        return 'THREE_MONTH';
      case WebPackageType.twoMonth:
        return 'TWO_MONTH';
      case WebPackageType.monthly:
        return 'MONTHLY';
      case WebPackageType.weekly:
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

  Map<String, dynamic> _convertJsPackage(dynamic jsPackage) {
    final presentedOfferingContext = _convertPresentedOfferingContext(
      jsPackage['rcBillingProduct']['presentedOfferingContext'],
    );

    return {
      'identifier': jsPackage['identifier'],
      'packageType': _convertPackageType(jsPackage['identifier']),
      'product': _convertJsProduct(jsPackage['rcBillingProduct']),
      'presentedOfferingContext': presentedOfferingContext,
      'offeringIdentifier': presentedOfferingContext?['offeringIdentifier'],
      'nativePackage': _jsObjectToMap(jsPackage),
    };
  }

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

  List<dynamic> _convertSubscriptionOptions(
    dynamic jsSubscriptionOptions,
    String storeProductId,
  ) {
    if (jsSubscriptionOptions == null) return [];

    final options = [];
    final jsOptions = jsSubscriptionOptions as js.JsObject;
    final keys = js.context['Object'].callMethod('keys', [jsOptions]);

    for (final key in keys) {
      final option = jsOptions[key];
      final pricingPhases = [
        _convertJsPricingPhase(option['base']),
      ];
      if (option['trial'] != null) {
        pricingPhases.insert(0, _convertJsPricingPhase(option['trial']));
      }
      options.add({
        'id': option['id'],
        'storeProductId': storeProductId,
        'productId': storeProductId,
        'priceId': option['priceId'],
        'pricingPhases': pricingPhases,
        'tags': [],
        'isBasePlan': true, // TODO: Support non-base plans
        'billingPeriod': {
          'iso8601': option['base']?['periodDuration'],
          'unit': _convertPeriodUnit(option['base']?['period']?['unit']),
          'value': option['base']?['period']?['number'],
        },
        'isPrepaid': false,
        'presentedOfferingContext':
            null, // TODO: Implement presented offering context
      });
    }

    return options;
  }

  Map<String, dynamic> _convertJsPricingPhase(dynamic phase) => {
        'billingPeriod': {
          'iso8601': phase['periodDuration'],
          'unit': _convertPeriodUnit(phase['period']?['unit']),
          'value': phase['period']?['number'],
        },
        'recurrenceMode': null, // TODO: Support recurrence mode
        'billingCycleCount': phase['cycleCount'],
        'price': phase['price'] != null
            ? {
                'amountMicros': phase['price']['amountMicros'],
                'currencyCode': phase['price']['currency'],
                'formatted': phase['price']['formattedPrice'],
              }
            : {
                'amountMicros': 0,
                'currencyCode':
                    'USD', // TODO: Fix handling of free trial phases. Shouldn't assume USD
                'formatted': '\$0',
              },
        'offerPaymentMode': null, // TODO: Support offer payment mode
      };

  String _convertPeriodUnit(String periodUnit) =>
      {
        'day': 'DAY',
        'week': 'WEEK',
        'month': 'MONTH',
        'year': 'YEAR',
      }[periodUnit] ??
      'UNKNOWN';

  Map<String, dynamic> _convertJsOffering(dynamic jsOffering) {
    var metadata = <String, dynamic>{};
    if (jsOffering['metadata'] != null) {
      metadata = _jsObjectToMap(jsOffering['metadata']);
    }
    return {
      'identifier': jsOffering['identifier'],
      'serverDescription': jsOffering['serverDescription'],
      'metadata': metadata,
      'availablePackages': _convertJsPackages(jsOffering['availablePackages']),
      'lifetime': _findPackageByType(
        jsOffering['availablePackages'],
        WebPackageType.lifetime,
      ),
      'annual': _findPackageByType(
        jsOffering['availablePackages'],
        WebPackageType.annual,
      ),
      'sixMonth': _findPackageByType(
        jsOffering['availablePackages'],
        WebPackageType.sixMonth,
      ),
      'threeMonth': _findPackageByType(
        jsOffering['availablePackages'],
        WebPackageType.threeMonth,
      ),
      'twoMonth': _findPackageByType(
        jsOffering['availablePackages'],
        WebPackageType.twoMonth,
      ),
      'monthly': _findPackageByType(
        jsOffering['availablePackages'],
        WebPackageType.monthly,
      ),
      'weekly': _findPackageByType(
        jsOffering['availablePackages'],
        WebPackageType.weekly,
      ),
    };
  }

  dynamic _jsValueToDart(dynamic value) {
    if (value is js.JsObject) {
      return _jsObjectToMap(value);
    } else if (value is List) {
      return value.map(_jsValueToDart).toList();
    } else {
      return value;
    }
  }

  Map<String, dynamic> _jsObjectToMap(js.JsObject jsObject) {
    final map = <String, dynamic>{};

    final keys = js.context['Object'].callMethod('keys', [jsObject]);

    for (final key in List<String>.from(keys)) {
      final value = jsObject[key];
      map[key] = _jsValueToDart(value);
    }

    return map;
  }

  Map<String, dynamic>? _convertPresentedOfferingContext(
    dynamic presentedOfferingContext,
  ) {
    if (presentedOfferingContext == null) {
      return null;
    }

    Map<String, dynamic>? targetingContext;
    if (presentedOfferingContext['targetingContext'] != null) {
      targetingContext = {
        'ruleId': presentedOfferingContext['targetingContext']['ruleId'],
        'revision': presentedOfferingContext['targetingContext']['revision'],
      };
    }

    return {
      'offeringIdentifier': presentedOfferingContext['offeringIdentifier'],
      'placementIdentifier': presentedOfferingContext['placementIdentifier'],
      'targetingContext': targetingContext,
    };
  }

  PurchasesErrorCode _mapJsErrorToPurchasesErrorCode(dynamic error) {
    final errorCode = error?.errorCode ?? -1;
    final errorType = error?.type?.toString().toLowerCase() ?? '';
    final errorMessage = error?.message?.toString().toLowerCase() ?? '';

    switch (errorCode) {
      case 0:
        return PurchasesErrorCode.unknownError;
      case 1:
        return PurchasesErrorCode.purchaseCancelledError;
      case 2:
        return PurchasesErrorCode.storeProblemError;
      case 3:
        return PurchasesErrorCode.purchaseNotAllowedError;
      case 4:
        return PurchasesErrorCode.purchaseInvalidError;
      case 5:
        return PurchasesErrorCode.productNotAvailableForPurchaseError;
      case 6:
        return PurchasesErrorCode.productAlreadyPurchasedError;
      case 7:
        return PurchasesErrorCode.receiptAlreadyInUseError;
      case 8:
        return PurchasesErrorCode.invalidReceiptError;
      case 9:
        return PurchasesErrorCode.missingReceiptFileError;
      case 10:
        return PurchasesErrorCode.networkError;
      case 11:
        return PurchasesErrorCode.invalidCredentialsError;
      case 12:
        return PurchasesErrorCode.unexpectedBackendResponseError;
      case 14:
        return PurchasesErrorCode.invalidAppUserIdError;
      case 15:
        return PurchasesErrorCode.operationAlreadyInProgressError;
      case 16:
        return PurchasesErrorCode.unknownBackendError;
      case 17:
        return PurchasesErrorCode.invalidAppleSubscriptionKeyError;
      case 18:
        return PurchasesErrorCode.ineligibleError;
      case 19:
        return PurchasesErrorCode.insufficientPermissionsError;
      case 20:
        return PurchasesErrorCode.paymentPendingError;
      case 21:
        return PurchasesErrorCode.invalidSubscriberAttributesError;
      case 22:
        return PurchasesErrorCode.logOutWithAnonymousUserError;
      case 23:
        return PurchasesErrorCode.configurationError;
      case 24:
        return PurchasesErrorCode.unsupportedError;
      case 25:
        return PurchasesErrorCode.emptySubscriberAttributesError;
      case 28:
        return PurchasesErrorCode.customerInfoError;
    }

    switch (errorType) {
      case 'network_error':
        return PurchasesErrorCode.networkError;
      case 'configuration_error':
        return PurchasesErrorCode.configurationError;
      default:
        if (errorMessage.contains('offline') ||
            errorMessage.contains('network')) {
          return PurchasesErrorCode.offlineConnectionError;
        } else if (errorMessage.contains('configuration')) {
          return PurchasesErrorCode.configurationError;
        }
        return PurchasesErrorCode.unknownError;
    }
  }
}
