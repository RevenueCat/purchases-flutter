### Releasing a version:

1. Create a `fastlane/.env` file with your GitHub API token (see `fastlane/.env.SAMPLE`). This will be used to create the PR, so you should use your own token so the PR gets assigned to you.
1. Run `bundle exec fastlane bump`
    1. Confirm base branch is correct
    2. Input new version number
    3. Update CHANGELOG.latest.md to include the latest changes. Call out API changes (if any). You can use the existing CHANGELOG.md as a base for formatting. To compile the changelog, you can compare the changes between the base branch for the release (usually main) against the latest release, by checking https://github.com/revenuecat/purchases-flutter/compare/<latest_release>...<base_branch>. For example, https://github.com/revenuecat/purchases-flutter/compare/3.10.0...main.
    4. A new branch and PR will automatically be created
1. `bundle exec fastlane update_hybrid_common version:x.x.x` to set the purchases-hybrid-common version number if needed.
1. If purchases-hybrid-common was updated, run `pod update PurchasesHybridCommon` in both `MagicWeather` and `purchase_tester`
1. Wait until PR is approved (don't merge yet) and pull branch from origin (to make sure you've got all the changes locally)
1. Run `flutter pub publish --dry-run`. Fix any errors if any show
1. When the PR is approved, approve the hold job created in CircleCI. CircleCI will create a tag for the version. Alternatively, you can tag the last commit in the release branch and push it to the repository.
1. The rest will be performed automatically by CircleCI. If the automation fails, you can revert to manually calling `bundle exec fastlane release`.
1. After that, you can merge the release PR to main and merge the bump to the next snapshot version PR right after.
