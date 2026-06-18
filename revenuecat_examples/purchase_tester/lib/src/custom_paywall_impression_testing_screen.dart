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
  bool _loading = false;
  String? _status;
  String? _error;
  String? _currentOfferingId;

  @override
  void initState() {
    super.initState();
    _loadOfferings();
  }

  @override
  void dispose() {
    _paywallIdController.dispose();
    super.dispose();
  }

  String? get _paywallId {
    final paywallId = _paywallIdController.text.trim();
    return paywallId.isEmpty ? null : paywallId;
  }

  Future<Offerings> _loadOfferings() async {
    final offerings = await Purchases.getOfferings();
    if (mounted) {
      setState(() {
        _currentOfferingId = offerings.current?.identifier;
      });
    }
    return offerings;
  }

  Future<void> _trackImpressionWithoutOffering() async {
    setState(() {
      _loading = true;
      _status = null;
      _error = null;
    });

    try {
      final offerings = await _loadOfferings();
      final currentOffering = offerings.current;
      final paywallId = _paywallId;

      if (currentOffering == null) {
        setState(() {
          _status =
              'No current offering configured. The native SDK cannot infer an offering for this call.';
        });
        if (mounted) {
          await showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('No current offering configured'),
              content: const Text(
                'The native SDK can only infer an offering when getOfferings().current is non-null. Use Track with Offering for this project.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
        return;
      }

      if (paywallId == null) {
        await Purchases.trackCustomPaywallImpression();
      } else {
        await Purchases.trackCustomPaywallImpression(
          params: CustomPaywallImpressionParams(
            paywallId: paywallId,
          ),
        );
      }

      setState(() {
        _status = 'Tracked without offering (paywallId: ${paywallId ?? 'nil'}, '
            'current offering: ${currentOffering.identifier})';
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

  Future<void> _trackImpressionWithOffering(Offering offering) async {
    setState(() {
      _loading = true;
      _status = null;
      _error = null;
    });

    try {
      final paywallId = _paywallId;

      await Purchases.trackCustomPaywallImpression(
        params: CustomPaywallImpressionParams(
          paywallId: paywallId,
          offering: offering,
        ),
      );

      setState(() {
        _status = 'Tracked with offering: ${offering.identifier} '
            '(paywallId: ${paywallId ?? 'nil'})';
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

  Future<void> _showOfferingPicker() async {
    setState(() {
      _loading = true;
      _status = 'Loading offerings...';
      _error = null;
    });

    try {
      final offerings = await _loadOfferings();
      final offeringOptions = offerings.all.values.toList()
        ..sort((a, b) => a.identifier.compareTo(b.identifier));

      if (!mounted) {
        return;
      }

      if (offeringOptions.isEmpty) {
        setState(() {
          _status = 'No offerings available';
        });
        return;
      }

      setState(() {
        _loading = false;
      });

      final selectedOffering = await showDialog<Offering>(
        context: context,
        builder: (context) => SimpleDialog(
          title: const Text('Select Offering'),
          children: [
            for (final offering in offeringOptions)
              SimpleDialogOption(
                onPressed: () => Navigator.of(context).pop(offering),
                child: Text(offering.identifier),
              ),
          ],
        ),
      );

      if (selectedOffering != null) {
        await _trackImpressionWithOffering(selectedOffering);
      } else if (mounted) {
        setState(() {
          _status = null;
        });
      }
    } catch (err) {
      setState(() {
        _error = err.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
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
            const SizedBox(height: 8),
            Text(
              'Current offering: ${_currentOfferingId ?? 'nil'}',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
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
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loading ? null : _trackImpressionWithoutOffering,
              child: Text(
                _loading ? 'Loading...' : 'Track without Offering',
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loading ? null : _showOfferingPicker,
              child: Text(
                _loading ? 'Loading...' : 'Track with Offering',
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
