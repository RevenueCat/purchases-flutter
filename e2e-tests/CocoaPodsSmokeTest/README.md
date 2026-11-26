# Git-sourced CocoaPods installation test

The committed iOS/macOS hosts contain one Debug-only app target and the Flutter build/plugin-registration hooks. They intentionally omit native unit-test targets, icons and template menus. CocoaPods generates the workspaces and its project integration.

Each Podfile pins RevenueCat, RevenueCatUI, PurchasesHybridCommon and PurchasesHybridCommonUI to compatible Git versions. The `update_hybrid_common` lane maintains the PHC and native pins.

CI installs the pods, runs the small Purchases configuration/app-user-ID check and verifies core/UI resources, without backend credentials.

After `flutter pub get` and `pod install` in `ios/` or `macos/`, run:

```sh
flutter drive -d <device> --target=integration_test/cocoapods_smoke_test.dart --driver=test_driver/integration_test.dart
```
