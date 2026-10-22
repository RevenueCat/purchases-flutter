<p align="center">
  <img src="https://uploads-ssl.webflow.com/5e2613cf294dc30503dcefb7/5e752025f8c3a31d56a51408_logo_red%20(1).svg" width="350" alt="RevenueCat"/>
<br>

[![pub package](https://img.shields.io/pub/v/purchases_ui_flutter.svg)](https://pub.dartlang.org/packages/purchases_ui_flutter)

## purchases_ui_flutter

*purchases_ui_flutter* allows to use [RevenueCat](https://www.revenuecat.com/)'s paywalls and customer center in your Flutter application. Check our [main SDK](https://pub.dev/packages/purchases_flutter) for more information and our [paywalls documentation](https://www.revenuecat.com/docs/paywalls)

## Installation
To use this plugin, add `purchases_flutter` and `purchases_ui_flutter` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

## Paywalls

Present your paywall like:
```dart
await RevenueCatUI.presentPaywall();
```

or conditionally based on entitlements:
```dart
await RevenueCatUI.presentPaywallIfNeeded("requiredEntitlementId");
```

Embed a full paywall with `PaywallView`, or place an original-template paywall
below your own content with `OriginalTemplatePaywallFooterView` (formerly
`PaywallFooterView`).

On Android, Flutter attempts to use Texture Layer Hybrid Composition by
default, falling back to Hybrid Composition when necessary. If an embedded
view stops rendering on affected Android 10 devices, explicitly select the
more expensive Hybrid Composition mode:
```dart
PaywallView(
  androidPlatformViewMode: AndroidPlatformViewMode.hybridComposition,
);
```

The `androidPlatformViewMode` parameter is also available on
`OriginalTemplatePaywallFooterView`, `PaywallFooterView`, and
`CustomerCenterView`. It is ignored on iOS and macOS. See
[RevenueCat/purchases-flutter#1954](https://github.com/RevenueCat/purchases-flutter/issues/1954)
and [flutter/flutter#160854](https://github.com/flutter/flutter/issues/160854)
for details.

## Customer Center

 Present as a modal (callbacks optional):
```dart
await RevenueCatUI.presentCustomerCenter(
  onRestoreCompleted: (customerInfo) {
    // handle restore success
  },
  onRefundRequestCompleted: (productId, status) {
    // handle refund completion
  },
);

// Or, if you don't need callbacks:
await RevenueCatUI.presentCustomerCenter();
```

Or display inline using the `CustomerCenterView` widget. See the [CustomerCenterView implementation](./lib/views/customer_center_view.dart) for full API details and callback options.

### Requirements
*purchases_ui_flutter* requires XCode 14.0+ and minimum targets iOS 11.0+ and Android 24+. Paywalls will only work on iOS 15.0+ and Android 24+.

## SDK Reference
Our full SDK reference [can be found here](https://pub.dev/documentation/purchases_ui_flutter/latest/).

## Getting Started
For more detailed information, you can view our complete documentation at [docs.revenuecat.com](https://docs.revenuecat.com/docs/flutter).
