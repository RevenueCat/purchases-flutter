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
  final Map<String, _PurchaseAs> _purchaseAsByOption =
      <String, _PurchaseAs>{};
  String? _purchaseStatusMessage;
  bool _isPurchasing = false;

  bool get _canAttemptPurchase =>
      !_isPurchasing && _selectedBaseOptionId != null;

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
              'Allows you to test subscriptions with add-ons.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _canAttemptPurchase ? () => _onPurchasePressed() : null,
              child: const Text('Purchase'),
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
        final purchaseAs = _purchaseAsFor(option);

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
                      label: 'Base Item',
                      value: isBase,
                      onChanged: (checked) =>
                          _onBaseItemToggled(option, checked),
                    ),
                    if (!isBase)
                      _OptionCheckbox(
                        label: 'Purchase Option',
                        value: isPurchaseOption,
                        onChanged: (checked) =>
                            _onPurchaseOptionToggled(option, checked),
                      ),
                    const SizedBox(height: 16),
                    Text(
                      'Purchase As:',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    _PurchaseAsPicker(
                      label: 'Store Product',
                      value: _PurchaseAs.storeProduct,
                      groupValue: purchaseAs,
                      onChanged: (value) => _onPurchaseAsChanged(option, value),
                    ),
                    _PurchaseAsPicker(
                      label: 'Subscription Option',
                      value: _PurchaseAs.subscriptionOption,
                      groupValue: purchaseAs,
                      onChanged: (value) => _onPurchaseAsChanged(option, value),
                    ),
                    _PurchaseAsPicker(
                      label: 'Package',
                      value: _PurchaseAs.package,
                      groupValue: purchaseAs,
                      onChanged: (value) => _onPurchaseAsChanged(option, value),
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

  void _onPurchaseAsChanged(SubscriptionOption option, _PurchaseAs value) {
    setState(() {
      _purchaseAsByOption[option.id] = value;
    });
  }

  Future<void> _onPurchasePressed() async {
    final baseId = _selectedBaseOptionId;
    if (baseId == null) return;

    final baseEntry = _findEntry(baseId);
    if (baseEntry == null) return;

    final List<_SubscriptionOptionEntry> selectedAddOns = _selectedPurchaseOptionIds
        .map(_findEntry)
        .whereType<_SubscriptionOptionEntry>()
        .where((entry) => entry.option.id != baseId)
        .toList(growable: false);

    final basePurchaseAs = _purchaseAsFor(baseEntry.option);

    final Map<String, StoreProduct> addOnStoreProductsMap = {};
    final Map<String, SubscriptionOption> addOnSubscriptionOptionsMap = {};
    final Map<String, Package> addOnPackagesMap = {};

    for (final entry in selectedAddOns) {
      final selection = _purchaseAsFor(entry.option);
      if (selection == _PurchaseAs.storeProduct) {
        addOnStoreProductsMap[entry.storeProduct.identifier] =
            entry.storeProduct;
      } else if (selection == _PurchaseAs.subscriptionOption) {
        debugPrint(
            'Adding add-on subscription option: ${entry.option.id}: ${entry.option.storeProductId}: ${entry.option.id}');
        addOnSubscriptionOptionsMap[entry.option.id] = entry.option;
      } else {
        addOnPackagesMap[entry.package.identifier] = entry.package;
      }
    }

    final List<StoreProduct>? addOnStoreProducts =
        addOnStoreProductsMap.isNotEmpty
            ? addOnStoreProductsMap.values.toList(growable: false)
            : null;
    final List<SubscriptionOption>? addOnSubscriptionOptions =
        addOnSubscriptionOptionsMap.isNotEmpty
            ? addOnSubscriptionOptionsMap.values.toList(growable: false)
            : null;
    final List<Package>? addOnPackages = addOnPackagesMap.isNotEmpty
        ? addOnPackagesMap.values.toList(growable: false)
        : null;

    final PurchaseParams params;
    switch (basePurchaseAs) {
      case _PurchaseAs.storeProduct:
        params = PurchaseParams.storeProduct(
          baseEntry.storeProduct,
          addOnStoreProducts: addOnStoreProducts,
          addOnPackages: addOnPackages,
          addOnSubscriptionOptions: addOnSubscriptionOptions,
        );
        break;
      case _PurchaseAs.subscriptionOption:
        params = PurchaseParams.subscriptionOption(
          baseEntry.option,
          addOnStoreProducts: addOnStoreProducts,
          addOnPackages: addOnPackages,
          addOnSubscriptionOptions: addOnSubscriptionOptions,
        );
        break;
      case _PurchaseAs.package:
        params = PurchaseParams.package(
          baseEntry.package,
          addOnStoreProducts: addOnStoreProducts,
          addOnPackages: addOnPackages,
          addOnSubscriptionOptions: addOnSubscriptionOptions,
        );
        break;
    }

    final baseDescription = basePurchaseAs == _PurchaseAs.storeProduct
        ? baseEntry.storeProduct.identifier
        : basePurchaseAs == _PurchaseAs.subscriptionOption
            ? '${baseEntry.option.storeProductId}:${baseEntry.option.id}'
            : '${baseEntry.package.identifier} (package)';
    final addOnDescriptions = [
      if (addOnStoreProducts != null)
        ...addOnStoreProducts.map((product) => product.identifier),
      if (addOnSubscriptionOptions != null)
        ...addOnSubscriptionOptions.map((option) => option.storeProductId),
      if (addOnPackages != null)
        ...addOnPackages.map((pkg) => '${pkg.identifier} (package)'),
    ];
    final purchaseAsLabel = basePurchaseAs == _PurchaseAs.storeProduct
        ? 'store product'
        : basePurchaseAs == _PurchaseAs.subscriptionOption
            ? 'subscription option'
            : 'package';

    final addOnSummary =
        addOnDescriptions.isNotEmpty
            ? ' with add-ons ${addOnDescriptions.join(', ')}'
            : '';
    final attemptMessage =
        'Attempting purchase: $baseDescription as $purchaseAsLabel$addOnSummary';
    debugPrint(attemptMessage);

    try {
      setState(() {
        _isPurchasing = true;
        _purchaseStatusMessage = null;
      });
      final result = await Purchases.purchase(params);
      final successMessage =
          'Purchase successful: ${result.storeTransaction.productIdentifier}$addOnSummary';
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

  _PurchaseAs _purchaseAsFor(SubscriptionOption option) =>
      _purchaseAsByOption[option.id] ?? _PurchaseAs.storeProduct;

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
            package: package,
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

  final Package package;

  _SubscriptionOptionEntry({
    required this.option,
    required this.storeProduct,
    required this.package,
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

class _PurchaseAsPicker extends StatelessWidget {
  final String label;
  final _PurchaseAs value;
  final _PurchaseAs groupValue;
  final ValueChanged<_PurchaseAs> onChanged;

  const _PurchaseAsPicker({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return InkWell(
      onTap: () => onChanged(value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<_PurchaseAs>(
            value: value,
            groupValue: groupValue,
            onChanged: (_) => onChanged(value),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
          ),
        ],
      ),
    );
  }
}

enum _PurchaseAs { storeProduct, subscriptionOption, package }

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
