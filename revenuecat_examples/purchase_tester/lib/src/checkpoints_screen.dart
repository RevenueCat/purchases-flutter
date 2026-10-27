import 'package:flutter/material.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

class CheckpointsScreen extends StatefulWidget {
  const CheckpointsScreen({Key? key}) : super(key: key);

  @override
  State<CheckpointsScreen> createState() => _CheckpointsScreenState();
}

class _CheckpointsScreenState extends State<CheckpointsScreen> {
  final _identifierController = TextEditingController();
  final _removeCallbacks = <void Function()>{};
  bool _fullScreen = false;
  String _status = 'Enter a dashboard checkpoint identifier.';

  @override
  void dispose() {
    for (final remove in _removeCallbacks) {
      remove();
    }
    _identifierController.dispose();
    super.dispose();
  }

  void _run() {
    setState(() {
      _status = 'Checkpoint called. Only passing it updates this status; '
          'backing out keeps you here.';
    });
    late final void Function() remove;
    try {
      remove = RevenueCatUI.checkpoint(
        _identifierController.text.trim(),
        (result) {
          _removeCallbacks.remove(remove);
          if (!mounted) return;
          setState(() {
            _status = 'Passed.\n'
                'Flow: ${result.flow == null ? 'none' : 'presented'}\n'
                'Entitlements: ${result.flow?.obtainedEntitlements.map((e) => e.entitlementInfo.identifier).join(', ') ?? '-'}\n'
                'Products: ${result.flow?.obtainedProducts.map((p) => p.product.identifier).join(', ') ?? '-'}\n'
                'Active entitlements: ${result.customer.entitlements.active.keys.join(', ')}';
          });
        },
        params: CheckpointParams(
          presentationMode: _fullScreen
              ? FlowPresentationMode.modalFullScreen
              : FlowPresentationMode.modalSheet,
          customVariables: const {
            'source': CustomVariableValue.string('flutter_tester'),
          },
        ),
      );
      _removeCallbacks.add(remove);
    } catch (e) {
      setState(() => _status = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkpoints')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _identifierController,
              autocorrect: false,
              decoration: const InputDecoration(
                labelText: 'Checkpoint identifier',
                border: OutlineInputBorder(),
              ),
            ),
            SwitchListTile(
              title: const Text('Full screen'),
              value: _fullScreen,
              onChanged: (value) => setState(() => _fullScreen = value),
            ),
            ElevatedButton(
              onPressed: _run,
              child: const Text('Run checkpoint'),
            ),
            const SizedBox(height: 16),
            Text(_status),
          ],
        ),
      ),
    );
  }
}
