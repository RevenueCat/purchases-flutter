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

The seven YAML files in `../maestro/sdk_update_tests` are byte-for-byte copies from
[iOS #7900](https://github.com/RevenueCat/purchases-ios/pull/7900),
[Android #4381](https://github.com/RevenueCat/purchases-android/pull/4381), and
[KMP #1063](https://github.com/RevenueCat/purchases-kmp/pull/1063).
Release discovery, clean attempts, update installation, retries and JUnit reports use
[shared actions #161](https://github.com/RevenueCat/fastlane-plugin-revenuecat_internal/pull/161).
Remove the temporary plugin pin when that PR merges.

## Run locally

Install the versions in `mise.toml`. Set `MAESTRO_TEST_STORE_API_KEY` to the Workflows Test Store key.
CI provides `WORKFLOWS_TEST_STORE_API_KEY` through the `maestro` context. Its `no_paywall` offering has
the `$rc_monthly` package, with product `pro_monthly_subscription` granting `pro`. The key is injected
through a generated Dart defines file under `build/sdk_update_tests`. Apps and build directories
must never be uploaded as CI artifacts; only diagnostic reports, logs and screenshots are uploaded.
The run lane removes inherited `MAESTRO_*` variables, which Maestro otherwise includes in JSON reports.

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
