import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(MaterialApp(
    title: 'RevenueCat Sample',
    home: InitialScreen(),
  ));
}

class InitialScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<InitialScreen> {
  PurchaserInfo _purchaserInfo;
  Map<String, Entitlement> _entitlements;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onUpdatedPurchaserInfo(purchaserInfo) {
    setState(() {
      _purchaserInfo = purchaserInfo;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    Purchases.setDebugLogsEnabled(true);
    Purchases.addPurchaserInfoUpdateListener(onUpdatedPurchaserInfo);
    await Purchases.setup("YOUR_API_KEY");
    PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
    Map<String, Entitlement> entitlements = await Purchases.getEntitlements();

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _purchaserInfo = purchaserInfo;
      _entitlements = entitlements;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_purchaserInfo == null) {
      return Scaffold(
        appBar: AppBar(title: Text("RevenueCat Sample App")),
        body: Center(
          child: Text("Loading..."),
        ),
      );
    } else {
      var isPro = _purchaserInfo.activeEntitlements.contains("pro");
      if (isPro) {
        return CatsScreen();
      } else {
        return UpsellScreen(
          entitlements: _entitlements,
        );
      }
    }
  }
}

class UpsellScreen extends StatelessWidget {
  Map<String, Entitlement> entitlements;

  UpsellScreen({Key key, @required this.entitlements}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (entitlements != null) {
      final pro = entitlements["pro"];
      if (pro != null) {
        final monthly = pro.offerings["monthly"];
        final annual = pro.offerings["annual"];
        if (monthly != null && annual != null) {
          return Scaffold(
              appBar: AppBar(title: Text("Upsell Screen")),
              body: Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  PurchaseButton(product: monthly),
                  PurchaseButton(product: annual)
                ],
              )));
        }
      }
    }
    return Scaffold(
        appBar: AppBar(title: Text("Upsell Screen")),
        body: Center(
          child: Text("Loading..."),
        ));
  }
}

class PurchaseButton extends StatelessWidget {
  final Product product;

  PurchaseButton({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () async {
        try {
          SuccessfulPurchase successfulPurchase = await Purchases.makePurchase(product.identifier);
          var isPro = successfulPurchase.purchaserInfo.activeEntitlements.contains("pro_cat");
          if (isPro) {
            return CatsScreen();
          }
        } on PlatformException catch (e) {
          if ((e.details as Map)["userCancelled"]) {
            print("User cancelled");
          }
        }
      },
      child: Text("Buy - (${product.priceString})"),
    );
  }
}

class CatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Scaffold(
      appBar: AppBar(title: Text("Cats Screen")),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
