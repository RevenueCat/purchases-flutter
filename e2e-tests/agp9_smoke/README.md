# AGP 9 smoke test for `purchases_ui_flutter`

A minimal Gradle-only fixture that exercises the Kotlin wiring in
`purchases_ui_flutter/android/build.gradle` under AGP 9, without needing
Flutter or a full app build.

## What it tests

The plugin decides whether to apply `kotlin-android` by checking whether a
`kotlin` extension is already registered, rather than by inspecting versions:

- **Extension absent** — nothing else provides Kotlin, so the plugin applies
  `kotlin-android` itself.
- **Extension present** — AGP's built-in Kotlin already registered it, so the
  plugin must not apply `kotlin-android` on top (that fails with
  `Cannot add extension with name 'kotlin'`).

Under AGP 9 which of those happens is controlled by `android.builtInKotlin`,
so `run.sh` runs both:

| `android.builtInKotlin` | `kotlin` extension | Plugin applies `kotlin-android` |
| ----------------------- | ------------------ | ------------------------------- |
| `true`                  | registered by AGP  | no                              |
| `false`                 | absent             | yes                             |

The `builtInKotlin=false` column is the path real apps hit today, since that
is what the Flutter 3.44+ migrator writes into `gradle.properties`.

AGP 8 is not covered here — it has no built-in Kotlin, so it always takes the
"extension absent" path, and every regular CI build already exercises it via
the `purchase_tester` example.

## How it works

`settings.gradle` pins AGP `9.0.1` via `pluginManagement` and includes the
plugin's `android/` directory as a subproject. The plugin's own
`buildscript { }` declares a lower AGP version, but the settings-level plugin
classpath is a parent of the subproject's, so the plugin's `build.gradle` is
evaluated against AGP 9 here.

`android.newDsl` is pinned off in `gradle.properties`: KGP cannot work with
AGP's new DSL, so the legacy Kotlin path requires opting out of it. Keeping it
off for both runs means the two cases differ only by `android.builtInKotlin`.

Assertions live in this directory's `build.gradle`, as a `verifyKotlinWiring`
task that prints the externally observable wiring (`agpVersion`,
`kotlinExtensionRegistered`, `kotlinAndroidPluginApplied`, `jvmTarget`).
`run.sh` asserts on that output. Deliberately nothing reads the plugin's
internal Gradle properties, so the fixture keeps working when the conditional
is refactored.

`run.sh` asserts, for each case:

1. `agpVersion` starts with `9` — guards the fixture itself, since the Kotlin
   assertions would otherwise pass for the wrong reason if the AGP 9 pin
   silently stopped taking effect.
2. A `kotlin` extension ends up registered either way.
3. `kotlin-android` is applied only in the case where AGP isn't providing it.
4. `jvmTarget` is `1.8` on the compile task. The plugin picks between two
   mutually exclusive `jvmTarget` DSLs, and configuring the wrong one for the
   Kotlin in play fails silently rather than erroring. This assertion is what
   catches that: with the plugin's `jvmTarget` block deleted, the
   `builtInKotlin=false` case reports `21` (KGP defaults to the JDK version)
   and fails. On the `builtInKotlin=true` path AGP derives `1.8` from
   `compileOptions`, so the assertion is redundant but harmless there.
5. The `compileDebugKotlin` task graph resolves under `--dry-run` — proves AGP
   applied cleanly and that the `jvmTarget` DSL selected for this case is
   valid.

This is a configuration-time smoke test, not a full build. The plugin's sources
import `io.flutter`, and those artifacts reach the classpath only via the
Flutter Gradle plugin in a real app, so compiling here is not an option:
attempting it fails with `Unresolved reference 'io'`. Consequently `jvmTarget`
is verified as configured rather than as emitted bytecode, and anything that
only surfaces during compilation — Kotlin source incompatibilities with
KGP 2.x, for instance — is out of scope.

## Running locally

Requires an Android SDK, plus the `java` and `gradle` versions from the repo's
`mise.toml`. AGP 9 needs a newer Gradle than Flutter's wrapper supplies, which
is the only reason `gradle` is pinned there at all.

```bash
mise install java gradle
bash e2e-tests/agp9_smoke/run.sh
```

`run.sh` calls `gradle` directly, so it picks up whichever version is on
`PATH` — mise's shims if mise is active. It asserts the AGP version it ends up
with, so a wrong Gradle surfaces as a failed assertion rather than a false
pass.
