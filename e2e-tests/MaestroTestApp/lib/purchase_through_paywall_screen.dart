import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

class PurchaseThroughPaywallScreen extends StatefulWidget {
  const PurchaseThroughPaywallScreen({super.key});

  @override
  State<PurchaseThroughPaywallScreen> createState() =>
      _PurchaseThroughPaywallScreenState();
}

class _PurchaseThroughPaywallScreenState
    extends State<PurchaseThroughPaywallScreen> {
  String _entitlements = 'none';
  String? _error;

  @override
  void initState() {
    super.initState();
    Purchases.addCustomerInfoUpdateListener(_updateEntitlements);
    Purchases.getCustomerInfo().then(_updateEntitlements);
  }

  @override
  void dispose() {
    Purchases.removeCustomerInfoUpdateListener(_updateEntitlements);
    super.dispose();
  }

  void _updateEntitlements(CustomerInfo info) {
    setState(() {
      _entitlements =
          info.entitlements.active.containsKey('pro') ? 'pro' : 'none';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Purchase through paywall')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Entitlements: $_entitlements',
              key: const Key('entitlements-label'),
              style: const TextStyle(fontSize: 18),
            ),
            if (_error != null) ...[
              const SizedBox(height: 10),
              Text(
                'Error: $_error',
                key: const Key('error-message'),
                style: const TextStyle(fontSize: 14, color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              key: const Key('present-paywall-button'),
              onPressed: () async {
                setState(() => _error = null);
                try {
                  await RevenueCatUI.presentPaywall();
                } catch (e) {
                  debugPrint('Failed to present paywall: $e');
                  setState(() => _error = e.toString());
                }
              },
              child: const Text('Present Paywall'),
            ),
          ],
        ),
      ),
    );
  }
}
