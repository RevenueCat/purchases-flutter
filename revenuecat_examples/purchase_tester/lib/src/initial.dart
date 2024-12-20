import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constant.dart';
import 'cats.dart';
import 'upsell.dart';

// ignore: public_member_api_docs
class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  CustomerInfo? _customerInfo;
  WebPurchaseRedemptionResult? webPurchaseRedemptionResult;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _redeemWebRedemptionLinksIfNeeded();
  }

  Future<void> _redeemWebRedemptionLinksIfNeeded() async {
    final appLinks = AppLinks();

    appLinks.stringLinkStream.listen((uri) async {
      _processLink(uri);
    });
  }

  void _processLink(String uri) async {
    final webPurchaseRedemption = await Purchases.parseAsWebPurchaseRedemption(uri);
    if (webPurchaseRedemption != null) {
      final result = await Purchases.redeemWebPurchase(webPurchaseRedemption);
      _showWebRedemptionResultDialog(result);
    }
  }

  void _showWebRedemptionResultDialog(WebPurchaseRedemptionResult result) {
    final message = result.when(
        success: (customerInfo) {
          return 'Web purchase redemption successful. CustomerInfo: $customerInfo';
        },
        error: (error) {
          return 'Web purchase redemption failed: $error';
        },
        purchaseBelongsToOtherUser: () {
          return 'Web purchase redemption failed: purchase belongs to another user';
        },
        invalidToken: () {
          return 'Web purchase redemption failed: invalid token';
        },
        expired: (obfuscatedEmail) {
          return 'Web purchase redemption failed: expired token for $obfuscatedEmail';
        }
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Web Redemption Link Result'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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
