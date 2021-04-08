- Replace the `api_key` in `revenuecat_examples/purchase_tester/lib/main.dart` with the api key with the sample app to test:

```
    sed -i.bck s/api_key/$API_KEY/ revenuecat_examples/purchase_tester/integration_test/app_test.dart
```

- Open xcode project inside revenuecat_examples/purchase_tester/ios and changes made to the plugin should be automatically reflected.
- When updating iOS dependency, make sure to run `pod install` inside `revenuecat_examples/purchase_tester/ios/`.

