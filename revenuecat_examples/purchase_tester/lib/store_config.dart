enum TesterStore { appleStore, googlePlay, amazonAppstore }

class StoreConfig {
  final TesterStore store;
  final String apiKey;
  static StoreConfig? _instance;

  factory StoreConfig({required TesterStore store, required String apiKey}) {
    _instance ??= StoreConfig._internal(store, apiKey);
    return _instance!;
  }

  StoreConfig._internal(this.store, this.apiKey);

  static StoreConfig get instance {
    return _instance!;
  }

  static bool isForAppleStore() => instance.store == TesterStore.appleStore;

  static bool isForGooglePlay() => instance.store == TesterStore.googlePlay;

  static bool isForAmazonAppstore() =>
      instance.store == TesterStore.amazonAppstore;
}
