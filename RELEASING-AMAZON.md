1. Start a branch `release/amazon-x.x.x`
1. Run `flutter format .`
1. Update CHANGELOG-LATEST.md with the changes for the current version (to be used by Fastlane for the github release notes)
1. Run `bundle exec fastlane bump_and_update_changelog version:X.Y.Z` (where X.Y.Z is the new version) to update the version number in pubspec.yaml, purchases_flutter.podspec and android/build.gradle.
1. `flutter pub pub publish --dry-run`
1. If purchases-hybrid-common was updated, run `pod update PurchasesHybridCommon` in both `MagicWeather` and `purchase_tester`
1. Commit the changes, open a PR into `amazon`, merge when ready
1. `git tag amazon-x.x.x`
1. `git tag amazon-latest`
1. `git push origin amazon && git push --tags`
1. Create a new release in github, make sure to check "pre release"
