import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import './constant.dart';

class PurchaseTester extends StatelessWidget {
  const PurchaseTester({Key? key}) : super(key: key);

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
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<InitialScreen> {
  CustomerInfo? _customerInfo;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
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
      final isPro =
          _customerInfo!.entitlements.active.containsKey(entitlementKey);
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
  const UpsellScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UpsellScreenState();
}

class _UpsellScreenState extends State<UpsellScreen> {
  Offerings? _offerings;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    Offerings? offerings;
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
      final offering = _offerings!.current;
      if (offering != null) {
        List<Widget> buttonThings = offering.availablePackages
            .map((package) {
              List<Widget> buttons = [
                _PurchaseButton(package: package),
                _PurchaseStoreProductButton(storeProduct: package.storeProduct)
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
  const _PurchaseButton({Key? key, required this.package}) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: () async {
          try {
            final customerInfo = await Purchases.purchasePackage(package);
            final isPro =
                customerInfo.entitlements.active.containsKey(entitlementKey);
            if (isPro) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const CatsScreen()),
              );
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const InitialScreen()),
          );
        },
        child: Text(
            'Buy Package: ${package.storeProduct.subscriptionPeriod ?? package.storeProduct.title}\n${package.storeProduct.priceString}'),
      );
}

class _PurchaseStoreProductButton extends StatelessWidget {
  final StoreProduct storeProduct;

  // ignore: public_member_api_docs
  const _PurchaseStoreProductButton({Key? key, required this.storeProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: () async {
          try {
            final customerInfo =
                await Purchases.purchaseStoreProduct(storeProduct);
            final isPro =
                customerInfo.entitlements.active.containsKey(entitlementKey);
            if (isPro) {
             Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const CatsScreen()),
              );
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const InitialScreen()),
          );
        },
        child: Text(
            'Buy StoreProduct (${storeProduct.productCategory}): ${storeProduct.subscriptionPeriod ?? storeProduct.title}\n${storeProduct.priceString}'),
      );
}

class _PurchaseSubscriptionOptionButton extends StatelessWidget {
  final SubscriptionOption option;

  // ignore: public_member_api_docs
  const _PurchaseSubscriptionOptionButton({Key? key, required this.option})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: () async {
          try {
            final customerInfo =
                await Purchases.purchaseSubscriptionOption(option);
            final isPro =
                customerInfo.entitlements.active.containsKey(entitlementKey);
            if (isPro) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const CatsScreen()),
              );
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
        },
        child:
            Text('Buy Option: - (${option.id}\n${option.pricingPhases.map((e) {
          return '${e.price.formatted} for ${e.billingPeriod?.value} ${e.billingPeriod?.unit}';
        }).join(' -> ')})'),
      );
}

// ignore: public_member_api_docs
class CatsScreen extends StatelessWidget {
  const CatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Cats Screen')),
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('User is pro'),
            ElevatedButton(
              onPressed: () async {
                try {
                  final customerInfo = await Purchases.getCustomerInfo();
                  final refundStatus =
                      await Purchases.beginRefundRequestForEntitlement(
                          customerInfo.entitlements.active[entitlementKey]!);
                  print('Refund request successful with status: $refundStatus');
                } catch (e) {
                  print('Refund request exception: $e');
                }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InitialScreen()),
                );
              },
              child: const Text('Begin refund for pro entitlement'),
            ),
          ],
        )),
      );
}
