import 'package:flutter/material.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

class PresentCustomerCenterScreen extends StatefulWidget {
  const PresentCustomerCenterScreen({super.key});

  @override
  State<PresentCustomerCenterScreen> createState() =>
      _PresentCustomerCenterScreenState();
}

class _PresentCustomerCenterScreenState
    extends State<PresentCustomerCenterScreen> {
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Present Customer Center')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_error != null) ...[
              Text(
                'Error: $_error',
                style: const TextStyle(fontSize: 14, color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
            ],
            ElevatedButton(
              onPressed: () async {
                setState(() => _error = null);
                try {
                  await RevenueCatUI.presentCustomerCenter();
                } catch (e) {
                  if (!mounted) return;
                  debugPrint('Failed to present customer center: $e');
                  setState(() => _error = e.toString());
                }
              },
              child: const Text('Open Customer Center'),
            ),
          ],
        ),
      ),
    );
  }
}
