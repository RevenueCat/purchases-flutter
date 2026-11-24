# Maestro E2E Test App

A minimal Flutter app used by Maestro end-to-end tests to verify RevenueCat SDK integration.

## Prerequisites

- Flutter SDK (>= 3.27.0)
- Xcode (iOS) / Android Studio (Android)
- [Maestro](https://maestro.mobile.dev/) CLI

## Setup

```bash
flutter pub get
```

## Running Locally

Build and install the app, then run Maestro with the launch arguments described below.

```bash
# Android
flutter build apk --debug
adb install -r build/app/outputs/flutter-apk/app-debug.apk

# iOS simulator
flutter build ios --debug --simulator
xcrun simctl install booted build/ios/iphonesimulator/Runner.app
```

## API Key

The app initialises RevenueCat with the placeholder `MAESTRO_TESTS_REVENUECAT_API_KEY`.
In CI, the Fastlane lane replaces this placeholder with the real key from the
`RC_E2E_TEST_API_KEY_PRODUCTION_TEST_STORE` environment variable (provided by the
CircleCI `e2e-tests` context) before building.

For local checkpoint tests, pass a Test Store key through the optional `rc_test_api_key` launch argument. The checkpoint Maestro flows read it from `MAESTRO_RC_TEST_API_KEY`. Load the key from the macOS login Keychain so its value never needs to be written to source files:

```bash
MAESTRO_RC_TEST_API_KEY="$(security find-generic-password -s RC_TEST_API_KEY -w ~/Library/Keychains/login.keychain-db)" \
  maestro --device <simulator-or-emulator-id> test \
  ../maestro/e2e_tests/checkpoint_custom_presenter_purchase.yaml \
  ../maestro/e2e_tests/checkpoint_custom_presenter_back.yaml \
  ../maestro/e2e_tests/checkpoint_custom_presenter_unmount.yaml \
  ../maestro/e2e_tests/checkpoint_custom_error_dialog.yaml
```

When the launch argument is absent or empty, the app uses the existing CI key placeholder. The test app reads launch arguments before configuring Purchases.

## Custom checkpoint coverage

The custom presenter screen receives its offering and typed custom variables from the native checkpoint. Its child widget owns the checkpoint callback while the parent owns the paywall UI, so the unmount flow disposes a real owner without dismissing the paywall. Counters expose premature callbacks and callbacks from a disposed owner instead of hiding them behind a mounted check.

The four flows cover buying before completing the presentation, backing out and retrying, completing after owner disposal and remounting, and custom error-dialog content. The error case uses invalid checkpoint identifier `!` so it does not rely on a network outage to exercise the error factory.

## RevenueCat Project

The test uses a RevenueCat project configured with:
- A **V2 Paywall** (the test asserts "Paywall V2" is visible)
- A `pro` entitlement (the test checks entitlement status after purchase)
- The **Test Store** environment for purchase confirmation

## Dependencies

`purchases_flutter` and `purchases_ui_flutter` are referenced as local `path:`
dependencies so the E2E tests always exercise the code on the current branch, not a
published pub.dev version.
