#!/usr/bin/env bash
#
# Smoke-test purchases_ui_flutter/android/build.gradle under AGP 9.
#
# Uses the sibling settings.gradle, which pins AGP 9.0.1 + KGP 2.2.10
# via pluginManagement. The plugin's own buildscript declares a lower
# AGP version, but Gradle resolves the classpath to the highest, so
# the plugin's build.gradle is evaluated with AGP 9 here.
#
# Assertions:
#   1. agpMajor == 9 (so the AGP 9 else-branch in build.gradle ran).
#   2. compileDebugKotlin task graph resolves (built-in Kotlin works).
#
# This is a configuration-time smoke test, not a full build.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

GRADLE_ARGS=(--no-daemon -q)

echo "==> Asserting agpMajor == 9"
agp_major="$(gradle "${GRADLE_ARGS[@]}" :purchases_ui_flutter:properties | awk '/^agpMajor: / {print $2}')"
if [[ "$agp_major" != "9" ]]; then
    echo "FAIL: expected agpMajor=9 but got '${agp_major}'." >&2
    echo "      The AGP 9 branch of purchases_ui_flutter/android/build.gradle was not exercised." >&2
    exit 1
fi
echo "OK: agpMajor=${agp_major}"

echo "==> Asserting compileDebugKotlin task graph resolves under AGP 9"
gradle "${GRADLE_ARGS[@]}" :purchases_ui_flutter:compileDebugKotlin --dry-run
echo "OK: AGP 9 + built-in Kotlin wired up correctly"

echo "==> AGP 9 smoke test passed"
