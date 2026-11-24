#  Magic Weather Flutter - RevenueCat Sample

Magic Weather is a sample app demonstrating the proper methods for using RevenueCat's *Purchases* SDK.

Sign up for a free RevenueCat account [here](https://www.revenuecat.com).

## Requirements

This sample uses:

- Flutter 2.0.1
- [purchases_flutter: ^2.0.3](https://github.com/RevenueCat/purchases-flutter)

See minimum Flutter version requirements for RevenueCat's *Purchases* SDK [here](https://docs.revenuecat.com/docs/flutter).

## Features

| Feature                          | Sample Project Location                   |
| -------------------------------- | ----------------------------------------- |
| 🕹 Configuring the *Purchases* SDK  | [lib/src/views/home.dart](lib/src/views/home.dart) |
| 💰 Building a basic paywall         | [lib/src/views/paywall.dart](lib/src/views/paywall.dart) |
| 🔐 Checking subscription status     | [lib/src/views/weather.dart](lib/src/views/weather.dart) |
| 🤑 Restoring transactions           | [lib/src/views/user.dart](lib/src/views/user.dart#L42) |
| 👥 Identifying the user             | [lib/src/views/user.dart](lib/src/views/user.dart#L26) |
| 🚪 Logging out the user             | [lib/src/views/user.dart](lib/src/views/user.dart#L40) |

## Prerequisites

- Be sure to have an an [Apple Developer Account](https://developer.apple.com/account/) or [Google Play Console Account](https://play.google.com/console/developers).
- Be sure to set up at least one subscription following our guide for the [App Store](https://docs.revenuecat.com/docs/ios-products) or [Google Play](https://www.revenuecat.com/docs/android-products) and link it to RevenueCat:
    - Add the [product](https://docs.revenuecat.com/docs/entitlements#products) (e.g. `rc_3999_1y`) to RevenueCat's dashboard. It should match the product ID on the App Store.
    - Attach the product to an [entitlement](https://docs.revenuecat.com/docs/entitlements#creating-an-entitlement), e.g. `premium`.
    - Attach the product to a [package](https://docs.revenuecat.com/docs/entitlements#adding-packages) (e.g. `Annual`) inside an [offering](https://docs.revenuecat.com/docs/entitlements#creating-an-offering) (e.g. `sale` or `default`).
- Get your [API key](https://docs.revenuecat.com/docs/authentication#obtaining-api-keys) from your RevenueCat project.

## Steps to Run

1. Download or clone this repository:
    >git clone https://github.com/RevenueCat/purchases-flutter.git

2. Navigate to the `revenuecat_examples` directory and open the `Magic Weather` file in your editor of choice.
    - This sample app can be run on Android Studio or XCode. 

3. Open the terminal in your editor and run 
    ```
    flutter pub get
    ```
    
4. In your `pubspec.yaml` file, add: 
    >dependencies:
    >purchases_flutter: ^4.0.0

5. The iOS app uses Swift Package Manager. Flutter 3.44 and later enable it by default; on earlier versions, run:
    ```
    flutter config --enable-swift-package-manager
    ```
    
6. Your bundle id/ Google Play package should be something unique, typically com.companyname.appname. Make sure what is in RevenueCat matches what is in XCode or build.gradle exactly, and what is in App Store Connect or Google Play Console exactly.
  
   - To set the **bundle id**, click your project `Runner` in Xcode and navigate to the `General` tab. Match the bundle ID to your bundle ID in App Store Connect and RevenueCat. To open Xcode from Android Studio, right click on the ios folder, hover over Flutter, and click “Open iOS module in XCode”.
    
      <img src="https://i.imgur.com/1z32GRo.png" alt="General tab in Xcode" width="250px" />
    
   - To set the **Google Play package**, navigate to your `build.gradle` file (android/app/build.gradle).

      <img src="https://i.imgur.com/iJlqt94.png" alt="build.gradle file in Android Studio" width="250px" />
       
7. Navigate to your `constant.dart` file (lib/src/constant.dart) and update your API keys to match the public API key for each app respectively. These can be found by navigating to “API Keys” in the Project settings sidebar, or by clicking into a project and scrolling down to “Public API Key”. 

   - While in `constant.dart`, set the **entitlementID** to match your entitlement's identifier.

      <img src="https://i.imgur.com/TGwIUhG.png" alt="constant.dart file in Android Studio" width="250px" />

8. Build the app and run it on your device!


### Example Flow: Purchasing a Subscription

1. On the home page, select **Change the Weather**.
2. On the prompted payment sheet, select the product listed.
3. On the next modal, select **Subscribe**.
4. On the next modal, sign in with your Sandbox Apple ID.
5. On the next modal, select **Ok**.
6. Return to the home page and select **Change the Weather** to see the weather change!

#### Purchase Flow Demo
<img src="https://i.imgur.com/SSbRLhr.gif" width="220px" />

For more technical resources, check out our [documentation](https://docs.revenuecat.com).

Looking for RevenueCat Support? Visit our [Help Center](https://support.revenuecat.com/hc/en-us).
