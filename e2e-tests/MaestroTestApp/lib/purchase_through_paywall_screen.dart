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
    Purchases.getCustomerInfo().then(_updateEntitlements).catchError((e) {
      if (!mounted) return;
      debugPrint('Failed to get customer info: $e');
      setState(() => _error = e.toString());
    });
  }

  @override
  void dispose() {
    Purchases.removeCustomerInfoUpdateListener(_updateEntitlements);
    super.dispose();
  }

  void _updateEntitlements(CustomerInfo info) {
    if (!mounted) return;
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
              style: const TextStyle(fontSize: 18),
            ),
            if (_error != null) ...[
              const SizedBox(height: 10),
              Text(
                'Error: $_error',
                style: const TextStyle(fontSize: 14, color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                setState(() => _error = null);
                try {
                  await RevenueCatUI.presentPaywall();
                } catch (e) {
                  if (!mounted) return;
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
