#!/usr/bin/env bash
#
# Smoke-test purchases_ui_flutter/android/build.gradle under AGP 9.
#
# Uses the sibling settings.gradle, which pins AGP 9.0.1 via pluginManagement.
# The plugin's own buildscript declares a lower AGP version, but the settings
# plugin classpath is a parent of the subproject's, so the plugin's
# build.gradle is evaluated against AGP 9 here.
#
# Runs both sides of the plugin's Kotlin conditional, since AGP 9 supplies
# Kotlin itself only when android.builtInKotlin is on:
#
#   builtInKotlin=true  -> AGP registers the `kotlin` extension, so the plugin
#                          must NOT apply kotlin-android.
#   builtInKotlin=false -> nothing registers it, so the plugin MUST apply
#                          kotlin-android itself.
#
# Each case also asserts the jvmTarget the plugin configured, read back off the
# compile task. Picking the wrong DSL for the Kotlin in play fails silently and
# leaves the default target, which on the builtInKotlin=false path is the JDK
# version (21) rather than 1.8.
#
# This is a configuration-time smoke test, not a full build: the plugin's
# sources import io.flutter, and the Flutter embedding artifacts are only on the
# classpath when the Flutter Gradle plugin supplies them, which needs a real
# Flutter app. So jvmTarget is verified as configured, not as emitted bytecode,
# and anything that only surfaces during compilation is out of scope here.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

GRADLE_ARGS=(--no-daemon -q)

# Reads a key=value line out of the verifyKotlinWiring output.
value_of() {
    awk -F= -v key="$1" '$1 == key {print $2}' <<<"$2"
}

assert_equals() {
    local key="$1" expected="$2" actual="$3"
    if [[ "$actual" != "$expected" ]]; then
        echo "FAIL: expected ${key}=${expected} but got '${actual}'." >&2
        exit 1
    fi
    echo "OK: ${key}=${actual}"
}

run_case() {
    local built_in_kotlin="$1"
    local expect_kgp_applied="$2"

    echo
    echo "=============================================================="
    echo "==> Case: android.builtInKotlin=${built_in_kotlin}"
    echo "=============================================================="

    local property_arg="-Pandroid.builtInKotlin=${built_in_kotlin}"
    local output
    output="$(gradle "${GRADLE_ARGS[@]}" "$property_arg" :verifyKotlinWiring)"
    echo "$output"

    # Guards the fixture itself: if the AGP 9 pin ever stops taking effect, the
    # Kotlin assertions below would pass for the wrong reason.
    local agp_major
    agp_major="$(value_of agpVersion "$output" | cut -d. -f1)"
    assert_equals agpMajor 9 "$agp_major"

    assert_equals kotlinExtensionRegistered true \
        "$(value_of kotlinExtensionRegistered "$output")"
    assert_equals kotlinAndroidPluginApplied "$expect_kgp_applied" \
        "$(value_of kotlinAndroidPluginApplied "$output")"
    assert_equals jvmTarget 1.8 "$(value_of jvmTarget "$output")"

    echo "==> Asserting compileDebugKotlin task graph resolves"
    gradle "${GRADLE_ARGS[@]}" "$property_arg" \
        :purchases_ui_flutter:compileDebugKotlin --dry-run
    echo "OK: compileDebugKotlin resolves"
}

run_case true false
run_case false true

echo
echo "==> AGP 9 smoke test passed"
