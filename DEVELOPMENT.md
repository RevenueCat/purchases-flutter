- Edit the `defaultValue` in `example/lib/main.dart` for the apiKey with the sample app to test:

```
    const apiKey = String.fromEnvironment("API_KEY", defaultValue: null);
```

- Open xcode project inside example/ios and changes made to the plugin should be automatically reflected.
- When updating iOS dependency, make sure to run `pod install` inside `example/ios/`.

