import 'package:flutter/material.dart';
import 'package:magic_weather_flutter/src/app.dart';

import 'store_config.dart';

void main() {
  StoreConfig(
    store: Store.appleStore,
    //TO DO: add the API key for your app from the RevenueCat dashboard: https://app.revenuecat.com
    apiKey: "",
  );

  runApp(const MagicWeatherFlutter());
}
