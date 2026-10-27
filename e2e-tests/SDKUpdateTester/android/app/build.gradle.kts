// Created by Antonio Pallares. Copyright (c) 2026 RevenueCat, Inc.

plugins {
    id("com.android.application")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.revenuecat.sdk_update_tester"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.revenuecat.SDKUpdateTester"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}

val verifySdkUpdateDependencies by tasks.registering {
    doLast {
        val output = System.getenv("SDK_UPDATE_OUTPUT")
            ?: error("SDK_UPDATE_OUTPUT is required")
        val expected = System.getenv("SDK_UPDATE_PHC_VERSION")
            ?: error("SDK_UPDATE_PHC_VERSION is required")
        val selected = configurations.getByName("debugRuntimeClasspath")
            .incoming.resolutionResult.allComponents.mapNotNull { it.moduleVersion }
            .filter { it.group == "com.revenuecat.purchases" }
        check(selected.any { it.name == "purchases-hybrid-common" && it.version == expected }) {
            "The app must use its Flutter SDK's declared hybrid-common $expected; resolved $selected"
        }
        file("$output/resolved-native-dependencies.txt").writeText(
            selected.map { it.toString() }.sorted().joinToString("\n", postfix = "\n")
        )
    }
}

tasks.named("preBuild") {
    dependsOn(verifySdkUpdateDependencies)
}
