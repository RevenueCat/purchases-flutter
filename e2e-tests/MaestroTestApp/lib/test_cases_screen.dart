import 'package:flutter/material.dart';
import 'purchase_through_paywall_screen.dart';

class TestCasesScreen extends StatelessWidget {
  const TestCasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Cases')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Purchase through paywall'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const PurchaseThroughPaywallScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
