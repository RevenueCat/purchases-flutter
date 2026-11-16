# Git-sourced CocoaPods installation test

The iOS and macOS CI jobs generate this minimal app with CocoaPods enabled only for this fixture. It installs the local core/UI plugins and sources all four RevenueCat/PHC pods from Git.

`scripts/resolve-git-pods.py` reads the wrapper's PHC requirement. Releases use the matching Git tag; snapshot requirements use the corresponding major development branch. Native core/UI tags come from that PHC commit's podspecs. The resolved commit is reused throughout the job.

The job checks Flutter regeneration, the lockfile's Git sources and versions, a runtime configure/app-user-ID call, and resource-bundle packaging. The smoke test uses a fake API key and requires no backend credentials.
