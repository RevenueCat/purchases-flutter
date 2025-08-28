<p align="center">
  <img src="https://uploads-ssl.webflow.com/5e2613cf294dc30503dcefb7/5e752025f8c3a31d56a51408_logo_red%20(1).svg" width="350" alt="RevenueCat"/>
<br>
  
[![pub package](https://img.shields.io/pub/v/purchases_flutter.svg)](https://pub.dartlang.org/packages/purchases_flutter)

## purchases_flutter

*purchases_flutter* is a client for the [RevenueCat](https://www.revenuecat.com/) subscription and purchase tracking system. It is an open source framework that provides a wrapper around `StoreKit`, `Google Play Billing` and the RevenueCat backend to make implementing in-app subscriptions in `Flutter` easy - receipt validation and status tracking included!

## Features
|   | RevenueCat |
| --- | --- |
✅ | Server-side receipt validation
➡️ | [Webhooks](https://docs.revenuecat.com/docs/webhooks) - enhanced server-to-server communication with events for purchases, renewals, cancellations, and more  
🎯 | Subscription status tracking - know whether a user is subscribed whether they're on iOS or Android
📊 | Analytics - automatic calculation of metrics like conversion, mrr, and churn  
📝 | [Online documentation](https://docs.revenuecat.com/docs/flutter) and [SDK Reference](https://pub.dev/documentation/purchases_flutter/latest/) up to date  
🔀 | [Integrations](https://www.revenuecat.com/integrations) - over a dozen integrations to easily send purchase data where you need it  
💯 | Well maintained - [frequent releases](https://github.com/RevenueCat/purchases-flutter/releases)  
📮 | Great support - [Help Center](https://revenuecat.zendesk.com) 

## Installation
To use this plugin, add `purchases_flutter` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

### Requirements
*purchases_flutter* requires Xcode 14.0+ and minimum targets iOS 13.0+/Android SDK 21+ (Android 5.0+).

## SDK Reference
 Our full SDK reference [can be found here](https://pub.dev/documentation/purchases_flutter/latest/).

## Getting Started
For more detailed information, you can view our complete documentation at [docs.revenuecat.com](https://docs.revenuecat.com/docs/flutter).

## Codelab

This codelab is a step-by-step tutorial designed to help you learn and master the [RevenueCat SDK](https://www.revenuecat.com/docs/welcome/overview) taking you from the absolute basics to more advanced implementation. Whether you're just getting started or looking to deepen your understanding, this guide walks you through everything you need to go from zero to hero with RevenueCat.

1. [RevenueCat Google Play Integration](https://revenuecat.github.io/codelab/google-play/codelab-1-google-play-integration/index.html#0): In this codelab, you'll learn how to:

   - Properly configure products on Google Play.
   - Set up the RevenueCat dashboard and connect it to your Google Play products.
   - Understanding Product, Offering, Package, and Entitlement.
   - Create paywalls using the [Paywall Editor](https://www.revenuecat.com/docs/tools/paywalls/creating-paywalls#using-the-editor).

2. [Flutter Purchases & Paywalls Overview](https://revenuecat.github.io/codelab/flutter/codelab-4-flutter-sdk/index.html#0): In this codelab, you will:
- Integrate the RevenueCat SDK into your Flutter project
- Implement in-app purchases in your Flutter application
- Learn how to distinguish between paying and non-paying users
- Build a paywall screen, which is based on the server-driven UI approach
