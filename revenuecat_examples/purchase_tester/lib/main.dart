import 'dart:io';

import 'package:flutter/material.dart';
import 'package:purchases_flutter_example/src/constant.dart';

import 'store_config.dart';
import 'src/app.dart';

void main() {
  if (Platform.isIOS || Platform.isMacOS) {
    StoreConfig(
      store: Store.appleStore,
      apiKey: appleApiKey,
    );
  } else if (Platform.isAndroid) {
    // Run the app passing --dart-define=AMAZON=true
    const useAmazon = bool.fromEnvironment("amazon");
    StoreConfig(
      store: useAmazon ? Store.amazonAppstore : Store.googlePlay,
      apiKey: useAmazon ? amazonApiKey : googleApiKey,
    );
  }

  runApp(const PurchaseTester());
}
