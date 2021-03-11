import 'package:flutter/material.dart';

//TO DO: add the API key for your app from the RevenueCat dashboard: https://app.revenuecat.com
const apiKey = 'api_key';

//TO DO: add the entitlement ID from the RevenueCat dashboard that is activated upon successful in-app purchase for the duration of the purchase.
const entitlementID = 'premium';

//TO DO: change the footer note
const footerText =
    "Don't forget to add your subscription terms and conditions. Read more about this here: https://www.revenuecat.com/blog/schedule-2-section-3-8-b";

const kColorNavigationBar = Color(0xff121212); // top nav bar
const kColorBottomNavigationBar = Color(0xff121212); // bottom nav bar
const kColorText = Color(0xffffffff); // text color
const kColorPrimary = Color(0xff000000); // background
const kColorBottomBarIconSelected = Color(0xff0a73d9);
const kColorAlert = Colors.red;
const kColorSuccess = Colors.green;
const kColorSearchBar = kColorPaywallBackground; // search bar
const kColorNavIcon = Color(0xff83888B);
const kColorPaywallBackground = Color(0xff1e1c21);
const kColorPremiumBackground = Color(0xff2e2c31);

const kDescriptionTextStyle = TextStyle(
  color: kColorText,
  fontWeight: FontWeight.normal,
  fontSize: kFontSizeNormal,
);

TextStyle kTitleTextStyle = TextStyle(
  color: kColorText,
  fontWeight: FontWeight.bold,
  fontSize: kFontSizeMedium,
);

const myDecoration = InputDecoration(
  fillColor: kColorSearchBar,
  filled: true,
  hintText: 'Enter App User ID',
  hintStyle: TextStyle(color: kColorText),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(kButtonRadius)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kColorSearchBar, width: 0),
    borderRadius: BorderRadius.all(Radius.circular(kButtonRadius)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kColorSearchBar, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(kButtonRadius)),
  ),
);

const kButtonRadius = 10.0;

const kFontSizeSuperSmall = 10.0;
const kFontSizeSmall = 13.0;
const kFontSizeNormal = 16.0;
const kFontSizeMedium = 18.0;
const kFontSizeLarge = 96.0;
