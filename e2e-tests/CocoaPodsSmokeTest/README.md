# Git-sourced CocoaPods installation test

This minimal Flutter app installs the local core/UI plugins through CocoaPods on iOS and macOS. Its Podfiles source RevenueCat, RevenueCatUI, PurchasesHybridCommon and PurchasesHybridCommonUI from Git.

The PHC refs and native iOS tags are explicit in each Podfile. The `update_hybrid_common` Fastlane lane updates the PHC pins and uses PHC's native iOS requirement to update the RevenueCat/RevenueCatUI pins.

CI runs `pod install` and `flutter drive` against the committed app. The smoke test configures Purchases with a fake API key and checks the app user ID and anonymous status, without backend credentials.

To run locally, use `flutter pub get`, then `pod install` in `ios/` or `macos/`, followed by:

```sh
flutter drive -d <device> --target=integration_test/cocoapods_smoke_test.dart --driver=test_driver/integration_test.dart
```
