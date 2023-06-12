import 'dart:io';

import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_flutter_example/src/constant.dart';

import 'store_config.dart';
import 'src/app.dart';

void main() async {
  if (Platform.isIOS || Platform.isMacOS) {
    StoreConfig(
      store: TesterStore.appleStore,
      apiKey: appleApiKey,
    );
  } else if (Platform.isAndroid) {
    // Run the app passing --dart-define=AMAZON=true
    const useAmazon = bool.fromEnvironment("amazon");
    StoreConfig(
      store: useAmazon ? TesterStore.amazonAppstore : TesterStore.googlePlay,
      apiKey: useAmazon ? amazonApiKey : googleApiKey,
    );
  }
  WidgetsFlutterBinding.ensureInitialized();

  await _configureSDK();
  runApp(const PurchaseTester());
}

Future<void> _configureSDK() async {
  await Purchases.setLogLevel(LogLevel.debug);

  PurchasesConfiguration configuration;
  if (StoreConfig.isForAmazonAppstore()) {
    configuration = AmazonConfiguration(StoreConfig.instance.apiKey);
  } else {
    configuration = PurchasesConfiguration(StoreConfig.instance.apiKey);
  }
  await Purchases.configure(configuration);

  await Purchases.enableAdServicesAttributionTokenCollection();
}
