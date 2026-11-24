import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'test_cases.dart';
import 'test_cases_screen.dart';

const apiKey = 'MAESTRO_TESTS_REVENUECAT_API_KEY';
const _launchArgsChannel = MethodChannel('com.revenuecat.maestro/launch_args');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Purchases.setLogLevel(LogLevel.debug);

  String? testFlow;
  String? testApiKey;
  try {
    testFlow = await _launchArgsChannel.invokeMethod<String>('getTestFlow');
    testApiKey = await _launchArgsChannel.invokeMethod<String>('getTestApiKey');
  } on MissingPluginException {
    debugPrint('Launch args channel not available');
  }

  final configurationKey =
      testApiKey != null && testApiKey.isNotEmpty ? testApiKey : apiKey;
  await Purchases.configure(PurchasesConfiguration(configurationKey));

  runApp(MaestroTestApp(initialTestFlow: testFlow));
}

class MaestroTestApp extends StatelessWidget {
  final String? initialTestFlow;

  const MaestroTestApp({super.key, this.initialTestFlow});

  @override
  Widget build(BuildContext context) {
    final match =
        testCases.where((tc) => tc.flowKey == initialTestFlow).firstOrNull;

    return MaterialApp(
      title: 'Maestro Test App',
      home: match?.builder() ?? const TestCasesScreen(),
    );
  }
}
