import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

const _checkpointIdentifier = 'donottouch_sdk_everyone';
const _productIdentifier = 'pro_monthly_subscription';

typedef _Presentation = ({
  PaywallPresentationParams params,
  void Function(PaywallPresentationResult) complete,
});

class CustomCheckpointPresenterScreen extends StatefulWidget {
  const CustomCheckpointPresenterScreen({super.key});

  @override
  State<CustomCheckpointPresenterScreen> createState() =>
      _CustomCheckpointPresenterScreenState();
}

class _CustomCheckpointPresenterScreenState
    extends State<CustomCheckpointPresenterScreen> {
  int? _ownerId = 1;
  int _nextOwnerId = 1;
  _Presentation? _presentation;
  bool _awaitingCompletion = false;
  int _presentationCount = 0;
  int _callbackCount = 0;
  int _earlyCallbacks = 0;
  int _staleCallbacks = 0;
  int _completionCount = 0;
  String _lastCompletion = 'none';
  String _entitlements = 'none';
  String _purchaseStatus = 'not started';
  String? _error;

  Package? get _monthlyPackage => _presentation
      ?.params.offering.availablePackages
      .where((package) => package.storeProduct.identifier == _productIdentifier)
      .firstOrNull;

  void _present(PaywallPresentationParams params,
      void Function(PaywallPresentationResult) complete) {
    setState(() {
      _awaitingCompletion = true;
      _presentationCount++;
      _purchaseStatus = 'not started';
      _presentation = (params: params, complete: complete);
    });
  }

  void _onPassed(int ownerId, CheckpointResult result) {
    // Observe stale callbacks too: a mounted check in the owner would hide an
    // SDK cleanup bug rather than letting Maestro detect it.
    setState(() {
      _callbackCount++;
      if (_awaitingCompletion) _earlyCallbacks++;
      if (ownerId != _ownerId) _staleCallbacks++;
      final active = result.customer.entitlements.active.keys.toList()..sort();
      _entitlements = active.isEmpty ? 'none' : active.join(', ');
    });
  }

  void _finish(PaywallPresentationResult result) {
    final presentation = _presentation;
    if (presentation == null) return;
    setState(() => _presentation = null);
    // Remove the app-owned UI in this frame before resuming native work.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _awaitingCompletion = false;
      presentation.complete(result);
      setState(() {
        _completionCount++;
        _lastCompletion = result.toString();
      });
    });
  }

  Future<void> _purchase() async {
    final package = _monthlyPackage;
    if (package == null) return;
    setState(() {
      _purchaseStatus = 'in progress';
      _error = null;
    });
    try {
      // Use the package from the presenter event to preserve offering context.
      await Purchases.purchase(PurchaseParams.package(package));
      setState(() => _purchaseStatus = 'complete');
    } catch (error) {
      setState(() {
        _purchaseStatus = 'failed';
        _error = error.toString();
      });
    }
  }

  String _describeVariable(String key) {
    final value = _presentation?.params.customVariables[key];
    if (value is StringCustomVariableValue) return 'string ${value.value}';
    if (value is NumberCustomVariableValue) {
      final number = value.value;
      return 'number ${number % 1 == 0 ? number.toInt() : number}';
    }
    if (value is BooleanCustomVariableValue) return 'boolean ${value.value}';
    return 'missing';
  }

  @override
  Widget build(BuildContext context) {
    final presentation = _presentation;
    final purchasing = _purchaseStatus == 'in progress';
    return Scaffold(
      appBar: AppBar(title: const Text('Custom checkpoint presenter')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Checkpoint owner: ${_ownerId == null ? 'unmounted' : 'mounted'}'),
            Text('Presentation count: $_presentationCount'),
            Text('Callback count: $_callbackCount'),
            Text('Callbacks before completion: $_earlyCallbacks'),
            Text('Stale callbacks: $_staleCallbacks'),
            Text('Completion count: $_completionCount'),
            Text('Last completion: $_lastCompletion'),
            Text('Customer active entitlements: $_entitlements'),
            if (_error != null) Text('Error: $_error'),
            if (_ownerId != null)
              _CheckpointOwner(
                key: ValueKey(_ownerId),
                ownerId: _ownerId!,
                presenter: _present,
                disabled: presentation != null,
                onPassed: _onPassed,
                onError: (error) => setState(() => _error = error),
              )
            else if (presentation == null)
              _TestButton(
                id: 'remount-checkpoint-owner-button',
                title: 'Remount checkpoint owner',
                onPressed: () => setState(() => _ownerId = ++_nextOwnerId),
              ),
            if (presentation != null) ...[
              const Divider(),
              const Text('Custom checkpoint paywall'),
              Text(
                  'Checkpoint identifier: ${presentation.params.checkpointIdentifier}'),
              Text(
                  'Offering identifier: ${presentation.params.offering.identifier}'),
              Text(
                  'Product available: ${_monthlyPackage?.storeProduct.identifier ?? 'missing'}'),
              Text(
                  'Presentation mode: ${presentation.params.presentationMode}'),
              Text('Custom string: ${_describeVariable('name')}'),
              Text('Custom number: ${_describeVariable('level')}'),
              Text('Custom boolean: ${_describeVariable('premium')}'),
              Text('Purchase: $_purchaseStatus'),
              _TestButton(
                id: 'custom-checkpoint-buy-button',
                title: 'Buy monthly package',
                onPressed: _monthlyPackage == null ||
                        purchasing ||
                        _purchaseStatus == 'complete'
                    ? null
                    : _purchase,
              ),
              Wrap(
                spacing: 8,
                children: [
                  _TestButton(
                    id: 'custom-checkpoint-continue-button',
                    title: 'Continue checkpoint',
                    onPressed: purchasing
                        ? null
                        : () => _finish(PaywallPresentationResult.continued),
                  ),
                  _TestButton(
                    id: 'custom-checkpoint-close-button',
                    title: 'Close checkpoint',
                    onPressed: purchasing
                        ? null
                        : () => _finish(PaywallPresentationResult.closed),
                  ),
                  _TestButton(
                    id: 'custom-checkpoint-back-button',
                    title: 'Back from custom paywall',
                    onPressed: purchasing
                        ? null
                        : () =>
                            _finish(PaywallPresentationResult.navigatedBack),
                  ),
                ],
              ),
              if (_ownerId != null)
                _TestButton(
                  id: 'unmount-checkpoint-owner-button',
                  title: 'Unmount checkpoint owner',
                  onPressed:
                      purchasing ? null : () => setState(() => _ownerId = null),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

// This child owns the checkpoint registration; its parent owns the paywall UI.
// Disposing this widget exercises real screen cleanup while keeping the UI open.
class _CheckpointOwner extends StatefulWidget {
  final int ownerId;
  final PaywallPresenter presenter;
  final bool disabled;
  final void Function(int ownerId, CheckpointResult result) onPassed;
  final void Function(String? error) onError;

  const _CheckpointOwner(
      {super.key,
      required this.ownerId,
      required this.presenter,
      required this.disabled,
      required this.onPassed,
      required this.onError});

  @override
  State<_CheckpointOwner> createState() => _CheckpointOwnerState();
}

class _CheckpointOwnerState extends State<_CheckpointOwner> {
  void Function()? _remove;

  @override
  void dispose() {
    _remove?.call();
    super.dispose();
  }

  void _hit() {
    _remove?.call();
    widget.onError(null);
    final ownerId = widget.ownerId;
    final onPassed = widget.onPassed;
    try {
      _remove = RevenueCatUI.checkpoint(
        _checkpointIdentifier,
        (result) => onPassed(ownerId, result),
        params: CheckpointParams(
          paywallPresenter: widget.presenter,
          presentationMode: FlowPresentationMode.modalFullScreen,
          customVariables: const {
            'name': CustomVariableValue.string('Maestro'),
            'level': CustomVariableValue.number(42),
            'premium': CustomVariableValue.boolean(true),
          },
        ),
      );
    } catch (error) {
      widget.onError(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) => _TestButton(
        id: 'hit-custom-checkpoint-button',
        title: 'Hit custom checkpoint',
        onPressed: widget.disabled ? null : _hit,
      );
}

class _TestButton extends StatelessWidget {
  final String id;
  final String title;
  final VoidCallback? onPressed;

  const _TestButton({required this.id, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) => Semantics(
        identifier: id,
        child: ElevatedButton(onPressed: onPressed, child: Text(title)),
      );
}
