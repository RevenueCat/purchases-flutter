import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_flutter_example/src/constant.dart';

import 'src/constant.dart';

void main() => runApp(
      const MaterialApp(
        title: 'RevenueCat Sample',
        home: InitialScreen(),
      ),
    );

// ignore: public_member_api_docs
class InitialScreen extends StatefulWidget {
  const InitialScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<InitialScreen> {
  CustomerInfo _customerInfo;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    await Purchases.setDebugLogsEnabled(true);

    if (Platform.isAndroid) {
      await Purchases.setup(googleApiKey);
    } else {
      await Purchases.setup(appleApiKey);
    }

    final customerInfo = await Purchases.getCustomerInfo();

    Purchases.addReadyForPromotedProductPurchaseListener(
        (productID, startPurchase) async {
      print('Received readyForPromotedProductPurchase event for '
          'productID: $productID');

      try {
        final purchaseResult = await startPurchase.call();
        print('Promoted purchase for productID '
            '${purchaseResult.productIdentifier} completed, or product was'
            'already purchased. customerInfo returned is:'
            ' ${purchaseResult.customerInfo}');
      } on PlatformException catch (e) {
        print('Error purchasing promoted product: ${e.message}');
      }
    });

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _customerInfo = customerInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_customerInfo == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('RevenueCat Sample App')),
        body: const Center(
          child: Text('Loading...'),
        ),
      );
    } else {
      final isPro = _customerInfo.entitlements.active.containsKey('pro_cat');
      if (isPro) {
        return const CatsScreen();
      } else {
        return const UpsellScreen();
      }
    }
  }
}

// ignore: public_member_api_docs
class UpsellScreen extends StatefulWidget {
  const UpsellScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UpsellScreenState();
}

class _UpsellScreenState extends State<UpsellScreen> {
  Offerings _offerings;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    Offerings offerings;
    try {
      offerings = await Purchases.getOfferings();
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _offerings = offerings;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_offerings != null) {
      final offering = _offerings.current;
      if (offering != null) {
        final monthly = offering.monthly;
        final lifetime = offering.lifetime;

        if (monthly.storeProduct.introductoryPrice != null) {
          apiTestIntroductoryPrice(monthly.storeProduct.introductoryPrice);
        }

        if (monthly != null && lifetime != null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Upsell Screen')),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _PurchaseButton(package: monthly),
                  _PurchaseButton(package: lifetime)
                ],
              ),
            ),
          );
        }
      }
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Upsell Screen')),
      body: const Center(
        child: Text('Loading...'),
      ),
    );
  }

  void apiTestIntroductoryPrice(IntroductoryPrice introPrice) {
    final PeriodUnit periodUnit = introPrice.periodUnit;
    final double price = introPrice.price;
    final String priceString = introPrice.priceString;
    final int cycles = introPrice.cycles;
    final int periodNumberOfUnits = introPrice.periodNumberOfUnits;

    /// deprecated properties
    // ignore: deprecated_member_use
    final String introPricePeriodUnit = introPrice.introPricePeriodUnit;
    // ignore: deprecated_member_use
    final double introPricePrice = introPrice.introPrice;
    // ignore: deprecated_member_use
    final String introPriceString = introPrice.introPriceString;
    // ignore: deprecated_member_use
    final String introPricePeriod = introPrice.introPricePeriod;
    final int introPricePeriodNumberOfUnits =
        // ignore: deprecated_member_use
        introPrice.introPricePeriodNumberOfUnits;
    // ignore: deprecated_member_use
    final int introPriceCycles = introPrice.introPriceCycles;

    print('introPricePeriodUnit: $introPricePeriodUnit, periodUnit: '
        '$periodUnit, price: $price.toString(), priceString: '
        '$priceString, cycles: $cycles.toString(), periodNumberOfUnits: '
        '$periodNumberOfUnits, introPrice: $introPrice.toString(), '
        'introPriceString: $introPriceString, introPricePeriod: '
        '$introPricePeriod, introPricePeriodNumberOfUnits: '
        '$introPricePeriodNumberOfUnits, introPriceCycles: '
        '$introPriceCycles, introPricePrice: $introPricePrice.toString()');
  }
}

class _PurchaseButton extends StatelessWidget {
  final Package package;

  // ignore: public_member_api_docs
  const _PurchaseButton({Key key, @required this.package}) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: () async {
          try {
            final customerInfo = await Purchases.purchasePackage(package);
            final isPro = customerInfo.entitlements.all['pro_cat'].isActive;
            if (isPro) {
              return const CatsScreen();
            }
          } on PlatformException catch (e) {
            if (e.purchasesErrorCode ==
                PurchasesErrorCode.purchaseCancelledError) {
              print('User cancelled');
            } else if (e.purchasesErrorCode ==
                PurchasesErrorCode.purchaseNotAllowedError) {
              print('User not allowed to purchase');
            } else if (e.purchasesErrorCode ==
                PurchasesErrorCode.paymentPendingError) {
              print('Payment is pending');
            }
          }
          return const InitialScreen();
        },
        child: Text('Buy - (${package.storeProduct.priceString})'),
      );
}

// ignore: public_member_api_docs
class CatsScreen extends StatelessWidget {
  const CatsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Cats Screen')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('User is pro'),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final refundStatus = await Purchases
                        .beginRefundRequestForActiveEntitlement();
                    print('refundStatus is $refundStatus');
                  } on PlatformException catch (e) {
                    if (e.purchasesErrorCode ==
                        PurchasesErrorCode.beginRefundRequestError) {
                      print('Error beginning refund request: ${e.message}');
                    }
                  }
                  return const InitialScreen();
                },
                child: const Text('Begin refund for active entitlement'),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await Purchases.showManageSubscriptions();
                  } on PlatformException catch (e) {
                    final errorCode = e.purchasesErrorCode;
                    print('showManageSubError: $e');
                    // if (errorCode == PurchasesErrorCode.beginRefundRequestError) {
                    //   print('Error beginning refund request: ${e.message}');
                    // }
                  }
                  return const InitialScreen();
                },
                child: const Text('Show manage subscriptions modal'),
              )
            ],
          ),
        ),
      );
}
