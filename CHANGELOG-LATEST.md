### New Features
*   📱 Initial support for cross-platform RevenueCat Paywalls 🐾 🧱  (#852) 

#### Instructions:
- Update `purchases-flutter` in your `pubspec.yaml`:
```yaml
dependencies:
  purchases_flutter: 6.6.0-beta.3
```
- For Android, you need to change your `MainActivity` to subclass `FlutterFragmentActivity` instead of `FlutterActivity`.

#### Usage:
```dart
await Purchases.presentPaywallIfNeeded("pro");
```

#### Limitations:

- Currently only full screen paywalls are supported
- There is no way to detect paywall events other than using `addCustomerInfoUpdateListener`
- Android's `minSdkVersion` is temporarily increased from `19` to `24` to support paywalls. This will be reverted in a future release as we split `purchases_flutter` and `purchases_flutter_ui`

### Breaking changes from previous beta

- `PurchasesFlutterActivity` has been removed. Use `FlutterFragmentActivity` provided by Flutter instead

### Fixes from previous beta
* Fix `presentPaywallIfNeeded` (#904) via Toni Rico (@tonidero)

### Other Changes
* Update paywalls latest main (#906) via Toni Rico (@tonidero)
* Update to use PHC PaywallHelpers instead of custom activity (#903) via Toni Rico (@tonidero)
* Fix flutter analyze deprecation warnings (#872)
