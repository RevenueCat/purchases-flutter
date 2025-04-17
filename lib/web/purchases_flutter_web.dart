import 'dart:async';
import 'dart:html' as html;
import 'dart:js' as js;
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import '../purchases_flutter.dart';

class PurchasesFlutterPlugin {
  static final _unknownErrorCode = '${PurchasesErrorCode.unknownError.index}';
  static final _configurationErrorCode = '${PurchasesErrorCode.configurationError.index}';

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
        case 'checkTrialOrIntroductoryPriceEligibility':
          return _checkTrialOrIntroductoryPriceEligibility(call.arguments);
        case 'setProxyURL':
          return _setProxyURL(call.arguments);
        case 'canMakePayments':
          return Future.value(true);
        case 'isWebPurchaseRedemptionURL':
          return Future.value(false);

        case 'syncPurchases':
        case 'collectDeviceIdentifiers':
        case 'invalidateCustomerInfoCache':
        case 'setAttributes':
        case 'showInAppMessages':
        case 'enableAdServicesAttributionTokenCollection':
        case 'setSimulatesAskToBuyInSandbox':
        case 'setAllowSharingStoreAccount':
          // No-op on web
          return Future.value();

        case 'purchase':
        case 'purchaseProduct':
        case 'recordPurchase':
        case 'getPromotionalOffer':
        case 'purchaseDiscountedPackage':
        case 'purchaseDiscountedProduct':
        case 'purchaseSubscriptionOption':
        case 'presentCodeRedemptionSheet':
        case 'beginRefundRequestForEntitlement':
        case 'beginRefundRequestForProduct':
        case 'beginRefundRequestForActiveEntitlement':
        case 'purchasePackageWithWinBackOffer':
        case 'purchaseProductWithWinBackOffer':
        case 'getEligibleWinBackOffersForProduct':
        case 'redeemWebPurchase':
          throw UnsupportedPlatformException();

        default:
          throw UnsupportedError(
            '${call.method} not implemented on web platform.',
          );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _setupPurchases(dynamic arguments) async {
    try {
      await js.context['purchasesLoaded'];

      final purchases = _getStaticPurchasesCommon();

      final apiKey = arguments['apiKey'] as String?;
      if (apiKey == null) {
        throw PlatformException(
          code: _configurationErrorCode,
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
        code: _configurationErrorCode,
        message: 'Purchases SDK not configured. Call configure first.',
      );
    }
  }

  Future<void> _setLogLevel(dynamic arguments) async {
    await js.context['purchasesLoaded'];
    final purchasesStaticCommon = _getStaticPurchasesCommon();
    try {
      final logLevel = arguments['level'] as String;
      final jsLogLevel = _convertLogLevel(logLevel);
      purchasesStaticCommon.callMethod('setLogLevel', [jsLogLevel]);
    } catch (e) {
      throw PlatformException(
        code: _unknownErrorCode,
        message: 'Error setting log level: $e',
      );
    }
  }

  String _convertLogLevel(String logLevel) {
    switch (logLevel.toLowerCase()) {
      case 'verbose':
        return 'VERBOSE';
      case 'debug':
        return 'DEBUG';
      case 'info':
        return 'INFO';
      case 'warn':
        return 'WARN';
      case 'error':
        return 'ERROR';
      default:
        return 'SILENT';
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
        code: _configurationErrorCode,
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
    if (purchases == null) {
      throw PlatformException(
        code: _configurationErrorCode,
        message: 'Purchases SDK not found on window object after loading.',
      );
    }
    return purchases;
  }

  Future<Map<String, dynamic>> _getCustomerInfo() async =>
      await _getMapFromInstanceMethod('getCustomerInfo', []);

  Future<Map<String, dynamic>> _getOfferings() async =>
      await _getMapFromInstanceMethod('getOfferings', []);

  Future<Map<String, dynamic>?> _getCurrentOfferingForPlacement(
    dynamic arguments,
  ) async {
    final placementIdentifier = arguments['placementIdentifier'] as String;
    return await _getNullableMapFromInstanceMethod(
        'getCurrentOfferingForPlacement',
        [placementIdentifier],
    );
  }

  Future<String> _getAppUserID() async {
    final instance = _getInstance();
    try {
      final result = instance.callMethod('getAppUserId', []);
      return result.toString();
    } catch (e) {
      throw PlatformException(
        code: _unknownErrorCode,
        message: 'Error getting app user ID: $e',
      );
    }
  }

  Future<Map<String, dynamic>> _logIn(dynamic arguments) async {
    final appUserId = arguments['appUserId'] as String;
    return await _getMapFromInstanceMethod('logIn', [appUserId]);
  }

  Future<Map<String, dynamic>> _logOut() async =>
      await _getMapFromInstanceMethod('logOut', []);

  Future<Map<String, dynamic>> _purchasePackage(dynamic arguments) async {
    final packageIdentifier = arguments['packageIdentifier'] as String;
    final options = js.JsObject.jsify({
      'packageIdentifier': packageIdentifier,
      'presentedOfferingContext': arguments['presentedOfferingContext'],
    });
    return await _getMapFromInstanceMethod('purchasePackage', [options]);
  }

  Future<Map<String, dynamic>> _restorePurchases() async =>
    // Web SDK doesn't support restore purchases, but returns current customer info
    // to match behavior with other platforms
    await _getCustomerInfo();

  Future<void> _close() async {
    // Web SDK's close() just unsets the instance
    js.context['PurchasesHybridMappings'] = null;
  }

  Future<bool> _isAnonymous() async {
    final instance = _getInstance();
    try {
      return instance.callMethod('isAnonymous') as bool;
    } catch (e) {
      throw PlatformException(
        code: _unknownErrorCode,
        message: 'Error checking user anonymous status: $e',
      );
    }
  }

  Future<bool> _isSandbox() async {
    final instance = _getInstance();
    try {
      return instance.callMethod('isSandbox') as bool;
    } catch (e) {
      throw PlatformException(
        code: _unknownErrorCode,
        message: 'Error checking sandbox status: $e',
      );
    }
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

  Future<void> _setProxyURL(dynamic arguments) async {
    final proxyURL = arguments['proxyURLString'] as String?;
    if (proxyURL == null) {
      throw PlatformException(
        code: '${PurchasesErrorCode.configurationError.index}',
        message: 'Proxy URL is required',
      );
    }
    final completer = Completer<void>();

    final purchasesCommonStatic = _getStaticPurchasesCommon();
    final promise = purchasesCommonStatic.callMethod('setProxyUrl', [proxyURL]);
    promise.callMethod('then', [
      js.allowInterop((result) => completer.complete()),
    ]).callMethod('catch', [
      js.allowInterop((error) => completer.completeError(_processError(error))),
    ]);
  }

  // Helper functions to handle JS interop

  Future<Map<String, dynamic>> _getMapFromInstanceMethod(
      String methodName,
      List<dynamic> args,
      ) async {
    final completer = Completer<Map<String, dynamic>>();
    final instance = _getInstance();

    final promise = instance.callMethod(methodName, args);
    promise.callMethod('then', [
      js.allowInterop((result) => completer.complete(_convertJsRecordToMap(result))),
    ]).callMethod('catch', [
      js.allowInterop((error) => completer.completeError(_processError(error))),
    ]);

    return completer.future;
  }

  Future<Map<String, dynamic>?> _getNullableMapFromInstanceMethod(
      String methodName,
      List<dynamic> args,
      ) async {
    final completer = Completer<Map<String, dynamic>?>();
    final instance = _getInstance();

    final promise = instance.callMethod(methodName, args);
    promise.callMethod('then', [
      js.allowInterop((result) {
        if (result == null) {
          completer.complete(null);
        } else {
          completer.complete(_convertJsRecordToMap(result));
        }
      }),
    ]).callMethod('catch', [
      js.allowInterop((error) => completer.completeError(_processError(error))),
    ]);

    return completer.future;
  }

  PlatformException _processError(dynamic error) {
    if (error is js.JsObject && error.hasProperty('code')) {
      final errorMap = _convertJsRecordToMap(error);
      final code = errorMap['code'];
      final message = errorMap['message'] as String?;
      final underlyingErrorMessage = errorMap['underlyingErrorMessage'] as String?;
      final finalMessage = '$message. $underlyingErrorMessage';
      return PlatformException(
        code: '$code',
        message: finalMessage,
        details: errorMap,
      );
    } else {
      return PlatformException(
        code: _unknownErrorCode,
        message: error.toString(),
      );
    }
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
}
