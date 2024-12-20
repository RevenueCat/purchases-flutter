import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

// ignore_for_file: deprecated_member_use_from_same_package

/// Testing utility that allows you to emit messages as if they were coming directly from the native SDKs.
/// This is useful to test the Flutter response for listeners set on the native SDKs.
/// Make sure you don't mock the MethodChannel when using this.
/// To mock a call from the native SDKs to Flutter, just pass the method name that Flutter
/// expects, then the parameters the SDK would send to Flutter on that call.
void _performDartSideChannelMethodCall(String methodName, dynamic params) {
  final methodCall = MethodCall(methodName, params);
  ServicesBinding.instance.channelBuffers.push(
    'purchases_flutter',
    const StandardMethodCodec().encodeMethodCall(methodCall),
    (ByteData? data) {},
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('purchases_flutter');
  final log = <MethodCall>[];
  dynamic response;
  final randomGenerator = Random(DateTime.now().microsecondsSinceEpoch);
  final mockCustomerInfoResponse = {
    'originalAppUserId': 'pepe',
    'entitlements': {'all': {}, 'active': {}, 'verification': 'NOT_REQUESTED'},
    'activeSubscriptions': [],
    'latestExpirationDate': '2021-04-09T14:48:00.000Z',
    'allExpirationDates': {},
    'allPurchasedProductIdentifiers': [],
    'firstSeen': '2021-01-09T14:48:00.000Z',
    'requestDate': '2021-04-09T14:48:00.000Z',
    'allPurchaseDates': {},
    'originalApplicationVersion': '1.2.3',
    'nonSubscriptionTransactions': [],
  };

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
      log.add(call);
      return response;
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
    log.clear();
    response = null;
  });

  test('setupPurchases', () async {
    await Purchases.setup(
      'api_key',
      appUserId: 'cesar',
    );
    expect(
      log,
      <Matcher>[
        isMethodCall(
          'setupPurchases',
          arguments: <String, dynamic>{
            'apiKey': 'api_key',
            'appUserId': 'cesar',
            'purchasesAreCompletedBy': 'REVENUECAT',
            'userDefaultsSuiteName': null,
            'useAmazon': false,
            'storeKitVersion': 'DEFAULT',
            'shouldShowInAppMessagesAutomatically': true,
            'entitlementVerificationMode': 'DISABLED',
            'pendingTransactionsForPrepaidPlansEnabled': false,
          },
        ),
      ],
    );
  });

  test('setupPurchases with purchasesAreCompletedBy', () async {
    await Purchases.setup(
      'api_key',
      appUserId: 'cesar',
      purchasesAreCompletedBy: PurchasesAreCompletedByMyApp(
        storeKitVersion: StoreKitVersion.storeKit2,
      ),
    );
    expect(
      log,
      <Matcher>[
        isMethodCall(
          'setupPurchases',
          arguments: <String, dynamic>{
            'apiKey': 'api_key',
            'appUserId': 'cesar',
            'purchasesAreCompletedBy': 'MY_APP',
            'userDefaultsSuiteName': null,
            'useAmazon': false,
            'storeKitVersion': 'STOREKIT_2',
            'shouldShowInAppMessagesAutomatically': true,
            'entitlementVerificationMode': 'DISABLED',
            'pendingTransactionsForPrepaidPlansEnabled': false,
          },
        ),
      ],
    );
  });

  test('setupPurchases with storeKitVersion', () async {
    await Purchases.setup(
      'api_key',
      appUserId: 'will',
      storeKitVersion: StoreKitVersion.storeKit1,
    );
    expect(
      log,
      <Matcher>[
        isMethodCall(
          'setupPurchases',
          arguments: <String, dynamic>{
            'apiKey': 'api_key',
            'appUserId': 'will',
            'purchasesAreCompletedBy': 'REVENUECAT',
            'userDefaultsSuiteName': null,
            'useAmazon': false,
            'storeKitVersion': 'STOREKIT_1',
            'shouldShowInAppMessagesAutomatically': true,
            'entitlementVerificationMode': 'DISABLED',
            'pendingTransactionsForPrepaidPlansEnabled': false,
          },
        ),
      ],
    );
  });

  test('setupPurchases with conflicting storeKitVersions', () async {
    await Purchases.setup(
      'api_key',
      appUserId: 'will',
      purchasesAreCompletedBy: PurchasesAreCompletedByMyApp(
        storeKitVersion: StoreKitVersion.storeKit2,
      ),
      storeKitVersion: StoreKitVersion.storeKit1,
    );
    expect(
      log,
      <Matcher>[
        isMethodCall(
          'setupPurchases',
          arguments: <String, dynamic>{
            'apiKey': 'api_key',
            'appUserId': 'will',
            'purchasesAreCompletedBy': 'MY_APP',
            'userDefaultsSuiteName': null,
            'useAmazon': false,
            'storeKitVersion': 'STOREKIT_2',
            'shouldShowInAppMessagesAutomatically': true,
            'entitlementVerificationMode': 'DISABLED',
            'pendingTransactionsForPrepaidPlansEnabled': false,
          },
        ),
      ],
    );
  });

  test(
      'addCustomerInfoUpdateListener does not call listener if it does not have one',
      () async {
    Purchases.addCustomerInfoUpdateListener((customerInfo) {
      fail(
        'listener should not be called if previous customer info was not set',
      );
    });
    expect(log, <Matcher>[]);
  });

  test(
      'addCustomerInfoUpdateListener calls each listener immediately if it has an existing customer info',
      () async {
    /// Making sure we don't mock the MethodChannel before mocking native to Flutter calls.
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
    _performDartSideChannelMethodCall(
      'Purchases-CustomerInfoUpdated',
      mockCustomerInfoResponse,
    );
    var listener1Called = false;
    Purchases.addCustomerInfoUpdateListener((customerInfo) {
      expect(customerInfo.originalAppUserId, 'pepe');
      listener1Called = true;
    });
    var listener2Called = false;
    Purchases.addCustomerInfoUpdateListener((customerInfo) {
      expect(customerInfo.originalAppUserId, 'pepe');
      listener2Called = true;
    });
    expect(listener1Called, true);
    expect(listener2Called, true);
  });

  test(
      'addCustomerInfoUpdateListener calls each listener immediately with latest customer info',
      () async {
    /// Making sure we don't mock the MethodChannel before mocking native to Flutter calls.
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
    _performDartSideChannelMethodCall(
      'Purchases-CustomerInfoUpdated',
      mockCustomerInfoResponse,
    );
    var listener1Called = false;
    Purchases.addCustomerInfoUpdateListener((customerInfo) {
      expect(customerInfo.originalAppUserId, 'pepe');
      listener1Called = true;
    });
    final mockCustomerInfoResponse2 =
        Map<String, dynamic>.from(mockCustomerInfoResponse);
    mockCustomerInfoResponse2['originalAppUserId'] = 'pepe2';
    _performDartSideChannelMethodCall(
      'Purchases-CustomerInfoUpdated',
      mockCustomerInfoResponse2,
    );
    var listener2Called = false;
    Purchases.addCustomerInfoUpdateListener((customerInfo) {
      expect(customerInfo.originalAppUserId, 'pepe2');
      listener2Called = true;
    });
    expect(listener1Called, true);
    expect(listener2Called, true);
  });

  test('getProductsList returns list of products', () async {
    response = [
      {
        'identifier': 'monthly_intro_pricing_one_week',
        'description': 'Monthly Product Intro Pricing One Week',
        'title': 'Monthly Product Intro Pricing One Week (PurchasesSample)',
        'price': 4.99,
        'priceString': '\$4.99',
        'currencyCode': 'USD',
        'introPrice': {
          'price': 0,
          'priceString': '\$0.00',
          'period': 'P1W',
          'cycles': 1,
          'periodUnit': 'DAY',
          'periodNumberOfUnits': 7,
        },
        'discounts': null,
      }
    ];
    final list = await Purchases.getProducts(['sku_a']);
    expect(list.length, 1);
  });

  test('canMakePayments with no params calls successfully', () async {
    response = Random().nextBool();
    final receivedCanMakePayments = await Purchases.canMakePayments();

    expect(receivedCanMakePayments, response);
    expect(log, <Matcher>[
      isMethodCall('canMakePayments', arguments: {'features': []}),
    ]);
  });

  test('canMakePayments with empty list calls successfully', () async {
    response = Random().nextBool();
    final receivedCanMakePayments = await Purchases.canMakePayments([]);

    expect(receivedCanMakePayments, response);
    expect(log, <Matcher>[
      isMethodCall('canMakePayments', arguments: {'features': []}),
    ]);
  });

  test('canMakePayments with params calls successfully', () async {
    response = Random().nextBool();
    final receivedCanMakePayments =
        await Purchases.canMakePayments([BillingFeature.subscriptions]);

    expect(receivedCanMakePayments, response);
    expect(log, <Matcher>[
      isMethodCall(
        'canMakePayments',
        arguments: {
          'features': [0],
        },
      ),
    ]);
  });

  test('canMakePayments params mapped to ordinals successfully', () async {
    response = Random().nextBool();
    final receivedCanMakePayments = await Purchases.canMakePayments([
      BillingFeature.subscriptions,
      BillingFeature.priceChangeConfirmation,
      BillingFeature.subscriptionsOnVr,
      BillingFeature.subscriptionsUpdate,
      BillingFeature.inAppItemsOnVr,
    ]);

    expect(receivedCanMakePayments, response);
    expect(log, <Matcher>[
      isMethodCall(
        'canMakePayments',
        arguments: {
          'features': [0, 4, 3, 1, 2],
        },
      ),
    ]);
  });

  test('logIn calls successfully', () async {
    try {
      final mockCreated = randomGenerator.nextBool();
      response = {
        'created': mockCreated,
        'customerInfo': mockCustomerInfoResponse,
      };
      final logInResult = await Purchases.logIn('appUserID');
      expect(
        logInResult.customerInfo,
        CustomerInfo.fromJson(mockCustomerInfoResponse),
      );
      expect(logInResult.created, mockCreated);
    } on PlatformException catch (e) {
      fail('there was an exception $e');
    }
  });

  test('logOut calls successfully', () async {
    try {
      response = mockCustomerInfoResponse;
      final customerInfo = await Purchases.logOut();
      expect(
        customerInfo,
        CustomerInfo.fromJson(mockCustomerInfoResponse),
      );
    } on PlatformException catch (e) {
      fail('there was an exception $e');
    }
  });

  test('errors are mapped correctly', () {
    expect(PurchasesErrorCode.unknownError.index, 0);
    expect(PurchasesErrorCode.purchaseCancelledError.index, 1);
    expect(PurchasesErrorCode.storeProblemError.index, 2);
    expect(PurchasesErrorCode.purchaseNotAllowedError.index, 3);
    expect(PurchasesErrorCode.purchaseInvalidError.index, 4);
    expect(PurchasesErrorCode.productNotAvailableForPurchaseError.index, 5);
    expect(PurchasesErrorCode.productAlreadyPurchasedError.index, 6);
    expect(PurchasesErrorCode.receiptAlreadyInUseError.index, 7);
    expect(PurchasesErrorCode.invalidReceiptError.index, 8);
    expect(PurchasesErrorCode.missingReceiptFileError.index, 9);
    expect(PurchasesErrorCode.networkError.index, 10);
    expect(PurchasesErrorCode.invalidCredentialsError.index, 11);
    expect(PurchasesErrorCode.unexpectedBackendResponseError.index, 12);
    expect(PurchasesErrorCode.receiptInUseByOtherSubscriberError.index, 13);
    expect(PurchasesErrorCode.invalidAppUserIdError.index, 14);
    expect(PurchasesErrorCode.operationAlreadyInProgressError.index, 15);
    expect(PurchasesErrorCode.unknownBackendError.index, 16);
    expect(PurchasesErrorCode.invalidAppleSubscriptionKeyError.index, 17);
    expect(PurchasesErrorCode.ineligibleError.index, 18);
    expect(PurchasesErrorCode.insufficientPermissionsError.index, 19);
    expect(PurchasesErrorCode.paymentPendingError.index, 20);
    expect(PurchasesErrorCode.invalidSubscriberAttributesError.index, 21);
    expect(PurchasesErrorCode.logOutWithAnonymousUserError.index, 22);
    expect(PurchasesErrorCode.configurationError.index, 23);
    expect(PurchasesErrorCode.unsupportedError.index, 24);
    expect(PurchasesErrorCode.emptySubscriberAttributesError.index, 25);
    expect(PurchasesErrorCode.productDiscountMissingIdentifierError.index, 26);
    expect(PurchasesErrorCode.unknownNonNativeError.index, 27);
    expect(
      PurchasesErrorCode
          .productDiscountMissingSubscriptionGroupIdentifierError.index,
      28,
    );
    expect(PurchasesErrorCode.customerInfoError.index, 29);
    expect(PurchasesErrorCode.systemInfoError.index, 30);
    expect(PurchasesErrorCode.beginRefundRequestError.index, 31);
    expect(PurchasesErrorCode.productRequestTimeout.index, 32);
    expect(PurchasesErrorCode.apiEndpointBlocked.index, 33);
    expect(PurchasesErrorCode.invalidPromotionalOfferError.index, 34);
    expect(PurchasesErrorCode.offlineConnectionError.index, 35);
  });

  test('PurchasesErrorHelper maps errors correctly', () {
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '0')),
      PurchasesErrorCode.unknownError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '1')),
      PurchasesErrorCode.purchaseCancelledError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '2')),
      PurchasesErrorCode.storeProblemError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '3')),
      PurchasesErrorCode.purchaseNotAllowedError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '4')),
      PurchasesErrorCode.purchaseInvalidError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '5')),
      PurchasesErrorCode.productNotAvailableForPurchaseError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '6')),
      PurchasesErrorCode.productAlreadyPurchasedError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '7')),
      PurchasesErrorCode.receiptAlreadyInUseError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '8')),
      PurchasesErrorCode.invalidReceiptError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '9')),
      PurchasesErrorCode.missingReceiptFileError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '10')),
      PurchasesErrorCode.networkError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '11')),
      PurchasesErrorCode.invalidCredentialsError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '12')),
      PurchasesErrorCode.unexpectedBackendResponseError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '13')),
      PurchasesErrorCode.receiptInUseByOtherSubscriberError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '14')),
      PurchasesErrorCode.invalidAppUserIdError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '15')),
      PurchasesErrorCode.operationAlreadyInProgressError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '16')),
      PurchasesErrorCode.unknownBackendError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '17')),
      PurchasesErrorCode.invalidAppleSubscriptionKeyError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '18')),
      PurchasesErrorCode.ineligibleError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '19')),
      PurchasesErrorCode.insufficientPermissionsError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '20')),
      PurchasesErrorCode.paymentPendingError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '21')),
      PurchasesErrorCode.invalidSubscriberAttributesError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '22')),
      PurchasesErrorCode.logOutWithAnonymousUserError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '23')),
      PurchasesErrorCode.configurationError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '24')),
      PurchasesErrorCode.unsupportedError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '25')),
      PurchasesErrorCode.emptySubscriberAttributesError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '26')),
      PurchasesErrorCode.productDiscountMissingIdentifierError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '27')),
      PurchasesErrorCode.unknownNonNativeError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '28')),
      PurchasesErrorCode.productDiscountMissingSubscriptionGroupIdentifierError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '29')),
      PurchasesErrorCode.customerInfoError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '30')),
      PurchasesErrorCode.systemInfoError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '31')),
      PurchasesErrorCode.beginRefundRequestError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '32')),
      PurchasesErrorCode.productRequestTimeout,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '33')),
      PurchasesErrorCode.apiEndpointBlocked,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '34')),
      PurchasesErrorCode.invalidPromotionalOfferError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '35')),
      PurchasesErrorCode.offlineConnectionError,
    );
    expect(
      PurchasesErrorHelper.getErrorCode(PlatformException(code: '36')),
      PurchasesErrorCode.unknownError,
    );
  });

  test('purchasePackage calls successfully', () async {
    try {
      response = {
        'productIdentifier': 'product.identifier',
        'customerInfo': mockCustomerInfoResponse,
      };
      const mockStoreProduct = StoreProduct(
        'com.revenuecat.lifetime',
        'description',
        'lifetime (PurchasesSample)',
        199.99,
        '\$199.99',
        'USD',
      );
      const mockPackage = Package(
        '\$rc_lifetime',
        PackageType.lifetime,
        mockStoreProduct,
        PresentedOfferingContext('main', null, null),
      );
      final purchasePackageResult =
          await Purchases.purchasePackage(mockPackage);
      expect(
        purchasePackageResult,
        CustomerInfo.fromJson(mockCustomerInfoResponse),
      );

      expect(
        log,
        <Matcher>[
          isMethodCall(
            'purchasePackage',
            arguments: <String, dynamic>{
              'packageIdentifier': '\$rc_lifetime',
              'presentedOfferingContext': <String, dynamic>{
                'offeringIdentifier': 'main',
                'placementIdentifier': null,
                'targetingContext': null,
              },
              'googleOldProductIdentifier': null,
              'googleProrationMode': null,
              'googleIsPersonalizedPrice': null,
            },
          ),
        ],
      );
    } on PlatformException catch (e) {
      fail('there was an exception $e');
    }
  });

  test(
      'purchasePackage with GoogleProductChangeInfo and googleIsPersonalizedPrice calls successfully',
      () async {
    try {
      response = {
        'productIdentifier': 'product.identifier',
        'customerInfo': mockCustomerInfoResponse,
      };
      const mockStoreProduct = StoreProduct(
        'com.revenuecat.lifetime',
        'description',
        'lifetime (PurchasesSample)',
        199.99,
        '\$199.99',
        'USD',
      );
      const mockPackage = Package(
        '\$rc_lifetime',
        PackageType.lifetime,
        mockStoreProduct,
        PresentedOfferingContext('main', null, null),
      );
      final googleProductChangeInfo = GoogleProductChangeInfo(
        'com.revenuecat.weekly',
        prorationMode: GoogleProrationMode.immediateWithTimeProration,
      );
      final purchasePackageResult = await Purchases.purchasePackage(
        mockPackage,
        googleProductChangeInfo: googleProductChangeInfo,
        googleIsPersonalizedPrice: true,
      );
      expect(
        purchasePackageResult,
        CustomerInfo.fromJson(mockCustomerInfoResponse),
      );

      expect(
        log,
        <Matcher>[
          isMethodCall(
            'purchasePackage',
            arguments: <String, dynamic>{
              'packageIdentifier': '\$rc_lifetime',
              'presentedOfferingContext': <String, dynamic>{
                'offeringIdentifier': 'main',
                'placementIdentifier': null,
                'targetingContext': null,
              },
              'googleOldProductIdentifier': 'com.revenuecat.weekly',
              'googleProrationMode': 1,
              'googleIsPersonalizedPrice': true,
            },
          ),
        ],
      );
    } on PlatformException catch (e) {
      fail('there was an exception $e');
    }
  });

  test('purchaseDiscountedPackage calls successfully', () async {
    try {
      response = {
        'productIdentifier': 'product.identifier',
        'customerInfo': mockCustomerInfoResponse,
      };
      const mockStoreProduct = StoreProduct(
        'com.revenuecat.lifetime',
        'description',
        'lifetime (PurchasesSample)',
        199.99,
        '\$199.99',
        'USD',
      );
      const mockPackage = Package(
        '\$rc_lifetime',
        PackageType.lifetime,
        mockStoreProduct,
        PresentedOfferingContext('main', null, null),
      );
      const mockPaymentDiscount = PromotionalOffer(
        'aIdentifier',
        'aKeyIdentifier',
        'aNonce',
        'aSignature',
        123456,
      );
      final purchasePackageResult = await Purchases.purchaseDiscountedPackage(
        mockPackage,
        mockPaymentDiscount,
      );
      expect(
        purchasePackageResult,
        CustomerInfo.fromJson(mockCustomerInfoResponse),
      );
    } on PlatformException catch (e) {
      fail('there was an exception $e');
    }
  });

  test('purchaseProduct calls successfully', () async {
    try {
      response = {
        'productIdentifier': 'product.identifier',
        'customerInfo': mockCustomerInfoResponse,
      };
      const mockStoreProduct = StoreProduct(
        'com.revenuecat.lifetime',
        'description',
        'lifetime (PurchasesSample)',
        199.99,
        '\$199.99',
        'USD',
      );
      final purchasePackageResult = await Purchases.purchaseProduct(
        mockStoreProduct.identifier,
      );
      expect(
        purchasePackageResult,
        CustomerInfo.fromJson(mockCustomerInfoResponse),
      );

      expect(
        log,
        <Matcher>[
          isMethodCall(
            'purchaseProduct',
            arguments: <String, dynamic>{
              'productIdentifier': 'com.revenuecat.lifetime',
              'type': 'subs',
              'googleOldProductIdentifier': null,
              'googleProrationMode': null,
              'googleIsPersonalizedPrice': null,
              'presentedOfferingIdentifier': null,
            },
          ),
        ],
      );
    } on PlatformException catch (e) {
      fail('there was an exception $e');
    }
  });

  test(
      'purchaseProduct with the deprecated PurchaseType.inapp calls successfully',
      () async {
    try {
      response = {
        'productIdentifier': 'product.identifier',
        'customerInfo': mockCustomerInfoResponse,
      };
      const mockStoreProduct = StoreProduct(
        'com.revenuecat.lifetime',
        'description',
        'lifetime (PurchasesSample)',
        199.99,
        '\$199.99',
        'USD',
      );
      final purchasePackageResult = await Purchases.purchaseProduct(
        mockStoreProduct.identifier,
        type: PurchaseType.inapp,
      );
      expect(
        purchasePackageResult,
        CustomerInfo.fromJson(mockCustomerInfoResponse),
      );

      expect(
        log,
        <Matcher>[
          isMethodCall(
            'purchaseProduct',
            arguments: <String, dynamic>{
              'productIdentifier': 'com.revenuecat.lifetime',
              'type': 'inapp',
              'googleOldProductIdentifier': null,
              'googleProrationMode': null,
              'googleIsPersonalizedPrice': null,
              'presentedOfferingIdentifier': null,
            },
          ),
        ],
      );
    } on PlatformException catch (e) {
      fail('there was an exception $e');
    }
  });

  test('purchaseStoreProduct calls successfully', () async {
    try {
      response = {
        'productIdentifier': 'product.identifier',
        'customerInfo': mockCustomerInfoResponse,
      };
      const mockStoreProduct = StoreProduct(
        'com.revenuecat.lifetime',
        'description',
        'lifetime (PurchasesSample)',
        199.99,
        '\$199.99',
        'USD',
        productCategory: ProductCategory.subscription,
        presentedOfferingContext:
            PresentedOfferingContext('my-offer', null, null),
      );
      final purchasePackageResult =
          await Purchases.purchaseStoreProduct(mockStoreProduct);
      expect(
        purchasePackageResult,
        CustomerInfo.fromJson(mockCustomerInfoResponse),
      );

      expect(
        log,
        <Matcher>[
          isMethodCall(
            'purchaseProduct',
            arguments: <String, dynamic>{
              'productIdentifier': 'com.revenuecat.lifetime',
              'type': 'subscription',
              'googleOldProductIdentifier': null,
              'googleProrationMode': null,
              'googleIsPersonalizedPrice': null,
              'presentedOfferingIdentifier': 'my-offer',
            },
          ),
        ],
      );
    } on PlatformException catch (e) {
      fail('there was an exception $e');
    }
  });

  test('purchaseDiscountedProduct calls successfully', () async {
    try {
      response = {
        'productIdentifier': 'product.identifier',
        'customerInfo': mockCustomerInfoResponse,
      };
      const mockStoreProduct = StoreProduct(
        'com.revenuecat.lifetime',
        'description',
        'lifetime (PurchasesSample)',
        199.99,
        '\$199.99',
        'USD',
        presentedOfferingContext:
            PresentedOfferingContext('my-offer', null, null),
      );
      const mockPaymentDiscount = PromotionalOffer(
        'aIdentifier',
        'aKeyIdentifier',
        'aNonce',
        'aSignature',
        123456,
      );
      final purchasePackageResult = await Purchases.purchaseDiscountedProduct(
        mockStoreProduct,
        mockPaymentDiscount,
      );
      expect(
        purchasePackageResult,
        CustomerInfo.fromJson(mockCustomerInfoResponse),
      );

      expect(
        log,
        <Matcher>[
          isMethodCall(
            'purchaseProduct',
            arguments: <String, dynamic>{
              'productIdentifier': 'com.revenuecat.lifetime',
              'signedDiscountTimestamp': '123456',
              'presentedOfferingIdentifier': 'my-offer',
            },
          ),
        ],
      );
    } on PlatformException catch (e) {
      fail('there was an exception $e');
    }
  });

  test('purchaseSubscriptionOption calls successfully on Android', () async {
    try {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;

      response = {
        'productIdentifier': 'gold:monthly',
        'customerInfo': mockCustomerInfoResponse,
      };
      const phase = PricingPhase(
        Period(PeriodUnit.month, 1, 'P1M'),
        RecurrenceMode.infiniteRecurring,
        1,
        Price('4.99', 4990000, 'USD'),
        null,
      );
      const mockSubscriptionOption = SubscriptionOption(
        'monthly',
        'gold:monthly',
        'gold',
        [phase],
        [],
        true,
        Period(PeriodUnit.month, 1, 'P1M'),
        false,
        phase,
        null,
        null,
        PresentedOfferingContext('my-offer', null, null),
        null,
      );
      final purchasePackageResult =
          await Purchases.purchaseSubscriptionOption(mockSubscriptionOption);
      expect(
        purchasePackageResult,
        CustomerInfo.fromJson(mockCustomerInfoResponse),
      );

      expect(
        log,
        <Matcher>[
          isMethodCall(
            'purchaseSubscriptionOption',
            arguments: <String, dynamic>{
              'productIdentifier': 'gold',
              'optionIdentifier': 'monthly',
              'googleOldProductIdentifier': null,
              'googleProrationMode': null,
              'googleIsPersonalizedPrice': null,
              'presentedOfferingIdentifier': 'my-offer',
            },
          ),
        ],
      );
    } on PlatformException catch (e) {
      fail('there was an exception $e');
    }
  });

  test(
      'purchaseSubscriptionOption with GoogleProductChangeInfo and googleIsPersonalizedPrice calls successfully on Android',
      () async {
    try {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;

      response = {
        'productIdentifier': 'gold:monthly',
        'customerInfo': mockCustomerInfoResponse,
      };
      const phase = PricingPhase(
        Period(PeriodUnit.month, 1, 'P1M'),
        RecurrenceMode.infiniteRecurring,
        1,
        Price('4.99', 4990000, 'USD'),
        null,
      );
      const mockSubscriptionOption = SubscriptionOption(
        'monthly',
        'gold:monthly',
        'gold',
        [phase],
        [],
        true,
        Period(PeriodUnit.month, 1, 'P1M'),
        false,
        phase,
        null,
        null,
        PresentedOfferingContext('my-offer', null, null),
        null,
      );
      final googleProductChangeInfo = GoogleProductChangeInfo(
        'silver',
        prorationMode: GoogleProrationMode.immediateWithoutProration,
      );
      final purchasePackageResult = await Purchases.purchaseSubscriptionOption(
        mockSubscriptionOption,
        googleProductChangeInfo: googleProductChangeInfo,
        googleIsPersonalizedPrice: true,
      );
      expect(
        purchasePackageResult,
        CustomerInfo.fromJson(mockCustomerInfoResponse),
      );

      expect(
        log,
        <Matcher>[
          isMethodCall(
            'purchaseSubscriptionOption',
            arguments: <String, dynamic>{
              'productIdentifier': 'gold',
              'optionIdentifier': 'monthly',
              'googleOldProductIdentifier': 'silver',
              'googleProrationMode': 3,
              'googleIsPersonalizedPrice': true,
              'presentedOfferingIdentifier': 'my-offer',
            },
          ),
        ],
      );
    } on PlatformException catch (e) {
      fail('there was an exception $e');
    }
  });

  test('purchaseSubscriptionOption throws error on iOS', () async {
    var catchCalled = false;
    try {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      const phase = PricingPhase(
        Period(PeriodUnit.month, 1, 'P1M'),
        RecurrenceMode.infiniteRecurring,
        1,
        Price('4.99', 4990000, 'USD'),
        null,
      );
      const mockSubscriptionOption = SubscriptionOption(
        'monthly',
        'gold:monthly',
        'gold',
        [phase],
        [],
        true,
        Period(PeriodUnit.month, 1, 'P1M'),
        false,
        phase,
        null,
        null,
        null,
        null,
      );
      await Purchases.purchaseSubscriptionOption(mockSubscriptionOption);

      fail('an exception should have been thrown');
    } on UnsupportedPlatformException catch (_) {
      catchCalled = true;
    }

    expect(catchCalled, true);
  });

  test('setupPurchases with amazon', () async {
    await Purchases.setup(
      'api_key',
      appUserId: 'cesar',
      purchasesAreCompletedBy: PurchasesAreCompletedByMyApp(
        storeKitVersion: StoreKitVersion.storeKit2,
      ),
      useAmazon: true,
    );
    expect(
      log,
      <Matcher>[
        isMethodCall(
          'setupPurchases',
          arguments: <String, dynamic>{
            'apiKey': 'api_key',
            'appUserId': 'cesar',
            'purchasesAreCompletedBy': 'MY_APP',
            'userDefaultsSuiteName': null,
            'storeKitVersion': 'STOREKIT_2',
            'useAmazon': true,
            'shouldShowInAppMessagesAutomatically': true,
            'entitlementVerificationMode': 'DISABLED',
            'pendingTransactionsForPrepaidPlansEnabled': false,
          },
        ),
      ],
    );
  });

  test('configure with amazon', () async {
    await Purchases.configure(
      AmazonConfiguration('api_key')
        ..appUserID = 'cesar'
        ..purchasesAreCompletedBy = const PurchasesAreCompletedByRevenueCat()
        ..pendingTransactionsForPrepaidPlansEnabled = true,
    );
    expect(
      log,
      <Matcher>[
        isMethodCall(
          'setupPurchases',
          arguments: <String, dynamic>{
            'apiKey': 'api_key',
            'appUserId': 'cesar',
            'purchasesAreCompletedBy': 'REVENUECAT',
            'userDefaultsSuiteName': null,
            'useAmazon': true,
            'storeKitVersion': 'DEFAULT',
            'shouldShowInAppMessagesAutomatically': true,
            'entitlementVerificationMode': 'DISABLED',
            'pendingTransactionsForPrepaidPlansEnabled': true,
          },
        ),
      ],
    );
  });

  test('configure with base configuration', () async {
    await Purchases.configure(
      PurchasesConfiguration('api_key')
        ..appUserID = 'cesar'
        ..purchasesAreCompletedBy = PurchasesAreCompletedByMyApp(
          storeKitVersion: StoreKitVersion.defaultVersion,
        ),
    );
    expect(
      log,
      <Matcher>[
        isMethodCall(
          'setupPurchases',
          arguments: <String, dynamic>{
            'apiKey': 'api_key',
            'appUserId': 'cesar',
            'purchasesAreCompletedBy': 'MY_APP',
            'userDefaultsSuiteName': null,
            'storeKitVersion': 'DEFAULT',
            'useAmazon': false,
            'shouldShowInAppMessagesAutomatically': true,
            'entitlementVerificationMode': 'DISABLED',
            'pendingTransactionsForPrepaidPlansEnabled': false,
          },
        ),
      ],
    );
  });

  test('configure with base configuration and using amazon', () async {
    await Purchases.configure(
      PurchasesConfiguration('api_key')
        ..appUserID = 'cesar'
        ..purchasesAreCompletedBy = PurchasesAreCompletedByMyApp(
          storeKitVersion: StoreKitVersion.defaultVersion,
        )
        ..store = Store.amazon,
    );
    expect(
      log,
      <Matcher>[
        isMethodCall(
          'setupPurchases',
          arguments: <String, dynamic>{
            'apiKey': 'api_key',
            'appUserId': 'cesar',
            'purchasesAreCompletedBy': 'MY_APP',
            'userDefaultsSuiteName': null,
            'storeKitVersion': 'DEFAULT',
            'useAmazon': true,
            'shouldShowInAppMessagesAutomatically': true,
            'entitlementVerificationMode': 'DISABLED',
            'pendingTransactionsForPrepaidPlansEnabled': false,
          },
        ),
      ],
    );
  });

  test(
      'beginRefundRequestForActiveEntitlement calls channel correctly for success',
      () async {
    response = 0; // Success code
    final refundRequestStatus =
        await Purchases.beginRefundRequestForActiveEntitlement();

    expect(refundRequestStatus, RefundRequestStatus.success);
    expect(log, <Matcher>[
      isMethodCall(
        'beginRefundRequestForActiveEntitlement',
        arguments: null,
      ),
    ]);
  });

  test(
      'beginRefundRequestForActiveEntitlement calls channel correctly for user cancelled',
      () async {
    response = 1; // User cancelled code
    final refundRequestStatus =
        await Purchases.beginRefundRequestForActiveEntitlement();

    expect(refundRequestStatus, RefundRequestStatus.userCancelled);
    expect(log, <Matcher>[
      isMethodCall(
        'beginRefundRequestForActiveEntitlement',
        arguments: null,
      ),
    ]);
  });

  test(
      'beginRefundRequestForActiveEntitlement calls channel correctly for error',
      () async {
    response = 2; // Error code
    final refundRequestStatus =
        await Purchases.beginRefundRequestForActiveEntitlement();

    expect(refundRequestStatus, RefundRequestStatus.error);
    expect(log, <Matcher>[
      isMethodCall(
        'beginRefundRequestForActiveEntitlement',
        arguments: null,
      ),
    ]);
  });

  test(
      'beginRefundRequestForActiveEntitlement throws UnsupportedPlatformException',
      () async {
    response = null;
    try {
      await Purchases.beginRefundRequestForActiveEntitlement();
      fail('Should have thrown an exception');
    } on UnsupportedPlatformException {
      // Success
    }
  });

  test('beginRefundRequestForProduct calls channel correctly', () async {
    response = 0; // Success

    const mockStoreProduct = StoreProduct(
      'com.revenuecat.lifetime',
      'description',
      'lifetime (PurchasesSample)',
      199.99,
      '\$199.99',
      'USD',
    );

    final refundRequestStatus =
        await Purchases.beginRefundRequestForProduct(mockStoreProduct);

    expect(refundRequestStatus, RefundRequestStatus.success);
    expect(log, <Matcher>[
      isMethodCall(
        'beginRefundRequestForProduct',
        arguments: {'productIdentifier': 'com.revenuecat.lifetime'},
      ),
    ]);
  });

  test('beginRefundRequestForEntitlement calls channel correctly', () async {
    response = 0; // Success

    final entitlementInfoJson = {
      'identifier': 'almost_pro',
      'isActive': true,
      'willRenew': true,
      'periodType': 'NORMAL',
      'latestPurchaseDateMillis': 1.58759855E9,
      'latestPurchaseDate': '2020-04-22T23:35:50.000Z',
      'originalPurchaseDateMillis': 1.591725245E9,
      'originalPurchaseDate': '2020-06-09T17:54:05.000Z',
      'expirationDateMillis': null,
      'expirationDate': null,
      'productIdentifier': 'consumable',
      'isSandbox': true,
      'unsubscribeDetectedAt': null,
      'unsubscribeDetectedAtMillis': null,
      'billingIssueDetectedAt': null,
      'billingIssueDetectedAtMillis': null,
      'store': Store.appStore,
    };
    final entitlementInfo = EntitlementInfo.fromJson(entitlementInfoJson);

    final refundRequestStatus =
        await Purchases.beginRefundRequestForEntitlement(entitlementInfo);

    expect(refundRequestStatus, RefundRequestStatus.success);
    expect(log, <Matcher>[
      isMethodCall(
        'beginRefundRequestForEntitlement',
        arguments: {'entitlementIdentifier': 'almost_pro'},
      ),
    ]);
  });

  test('setLogHandler works correctly', () async {
    LogLevel? receivedLogLevel;
    const expectedMessage = 'A log sent';
    await Purchases.setLogHandler((logLevel, message) {
      expect(message, expectedMessage);
      receivedLogLevel = logLevel;
    });
    for (final logLevel in LogLevel.values) {
      _performDartSideChannelMethodCall(
        'Purchases-LogHandlerEvent',
        {
          'logLevel': logLevel.name.toUpperCase(),
          'message': expectedMessage,
        },
      );
      expect(receivedLogLevel, logLevel);
    }
  });

  test('setLogHandler logs as info if log level not found', () async {
    LogLevel? receivedLogLevel;
    await Purchases.setLogHandler((logLevel, message) {
      receivedLogLevel = logLevel;
    });
    _performDartSideChannelMethodCall(
      'Purchases-LogHandlerEvent',
      {
        'logLevel': 'wrong',
        'message': 'A log sent',
      },
    );
    expect(receivedLogLevel, LogLevel.info);
  });

  test('syncAmazonPurchase calls channel correctly', () async {
    await Purchases.syncAmazonPurchase(
      'productID_test',
      'receiptID_test',
      'amazonUserID_test',
      'isoCurrencyCode_test',
      3.4,
    );
    expect(log, <Matcher>[
      isMethodCall(
        'syncAmazonPurchase',
        arguments: {
          'productID': 'productID_test',
          'receiptID': 'receiptID_test',
          'amazonUserID': 'amazonUserID_test',
          'isoCurrencyCode': 'isoCurrencyCode_test',
          'price': 3.4,
        },
      ),
    ]);
  });

  test(
      'syncAmazonPurchase calls channel correctly with null price and isoCurrencyCode',
      () async {
    await Purchases.syncAmazonPurchase(
      'productID_test',
      'receiptID_test',
      'amazonUserID_test',
      null,
      null,
    );
    expect(log, <Matcher>[
      isMethodCall(
        'syncAmazonPurchase',
        arguments: {
          'productID': 'productID_test',
          'receiptID': 'receiptID_test',
          'amazonUserID': 'amazonUserID_test',
          'isoCurrencyCode': null,
          'price': null,
        },
      ),
    ]);
  });

  test('syncObserverModeAmazonPurchase calls channel correctly', () async {
    await Purchases.syncObserverModeAmazonPurchase(
      'productID_test',
      'receiptID_test',
      'amazonUserID_test',
      'isoCurrencyCode_test',
      3.4,
    );
    expect(log, <Matcher>[
      isMethodCall(
        'syncAmazonPurchase',
        arguments: {
          'productID': 'productID_test',
          'receiptID': 'receiptID_test',
          'amazonUserID': 'amazonUserID_test',
          'isoCurrencyCode': 'isoCurrencyCode_test',
          'price': 3.4,
        },
      ),
    ]);
  });

  test(
      'syncObserverModeAmazonPurchase calls channel correctly with null price and isoCurrencyCode',
      () async {
    await Purchases.syncObserverModeAmazonPurchase(
      'productID_test',
      'receiptID_test',
      'amazonUserID_test',
      null,
      null,
    );
    expect(log, <Matcher>[
      isMethodCall(
        'syncAmazonPurchase',
        arguments: {
          'productID': 'productID_test',
          'receiptID': 'receiptID_test',
          'amazonUserID': 'amazonUserID_test',
          'isoCurrencyCode': null,
          'price': null,
        },
      ),
    ]);
  });

  test('showInAppMessages works correctly when passing arguments', () async {
    await Purchases.showInAppMessages(
      types: {
        InAppMessageType.billingIssue,
        InAppMessageType.priceIncreaseConsent,
        InAppMessageType.generic,
      },
    );
    expect(log, <Matcher>[
      isMethodCall(
        'showInAppMessages',
        arguments: {
          'types': [0, 1, 2],
        },
      ),
    ]);
  });

  test('showInAppMessages works correctly when not passing arguments',
      () async {
    await Purchases.showInAppMessages();
    expect(log, <Matcher>[
      isMethodCall(
        'showInAppMessages',
        arguments: {
          'types': null,
        },
      ),
    ]);
  });

  test('parseAsWebPurchaseRedemption works correctly', () async {
    const link = 'custom-scheme://redeem_web_purchase?redemption_token=1234';
    response = true;
    final webPurchaseRedemption = await Purchases.parseAsWebPurchaseRedemption(link);
    expect(log, <Matcher>[
      isMethodCall(
        'isWebPurchaseRedemptionURL',
        arguments: {
          'urlString': link,
        },
      ),
    ]);
    expect(webPurchaseRedemption, isNotNull);
  });

  test('redeemWebPurchase works correctly', () async {
    const link = 'custom-scheme://redeem_web_purchase?redemption_token=1234';
    const webPurchaseRedemption = WebPurchaseRedemption(link);
    response = {
      'result': 'SUCCESS',
      'customerInfo': mockCustomerInfoResponse,
    };
    final webPurchaseRedemptionResult = await Purchases.redeemWebPurchase(webPurchaseRedemption);
    expect(log, <Matcher>[
      isMethodCall(
        'redeemWebPurchase',
        arguments: {
          'redemptionLink': link,
        },
      ),
    ]);
    final expiredOrNull = webPurchaseRedemptionResult.whenOrNull(
      success: (customerInfo) {
        expect(customerInfo, CustomerInfo.fromJson(mockCustomerInfoResponse));
        return webPurchaseRedemptionResult;
      },
    );
    expect(expiredOrNull, isNotNull);
  });
}
