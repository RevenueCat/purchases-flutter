import 'package:flutter/foundation.dart';

enum Store { appleStore, googlePlay, amazonAppstore }

class StoreConfig {
  final Store store;
  final String apiKey;
  static StoreConfig _instance;

  factory StoreConfig({@required Store store, @required String apiKey}) {
    _instance ??= StoreConfig._internal(store, apiKey);
    return _instance;
  }

  StoreConfig._internal(this.store, this.apiKey);

  static StoreConfig get instance {
    return _instance;
  }

  static bool isForAppleStore() => _instance.store == Store.appleStore;

  static bool isForGooglePlay() => _instance.store == Store.googlePlay;

  static bool isForAmazonAppstore() => _instance.store == Store.amazonAppstore;
}
