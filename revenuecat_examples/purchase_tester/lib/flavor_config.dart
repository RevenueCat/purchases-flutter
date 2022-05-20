import 'package:flutter/foundation.dart';

enum Flavor { appleStore, googlePlay, amazonAppstore }

class FlavorValues {
  FlavorValues({@required this.apiKey});

  final String apiKey;
}

class FlavorConfig {
  final Flavor flavor;
  final String apiKey;
  static FlavorConfig _instance;

  factory FlavorConfig({@required Flavor flavor, @required String apiKey}) {
    _instance ??= FlavorConfig._internal(flavor, apiKey);
    return _instance;
  }

  FlavorConfig._internal(this.flavor, this.apiKey);

  static FlavorConfig get instance {
    return _instance;
  }

  static bool isForAppleStore() => _instance.flavor == Flavor.appleStore;

  static bool isForGooglePlay() => _instance.flavor == Flavor.googlePlay;

  static bool isForAmazonAppstore() =>
      _instance.flavor == Flavor.amazonAppstore;
}
