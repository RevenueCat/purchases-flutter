fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

### bump_and_update_changelog

```sh
[bundle exec] fastlane bump_and_update_changelog
```

Increment build number and update changelog

### run_api_tests

```sh
[bundle exec] fastlane run_api_tests
```

Builds and analyzes the api_tester project to make sure APIs are expected

----


## iOS

### ios bump

```sh
[bundle exec] fastlane ios bump
```

Increment build number

----


## Android

### android bump

```sh
[bundle exec] fastlane android bump
```

Increment build number

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
