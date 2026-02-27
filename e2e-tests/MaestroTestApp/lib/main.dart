import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'test_cases_screen.dart';

const apiKey = 'MAESTRO_TESTS_REVENUECAT_API_KEY';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Purchases.setLogLevel(LogLevel.debug);
  await Purchases.configure(PurchasesConfiguration(apiKey));
  runApp(const MaestroTestApp());
}

class MaestroTestApp extends StatelessWidget {
  const MaestroTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maestro Test App',
      home: const TestCasesScreen(),
    );
  }
}
