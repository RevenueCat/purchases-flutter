import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class CustomPaywallImpressionTestingScreen extends StatefulWidget {
  const CustomPaywallImpressionTestingScreen({Key? key}) : super(key: key);

  @override
  State<CustomPaywallImpressionTestingScreen> createState() =>
      _CustomPaywallImpressionTestingScreenState();
}

class _CustomPaywallImpressionTestingScreenState
    extends State<CustomPaywallImpressionTestingScreen> {
  final _paywallIdController = TextEditingController();
  final _offeringIdController = TextEditingController();
  bool _loading = false;
  String? _status;
  String? _error;

  @override
  void dispose() {
    _paywallIdController.dispose();
    _offeringIdController.dispose();
    super.dispose();
  }

  Future<void> _trackImpression() async {
    setState(() {
      _loading = true;
      _status = null;
      _error = null;
    });

    try {
      final paywallId = _paywallIdController.text.trim();
      final offeringId = _offeringIdController.text.trim();

      if (paywallId.isEmpty && offeringId.isEmpty) {
        await Purchases.trackCustomPaywallImpression();
      } else {
        await Purchases.trackCustomPaywallImpression(
          params: CustomPaywallImpressionParams(
            paywallId: paywallId.isEmpty ? null : paywallId,
            offeringId: offeringId.isEmpty ? null : offeringId,
          ),
        );
      }
      setState(() {
        _status =
            'Tracked (paywallId: ${paywallId.isEmpty ? 'nil' : paywallId}, '
            'offeringId: ${offeringId.isEmpty ? 'nil' : offeringId})';
      });
    } catch (err) {
      setState(() {
        _error = err.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Paywall Impression Testing'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Custom Paywall Impression',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Use this screen to test tracking custom paywall impressions.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _paywallIdController,
              decoration: const InputDecoration(
                labelText: 'Paywall ID',
                hintText: 'Optional — leave empty for none',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _offeringIdController,
              decoration: const InputDecoration(
                labelText: 'Offering ID',
                hintText: 'Optional — leave empty for none',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loading ? null : _trackImpression,
              child: Text(
                _loading ? 'Loading...' : 'Track Custom Paywall Impression',
              ),
            ),
            if (_status != null) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green[300]!),
                ),
                child: Text(
                  _status!,
                  style: TextStyle(color: Colors.green[800], fontSize: 14),
                ),
              ),
            ],
            if (_error != null) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red[300]!),
                ),
                child: Text(
                  'Error: $_error',
                  style: TextStyle(color: Colors.red[800], fontSize: 14),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
