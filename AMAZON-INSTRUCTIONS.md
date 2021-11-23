Adds initial Amazon store support. This won't work right away as it requires special RevenueCat setup that's not available for all customers.

In order to use please point to this tag in your `pubspec.yaml` like this:

```
dependencies:
  purchases_flutter:
    git:
      url: git://github.com/revenuecat/purchases-flutter.git
      ref: amazon.alpha.2
```

Then configure the package using your **RevenueCat API key specific for Amazon** and passing `useAmazon: true`:

```
await Purchases.setup(apiKey, appUserId: null, observerMode: false, useAmazon: true);
```

Modify your `android/app/build.gradle` to add a dependency to the official `in-app-purchasing-2.0.76.jar`

```
dependencies {
    implementation files('libs/in-app-purchasing-2.0.76.jar')
```

The next step would be to add the `jar` to your project. For that you can use the following gradle task that can be added to `android/app/build.gradle` and run via `./gradlew getAmazonLibrary` or via Android Studio :

```
// Gradle task to download Amazon library
ext {
    iapVersion = "2.0.76"
}

task getAmazonLibrary {
    ext {
        downloadURL = "https://amzndevresources.com/iap/sdk/AmazonInAppPurchasing_Android.zip"
        fileToExtract = "in-app-purchasing-${iapVersion}.jar"
        destFile = new File( projectDir, "libs/$fileToExtract" )
    }

    inputs.property( 'downloadURL', downloadURL )
    inputs.property( 'fileToExtract', fileToExtract )
    outputs.file( destFile )

    doLast {
        File destDir = destFile.parentFile
        destDir.mkdirs()

        File downloadFile = new File( temporaryDir, 'download.zip' )
        new URL( downloadURL ).withInputStream { is ->
            downloadFile.withOutputStream { it << is }
        }

        project.copy {
            from {
                zipTree(downloadFile).matching { include "**/$fileToExtract" }.singleFile
            }

            into( destDir )
        }
    }
}
```

That gradle task will add the jar to the `libs` folder inside `app`:

<img width="366" alt="I in-app-purchasing-2 0 76 jar" src="https://user-images.githubusercontent.com/664544/127639109-e8b04a7e-2501-45ee-beca-d778ecab58a0.png">


Alternatively, you can do this manually by downloading the .zip from [Amazon](https://amzndevresources.com/iap/sdk/AmazonInAppPurchasing_Android.zip) and then unzipping and moving the `in-app-purchasing-2.0.76.jar` into your projects `android/app/libs/` folder like in the screenshot above.

Due to some limitations, RevenueCat will only validate purchases made in production or in Live App Testing and won't validate purchases made with the Amazon App Tester.
