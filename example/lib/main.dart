import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

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

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    Purchases.setDebugLogsEnabled(true);
    await Purchases.setup("api_key");
    Purchases.addAttributionData({}, PurchasesAttributionNetwork.facebook);
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
      var isPro = _purchaserInfo.entitlements.active.containsKey("pro_cat");
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
      final pro = entitlements["pro_cat"];
      if (pro != null) {
        final monthly = pro.offerings["monthly_cats"];
        final annual = pro.offerings["annual_cats"];
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
          PurchaserInfo purchaserInfo =
              await Purchases.makePurchase(product.identifier);
          var isPro = purchaserInfo.entitlements.all["pro_cat"].isActive;
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
    return Scaffold(
        appBar: AppBar(title: Text("Cats Screen")),
        body: Center(
          child: Text("User is pro"),
        ));
  }
}
