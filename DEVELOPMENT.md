- Replace the `api_key` in `example/lib/main.dart` with the api key with the sample app to test:

```
    sed -i.bck s/api_key/$API_KEY/ example/integration_test/app_test.dart
```

- Open xcode project inside example/ios and changes made to the plugin should be automatically reflected.
- When updating iOS dependency, make sure to run `pod install` inside `example/ios/`.

