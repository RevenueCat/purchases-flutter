fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

### bump

```sh
[bundle exec] fastlane bump
```

Bump version, edit changelog, and create pull request

### automatic_bump

```sh
[bundle exec] fastlane automatic_bump
```

Automatically bumps version, edit changelog, and create pull request

### release

```sh
[bundle exec] fastlane release
```

Create release

### release_purchases_ui_flutter

```sh
[bundle exec] fastlane release_purchases_ui_flutter
```

Create purchases_ui_flutter release

### github_release_current_version

```sh
[bundle exec] fastlane github_release_current_version
```

Make github release with current version number

### github_release

```sh
[bundle exec] fastlane github_release
```

Make github release

### run_api_tests

```sh
[bundle exec] fastlane run_api_tests
```

Builds and analyzes the api_tester project to make sure APIs are expected

### tag_current_branch

```sh
[bundle exec] fastlane tag_current_branch
```

Tag current branch with current version number

### update_hybrid_common

```sh
[bundle exec] fastlane update_hybrid_common
```

Update hybrid common pod and gradle

### run_maestro_e2e_tests_ios

```sh
[bundle exec] fastlane run_maestro_e2e_tests_ios
```

Run maestro E2E tests on iOS

### build_maestro_app_android

```sh
[bundle exec] fastlane build_maestro_app_android
```

Build maestro E2E test app for Android

### run_maestro_e2e_tests_android

```sh
[bundle exec] fastlane run_maestro_e2e_tests_android
```

Run maestro E2E tests on Android (emulator must be running)

### trigger_bump

```sh
[bundle exec] fastlane trigger_bump
```

Trigger bump

### verify_web_hybrid_mappings_bundle

```sh
[bundle exec] fastlane verify_web_hybrid_mappings_bundle
```

Verifies the vendored web SDK bundle matches the published purchases-js-hybrid-mappings bundle for the current purchases-hybrid-common version

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
