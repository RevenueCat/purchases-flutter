<p align="center">
  <img src="https://uploads-ssl.webflow.com/5e2613cf294dc30503dcefb7/5e752025f8c3a31d56a51408_logo_red%20(1).svg" width="350" alt="RevenueCat"/>
<br>

[![pub package](https://img.shields.io/pub/v/purchases_ui_flutter.svg)](https://pub.dartlang.org/packages/purchases_ui_flutter)

## purchases_ui_flutter

*purchases_ui_flutter* allows to use [RevenueCat](https://www.revenuecat.com/)'s paywalls in your Flutter application. Check our [main SDK](https://pub.dev/packages/purchases_flutter) for more information and our [paywalls documentation](https://www.revenuecat.com/docs/paywalls)

## Installation
To use this plugin, add `purchases_flutter` and `purchases_ui_flutter` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

Then, you can present your paywall like:
```dart
await RevenueCatUI.presentPaywall();
```

or, if you want to present it conditionally based on a user's entitlements:
```dart
await RevenueCatUI.presentPaywallIfNeeded("requiredEntitlementId");
```

### Requirements
*purchases_ui_flutter* requires XCode 14.0+ and minimum targets iOS 11.0+ and Android 24+. Paywalls will only work on iOS 15.0+ and Android 24+.

## SDK Reference
Our full SDK reference [can be found here](https://pub.dev/documentation/purchases_ui_flutter/latest/).

## Getting Started
For more detailed information, you can view our complete documentation at [docs.revenuecat.com](https://docs.revenuecat.com/docs/flutter).
