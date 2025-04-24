import 'dart:async';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:web/web.dart';

import '../purchases_flutter.dart';

class PurchasesFlutterPlugin {
  static final _unknownErrorCode = '${PurchasesErrorCode.unknownError.index}';
  static final _configurationErrorCode = '${PurchasesErrorCode.configurationError.index}';
  static const _platformName = 'flutter';
  static const _pluginVersion = '8.7.3';

  static Completer<void>? _initCompleter;

  static void _injectScriptIfNeeded() {
    if (_initCompleter != null) {
      return;
    }
    _initCompleter = Completer<void>();

    // TODO: Host library ourselves.
    const library = 'https://unpkg.com/@revenuecat/purchases-js-hybrid-mappings@0.0.7-alpha.2/dist/index.umd.js';

    final script = HTMLScriptElement()
      ..type = 'text/javascript'
      ..text = '''
        window.after_rc_load_callback = async (callback) => {
          callback(await import("$library"));
        };
      ''';

    final head = document.head;
    if (head == null) {
      throw StateError(
        "The current document doesn't have a head element which is required to insert a script.",
      );
    }
    
    head.append(script);

    globalContext.callMethod(
      'after_rc_load_callback'.toJS,
      ((JSAny? module) {
        globalContext['revenuecat'] = module;
        globalContext.delete('after_rc_load_callback'.toJS);
        _initCompleter?.complete();
      }).toJS,
    );
  }

  static void registerWith(Registrar registrar) {
    final channel = MethodChannel(
      'purchases_flutter',
      const StandardMethodCodec(),
      registrar,
    );

    final instance = PurchasesFlutterPlugin();
    channel.setMethodCallHandler(instance.handleMethodCall);

    _injectScriptIfNeeded();
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    if (_initCompleter == null) {
      throw PlatformException(
          code: _unknownErrorCode,
          message: 'Purchases SDK not loaded on method call: ${call.method}',
      );
    }
    await _initCompleter?.future;
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
      final apiKey = arguments['apiKey'] as String?;
      if (apiKey == null) {
        throw PlatformException(
          code: _configurationErrorCode,
          message: 'API key is required',
        );
      }

      final appUserId = arguments['appUserId'] as String?;

      final options = {
        'apiKey': apiKey,
        'appUserId': appUserId,
        'flavor': _platformName,
        'flavorVersion': _pluginVersion,
      };

      _callStaticMethod('configure', [options]);
    } catch (e) {
      throw PlatformException(
        code: _configurationErrorCode,
        message: 'Purchases SDK not configured. Call configure first.',
      );
    }
  }

  Future<void> _setLogLevel(dynamic arguments) async {
    final logLevel = arguments['level'] as String;
    final jsLogLevel = _convertLogLevel(logLevel);
    _callStaticMethod('setLogLevel', [jsLogLevel]);
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

  bool _isConfigured() => _callStaticMethod('isConfigured', []) as bool;

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
    final purchases = _getInstance();
    return purchases.callMethod('getAppUserId'.toJS).dartify().toString();
  }

  Future<Map<String, dynamic>> _logIn(dynamic arguments) async {
    final appUserId = arguments['appUserID'] as String;
    final result = await _getMapFromInstanceMethod('logIn', [appUserId]);
    return result;
  }

  Future<Map<String, dynamic>> _logOut() async =>
      await _getMapFromInstanceMethod('logOut', []);

  Future<Map<String, dynamic>> _purchasePackage(dynamic arguments) async {
    final packageIdentifier = arguments['packageIdentifier'] as String;
    final options = {
      'packageIdentifier': packageIdentifier,
      'presentedOfferingContext': arguments['presentedOfferingContext'],
    };
    return await _getMapFromInstanceMethod('purchasePackage', [options]);
  }

  Future<Map<String, dynamic>> _restorePurchases() async =>
    // Web SDK doesn't support restore purchases, but returns current customer info
    // to match behavior with other platforms
    await _getCustomerInfo();

  Future<void> _close() async {
    // Web SDK's close() just unsets the instance
    // TODO
    // js.context['PurchasesHybridMappings'] = null;
  }

  Future<bool> _isAnonymous() async {
    final purchases = _getInstance();
    return purchases.callMethod('isAnonymous'.toJS).dartify() as bool;
  }

  Future<bool> _isSandbox() async {
    final purchases = _getInstance();
    return purchases.callMethod('isSandbox'.toJS).dartify() as bool;
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
    return _callStaticMethodReturningPromise('setProxyUrl', [proxyURL]);
  }

  // Helper functions to handle JS interop

  Object? _callStaticMethod(
    String methodName,
    List<dynamic> args,
  ) {
    final purchasesStatic = _getStaticPurchasesCommon();
    final processedArgs = _processArgs(args);

    try {
      return purchasesStatic.callMethodVarArgs(
          methodName.toJS,
          processedArgs,
      ).dartify();
    } catch (e) {
      throw PlatformException(
        code: _unknownErrorCode,
        message: 'Error calling static method $methodName: $e',
      );
    }
  }

  JSObject _callInstanceMethod(
      String methodName,
      List<dynamic> args,
  ) {
    final purchases = _getInstance();
    final jsArgs = _processArgs(args);
    return purchases.callMethodVarArgs(methodName.toJS, jsArgs);
  }

  JSObject _getInstance() {
    final purchases = _getStaticPurchasesCommon();

    if (!_isConfigured()) {
      throw PlatformException(
        code: _configurationErrorCode,
        message: 'Purchases SDK not configured. Call configure first.',
      );
    }

    return purchases.callMethod('getInstance'.toJS);
  }

  JSObject _getStaticPurchasesCommon() {
    final purchasesHybridMappings = globalContext['PurchasesHybridMappings'] as JSObject;
    JSObject? purchasesCommon;
    if (purchasesHybridMappings.has('PurchasesCommon')) {
      purchasesCommon = purchasesHybridMappings['PurchasesCommon'] as JSObject;
    }
    if (purchasesCommon == null) {
      throw PlatformException(
        code: _configurationErrorCode,
        message: 'Purchases SDK not found on window object after loading.',
      );
    }
    return purchasesCommon;
  }

  Future _callStaticMethodReturningPromise(
      String methodName,
      List<dynamic> args,
      ) async {
    final promise = _callStaticMethod(methodName, args) as JSPromise;
    return promise.toDart
        .catchError((error) => throw _processError(error));
  }

  Future<Map<String, dynamic>> _getMapFromInstanceMethod(
      String methodName,
      List<dynamic> args,
  ) async {
    final promise = _callInstanceMethod(methodName, args) as JSPromise;

    return promise.toDart
        .then(_convertJsRecordToMap)
        .catchError((error) => throw _processError(error));
  }

  Future<Map<String, dynamic>?> _getNullableMapFromInstanceMethod(
      String methodName,
      List<dynamic> args,
  ) async {
    final promise = _callInstanceMethod(methodName, args) as JSPromise;

    return promise.toDart
        .then((value) {
          if (value == null) {
            return null;
          }
          return _convertJsRecordToMap(value);
        })
        .catchError((error) => throw _processError(error));
  }

  List<JSAny?> _processArgs(List<dynamic> args) {
    final jsArgs = <JSAny?>[];
    for (final arg in args) {
      if (arg is Map<String, dynamic>) {
        jsArgs.add(arg.jsify());
      } else if (arg is List) {
        jsArgs.add(arg.jsify());
      } else if (arg is String) {
        jsArgs.add(arg.toJS);
      } else if (arg is int) {
        jsArgs.add(arg.toJS);
      } else if (arg is bool) {
        jsArgs.add(arg.toJS);
      } else if (arg == null) {
        jsArgs.add(null);
      } else {
        throw ArgumentError(
          'Unsupported argument type: ${arg.runtimeType}',
        );
      }
    }
    return jsArgs;
  }

  PlatformException _processError(dynamic error) {
    if (error is JSObject && error.has('code')) {
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

  Map<String, dynamic> _convertJsRecordToMap(JSAny? jsRecord) {
    if (jsRecord == null) {
      throw ArgumentError('returned result cannot be null');
    } else {
      return Map<String, dynamic>.from(
          jsRecord.dartify() as Map<dynamic, dynamic>,
      );
    }
  }
}
