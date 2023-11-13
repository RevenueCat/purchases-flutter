### New Features
*   📱 Initial support for cross-platform RevenueCat Paywalls 🐾 🧱  (#852) 

#### Instructions:
- Update `purchases-flutter` in your `pubspec.yaml`:
```yaml
dependencies:
  purchases_flutter: 6.3.0-beta.1
```

#### Usage:
```dart
await Purchases.presentPaywallIfNeeded("pro");
```

#### Limitations:

- Currently only full screen paywalls are supported
- There is no way to detect paywall events other than using `addCustomerInfoUpdateListener`
- Android's `minSdkVersion` is temporarily increased from `19` to `24` to support paywalls. This will be reverted in a future release as we split `purchases_flutter` and `purchases_flutter_ui`