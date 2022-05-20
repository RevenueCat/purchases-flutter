import 'package:flutter/material.dart';

import 'flavor_config.dart';
import 'src/app.dart';

void main() {
  FlavorConfig(
    flavor: Flavor.appleStore,
    //TO DO: add the API key for your app from the RevenueCat dashboard: https://app.revenuecat.com
    apiKey: "",
  );

  runApp(const PurchaseTester());
}
