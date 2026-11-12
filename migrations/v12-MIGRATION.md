## v12 Installation Changes

Both `purchases_flutter` and `purchases_ui_flutter` require Flutter 3.27.0+ and Dart 3.6.0+ on all platforms. Upgrade your Flutter SDK before updating these packages. On Flutter versions before 3.44, enable SPM manually as described in the migration guide below.

This major adopts Purchases Hybrid Common 21, which is no longer published to CocoaPods trunk. Swift Package Manager (SPM) is the supported way to integrate RevenueCat's Apple dependencies.

Before upgrading, follow the [Flutter CocoaPods-to-SPM migration guide](https://rev.cat/flutter-spm-migration). Migrate both the core and UI packages if your app uses RevenueCat UI.

The guide covers iOS and macOS. Flutter can continue using CocoaPods for other plugins.
