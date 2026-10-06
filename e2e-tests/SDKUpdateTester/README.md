<!-- Created by Antonio Pallares. Copyright (c) 2026 RevenueCat, Inc. -->

# SDK update tests

This app uses the Flutter SDK to configure Purchases, log in, fetch customer info and offerings, and
purchase the `no_paywall` offering's monthly package. Both builds use `com.revenuecat.SDKUpdateTester`.
The released build resolves `purchases_flutter` from pub.dev; the local build resolves this checkout.
Each uses its own native plugins and declared hybrid-common dependencies. Build checks verify the
resolved package source, version, Dart import path, native plugin paths and wrapper versions, and
the native dependency versions selected by Gradle or Swift Package Manager.

The on-screen version comes from verified package metadata because Flutter's SDK has no public
version getter. It includes `Hosted` or `Path` to distinguish the builds when the checkout and
published package have the same version. Each output contains `version.txt`, `source.txt`, the pub
lockfile, package metadata and resolved native dependencies. Flutter generates the platform scaffolding
inside the ignored build directory, keeping this template small and matching the repository's tool pin.

## Run locally

Use Xcode 27.0 and Flutter 3.44.9, matching CI. This Flutter patch includes the Xcode 27
framework verification fix. The generated test host targets iOS 15 and uses the scene lifecycle;
the launch-argument channel registers when its engine initializes.

Install the versions in `mise.toml`. Set `MAESTRO_TEST_STORE_API_KEY` to the `automated_sdk_tests` Test Store key.
CI provides it through the `maestro` context. Its `no_paywall` offering has
the `$rc_monthly` package, with product `pro_monthly_subscription` granting `pro`. The key is injected
through a generated Dart defines file under `build/sdk_update_tests`. Apps and build directories
must never be uploaded as CI artifacts; only diagnostic reports, logs and screenshots are uploaded.

With one Android emulator booted:

```sh
bundle exec fastlane build_sdk_update_test_apps platform:android
bundle exec fastlane run_sdk_update_test platform:android test_case:anonymous_user
bundle exec fastlane run_sdk_update_test platform:android test_case:logged_in_user
```

Replace `android` with `ios` on a Mac with a booted simulator. The two debug APKs use the same signing
key and version codes 1 and 2. The released and local builds have separate generated projects and
outputs under `build/sdk_update_tests/<platform>/{release,local}`. Release discovery includes the
checkout's version by using the next minor version as its upper bound, because main retains the last
released version until the next bump. `release_version:` can select a published version for reproduction.

Both platform CI jobs build their own released and local variants. Each user case runs separately;
the logged-in case still runs if the anonymous case fails. JUnit results are kept separately by case.
The `sdk-update-tests` pipeline action runs only these jobs on demand. They also run in normal tests,
the Maestro schedule, and the release gates.

## Coverage limitation

An online customer-info refresh can recover entitlements from RevenueCat and hide a lost local cache.
These flows verify retained identity and visible entitlements, but do not prove offline cache
preservation. Screenshot comparisons also tolerate a small pixel difference and cannot prove exact
user-ID equality. Stronger assertions should be coordinated under
[SDK-4526](https://linear.app/revenuecat/issue/SDK-4526) and mirrored across the native implementations.

In [CI validation](https://app.circleci.com/pipelines/github/RevenueCat/purchases-flutter/6534), the
iOS logged-in case displayed an anonymous ID after the update in two attempts, then retained the
logged-in ID on the third attempt. The cause is unresolved. The failed assertions and screenshots
remain in the diagnostic artifacts; JUnit contains the final attempt, following the shared runner.

With Xcode 27, both iOS cases passed locally. The logged-in case first showed an anonymous ID
after the update and passed on a fresh attempt. The failed run was preserved. Upgrading the
toolchain has not resolved this identity flakiness.

The Xcode 27 [CI run](https://app.circleci.com/pipelines/github/RevenueCat/purchases-flutter/6536)
passed all four cases. The iOS logged-in case showed an anonymous ID after the update on its first
attempt and passed on the second. Other cases passed on their first attempt. Failed attempts
remain in diagnostics, and JUnit contains the final attempt.
