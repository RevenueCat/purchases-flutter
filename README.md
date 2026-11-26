# purchases_flutter

The RevenueCat SDK for Flutter on iOS, Android, macOS, and web. It wraps StoreKit and Google Play Billing and handles purchases and entitlements.

[![pub.dev version](https://img.shields.io/pub/v/purchases_flutter.svg)](https://pub.dev/packages/purchases_flutter) [![License: MIT](https://img.shields.io/github/license/RevenueCat/purchases-flutter)](https://github.com/RevenueCat/purchases-flutter/blob/main/LICENSE)

[Docs](https://www.revenuecat.com/docs?utm_source=github&utm_medium=sdk_readme&utm_content=purchases-flutter) · [Install guide](https://www.revenuecat.com/docs/getting-started/installation/flutter?utm_source=github&utm_medium=sdk_readme&utm_content=purchases-flutter) · [SDK reference](https://pub.dev/documentation/purchases_flutter/latest/) · [Sample app](https://github.com/RevenueCat/purchases-flutter/tree/main/revenuecat_examples/MagicWeather) · [Changelog](https://github.com/RevenueCat/purchases-flutter/releases) · [Migration guide](https://github.com/RevenueCat/purchases-flutter/blob/main/migrations/v12-MIGRATION.md)

## Requirements

| Requirement | Minimum |
|---|---|
| Flutter | 3.41 |
| Dart | 3.11 |
| iOS | 13.0 |
| macOS | 10.15 |
| Android | 7.0 (API level 24) |
| Web | Supported |
| Android compile SDK | API 35 |
| Kotlin (Android) | 2.1.0 |
| Xcode | 15.0 |

`purchases_ui_flutter` supports iOS and Android only, so Paywalls and Customer Center aren't available on web or macOS. They need iOS 15 or later and Android 7.0 (API level 24) or later.

## Installation

Add `purchases_flutter`, plus `purchases_ui_flutter` if you show Paywalls or Customer Center:

```shell
flutter pub add purchases_flutter purchases_ui_flutter
```

If your app doesn't show Paywalls or Customer Center, add only the core package: `flutter pub add purchases_flutter`.

Then import the SDK in each file that uses it:

```dart
import 'package:purchases_flutter/purchases_flutter.dart';
```

- iOS and macOS: the SDK requires Swift Package Manager (SPM). Flutter 3.44 and later enable SPM unless your app turns it off; on Flutter 3.41 to 3.43, run `flutter config --enable-swift-package-manager` on every developer machine and in CI. If your app installs RevenueCat with CocoaPods, follow the [CocoaPods to SPM migration guide](https://www.revenuecat.com/docs/sdk-guides/flutter-cocoapods-to-spm-migration?utm_source=github&utm_medium=sdk_readme&utm_content=purchases-flutter) before you upgrade. Other plugins can keep using CocoaPods.
- iOS: add the In-App Purchase capability in Xcode before you make App Store purchases, in sandbox or production ([steps](https://www.revenuecat.com/docs/getting-started/installation/ios?utm_source=github&utm_medium=sdk_readme&utm_content=purchases-flutter#3-enable-the-in-app-purchase-capability)). The Test Store works without it.
- Android: the Activity that starts purchases needs a `launchMode` of `standard` or `singleTop` (new Flutter projects use `singleTop`). Other values cancel the purchase when Google Play sends the user to another app to verify payment.
- Android: for Paywalls, `MainActivity` must extend `FlutterFragmentActivity` instead of `FlutterActivity` ([details](https://www.revenuecat.com/docs/getting-started/installation/flutter?utm_source=github&utm_medium=sdk_readme&utm_content=purchases-flutter#subclass-flutterfragmentactivity)).

| Package | What it's for | When you need it |
|---|---|---|
| [`purchases_flutter`](https://pub.dev/packages/purchases_flutter) | Purchases, entitlements, subscription status | Always |
| [`purchases_ui_flutter`](https://pub.dev/packages/purchases_ui_flutter) | Paywalls and Customer Center | You show RevenueCat Paywalls or Customer Center |
| [`purchases_admob_flutter`](https://pub.dev/packages/purchases_admob_flutter) | Tracks AdMob ad events in RevenueCat | You show AdMob ads. Install it separately |

## Quick start

Before you start, create a RevenueCat project, connect your store or start with the Test Store, and add an entitlement. See the [Quickstart](https://www.revenuecat.com/docs/getting-started/quickstart?utm_source=github&utm_medium=sdk_readme&utm_content=purchases-flutter).

Configure `Purchases` once at app launch with each platform's public API key (the Test Store key while you test, in debug builds only):

```dart
import 'dart:io' show Platform;

import 'package:purchases_flutter/purchases_flutter.dart';

Future<void> initPlatformState() async {
  await Purchases.setLogLevel(LogLevel.debug);

  late PurchasesConfiguration configuration;
  if (Platform.isAndroid) {
    configuration = PurchasesConfiguration(<revenuecat_project_google_api_key>);
  } else if (Platform.isIOS) {
    configuration = PurchasesConfiguration(<revenuecat_project_apple_api_key>);
  }
  await Purchases.configure(configuration);
}
```

This snippet covers Android and iOS. On macOS, add a `Platform.isMacOS` branch that uses your Apple API key. On web, check `kIsWeb` (from `package:flutter/foundation.dart`) first and pass the public API key of your web config ([Flutter web setup](https://www.revenuecat.com/docs/getting-started/installation/flutter?utm_source=github&utm_medium=sdk_readme&utm_content=purchases-flutter#flutter-web)).

Inside an async function, check whether the user has an active entitlement before you show a paywall:

```dart
import 'package:flutter/services.dart';

try {
  CustomerInfo customerInfo = await Purchases.getCustomerInfo();
  if (customerInfo.entitlements.active.isNotEmpty) {
    // User has access to some entitlement
  }
} on PlatformException catch (e) {
  // Error fetching customer info
}
```

## What's included

- [Paywalls](https://www.revenuecat.com/docs/tools/paywalls?utm_source=github&utm_medium=sdk_readme&utm_content=purchases-flutter): build single-screen or multi-step paywalls in the dashboard and change them without an app update.
- [Customer Center](https://www.revenuecat.com/docs/tools/customer-center?utm_source=github&utm_medium=sdk_readme&utm_content=purchases-flutter): a self-service screen where users cancel subscriptions and restore purchases. On iOS, users can also request refunds and change plans.
- [Placements](https://www.revenuecat.com/docs/tools/targeting/placements?utm_source=github&utm_medium=sdk_readme&utm_content=purchases-flutter): serve a different Offering at each paywall location in your app.
- [Test Store](https://www.revenuecat.com/docs/test-and-launch/sandbox/test-store?utm_source=github&utm_medium=sdk_readme&utm_content=purchases-flutter): make test purchases before you set up App Store Connect or Google Play Console.
- [In-app currency](https://www.revenuecat.com/docs/offerings/in-app-currency?utm_source=github&utm_medium=sdk_readme&utm_content=purchases-flutter): read the current Customer's in-app currency balances.
- [iOS subscription offers](https://www.revenuecat.com/docs/subscription-guidance/subscription-offers/ios-subscription-offers?utm_source=github&utm_medium=sdk_readme&utm_content=purchases-flutter): promotional offers, the offer code redemption sheet, and win-back offers.
- [Your own purchase code](https://www.revenuecat.com/docs/migrating-to-revenuecat/sdk-or-not/finishing-transactions?utm_source=github&utm_medium=sdk_readme&utm_content=purchases-flutter): set `purchasesAreCompletedBy` when your app completes purchases itself, for example with another in-app purchase plugin.
- [Offline entitlements](https://www.revenuecat.com/docs/customers/customer-info?utm_source=github&utm_medium=sdk_readme&utm_content=purchases-flutter#offline-entitlements): the SDK grants entitlements for new subscription purchases while RevenueCat's servers are down. It's unavailable when your app completes purchases itself.
- [Trusted Entitlements](https://www.revenuecat.com/docs/customers/trusted-entitlements?utm_source=github&utm_medium=sdk_readme&utm_content=purchases-flutter): informational by default on iOS, Android, and macOS. The SDK checks a signature on entitlement data and reports the result in each entitlement's `verification` property, so your app can detect tampered responses. It doesn't block access.
- [Flutter web](https://www.revenuecat.com/docs/getting-started/installation/flutter?utm_source=github&utm_medium=sdk_readme&utm_content=purchases-flutter#flutter-web): the SDK uses RevenueCat Billing, Stripe Billing, or Paddle Billing instead of the app stores. [Redemption Links](https://www.revenuecat.com/docs/web/redemption-links?utm_source=github&utm_medium=sdk_readme&utm_content=purchases-flutter) unlock a web purchase in your mobile app from a deep link.
- [Ad Monetization](https://www.revenuecat.com/docs/ad-monetization?utm_source=github&utm_medium=sdk_readme&utm_content=purchases-flutter): report ad impressions, clicks, and revenue next to subscription data. On iOS, ad tracking needs iOS 15 or later. The [AdMob adapter](https://www.revenuecat.com/docs/getting-started/adapter-sdks/admob?utm_source=github&utm_medium=sdk_readme&utm_content=purchases-flutter) tracks AdMob events automatically.

## Documentation

- [Install guide](https://www.revenuecat.com/docs/getting-started/installation/flutter?utm_source=github&utm_medium=sdk_readme&utm_content=purchases-flutter): pub setup, iOS and Android project setup, Flutter web, and troubleshooting.
- [Configure the SDK](https://www.revenuecat.com/docs/getting-started/configuring-sdk?utm_source=github&utm_medium=sdk_readme&utm_content=purchases-flutter): API keys for each platform, debug logs, Test Store, and other configuration options.
- [Displaying paywalls](https://www.revenuecat.com/docs/tools/paywalls/displaying-paywalls?utm_source=github&utm_medium=sdk_readme&utm_content=purchases-flutter): present a paywall with `presentPaywall`, `presentPaywallIfNeeded`, or `PaywallView`.
- [Testing purchases](https://www.revenuecat.com/docs/test-and-launch/sandbox?utm_source=github&utm_medium=sdk_readme&utm_content=purchases-flutter): Test Store and sandbox testing.
- [Migration guide](https://github.com/RevenueCat/purchases-flutter/blob/main/migrations/v12-MIGRATION.md): changes in the current major version, including the Flutter 3.41 and Dart 3.11 minimums and the Swift Package Manager requirement on iOS and macOS.
- [SDK reference](https://pub.dev/documentation/purchases_flutter/latest/): every public class and method in `purchases_flutter`. `purchases_ui_flutter` has its [own reference](https://pub.dev/documentation/purchases_ui_flutter/latest/).

## Using an AI coding agent

Your agent's training data is likely older than the current version of this SDK. Point it at current sources:

- [llms.txt](https://www.revenuecat.com/docs/llms.txt?utm_source=github&utm_medium=sdk_readme&utm_content=purchases-flutter): an index of the docs. Add `.md` to any docs URL for a Markdown version.
- [RevenueCat MCP server](https://www.revenuecat.com/docs/tools/mcp?utm_source=github&utm_medium=sdk_readme&utm_content=purchases-flutter): lets your agent read and change your RevenueCat project configuration.
- [AI Toolkit](https://github.com/RevenueCat/ai-toolkit): installs RevenueCat skills and the MCP server in one step.
- [Releases](https://github.com/RevenueCat/purchases-flutter/releases): check the latest version before adding the dependency.

## Sample apps

- [MagicWeather](https://github.com/RevenueCat/purchases-flutter/tree/main/revenuecat_examples/MagicWeather): a Flutter app for iOS, Android, and web that configures the SDK, builds a custom paywall from the current Offering, checks subscription status, restores purchases, and logs users in and out.

## Getting help

- Bugs: open an issue in [this repo](https://github.com/RevenueCat/purchases-flutter/issues).
- Account or configuration questions: [RevenueCat Support](https://www.revenuecat.com/docs/revenuecat-support/support-first-steps?utm_source=github&utm_medium=sdk_readme&utm_content=purchases-flutter).
- Discussion: [RevenueCat Community](https://community.revenuecat.com/).

## Contributing

This repository is published from the `main` branch and release tags of RevenueCat's internal development repository. Issues are tracked here. Pull requests are welcome: a maintainer reviews them here and brings accepted changes into the internal repository, so they can't be merged directly.

See the [contributing guide](https://github.com/RevenueCat/purchases-flutter/blob/main/CONTRIBUTING.md).

## License

MIT. See [LICENSE](https://github.com/RevenueCat/purchases-flutter/blob/main/LICENSE).
