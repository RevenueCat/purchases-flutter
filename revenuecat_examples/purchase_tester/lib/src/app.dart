import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import './constant.dart';
import '../store_config.dart';

class PurchaseTester extends StatelessWidget {
  const PurchaseTester({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'RevenueCat Sample',
      home: InitialScreen(),
    );
  }
}

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
    await Purchases.setLogLevel(LogLevel.debug);

    PurchasesConfiguration configuration;
    if (StoreConfig.isForAmazonAppstore()) {
      configuration = AmazonConfiguration(StoreConfig.instance.apiKey);
    } else {
      configuration = PurchasesConfiguration(StoreConfig.instance.apiKey);
    }
    await Purchases.configure(configuration);

    await Purchases.enableAdServicesAttributionTokenCollection();

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
      final isPro = _customerInfo.entitlements.active.isNotEmpty;
      if (isPro) {
        return CatsScreen();
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
        List<Widget> buttonThings = offering.availablePackages
            .map((package) {
              List<Widget> buttons = [
                _PurchaseButton(package: package),
              ];

              List<Widget> optionButtons =
                  (package.storeProduct.subscriptionOptions?.map((e) {
                            return _PurchaseSubscriptionOptionButton(option: e);
                          }) ??
                          [])
                      .toList();

              buttons.addAll(optionButtons);

              return buttons;
            })
            .expand((i) => i)
            .toList();

        return Scaffold(
          appBar: AppBar(title: const Text('Upsell Screen')),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: buttonThings,
            ),
          ),
        );
      }
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Upsell Screen')),
      body: const Center(
        child: Text('Loading...'),
      ),
    );
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
            final isPro = customerInfo.entitlements.active.isNotEmpty;
            if (isPro) {
              return CatsScreen();
            }
          } on PlatformException catch (e) {
            final errorCode = PurchasesErrorHelper.getErrorCode(e);
            if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
              print('User cancelled');
            } else if (errorCode ==
                PurchasesErrorCode.purchaseNotAllowedError) {
              print('User not allowed to purchase');
            } else if (errorCode == PurchasesErrorCode.paymentPendingError) {
              print('Payment is pending');
            }
          }
          return const InitialScreen();
        },
        child: Text(
            'Buy Package: ${package.storeProduct.subscriptionPeriod ?? package.storeProduct.title}\n${package.storeProduct.priceString}'),
      );
}

class _PurchaseSubscriptionOptionButton extends StatelessWidget {
  final SubscriptionOption option;

  // ignore: public_member_api_docs
  const _PurchaseSubscriptionOptionButton({Key key, @required this.option})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: () async {
          try {
            final customerInfo =
                await Purchases.purchaseSubscriptionOption(option);
            final isPro = customerInfo.entitlements.active.isNotEmpty;
            if (isPro) {
              return CatsScreen();
            }
          } on PlatformException catch (e) {
            final errorCode = PurchasesErrorHelper.getErrorCode(e);
            if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
              print('User cancelled');
            } else if (errorCode ==
                PurchasesErrorCode.purchaseNotAllowedError) {
              print('User not allowed to purchase');
            } else if (errorCode == PurchasesErrorCode.paymentPendingError) {
              print('Payment is pending');
            }
          }
          return const InitialScreen();
        },
        child:
            Text('Buy Option: - (${option.id}\n${option.pricingPhases.map((e) {
          return '${e.price.formatted} for ${e.billingPeriod.value} ${e.billingPeriod.unit}';
        }).join(' -> ')})'),
      );
}

// ignore: public_member_api_docs

class CatsScreen extends StatefulWidget {
  @override
  _CatsScreenState createState() => _CatsScreenState();
}

class _CatsScreenState extends State<CatsScreen> {
  String _customerInfoString = 'Fetching customer info...';

  @override
  void initState() {
    super.initState();
    _fetchCustomerInfo();
  }

  void _fetchCustomerInfo() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      final prettyCustomerInfo =
          JsonEncoder.withIndent('  ').convert(customerInfo.toJson());
      setState(() {
        _customerInfoString = prettyCustomerInfo;
      });
    } catch (e) {
      setState(() {
        _customerInfoString = 'Failed to fetch customer info: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Cats Screen')),
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    _customerInfoString,
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final customerInfo = await Purchases.getCustomerInfo();
                  final refundStatus =
                      await Purchases.beginRefundRequestForEntitlement(
                          customerInfo.entitlements.active.values.first);
                  print('Refund request successful with status: $refundStatus');
                } catch (e) {
                  print('Refund request exception: $e');
                }
                return const InitialScreen();
              },
              child: const Text('Begin refund for pro entitlement'),
            ),
          ],
        )),
      );
}
