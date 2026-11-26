## RevenueCat SDK
### 💥 Breaking Changes

**Drop CocoaPods support.** RevenueCat’s iOS and macOS dependencies now require Swift Package Manager. Migrate before upgrading or stay on 11.x until you can migrate. On Flutter 3.41–3.43, enable Swift Package Manager explicitly. Flutter 3.44 and later enable it by default unless your app disables it. [Flutter migration guide](https://rev.cat/flutter-spm-migration)

**Raise the Flutter, Dart, and Android minimums.** `purchases_flutter` and `purchases_ui_flutter` now require Flutter 3.41.0 and Dart 3.11.0 or later on all platforms. Android builds require Android 7.0 (`minSdk` 24). If your app sets a lower `minSdk` explicitly, raise it before upgrading. [Flutter and Dart minimums](https://github.com/RevenueCat/purchases-flutter_internal/pull/8) · [Android minimum](https://github.com/RevenueCat/purchases-flutter_internal/pull/60)

**Make `entitlementVerificationMode` nullable.** Code that reads `PurchasesConfiguration.entitlementVerificationMode` must handle `null`. For example, use `configuration.entitlementVerificationMode?.name`. Leaving the setting unset uses the native informational default. [Flutter #12](https://github.com/RevenueCat/purchases-flutter_internal/pull/12)

### 📦 Dependency Updates
* Updates purchases-hybrid-common to 21.0.0 ([#58](https://github.com/RevenueCat/purchases-flutter_internal/pull/58)) via Antonio Pallares ([@ajpallares](https://github.com/ajpallares))
