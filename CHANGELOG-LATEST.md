### New features
*   📱 Initial support for cross-platform RevenueCat Paywalls 🐾 🧱  (#931) 

#### Instructions:
- For Android, you need to change your `MainActivity` to subclass `FlutterFragmentActivity` instead of `FlutterActivity`. Also, the min sdk version of the new package is `24`. Please make sure your app's `android/build.gradle` minSdkVersion has that or a higher version.
- Add `purchases-ui-flutter` in your `pubspec.yaml`:
```yaml
dependencies:
  purchases_ui_flutter: 6.15.0
```

#### Usage:
```dart
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

await RevenueCatUI.presentPaywallIfNeeded("pro");
```

#### Limitations:
- Currently only full screen paywalls are supported
- There is no way to detect paywall events other than using `addCustomerInfoUpdateListener`

