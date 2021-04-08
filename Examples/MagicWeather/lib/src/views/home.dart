import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:magic_weather_flutter/src/constant.dart';
import 'package:magic_weather_flutter/src/views/weather.dart';
import 'package:magic_weather_flutter/src/views/user.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:magic_weather_flutter/src/model/singletons_data.dart';
import 'package:magic_weather_flutter/src/model/styles.dart';

final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();

class AppContainer extends StatefulWidget {
  @override
  AppContainerState createState() => AppContainerState();
}

class AppContainerState extends State<AppContainer> {
  int currentIndex = 0;

  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  Future<void> initPlatformState() async {
    // Enable debug logs before calling `configure`.
    await Purchases.setDebugLogsEnabled(true);

    /*
    - appUserID is nil, so an anonymous ID will be generated automatically by the Purchases SDK. Read more about Identifying Users here: https://docs.revenuecat.com/docs/user-ids

    - observerMode is false, so Purchases will automatically handle finishing transactions. Read more about Observer Mode here: https://docs.revenuecat.com/docs/observer-mode
    */
    await Purchases.setup(apiKey, appUserId: null, observerMode: false);

    appData.appUserID = await Purchases.appUserID;

    Purchases.addPurchaserInfoUpdateListener((purchaserInfo) async {
      appData.appUserID = await Purchases.appUserID;

      PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
      (purchaserInfo.entitlements.all[entitlementID] != null &&
              purchaserInfo.entitlements.all[entitlementID].isActive)
          ? appData.entitlementIsActive = true
          : appData.entitlementIsActive = false;

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: kColorBar,
      tabBar: CupertinoTabBar(
        backgroundColor: kColorBar,
        activeColor: kColorAccent,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.wb_sunny,
              size: 24.0,
            ),
            label: 'Weather',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_rounded,
              size: 24.0,
            ),
            label: 'User',
          ),
        ],
        onTap: (index) {
          // back home only if not switching tab
          if (currentIndex == index) {
            switch (index) {
              case 0:
                firstTabNavKey.currentState.popUntil((r) => r.isFirst);
                break;
              case 1:
                secondTabNavKey.currentState.popUntil((r) => r.isFirst);
                break;
            }
          }
          currentIndex = index;
        },
      ),
      tabBuilder: (context, index) {
        if (index == 0) {
          return CupertinoTabView(
            navigatorKey: firstTabNavKey,
            builder: (BuildContext context) => WeatherScreen(),
          );
        } else {
          return CupertinoTabView(
            navigatorKey: secondTabNavKey,
            builder: (BuildContext context) => UserScreen(),
          );
        }
      },
    );
  }
}
