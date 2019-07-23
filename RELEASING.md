1. Update to the latest SDK versions in purchases_flutter.podspec and build.gradle.
1. Run `./scripts/download-purchases-common.sh 0.1.2`
1. Run `flutter format`
1. Update versions in VERSIONS.md.
1. Update version in pubspec.yaml, purchases_flutter.podspec.
1. Add an entry to CHANGELOG.md
1. `flutter pub pub publish --dry-run`
1. `git commit -am "Preparing for version x.y.z"`
1. `git tag x.y.z`
1. `git push origin master && git push --tags`
1. Create a new release in github and upload
1. `flutter pub pub publish`
