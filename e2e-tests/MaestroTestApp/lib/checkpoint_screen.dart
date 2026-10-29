// ignore_for_file: experimental_member_use

import 'package:flutter/material.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

const _entitlementId = 'pro';
const _productId = 'pro_monthly_subscription';

String _listOrNone(Iterable<String> values) =>
    values.isEmpty ? 'none' : (values.toList()..sort()).join(', ');

class CheckpointScreen extends StatefulWidget {
  final String identifier;

  const CheckpointScreen({super.key, required this.identifier});

  @override
  State<CheckpointScreen> createState() => _CheckpointScreenState();
}

class _CheckpointScreenState extends State<CheckpointScreen> {
  String _status = 'Callback: not invoked';
  List<String> _lines = const [];
  String? _error;
  int _invocations = 0;
  void Function()? _removeCallback;

  @override
  void dispose() {
    _removeCallback?.call();
    super.dispose();
  }

  void _hitCheckpoint() {
    setState(() => _error = null);
    try {
      _removeCallback = RevenueCatUI.checkpoint(widget.identifier, (result) {
        if (!mounted) return;
        _invocations += 1;
        final entitlements = result.flow?.obtainedEntitlements
                .map((e) => e.entitlementInfo.identifier) ??
            const <String>[];
        final products = (result.flow?.obtainedProducts ?? const [])
            .map((p) => p.product.identifier)
            .toList();
        setState(() {
          _status = result.flow == null
              ? 'Callback: passed, no flow (call #$_invocations)'
              : 'Callback: passed, entitlements: ${_listOrNone(entitlements)} '
                  '(call #$_invocations)';
          // One line per fact, without regex specials, so Maestro matches each literally.
          _lines = [
            'Obtained products: ${_listOrNone(products)}',
            'Entitlement $_entitlementId obtained: '
                '${entitlements.contains(_entitlementId)}',
            'Product $_productId obtained: ${products.contains(_productId)}',
            'Customer active entitlements: '
                '${_listOrNone(result.customer.entitlements.active.keys)}',
          ];
        });
      });
    } catch (e) {
      debugPrint('Failed to hit checkpoint: $e');
      setState(() => _error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkpoint')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Identifier: ${widget.identifier}',
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
              onPressed: _hitCheckpoint,
              child: const Text('Hit checkpoint'),
            ),
            const SizedBox(height: 20),
            Text(_status, style: const TextStyle(fontSize: 16)),
            for (final line in _lines) Text(line),
          ],
        ),
      ),
    );
  }
}
