### Releasing a version:

1. Create a `fastlane/.env` file with your GitHub API token (see `fastlane/.env.SAMPLE`). This will be used to create the PR, so you should use your own token so the PR gets assigned to you.
1. Run `bundle exec fastlane bump`
    1. Input new version number
    2. Update CHANGELOG.latest.md to include the latest changes. Call out API changes (if any). You can use the existing CHANGELOG.md as a base for formatting. To compile the changelog, you can compare the changes between the base branch for the release (usually main) against the latest release, by checking https://github.com/revenuecat/purchases-flutter/compare/<latest_release>...<base_branch>. For example, https://github.com/revenuecat/purchases-flutter/compare/3.10.0...main. 
    3. A new branch and PR will automatically be created
1. Update to the latest SDK versions in ios/purchases_flutter.podspec, macos/purchases_flutter.podspec and android/build.gradle.
1. Update versions in VERSIONS.md and push changes
1. If purchases-hybrid-common was updated, run `pod update PurchasesHybridCommon` in both `MagicWeather` and `purchase_tester`
1. Wait until PR approved and make sure local copy matches remote
1. Run `flutter pub publish --dry-run`. Fix any errors if any show
1. Create a tag for the new release in the last commit of the branch and push the tag. The rest will be performed automatically by CircleCI. If the automation fails, you can revert to manually calling `bundle exec fastlane release`.
