import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'test_cases_screen.dart';
import 'purchase_through_paywall_screen.dart';

const apiKey = 'MAESTRO_TESTS_REVENUECAT_API_KEY';
const _launchArgsChannel = MethodChannel('com.revenuecat.maestro/launch_args');

const _testFlowScreenMap = {
  'purchase_through_paywall': 'PurchaseThroughPaywall',
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Purchases.setLogLevel(LogLevel.debug);
  await Purchases.configure(PurchasesConfiguration(apiKey));

  String? testFlow;
  try {
    testFlow = await _launchArgsChannel.invokeMethod<String>('getTestFlow');
  } catch (_) {}

  runApp(MaestroTestApp(initialTestFlow: testFlow));
}

class MaestroTestApp extends StatelessWidget {
  final String? initialTestFlow;

  const MaestroTestApp({super.key, this.initialTestFlow});

  @override
  Widget build(BuildContext context) {
    final screen = initialTestFlow != null &&
            _testFlowScreenMap.containsKey(initialTestFlow)
        ? initialTestFlow
        : null;

    return MaterialApp(
      title: 'Maestro Test App',
      home: screen == 'purchase_through_paywall'
          ? const PurchaseThroughPaywallScreen()
          : const TestCasesScreen(),
    );
  }
}
