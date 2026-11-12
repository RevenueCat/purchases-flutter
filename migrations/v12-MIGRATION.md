## v12 Installation Changes

Both `purchases_flutter` and `purchases_ui_flutter` require Flutter 3.41.0+ and Dart 3.11.0+ on all platforms. Upgrade your Flutter SDK before updating these packages.

On Flutter 3.41–<3.44, enable SPM before building. Run this on every developer machine and in CI:

```sh
flutter config --enable-swift-package-manager
```

Alternatively, enable SPM in your app's `pubspec.yaml` under `flutter.config.enable-swift-package-manager`. Flutter 3.44+ enables SPM by default; remove any app setting that explicitly disables it. Leaving SPM disabled makes Flutter attempt an unsupported CocoaPods installation.

This major adopts Purchases Hybrid Common 21, which is no longer published to CocoaPods trunk. Swift Package Manager (SPM) is the supported way to integrate RevenueCat's Apple dependencies.

Before upgrading, follow the [Flutter CocoaPods-to-SPM migration guide](https://rev.cat/flutter-spm-migration). Migrate both the core and UI packages if your app uses RevenueCat UI.

The guide covers iOS and macOS. Flutter can continue using CocoaPods for other plugins.
