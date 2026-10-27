<p align="center">
  <img src="https://uploads-ssl.webflow.com/5e2613cf294dc30503dcefb7/5e752025f8c3a31d56a51408_logo_red%20(1).svg" width="350" alt="RevenueCat"/>
<br>

[![pub package](https://img.shields.io/pub/v/purchases_ui_flutter.svg)](https://pub.dartlang.org/packages/purchases_ui_flutter)

## purchases_ui_flutter

*purchases_ui_flutter* allows to use [RevenueCat](https://www.revenuecat.com/)'s paywalls and customer center in your Flutter application. Check our [main SDK](https://pub.dev/packages/purchases_flutter) for more information and our [paywalls documentation](https://www.revenuecat.com/docs/paywalls)

## Installation
To use this plugin, add `purchases_flutter` and `purchases_ui_flutter` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

## Paywalls

Present your paywall like:
```dart
await RevenueCatUI.presentPaywall();
```

or conditionally based on entitlements:
```dart
await RevenueCatUI.presentPaywallIfNeeded("requiredEntitlementId");
```

Embed a full paywall with `PaywallView`, or place an original-template paywall
below your own content with `OriginalTemplatePaywallFooterView` (formerly
`PaywallFooterView`).

On Android, Flutter attempts to use Texture Layer Hybrid Composition by
default, falling back to Hybrid Composition when necessary. If an embedded
view stops rendering on affected Android 10 devices, explicitly select the
more expensive Hybrid Composition mode:
```dart
PaywallView(
  androidPlatformViewMode: AndroidPlatformViewMode.hybridComposition,
);
```

The `androidPlatformViewMode` parameter is also available on
`OriginalTemplatePaywallFooterView`, `PaywallFooterView`, and
`CustomerCenterView`. It is ignored on iOS and macOS. See
[RevenueCat/purchases-flutter#1954](https://github.com/RevenueCat/purchases-flutter/issues/1954)
and [flutter/flutter#160854](https://github.com/flutter/flutter/issues/160854)
for details.

## Customer Center

 Present as a modal (callbacks optional):
```dart
await RevenueCatUI.presentCustomerCenter(
  onRestoreCompleted: (customerInfo) {
    // handle restore success
  },
  onRefundRequestCompleted: (productId, status) {
    // handle refund completion
  },
);

// Or, if you don't need callbacks:
await RevenueCatUI.presentCustomerCenter();
```

Or display inline using the `CustomerCenterView` widget. See the [CustomerCenterView implementation](./lib/views/customer_center_view.dart) for full API details and callback options.

## Checkpoints (experimental, invite-only)

> **Experimental:** The checkpoints API is experimental and may change or be removed in a future release without a major version bump.

Checkpoints let you gate navigation with flows (often paywalls) defined in the RevenueCat dashboard. They require access to the native SDKs' invite-only checkpoints API, iOS 15+ or Android, and Purchases to be configured.

```dart
final removeCallback = RevenueCatUI.checkpoint(
  'upgrade',
  (result) {
    // Continue to the next screen here. The native SDK decides when the checkpoint passes.
    print('${result.customer} ${result.flow?.obtainedEntitlements} ${result.flow?.obtainedProducts}');
  },
  params: CheckpointParams(
    customVariables: {'level': CustomVariableValue.number(12)},
    presentationMode: FlowPresentationMode.modalSheet,
  ),
);

// Remove the callback when the owning screen is disposed. This does not dismiss native UI.
// removeCallback();
```

The callback is called at most once, only when the checkpoint passes. `result.flow` is `null` when there was nothing to present, such as an unconfigured identifier or no matching rule. Backing out, a blocking failure, or another checkpoint owning presentation does not invoke the callback. Treat a checkpoint as a callback rather than a pending operation to await. By default, the SDK presents the flow and its error dialogs.

### App-presented checkpoint errors (experimental)

Supply an error presenter to handle errors with Flutter UI on Android and iOS:

```dart
final removeCallback = RevenueCatUI.checkpoint(
  'upgrade',
  (result) { /* Continue to the next screen. */ },
  params: CheckpointParams(
    errorPresenter: CheckpointErrorPresenter(
      context: context,
      present: (request) async {
        await showDialog<void>(
          context: request.context,
          useRootNavigator: false,
          builder: (dialogContext) => AlertDialog(
            title: const Text('Something went wrong'),
            content: Text(request.error.message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    ),
  ),
);
```

The configuration context must be mounted and have a root navigator. The library owns the host; no public host widget is required. Present error UI using `request.context` and `useRootNavigator: false`, so it is disposed with the checkpoint. On Android, the error host occludes earlier pages in that root navigator; app shells that paint backgrounds outside the navigator can cover the underlying native flow. Error UI presented through a captured context's nested navigator or outside the host subtree is not managed by the library.

Completing the presenter's future acknowledges the error; the native SDK then decides how the flow proceeds. `await request.complete()` can acknowledge explicitly once app UI has dismissed; repeated acknowledgements are harmless. The presenter's future must still settle. A thrown or failed presenter is reported through Flutter's error handler and acknowledged so it cannot leave the native flow waiting. Error requests include `requestId`, `kind`, and `PurchasesError`; they are serialized and never invoke a second presenter concurrently for the same call.

`presentationMode` still controls the flow: iOS uses a library-owned Flutter sheet/full-screen route containing the native flow; Android retains SDK presentation and hosts Flutter UI above it for errors. Removing the callback also disposes its error UI. On iOS it cancels the embedded flow; Android has no native cancellation/end-of-flow handle, so its flow remains open and future errors are acknowledged without calling the removed presenter. Keep and call the remover when the owning screen is disposed, including when a user backs out on Android. Checkpoints without an error presenter retain their existing detach-only remover behavior.

**iOS development dependency:** This path requires the unreleased embedded checkpoint SPI from [purchases-ios #8129](https://github.com/RevenueCat/purchases-ios/pull/8129) and [hybrid-common #2036](https://github.com/RevenueCat/purchases-hybrid-common/pull/2036). Until those dependencies ship, build against their local branches as described in [DEVELOPMENT.md](../DEVELOPMENT.md) and define `RC_CHECKPOINT_EMBEDDED` for the `purchases_ui_flutter` Swift target. For CocoaPods, set `SWIFT_ACTIVE_COMPILATION_CONDITIONS` to `$(inherited) RC_CHECKPOINT_EMBEDDED` on that pod target in the Podfile's `post_install`; for local SwiftPM development, add `.define("RC_CHECKPOINT_EMBEDDED")` to that target's `swiftSettings`. Released dependencies compile normally with the path disabled; attempting app-presented errors then reports an unsupported-build error through Flutter's error handler. Remove this temporary condition and pin released dependencies before shipping. Android uses the existing native error-presenter API and does not require these iOS branches.

### Requirements
*purchases_ui_flutter* requires XCode 14.0+ and minimum targets iOS 11.0+ and Android 24+. Paywalls will only work on iOS 15.0+ and Android 24+.

## SDK Reference
Our full SDK reference [can be found here](https://pub.dev/documentation/purchases_ui_flutter/latest/).

## Getting Started
For more detailed information, you can view our complete documentation at [docs.revenuecat.com](https://docs.revenuecat.com/docs/flutter).
