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
            'https://unpkg.com/@revenuecat/purchases-js-hybrid-mappings@0.0.7-alpha.1/dist/index.umd.js'
        ..type = 'text/javascript';

      final completer = Completer<void>();

      script.onLoad.listen((_) {
        if (js.context.hasProperty('PurchasesHybridMappings')) {
          completer.complete();
        } else {
          completer.completeError('PurchasesHybridMappings object not found on window');
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
    if (js.context.hasProperty('PurchasesHybridMappings')) {
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

      if (!js.context.hasProperty('PurchasesHybridMappings')) {
        throw PlatformException(
          code: 'SDKNotLoaded',
          message:
              'Purchases hybrid mappings SDK not found on window object. Make sure the SDK is properly loaded.',
        );
      }

      var purchases = js.context['PurchasesHybridMappings'];

      if (purchases.hasProperty('PurchasesCommon')) {
        purchases = purchases['PurchasesCommon'];
      }

      final apiKey = arguments['apiKey'] as String?;
      if (apiKey == null) {
        throw PlatformException(
          code: 'ConfigurationError',
          message: 'API key is required',
        );
      }

      final appUserId = arguments['appUserId'] as String?;

      final options = js.JsObject.jsify({
        'apiKey': apiKey,
        'appUserId': appUserId,
      });

      purchases.callMethod('configure', [options]);
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
      var purchases = js.context['PurchasesHybridMappings'];

      if (purchases == null) {
        throw PlatformException(
          code: 'SDKNotLoaded',
          message: 'Purchases SDK not found on window object after loading.',
        );
      }

      if (purchases.hasProperty('PurchasesCommon')) {
        purchases = purchases['PurchasesCommon'];
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
    final purchases = _getStaticPurchasesCommon();

    return purchases.callMethod('isConfigured') as bool;
  }

  js.JsObject _getInstance() {
    final purchases = _getStaticPurchasesCommon();

    if (!_isConfigured()) {
      throw PlatformException(
        code: PurchasesErrorCode.configurationError.index.toString(),
        message: 'Purchases SDK not configured. Call configure first.',
      );
    }

    return purchases.callMethod('getInstance');
  }

  js.JsObject _getStaticPurchasesCommon() {
    var purchases = js.context['PurchasesHybridMappings'];
    if (purchases.hasProperty('PurchasesCommon')) {
      purchases = purchases['PurchasesCommon'];
    }
    return purchases;
  }

  Future<Map<String, dynamic>> _getCustomerInfo() async {
    final completer = Completer<Map<String, dynamic>>();
    final instance = _getInstance();

    final promise = instance.callMethod('getCustomerInfo', []);
    promise.callMethod(
      'then',
      [
        js.allowInterop(
          (result) => completer.complete(_convertJsRecordToMap(result)),
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
          (result) => completer.complete(_convertJsRecordToMap(result)),
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
            completer.complete(_convertJsRecordToMap(result));
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

    final promise = instance.callMethod('logIn', [appUserId]);
    promise.callMethod(
      'then',
      [
        js.allowInterop(
          (result) => completer.complete(_convertJsRecordToMap(result)),
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

  Future<Map<String, dynamic>> _logOut() async {
    final completer = Completer<Map<String, dynamic>>();
    final instance = _getInstance();

    final promise = instance.callMethod('logOut');
    promise.callMethod(
      'then',
      [
        js.allowInterop(
              (result) => completer.complete(_convertJsRecordToMap(result)),
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
    final packageIdentifier = arguments['packageIdentifier'] as String;
    final options = js.JsObject.jsify({
      'packageIdentifier': packageIdentifier,
      'presentedOfferingContext': arguments['presentedOfferingContext'],
    });
    final promise =
        instance.callMethod('purchasePackage', [options]);
    promise.callMethod(
      'then',
      [
        js.allowInterop(
          (result) => completer.complete(_convertJsRecordToMap(result)),
        ),
      ],
    ).callMethod('catch', [
      js.allowInterop(
        (error) {
          final errorMap = _convertJsRecordToMap(error);
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
    js.context['PurchasesHybridMappings'] = null;
  }

  Future<bool> _isAnonymous() async {
    try {
      final instance = _getInstance();
      return instance.callMethod('isAnonymous') as bool;
    } catch (e) {
      throw PlatformException(
        code: 'AnonymousCheckError',
        message: 'Error checking user anonymous status: $e',
      );
    }
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
    final proxyURL = arguments['proxyURLString'] as String;
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

  dynamic _convertJsToDart(dynamic jsValue) {
    if (jsValue is js.JsObject) {
      final isArray = js.context['Array'].callMethod('isArray', [jsValue]);
      if (isArray) {
        return _convertJsArrayToList(jsValue);
      } else {
        return _convertJsRecordToMap(jsValue);
      }
    }
    return jsValue;
  }

  List<dynamic> _convertJsArrayToList(js.JsObject jsArray) {
    final length = jsArray['length'];
    final list = <dynamic>[];
    for (var i = 0; i < length; i++) {
      final element = jsArray[i];
      list.add(_convertJsToDart(element));
    }
    return list;
  }

  Map<String, dynamic> _convertJsRecordToMap(js.JsObject jsRecord) {
    final result = <String, dynamic>{};

    final keys = js.context['Object'].callMethod('keys', [jsRecord]);
    final length = keys['length'];

    for (var i = 0; i < length; i++) {
      final key = keys[i];
      final value = jsRecord[key];
      result[key] = _convertJsToDart(value);
    }
    return result;
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
