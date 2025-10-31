import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class AddOnPurchasingScreen extends StatefulWidget {
  final Offering offering;

  const AddOnPurchasingScreen({super.key, required this.offering});

  @override
  State<AddOnPurchasingScreen> createState() => _AddOnPurchasingScreenState();
}

class _AddOnPurchasingScreenState extends State<AddOnPurchasingScreen> {
  late final List<_SubscriptionOptionEntry> _options;
  String? _selectedBaseOptionId;
  final Set<String> _selectedPurchaseOptionIds = <String>{};
  _AddOnType _selectedType = _AddOnType.addOnStoreProducts;
  String? _purchaseStatusMessage;
  bool _isPurchasing = false;

  bool get _canAttemptPurchase =>
      !_isPurchasing &&
      _selectedBaseOptionId != null &&
      _selectedPurchaseOptionIds.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _options = _extractOptions(widget.offering);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add-On Purchasing')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Allows you to test subscriptions with add ons.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _canAttemptPurchase ? () => _onPurchasePressed() : null,
              child: const Text('Purchase with PurchaseParams.storeProduct'),
            ),
            if (_isPurchasing)
              const Padding(
                padding: EdgeInsets.only(top: 12),
                child: LinearProgressIndicator(),
              ),
            if (_purchaseStatusMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  _purchaseStatusMessage!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            const SizedBox(height: 24),
            Text(
              'Add-on type',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            RadioListTile<_AddOnType>(
              contentPadding: EdgeInsets.zero,
              title: const Text('.addOnStoreProducts()'),
              value: _AddOnType.addOnStoreProducts,
              groupValue: _selectedType,
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _selectedType = value;
                });
              },
            ),
            const SizedBox(height: 16),
            Expanded(child: _buildOptionsList(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionsList(BuildContext context) {
    if (_options.isEmpty) {
      return const Center(
        child: Text('No subscription options available for this offering.'),
      );
    }

    return ListView.separated(
      itemCount: _options.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final entry = _options[index];
        final option = entry.option;
        final bool isBase = _selectedBaseOptionId == option.id;
        final bool isPurchaseOption =
            _selectedPurchaseOptionIds.contains(option.id);

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.storeProduct.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Option: ${option.id}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _formatPricing(option),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _OptionCheckbox(
                      label: 'Base item',
                      value: isBase,
                      onChanged: (checked) =>
                          _onBaseItemToggled(option, checked),
                    ),
                    if (!isBase)
                      _OptionCheckbox(
                        label: 'Purchase option',
                        value: isPurchaseOption,
                        onChanged: (checked) =>
                            _onPurchaseOptionToggled(option, checked),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onBaseItemToggled(SubscriptionOption option, bool checked) {
    setState(() {
      if (checked) {
        _selectedBaseOptionId = option.id;
        _selectedPurchaseOptionIds.remove(option.id);
      } else if (_selectedBaseOptionId == option.id) {
        _selectedBaseOptionId = null;
      }
    });
  }

  void _onPurchaseOptionToggled(SubscriptionOption option, bool checked) {
    setState(() {
      if (checked) {
        _selectedPurchaseOptionIds.add(option.id);
      } else {
        _selectedPurchaseOptionIds.remove(option.id);
      }
    });
  }

  Future<void> _onPurchasePressed() async {
    final baseId = _selectedBaseOptionId;
    if (baseId == null) return;

    final baseEntry = _findEntry(baseId);
    if (baseEntry == null) return;

    List<StoreProduct>? addOnStoreProducts;
    if (_selectedType == _AddOnType.addOnStoreProducts &&
        _selectedPurchaseOptionIds.isNotEmpty) {
      final Map<String, StoreProduct> addOnMap = {};
      for (final entry in _options) {
        if (entry.option.id == baseId) continue;
        if (_selectedPurchaseOptionIds.contains(entry.option.id)) {
          addOnMap[entry.storeProduct.identifier] = entry.storeProduct;
        }
      }
      if (addOnMap.isNotEmpty) {
        addOnStoreProducts = addOnMap.values.toList(growable: false);
      }
    }

    final params = PurchaseParams.storeProduct(
      baseEntry.storeProduct,
      addOnStoreProducts: addOnStoreProducts,
    );

    final addOnIdentifiers = addOnStoreProducts
        ?.map((product) => product.identifier)
        .toList(growable: false);

    final attemptMessage =
        'Attempting purchase: ${baseEntry.storeProduct.identifier}'
        '${addOnIdentifiers != null && addOnIdentifiers.isNotEmpty ? ' with add-ons ${addOnIdentifiers.join(', ')}' : ''}';
    debugPrint(attemptMessage);

    try {
      setState(() {
        _isPurchasing = true;
        _purchaseStatusMessage = null;
      });
      final result = await Purchases.purchase(params);
      final successMessage =
          'Purchase successful: ${result.storeTransaction.productIdentifier}'
          '${addOnIdentifiers != null && addOnIdentifiers.isNotEmpty ? ' with add-ons ${addOnIdentifiers.join(', ')}' : ''}';
      debugPrint(successMessage);
      setState(() {
        _isPurchasing = false;
        _purchaseStatusMessage = successMessage;
      });
    } on PlatformException catch (error) {
      debugPrint('Add-on purchase failed: ${error.message}');
      setState(() {
        _isPurchasing = false;
        final details = [
          if (error.code.isNotEmpty) error.code,
          if (error.message != null) error.message!,
        ].join(': ');
        _purchaseStatusMessage =
            'Purchase failed${details.isNotEmpty ? ': $details' : ''}';
      });
    } catch (error) {
      setState(() {
        _isPurchasing = false;
        _purchaseStatusMessage = 'Purchase failed: $error';
      });
    }
  }

  _SubscriptionOptionEntry? _findEntry(String optionId) {
    for (final entry in _options) {
      if (entry.option.id == optionId) return entry;
    }
    return null;
  }

  List<_SubscriptionOptionEntry> _extractOptions(Offering offering) {
    final Map<String, _SubscriptionOptionEntry> deduped = {};
    for (final package in offering.availablePackages) {
      final storeProduct = package.storeProduct;
      final options = storeProduct.subscriptionOptions;
      if (options == null) continue;

      for (final option in options) {
        deduped.putIfAbsent(
          option.id,
          () => _SubscriptionOptionEntry(
            option: option,
            storeProduct: storeProduct,
          ),
        );
      }
    }
    return deduped.values.toList()
      ..sort((a, b) => a.option.id.compareTo(b.option.id));
  }
}

class _SubscriptionOptionEntry {
  final SubscriptionOption option;
  final StoreProduct storeProduct;

  _SubscriptionOptionEntry({
    required this.option,
    required this.storeProduct,
  });
}

class _OptionCheckbox extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _OptionCheckbox({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: value,
            onChanged: (checked) => onChanged(checked ?? false),
          ),
          Text(label),
        ],
      ),
    );
  }
}

enum _AddOnType { addOnStoreProducts }

String _formatPricing(SubscriptionOption option) {
  if (option.pricingPhases.isEmpty) {
    return 'No pricing phases available';
  }

  final buffer = StringBuffer();
  for (final phase in option.pricingPhases) {
    final price = phase.price.formatted;
    final period = phase.billingPeriod?.iso8601 ?? 'one-time';
    buffer.writeln('$price • $period');
  }
  return buffer.toString().trim();
}
