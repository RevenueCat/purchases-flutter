import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('purchases_flutter');
  final List<MethodCall> log = <MethodCall>[];
  dynamic response;
  final randomGenerator = Random(DateTime.now().microsecondsSinceEpoch);
  var mockPurchaserInfoResponse = {
    "originalAppUserId": "pepe",
    "entitlements": {"all": {}, "active": {}},
    "activeSubscriptions": [],
    "latestExpirationDate": "2021-04-09T14:48:00.000Z",
    "allExpirationDates": {},
    "allPurchasedProductIdentifiers": [],
    "firstSeen": "2021-01-09T14:48:00.000Z",
    "requestDate": "2021-04-09T14:48:00.000Z",
    "allPurchaseDates": {},
    "originalApplicationVersion": "1.2.3",
    "nonSubscriptionTransactions": []
  };

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      log.add(methodCall);
      return response;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
    log.clear();
    response = null;
  });

  test('setupPurchases', () async {
    await Purchases.setup('api_key', appUserId: 'cesar', observerMode: true);
    expect(
      log,
      <Matcher>[
        isMethodCall(
          'setupPurchases',
          arguments: <String, dynamic>{
            'apiKey': 'api_key',
            'appUserId': 'cesar',
            'observerMode': true,
            'userDefaultsSuiteName': null
          },
        )
      ],
    );
  });

  test('getProductsList returns list of products', () async {
    response = [
      {
        "identifier": "monthly_intro_pricing_one_week",
        "description": "Monthly Product Intro Pricing One Week",
        "title": "Monthly Product Intro Pricing One Week (PurchasesSample)",
        "price": 4.99,
        "price_string": "\$4.99",
        "currency_code": "USD",
        "introPrice": {
          "price": 0,
          "priceString": "\$0.00",
          "period": "P1W",
          "cycles": 1,
          "periodUnit": "DAY",
          "periodNumberOfUnits": 7
        },
        "discounts": null,
        "intro_price": 0,
        "intro_price_string": "\$0.00",
        "intro_price_period": "P1W",
        "intro_price_cycles": 1,
        "intro_price_period_unit": "DAY",
        "intro_price_period_number_of_units": 7
      }
    ];
    var list = await Purchases.getProducts(['sku_a']);
    expect(list.length, 1);
  });

  test('checkTrialOrIntroductoryPriceEligibility returns eligibility map',
      () async {
    response = {
      "monthly_intro_pricing_one_week": {
        "status": 0,
        "description": "Status indeterminate."
      }
    };
    var list = await Purchases.checkTrialOrIntroductoryPriceEligibility(
        ['monthly_intro_pricing_one_week']);
    expect(list.length, 1);
  });

  test('canMakePayments with no params calls successfully', () async {
    response = Random().nextBool();
    var receivedCanMakePayments = await Purchases.canMakePayments();

    expect(receivedCanMakePayments, response);
    expect(log, <Matcher>[
      isMethodCall('canMakePayments', arguments: {'features': []})
    ]);
  });

  test('canMakePayments with empty list calls successfully', () async {
    response = Random().nextBool();
    var receivedCanMakePayments = await Purchases.canMakePayments([]);

    expect(receivedCanMakePayments, response);
    expect(log, <Matcher>[
      isMethodCall('canMakePayments', arguments: {'features': []})
    ]);
  });

  test('canMakePayments with params calls successfully', () async {
    response = Random().nextBool();
    var receivedCanMakePayments =
        await Purchases.canMakePayments([BillingFeature.subscriptions]);

    expect(receivedCanMakePayments, response);
    expect(log, <Matcher>[
      isMethodCall('canMakePayments', arguments: {
        'features': [0]
      })
    ]);
  });

  test('canMakePayments params mapped to ordinals successfully', () async {
    response = Random().nextBool();
    var receivedCanMakePayments = await Purchases.canMakePayments([
      BillingFeature.subscriptions,
      BillingFeature.priceChangeConfirmation,
      BillingFeature.subscriptionsOnVr,
      BillingFeature.subscriptionsUpdate,
      BillingFeature.inAppItemsOnVr
    ]);

    expect(receivedCanMakePayments, response);
    expect(log, <Matcher>[
      isMethodCall('canMakePayments', arguments: {
        'features': [0, 4, 3, 1, 2]
      })
    ]);
  });

  test('logIn calls successfully', () async {
    try {
      var mockCreated = randomGenerator.nextBool();
      response = {
        "created": mockCreated,
        "purchaserInfo": mockPurchaserInfoResponse
      };
      LogInResult logInResult = await Purchases.logIn("appUserID");
      expect(logInResult.purchaserInfo,
          PurchaserInfo.fromJson(mockPurchaserInfoResponse));
      expect(logInResult.created, mockCreated);
    } on PlatformException catch (e) {
      fail("there was an exception " + e.toString());
    }
  });

  test('logOut calls successfully', () async {
    try {
      response = mockPurchaserInfoResponse;
      PurchaserInfo purchaserInfo = await Purchases.logOut();
      expect(purchaserInfo, PurchaserInfo.fromJson(mockPurchaserInfoResponse));
    } on PlatformException catch (e) {
      fail("there was an exception " + e.toString());
    }
  });
}
