import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

import 'constant.dart';
import 'app.dart';
import 'cats.dart';

class UpsellScreen extends StatefulWidget {
  const UpsellScreen({Key? key}) : super(key: key);

  @override
  State<UpsellScreen> createState() => _UpsellScreenState();
}

class _UpsellScreenState extends State<UpsellScreen> {
  Offerings? _offerings;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
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
    return Scaffold(
      appBar: AppBar(title: const Text('Upsell Screen')),
      body: _offerings == null
          ? const Center(child: CircularProgressIndicator())
          : _buildOfferings(context),
    );
  }

  Widget _buildOfferings(BuildContext context) {
    final offering = _offerings!.current;
    if (offering == null || offering.availablePackages.isEmpty) {
      return const Center(child: Text('No offerings available'));
    }

    List<Widget> packageCards = offering.availablePackages.map((package) {
      List<Widget> buttons = [
        _PurchaseButton(package: package),
        _PurchaseStoreProductButton(storeProduct: package.storeProduct),
      ];

      if (package.storeProduct.subscriptionOptions != null) {
        buttons.addAll(package.storeProduct.subscriptionOptions!.map((option) {
          return _PurchaseSubscriptionOptionButton(option: option);
        }).toList());
      }

      return Card(
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [Text(package.storeProduct.title), ...buttons],
          ),
        ),
      );
    }).toList();

    List<Widget> purchaseOptions = [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  const Text("Paywalls"),
                  ElevatedButton(
                    onPressed: () async {
                      final paywallResult = await RevenueCatUI.presentPaywall();
                      log('Paywall result: $paywallResult');
                    },
                    child: const Text('Present paywall'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final paywallResult =
                          await RevenueCatUI.presentPaywallIfNeeded(entitlementKey);
                      log('Paywall result: $paywallResult');
                    },
                    child: const Text('Present paywall if needed ("$entitlementKey")'),
                  )
                ]))),
      ),
      ...packageCards,
    ];

    return ListView(
      children: purchaseOptions,
    );
  }
}

class _PurchaseButton extends StatelessWidget {
  final Package package;

  // ignore: public_member_api_docs
  const _PurchaseButton({Key? key, required this.package}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.all(8.0),
        child: ListTile(
          title: const Text('Buy Package'),
          subtitle: Text(package.storeProduct.priceString),
          trailing: IconButton(
            icon: const Icon(Icons.add_shopping_cart),
            onPressed: () => _purchasePackage(context, package),
          ),
        ),
      );

  Future<void> _purchasePackage(BuildContext context, Package package) async {
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
      } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
        print('User not allowed to purchase');
      } else if (errorCode == PurchasesErrorCode.paymentPendingError) {
        print('Payment is pending');
      }
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const InitialScreen()),
    );
  }
}

class _PurchaseStoreProductButton extends StatelessWidget {
  final StoreProduct storeProduct;

  // ignore: public_member_api_docs
  const _PurchaseStoreProductButton({Key? key, required this.storeProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text('Buy StoreProduct (${storeProduct.productCategory})'),
          subtitle: Text(
              '${storeProduct.priceString} for ${storeProduct.subscriptionPeriod ?? storeProduct.title}'),
          trailing: IconButton(
            icon: const Icon(Icons.add_shopping_cart),
            onPressed: () => _purchaseStoreProduct(context, storeProduct),
          ),
        ),
      );

  Future<void> _purchaseStoreProduct(
      BuildContext context, StoreProduct storeProduct) async {
    try {
      final customerInfo = await Purchases.purchaseStoreProduct(storeProduct);
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
      } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
        print('User not allowed to purchase');
      } else if (errorCode == PurchasesErrorCode.paymentPendingError) {
        print('Payment is pending');
      }
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const InitialScreen()),
    );
  }
}

class _PurchaseSubscriptionOptionButton extends StatelessWidget {
  final SubscriptionOption option;

  // ignore: public_member_api_docs
  const _PurchaseSubscriptionOptionButton({Key? key, required this.option})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text('Buy Option: ${option.id}'),
          subtitle: Text('Phases:\n${option.pricingPhases.map((e) {
            return '- ${e.price.formatted} for ${e.billingPeriod?.iso8601}';
          }).join('\n')}'),
          trailing: IconButton(
            icon: const Icon(Icons.add_shopping_cart),
            onPressed: () async {
              try {
                final customerInfo =
                    await Purchases.purchaseSubscriptionOption(option);
                final isPro = customerInfo.entitlements.active
                    .containsKey(entitlementKey);
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
                } else if (errorCode ==
                    PurchasesErrorCode.paymentPendingError) {
                  print('Payment is pending');
                }
              }
            },
          ),
        ),
      );
}
