import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'premium_screen.dart';

const _offeringIdentifiers = [
  'onboarding_affiliate_2wk_trial',
  'qr-code-preview-offering',
  'Offering 2',
];

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

  void _presentPaywallViaWidgetModal(String offeringIdentifier) {
    setState(() => _error = null);
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (_) =>
            PremiumScreen(offeringIdentifier: offeringIdentifier),
        fullscreenDialog: true,
      ),
    );
  }

  void _presentPaywallViaWidgetPush(String offeringIdentifier) {
    setState(() => _error = null);
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (_) =>
            PremiumScreen(offeringIdentifier: offeringIdentifier),
      ),
    );
  }

  Future<void> _presentPaywallViaRevenueCatUI(String offeringIdentifier) async {
    setState(() => _error = null);
    try {
      final offerings = await Purchases.getOfferings();
      final offering = offerings.all[offeringIdentifier];
      await RevenueCatUI.presentPaywall(offering: offering);
    } catch (e) {
      if (!mounted) return;
      debugPrint('Failed to present paywall via RevenueCatUI: $e');
      setState(() => _error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Purchase through paywall')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Entitlements: $_entitlements',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            if (_error != null) ...[
              const SizedBox(height: 10),
              Text(
                'Error: $_error',
                style: const TextStyle(fontSize: 14, color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 24),
            _SectionHeader(
              title: 'Via PaywallView widget (fullscreen modal)',
              subtitle:
                  'Navigator.push(MaterialPageRoute(fullscreenDialog: true)) '
                  '→ PaywallView (customer pattern, slides up)',
            ),
            const SizedBox(height: 8),
            for (final identifier in _offeringIdentifiers) ...[
              ElevatedButton(
                onPressed: () => _presentPaywallViaWidgetModal(identifier),
                child: Text('Present Paywall: $identifier'),
              ),
              const SizedBox(height: 10),
            ],
            const SizedBox(height: 16),
            _SectionHeader(
              title: 'Via PaywallView widget (horizontal push)',
              subtitle:
                  'Navigator.push(MaterialPageRoute()) '
                  '→ PaywallView (iOS navigation push style)',
            ),
            const SizedBox(height: 8),
            for (final identifier in _offeringIdentifiers) ...[
              ElevatedButton(
                onPressed: () => _presentPaywallViaWidgetPush(identifier),
                child: Text('Present Paywall: $identifier'),
              ),
              const SizedBox(height: 10),
            ],
            const SizedBox(height: 16),
            _SectionHeader(
              title: 'Via RevenueCatUI.presentPaywall',
              subtitle: 'Native modal presentation (no Flutter route)',
            ),
            const SizedBox(height: 8),
            for (final identifier in _offeringIdentifiers) ...[
              ElevatedButton(
                onPressed: () => _presentPaywallViaRevenueCatUI(identifier),
                child: Text('Present Paywall: $identifier'),
              ),
              const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionHeader({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
        ),
      ],
    );
  }
}
