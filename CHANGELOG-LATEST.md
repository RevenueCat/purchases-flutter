### New features
*   📱 Initial support for cross-platform RevenueCat Paywalls 🐾 🧱  (#852) 

#### Instructions:
- For Android, you need to change your `MainActivity` to subclass `FlutterFragmentActivity` instead of `FlutterActivity`. Also, the min sdk version of the new package is 24. Please make sure your app's android/build.gradle minSdkVersion has that or a higher version.
- Add `purchases-ui-flutter` in your `pubspec.yaml`:
```yaml
dependencies:
  purchases_ui_flutter: 6.15.0-beta.4
```

#### Usage:
```dart
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

await RevenueCatUI.presentPaywallIfNeeded("pro");
```

#### Limitations:
- Currently only full screen paywalls are supported
- There is no way to detect paywall events other than using `addCustomerInfoUpdateListener`

#### Breaking changes from previous beta:
- Now, you need to add a new dependency `purchases_ui_flutter` to your `pubspec.yaml`. Before this, it was part of the main RevenueCat SDK `purchases_flutter`.
- A new import is required to use this functionality: `import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';`
- Usage has changed the class from `Purchases.presentPaywall` to `RevenueCatUI.presentPaywall`.
- `presentPaywall` and `presentPaywallIfNeeded` now don't return a result. To detect purchases, please use `Purchases.getCustomerInfo` from the `purchases_flutter` SDK. A return value will be added in future releases. 

### Other Changes
* Fix pub score for `purchases-ui-flutter` (#924) via Toni Rico (@tonidero)
* Update `paywalls` to latest `main` (#923) via Toni Rico (@tonidero)
* Rename `purchases_flutter_ui` to `purchases_ui_flutter` (#921) via Toni Rico (@tonidero)
* Separate paywalls into a different package (#919) via Toni Rico (@tonidero)
* Remove result from presentPaywall methods (#916) via Toni Rico (@tonidero)
* Update to use PHC PaywallHelpers instead of custom activity (#903) via Toni Rico (@tonidero)

