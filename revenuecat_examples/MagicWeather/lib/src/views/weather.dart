import 'package:flutter/material.dart';
import 'package:magic_weather_flutter/src/constant.dart';
import 'package:magic_weather_flutter/src/components/top_bar.dart';
import 'package:magic_weather_flutter/src/model/singletons_data.dart';
import 'package:magic_weather_flutter/src/model/styles.dart';
import 'package:magic_weather_flutter/src/model/weather_data.dart';
import 'package:purchases_flutter/object_wrappers.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:magic_weather_flutter/src/views/paywall.dart';
import 'package:magic_weather_flutter/src/components/native_dialog.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  bool _isLoading = false;

  /*
    We should check if we can magically change the weather 
    (subscription active) and if not, display the paywall.
  */
  void perfomMagic() async {
    setState(() {
      _isLoading = true;
    });

    PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();

    if (purchaserInfo.entitlements.all[entitlementID] != null &&
        purchaserInfo.entitlements.all[entitlementID].isActive == true) {
      appData.currentData = WeatherData.generateData();

      setState(() {
        _isLoading = false;
      });
    } else {
      Offerings offerings;
      try {
        offerings = await Purchases.getOfferings();
      } on PlatformException catch (e) {
        await showDialog(
            context: context,
            builder: (BuildContext context) => ShowDialogToDismiss(
                title: "Error", content: e.message, buttonText: 'OK'));
      }

      setState(() {
        _isLoading = false;
      });

      if (offerings == null || offerings.current == null) {
        // offerings are empty, show a message to your user
      } else {
        // current offering is available, show paywall
        await showModalBottomSheet(
          useRootNavigator: true,
          isDismissible: true,
          isScrollControlled: true,
          backgroundColor: kColorBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
              return Paywall(
                offering: offerings.current,
              );
            });
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TopBar(
        text: "✨ Magic Weather",
        style: kTitleTextStyle,
        uniqueHeroTag: 'weather',
        child: Scaffold(
          backgroundColor: appData.currentData.weatherColor,
          body: ModalProgressHUD(
            inAsyncCall: _isLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "${appData.currentData.emoji}\n${appData.currentData.temperature}°${appData.currentData.unit.toString().split('.')[1].toUpperCase()}",
                          textAlign: TextAlign.center,
                          style: kDescriptionTextStyle.copyWith(
                              fontSize: kFontSizeLarge),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.near_me),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                    "${appData.currentData.environment.toString().split('.')[1].toUpperCase()}",
                                    style: kDescriptionTextStyle.copyWith(
                                        fontSize: kFontSizeMedium,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: TextButton(
                    onPressed: () => perfomMagic(),
                    child: Text(
                      "✨ Change the Weather",
                      style: kDescriptionTextStyle.copyWith(
                          fontSize: kFontSizeMedium,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
