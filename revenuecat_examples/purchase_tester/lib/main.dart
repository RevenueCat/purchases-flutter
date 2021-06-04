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

// ignore: public_member_api_docs
class InitialScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<InitialScreen> {
  PurchaserInfo _purchaserInfo;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup("api_key");

    PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _purchaserInfo = purchaserInfo;
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
        return UpsellScreen();
      }
    }
  }
}

// ignore: public_member_api_docs
class UpsellScreen extends StatefulWidget {
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
        if (monthly != null && lifetime != null) {
          return Scaffold(
              appBar: AppBar(title: Text("Upsell Screen")),
              body: Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _PurchaseButton(package: monthly),
                  _PurchaseButton(package: lifetime)
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

class _PurchaseButton extends StatelessWidget {
  final Package package;

  // ignore: public_member_api_docs
  _PurchaseButton({Key key, @required this.package}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          PurchaserInfo purchaserInfo =
              await Purchases.purchasePackage(package);
          var isPro = purchaserInfo.entitlements.all["pro_cat"].isActive;
          if (isPro) {
            return CatsScreen();
          }
        } on PlatformException catch (e) {
          var errorCode = PurchasesErrorHelper.getErrorCode(e);
          if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
            print("User cancelled");
          } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
            print("User not allowed to purchase");
          } else if (errorCode == PurchasesErrorCode.paymentPendingError) {
            print("Payment is pending");
          }
        }
        return InitialScreen();
      },
      child: Text("Buy - (${package.product.priceString})"),
    );
  }
}

// ignore: public_member_api_docs
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
