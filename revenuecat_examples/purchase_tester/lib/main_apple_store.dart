import 'package:flutter/material.dart';
import 'package:purchases_flutter_example/src/constant.dart';

import 'flavor_config.dart';
import 'src/app.dart';

void main() {
  StoreConfig(
    store: Store.appleStore,
    apiKey: appleApiKey,
  );

  runApp(const PurchaseTester());
}
