import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:magic_weather_flutter/src/constant.dart';
import 'package:magic_weather_flutter/src/model/singletons_data.dart';
import 'package:magic_weather_flutter/src/model/styles.dart';

class Paywall extends StatefulWidget {
  final Offering offering;

  Paywall({Key key, @required this.offering}) : super(key: key);

  @override
  _PaywallState createState() => _PaywallState();
}

class _PaywallState extends State<Paywall> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Wrap(
          children: <Widget>[
            Container(
              height: 70.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: kColorBar,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25.0))),
              child: Center(
                  child:
                      Text('✨ Magic Weather Premium', style: kTitleTextStyle)),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 32, bottom: 16, left: 16.0, right: 16.0),
              child: Container(
                child: Text(
                  'MAGIC WEATHER PREMIUM',
                  style: kDescriptionTextStyle,
                ),
                width: double.infinity,
              ),
            ),
            ListView.builder(
              itemCount: widget.offering.availablePackages.length,
              itemBuilder: (BuildContext context, int index) {
                var myProductList = widget.offering.availablePackages;
                return Card(
                  color: Colors.black,
                  child: ListTile(
                      onTap: () async {
                        try {
                          PurchaserInfo purchaserInfo =
                              await Purchases.purchasePackage(
                                  myProductList[index]);
                          appData.entitlementIsActive = purchaserInfo
                              .entitlements.all[entitlementID].isActive;
                        } catch (e) {
                          print(e);
                        }

                        setState(() {});
                        Navigator.pop(context);
                      },
                      title: Text(
                        myProductList[index].product.title,
                        style: kTitleTextStyle,
                      ),
                      subtitle: Text(
                        myProductList[index].product.description,
                        style: kDescriptionTextStyle.copyWith(
                            fontSize: kFontSizeSuperSmall),
                      ),
                      trailing: Text(myProductList[index].product.priceString,
                          style: kTitleTextStyle)),
                );
              },
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 32, bottom: 16, left: 16.0, right: 16.0),
              child: Container(
                child: Text(
                  footerText,
                  style: kDescriptionTextStyle,
                ),
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
