# Maestro E2E Test App

A minimal Flutter app used by Maestro end-to-end tests to verify RevenueCat SDK integration.

## Prerequisites

- Flutter SDK (>= 3.27.0)
- Xcode (iOS) / Android Studio (Android)
- [Maestro](https://maestro.mobile.dev/) CLI
- CocoaPods (`gem install cocoapods`)

## Setup

```bash
flutter pub get
```

## Running Locally

```bash
flutter run --debug -d <simulator-or-emulator-id>
```

## API Key

The app initialises RevenueCat with the placeholder `MAESTRO_TESTS_REVENUECAT_API_KEY`.
In CI, the Fastlane lane replaces this placeholder with the real key from the
`RC_E2E_TEST_API_KEY_PRODUCTION_TEST_STORE` environment variable (provided by the
CircleCI `e2e-tests` context) before building.

To run locally, either:
- Replace the placeholder in `lib/main.dart` with a valid API key (do **not** commit it), or
- Export the env var and run the same `sed` command the Fastlane lane uses.

## RevenueCat Project

The test uses a RevenueCat project configured with:
- A **V2 Paywall** (the test asserts "Paywall V2" is visible)
- A `pro` entitlement (the test checks entitlement status after purchase)
- The **Test Store** environment for purchase confirmation

## Dependencies

`purchases_flutter` and `purchases_ui_flutter` are referenced as local `path:`
dependencies so the E2E tests always exercise the code on the current branch, not a
published pub.dev version.
