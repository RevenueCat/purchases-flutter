1. Start a branch `release/x.x.x`
1. Update to the latest SDK versions in purchases_flutter.podspec and build.gradle.
1. Run `flutter format .`
1. Update versions in VERSIONS.md.
1. Update CHANGELOG.latest.md with the changes for the current version (to be used by Fastlane for the github release notes)
1. Run fastlane bump_and_update_changelog version:X.Y.Z (where X.Y.Z is the new version) to update the version number in pubspec.yaml, purchases_flutter.podspec and android/build.gradle.
1. `flutter pub pub publish --dry-run`
1. `git commit -am "Preparing for version x.y.z"`
1. `git tag x.y.z`
1. `git push origin master && git push --tags`
1. Create a new release in github and upload
1. `flutter pub pub publish`
