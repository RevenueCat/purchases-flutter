# purchases-flutter — Development Guidelines

## Project Overview

RevenueCat's official Flutter SDK for in-app purchases and subscriptions. This plugin wraps the native iOS and Android SDKs, providing a unified Dart API for Flutter apps.

**Related repositories:**
- **iOS SDK**: https://github.com/RevenueCat/purchases-ios
- **Android SDK**: https://github.com/RevenueCat/purchases-android
- **JS SDK**: https://github.com/RevenueCat/purchases-js (used for web support)
- **Hybrid Common**: https://github.com/RevenueCat/purchases-hybrid-common — shared layer for hybrid SDKs (Flutter, React Native, Unity, Cordova). Contains:
  - `ios/` and `android/` native wrappers that bridge platform SDKs to hybrid frameworks
  - `typescript/` shared TypeScript types and mappings
  - `purchases-js-hybrid-mappings/` web-specific mappings

When implementing features or debugging, check these repos for reference and patterns.

## Important: Public API Stability

**Do NOT introduce breaking changes to the public API.** The `lib/` directory contains the public API surface that thousands of apps depend on.

✅ **Safe changes:**
- Adding new optional parameters to existing methods
- Adding new classes, methods, or properties
- Bug fixes that don't change method signatures
- Internal implementation changes

❌ **Requires explicit approval:**
- Removing or renaming public classes/methods/properties
- Changing method signatures (parameter types, required params)
- Changing return types
- Modifying behavior in ways that break existing integrations

The `api_tester/` package runs in CI to catch unintended API changes. **If it fails, you've likely broken the public API.**

## Code Structure

```
purchases-flutter/
├── lib/                      # Public Dart API (purchases_flutter.dart is the entry point)
├── test/                     # Unit tests for main SDK
├── android/                  # Android native implementation (Kotlin/Java)
├── ios/                      # iOS native implementation (Swift/ObjC)
├── macos/                    # macOS native implementation
├── purchases_ui_flutter/     # Separate package for UI components (Paywalls, Customer Center)
├── api_tester/               # API stability tests (detects breaking changes)
├── revenuecat_examples/      # Sample apps
│   ├── MagicWeather/         # Basic subscription demo
│   └── purchase_tester/      # Comprehensive testing app
├── fastlane/                 # Release automation
├── .circleci/                # CI configuration (primary CI system)
└── migrations/               # Version migration guides
```

> Note: `example/` is minimal (README only). Use `revenuecat_examples/purchase_tester/` for testing.

## Constraints / Support Policy

| Platform | Minimum Version |
|----------|-----------------|
| Flutter  | 3.27.0          |
| Dart     | 3.6.0           |
| iOS      | 13+             |
| Android  | SDK 21+         |
| Xcode    | 14+             |

Don't raise minimum versions unless explicitly required and justified.

## Testing

**IMPORTANT: All lint and tests must pass before pushing changes.**

```bash
# Format (REQUIRED)
dart format .

# Static analysis (REQUIRED)
flutter analyze lib

# Unit tests (REQUIRED)
flutter test

# API stability tests (checks for breaking changes)
bundle exec fastlane run_api_tests
```

### Multi-Package Testing

If you modify `purchases_ui_flutter/`, run checks for that package too:

```bash
cd purchases_ui_flutter
dart format .
flutter analyze lib
flutter test
```

### Build Verification

```bash
# iOS
cd revenuecat_examples/purchase_tester && flutter build ios --no-codesign

# Android
cd revenuecat_examples/purchase_tester && flutter build apk
```

### Integration Tests

```bash
# Android (emulator)
cd revenuecat_examples/purchase_tester && flutter test integration_test/app_test.dart

# iOS/macOS
cd revenuecat_examples/purchase_tester && flutter drive \
  --target=integration_test/app_test.dart \
  --driver=test_driver/integration_test.dart
```

> See `DEVELOPMENT.md` for full setup instructions including local native SDK development.

## Code Conventions

### Dart
- Match existing style and patterns exactly
- Prefer clear, explicit names over cleverness
- Add tests for behavior changes
- Run `dart format .` before committing

### Platform Code (iOS/Android)
- Keep platform logic minimal and well-isolated
- Maintain parity across iOS/Android for cross-platform features
- Check the native SDKs for implementation reference
- Avoid platform-specific behavior differences unless documented

### Adding New Public API
1. Follow existing patterns in `lib/` exactly
2. Ensure it's additive (no breaking changes)
3. Add corresponding tests in `test/`
4. Update `api_tester/` if needed to cover the new API

## PR Checklist

- [ ] `dart format .` is clean
- [ ] `flutter analyze lib` passes
- [ ] `flutter test` passes (new tests added where appropriate)
- [ ] Sample app builds (`revenuecat_examples/purchase_tester`)
- [ ] If native code modified: platform builds succeed
- [ ] If public API changed: confirmed additive and non-breaking
- [ ] If behavior changed: docs/changelog updated
- [ ] PR description includes: what, why, how tested

## When the Task is Ambiguous

1. Search for similar existing implementation in this repo first
2. Check purchases-ios, purchases-android, and purchases-hybrid-common for patterns
3. If there's a pattern, follow it exactly
4. If not, propose options with tradeoffs and pick the safest default

## Guardrails

- **Don't invent APIs or file paths** — verify they exist
- **Don't remove code you don't understand** — ask for context
- **Don't make large refactors** unless explicitly requested
- **Keep diffs minimal** — preserve existing formatting
- **Don't break the public API** — if `api_tester` fails, investigate why
- **Check native SDKs** when unsure about implementation details
