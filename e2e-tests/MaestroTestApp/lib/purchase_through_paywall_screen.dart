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
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await RevenueCatUI.presentPaywall();
              },
              child: const Text('Present Paywall'),
            ),
          ],
        ),
      ),
    );
  }
}
