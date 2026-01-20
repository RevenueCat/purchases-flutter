# Development Guide

This guide explains how to set up the development environment for the RevenueCat Flutter SDK, run sample apps, and work with local dependencies.

## Prerequisites

- Flutter SDK (>=3.27.0) - See [Flutter installation guide](https://docs.flutter.dev/get-started/install)
- Xcode (for iOS development)
- Android Studio (for Android development)
- **Swift Package Manager** (recommended for iOS dependencies) or CocoaPods (legacy)
- Physical iOS/Android device (recommended for testing purchases)

> **Note**: As of September 2025, the purchase_tester sample app defaults to Swift Package Manager. You can switch between SPM and CocoaPods using Flutter's built-in configuration.

## Running Tests

To run tests for the main plugin:
```bash
fvm flutter test
```

## Sample Applications

### MagicWeather Sample

The MagicWeather sample demonstrates basic subscription functionality.

**App Identifiers:**
- iOS Bundle ID: `com.revenuecat.sampleapp`
- Android Package Name: `com.revenuecat.purchases_sample`

#### Setup
1. Navigate to the sample directory:
   ```bash
   cd revenuecat_examples/MagicWeather
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Configure API keys in `lib/src/constant.dart`:
   ```dart
   const appleApiKey = 'your_apple_api_key';
   const googleApiKey = 'your_google_api_key';
   const amazonApiKey = 'your_amazon_api_key';
   const webApiKey = 'your_web_api_key';
   ```
   Get your API keys from the [RevenueCat dashboard](https://app.revenuecat.com)

4. **Optional**: If using your own app configuration, update the bundle ID (iOS) and application ID (Android) to match your RevenueCat app settings.

5. Run the app:
   ```bash
   flutter run
   ```

### PurchaseTester Sample

The PurchaseTester is a comprehensive testing app that includes all RevenueCat features. **By default, it uses Swift Package Manager** for iOS dependencies.

**App Identifiers:**
- iOS Bundle ID: `com.revenuecat.sampleapp`
- Android Package Name: `com.revenuecat.purchases_sample`

#### Setup
1. Navigate to the sample directory:
   ```bash
   cd revenuecat_examples/purchase_tester
   ```

2. **Choose your dependency manager** (optional):
   - **For Swift Package Manager** (default):
     ```bash
     flutter config --enable-swift-package-manager
     ```
   - **For CocoaPods** (if needed for development):
     ```bash
     flutter config --no-enable-swift-package-manager
     ```

3. Install dependencies (click "Get dependencies" in your IDE or run):
   ```bash
   flutter pub get
   ```

4. Configure API keys in `lib/src/constant.dart`:
   ```dart
   const appleApiKey = 'your_apple_api_key';  // Replace 'appl_api_key'
   const googleApiKey = 'your_google_api_key';  // Replace 'googl_api_key' 
   const amazonApiKey = 'your_amazon_api_key';  // Replace 'amazon_api_key'
   const webApiKey = 'your_web_api_key';  // Replace 'web_api_key'
   ```
   Get your API keys from the [RevenueCat dashboard](https://app.revenuecat.com)

5. **Optional**: If using your own app configuration, update the bundle ID (iOS) and application ID (Android) to match your RevenueCat app settings. The sample apps are currently configured with `com.revenuecat.sampleapp` (iOS) and `com.revenuecat.purchases_sample` (Android).

6. Connect a physical device (recommended for purchase testing) and run:
   ```bash
   flutter run
   ```

#### Integration Tests
To run integration tests, replace the API key in the test file:
```bash
sed -i.bck s/api_key/$API_KEY/ integration_test/app_test.dart
```


## Local Development with Dependencies

The RevenueCat Flutter SDK depends on several native SDKs and hybrid common libraries:

**Core Dependencies:**
- `purchases-hybrid-common` / `PurchasesHybridCommon` - Shared logic between hybrid SDKs
- `purchases-ios` / `RevenueCat` - iOS native SDK  
- `purchases-android` / `purchases` - Android native SDK

**UI Dependencies:**
- `purchases-hybrid-common-ui` / `PurchasesHybridCommonUI` - Shared UI logic for paywalls
- `RevenueCatUI` - iOS native UI components
- `purchases-ui` - Android native UI components

### Working with Local Flutter Packages

Both sample apps are already configured to use local versions of the RevenueCat Flutter packages via `dependency_overrides` in their `pubspec.yaml`:

```yaml
dependency_overrides:
  purchases_flutter:
    path: ../../
  purchases_ui_flutter:
    path: ../../purchases_ui_flutter
```

Any changes to the main Flutter plugin will be automatically reflected in the sample apps.

## Switching Between SPM and CocoaPods

The PurchaseTester sample is designed to work seamlessly with both Swift Package Manager and CocoaPods. Based on [PR #1454](https://github.com/RevenueCat/purchases-flutter/pull/1454), you can easily switch between them:

### Enable Swift Package Manager (Default)
```bash
flutter config --enable-swift-package-manager
flutter clean
flutter pub get
```

### Switch to CocoaPods (For Legacy Support)
```bash
flutter config --no-enable-swift-package-manager
flutter clean
flutter pub get
cd ios && pod install
```

> **Note**: The sample app includes both SPM Package.swift files and CocoaPods podspec files, so it can work with either dependency manager without manual configuration changes.

### Working with Local Dependencies

You can configure the Flutter SDK to use local versions of RevenueCat's native SDKs for development. This is useful when working on features that span multiple repositories or debugging issues in the native layer.

**Clone the repositories you want to work with locally:**

```bash
# Core hybrid layer (required for most development)
git clone https://github.com/RevenueCat/purchases-hybrid-common.git

# Native iOS SDK (optional, for deeper iOS debugging)
git clone https://github.com/RevenueCat/purchases-ios.git

# Native Android SDK (optional, for deeper Android debugging)  
git clone https://github.com/RevenueCat/purchases-android.git
```

#### iOS Setup with Swift Package Manager (Recommended)

Update the plugin's Package.swift files to use local packages:

> **Note**: You only need to update the Package.swift files. Xcode will automatically use the local dependencies when you build - no manual "Add Package Dependencies" step required.

**For iOS debugging**: Open the sample app's iOS project in Xcode:  
   `revenuecat_examples/purchase_tester/ios/Runner.xcodeproj` or `revenuecat_examples/MagicWeather/ios/Runner.xcodeproj`

> **Recommended SPM Workflow:**  
> 1. Make Flutter changes in your editor  
> 2. Open `ios/Runner.xcodeproj` in Xcode  
> 3. Build and run from Xcode (SPM local deps work perfectly!)

**For purchases-hybrid-common:**

**purchases_flutter** (`ios/purchases_flutter/Package.swift`):
```swift
dependencies: [
    // Replace remote dependency:
    // .package(url: "https://github.com/RevenueCat/purchases-hybrid-common.git", exact: "17.13.0")
    
    // With local path:
    .package(path: "/path/to/purchases-hybrid-common")
],
```

**purchases_ui_flutter** (`purchases_ui_flutter/ios/purchases_ui_flutter/Package.swift`):
```swift
dependencies: [
    .package(path: "/path/to/purchases-hybrid-common")
],
targets: [
    .target(
        name: "purchases_ui_flutter",
        dependencies: [
            .product(name: "PurchasesHybridCommonUI", package: "purchases-hybrid-common")
        ]
    )
]
```

**For purchases-ios (optional):**

If you're using local `purchases-ios`, update purchases-hybrid-common's Package.swift to use the local RevenueCat SDK:
```swift
dependencies: [
    .package(path: "/path/to/purchases-ios")
],
targets: [
    // Update targets to use local RevenueCat and RevenueCatUI products
    .target(
        name: "PurchasesHybridCommon",
        dependencies: [
            .product(name: "RevenueCat", package: "purchases-ios")
        ]
    ),
    .target(
        name: "PurchasesHybridCommonUI", 
        dependencies: [
            .product(name: "RevenueCatUI", package: "purchases-ios")
        ]
    )
]
```

#### iOS Setup with CocoaPods (Legacy)

**For purchases-hybrid-common:**

1. In the iOS podspec (`ios/purchases_flutter.podspec`), modify the dependency:
   ```ruby
   # Replace this line:
   s.dependency 'PurchasesHybridCommon', '17.13.0'
   
   # With a local path (remove version number):
   s.dependency 'PurchasesHybridCommon', :path => '/path/to/purchases-hybrid-common/ios'
   ```

2. In your sample app's `ios/Podfile`, add the local dependencies:
   ```ruby
   target 'Runner' do
     # ... existing configuration ...
     
     # Add local PurchasesHybridCommon and UI
     pod 'PurchasesHybridCommon', :path => '/path/to/purchases-hybrid-common'
     pod 'PurchasesHybridCommonUI', :path => '/path/to/purchases-hybrid-common'
   end
   ```

**For purchases-ios (optional):**

3. In your sample app's `ios/Podfile`, also add:
   ```ruby
   target 'Runner' do
     # ... existing configuration ...
     
     # Point to local RevenueCat SDK (both core and UI)
     pod 'RevenueCat', :path => '/path/to/purchases-ios'
     pod 'RevenueCatUI', :path => '/path/to/purchases-ios'
   end
   ```

4. Remove existing Podfile.lock and Pods folder, then install:
   ```bash
   cd revenuecat_examples/purchase_tester/ios
   rm -rf Podfile.lock Pods/
   pod install --repo-update
   ```

**For iOS debugging**: Open the sample app's iOS project in Xcode:  
   `revenuecat_examples/purchase_tester/ios/Runner.xcodeproj` or `revenuecat_examples/MagicWeather/ios/Runner.xcodeproj`

#### Android Setup

Choose **one** of these three alternative approaches to use local dependencies:

**Option 1: enableLocalBuild task (recommended)**:

> **✅ Note**: The Android variant resolution issue has been solved! Both `purchases-hybrid-common` and `purchases-android` now work together seamlessly with local builds.

   ```bash
   cd revenuecat_examples/purchase_tester/android
   
   # For purchases-hybrid-common (includes core + UI):
   ./gradlew enableLocalBuild -PcommonPath="/path/to/purchases-hybrid-common/android"
   
   # For purchases-android (includes core + UI):
   ./gradlew enableLocalBuild -PandroidPath="/path/to/purchases-android"
   
   # You can enable both at the same time:
   ./gradlew enableLocalBuild -PcommonPath="/path/to/purchases-hybrid-common/android" -PandroidPath="/path/to/purchases-android"
   ```

   This configures the sample app to use your local dependencies instead of published versions.

   To disable later:
   ```bash
   ./gradlew disableLocalBuild
   ```

**For Android debugging**: Open the sample app's Android project in Android Studio:  
   `File → Open → /path/to/purchases-flutter/revenuecat_examples/purchase_tester/android/`

**Option 2: Manual includeBuild setup**:

Add to your sample app's `android/settings.gradle`:
```gradle
includeBuild('/path/to/purchases-hybrid-common/android') {
    dependencySubstitution {
        substitute module('com.revenuecat.purchases:purchases-hybrid-common') using project(':hybridcommon')
        substitute module('com.revenuecat.purchases:purchases-hybrid-common-ui') using project(':hybridcommon-ui')
    }
}

includeBuild('/path/to/purchases-android') {
    dependencySubstitution {
        substitute module('com.revenuecat.purchases:purchases') using project(':purchases')
        substitute module('com.revenuecat.purchases:purchases-ui') using project(':ui:revenuecatui')
    }
}
```

**Option 3: Local Maven repository**:
   
   1. Build and publish the local version:
      ```bash
      cd /path/to/purchases-hybrid-common/android
      ./gradlew publishToMavenLocal
      ```
   
   2. Add mavenLocal() to your sample app's `android/build.gradle`:
      ```gradle
      allprojects {
          repositories {
              mavenLocal()  // Add this first
              google()
              mavenCentral()
          }
      }
      ```


## Development Workflow

1. **Make changes** to the Flutter plugin code in `lib/`
2. **Test changes** using the sample apps (changes are reflected automatically)
3. **Run tests** with `fvm flutter test`
4. **Test on native platforms** by running the sample apps on iOS/Android devices

## Troubleshooting

### macOS Security Issues
If you encounter a security dialog on macOS when running Flutter:
1. Go to **System Preferences** > **Security & Privacy**
2. Click the lock icon at the bottom left to unlock
3. Click **"Allow Anyway"** for the blocked item
4. Try running the app again

### iOS/SPM Issues
- **Swift Package Manager (Recommended)**:
  - We recommend opening Xcode project directly and building from there
  - Clear Swift Package caches: **Product** → **Clean Build Folder** in Xcode
  - Reset package caches: **File** → **Packages** → **Reset Package Caches**
  - Ensure local package paths are correct and accessible
  - If packages don't appear, try closing and reopening Xcode
  - If SPM integration fails, try switching to CocoaPods temporarily:
    ```bash
    flutter config --no-enable-swift-package-manager
    flutter clean && flutter pub get
    ```

- **CocoaPods (Legacy)**:
  - If you encounter CocoaPods issues, try:
    ```bash
    cd ios && pod repo update && pod install --clean-install
    ```
  - Ensure your local dependency paths are correct in podspecs and Podfiles

- **General iOS Issues**:
  - Clear Xcode derived data if builds fail
  - Verify code signing settings for your development team

### Android Issues
- **Gradle Version Compatibility**: Ensure all projects use compatible AGP versions. If you get "Using multiple versions of the Android Gradle plugin" errors:
  - Check that purchases-flutter, purchases-hybrid-common, and purchases-android all use the same AGP version
  - Currently requires AGP version indicated in `android/build.gradle#L13` and Gradle version in `android/gradle/wrapper/gradle-wrapper.properties#L4`
  
- **`failOnNoDiscoveredTests` Error**: If you get "Unresolved reference: failOnNoDiscoveredTests" when building with local `purchases-hybrid-common`:
  - This happens with Gradle versions < 9.0.0 (the property was introduced in Gradle 9.0.0)
  - **Fix**: Comment out the `failOnNoDiscoveredTests = false` line in `purchases-hybrid-common/android/api-tests/build.gradle.kts`
  - The property is optional and can be safely disabled for compatibility
  
- Clean and rebuild if you encounter dependency resolution issues:
  ```bash
  cd android && ./gradlew clean
  flutter clean && flutter pub get
  ```
- Verify that `includeBuild` paths are correct in `settings.gradle`
- Check that local Maven repositories are properly configured

### Flutter Issues
- Clear Flutter caches:
  ```bash
  flutter clean
  flutter pub get
  ```
- Ensure you're using the correct Flutter version

