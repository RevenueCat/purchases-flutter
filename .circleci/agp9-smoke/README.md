# AGP 9 smoke test for `purchases_ui_flutter`

A minimal Gradle-only fixture that exercises the AGP-9 branch of
`purchases_ui_flutter/android/build.gradle`, without needing Flutter
or a full app build.

## What it tests

`purchases_ui_flutter/android/build.gradle` switches behaviour based on the
detected Android Gradle Plugin major version:

- `agpMajor < 9` — applies the `kotlin-android` plugin and uses the
  legacy `android.kotlinOptions { … }` DSL.
- `agpMajor >= 9` — relies on AGP's built-in Kotlin and uses the
  top-level `kotlin { compilerOptions { … } }` DSL.

The first branch is exercised by every regular CI build (the
`purchase_tester` example pins AGP 8 / KGP 1.x).

The AGP 9 branch only runs when a downstream user is on a recent enough
Flutter (3.44+) and AGP 9. This fixture lets CI catch regressions on
that branch at configuration time.

## How it works

`settings.gradle` pins AGP `9.0.1` and KGP `2.2.10` via
`pluginManagement`, then includes the plugin's `android/` directory as
a subproject. The plugin's own `buildscript { }` declares a lower AGP
version; Gradle resolves the classpath to the highest declared version,
so the plugin's `build.gradle` is evaluated under AGP 9 here.

`run.sh` asserts:

1. `agpMajor == 9` after the plugin's `buildscript { }` runs — proves
   the AGP-9 branches of the plugin's `build.gradle` are reached.
2. The `compileDebugKotlin` task graph resolves under `--dry-run` —
   proves AGP applied cleanly and the new top-level
   `kotlin.compilerOptions` DSL is valid.

This is a configuration-time smoke test, not a full build. It will not
catch issues that only manifest during actual compilation (e.g. Kotlin
source incompatibilities with KGP 2.x).

## Running locally

Requires JDK 21, Gradle 9.1+, and an Android SDK installed.

```bash
bash .circleci/agp9-smoke/run.sh
```
