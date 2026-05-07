import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

enum _ProductChangePurchaseKind {
  package,
  storeProduct,
  subscriptionOption,
}

extension _ProductChangePurchaseKindExtension on _ProductChangePurchaseKind {
  String get label {
    switch (this) {
      case _ProductChangePurchaseKind.package:
        return 'Package';
      case _ProductChangePurchaseKind.storeProduct:
        return 'Store product';
      case _ProductChangePurchaseKind.subscriptionOption:
        return 'Subscription option';
    }
  }
}

class ProductChangeTestingScreen extends StatefulWidget {
  const ProductChangeTestingScreen({Key? key}) : super(key: key);

  @override
  State<ProductChangeTestingScreen> createState() =>
      _ProductChangeTestingScreenState();
}

class _ProductChangeTestingScreenState
    extends State<ProductChangeTestingScreen> {
  bool _loading = false;
  bool _purchasing = false;
  String? _error;
  String? _status;
  CustomerInfo? _customerInfo;
  Offering? _currentOffering;
  String? _selectedOldProductIdentifier;
  Package? _selectedPackage;
  SubscriptionOption? _selectedSubscriptionOption;
  StoreReplacementMode? _selectedReplacementMode;
  _ProductChangePurchaseKind _purchaseKind = _ProductChangePurchaseKind.package;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  List<String> get _oldProductIdentifiers {
    final customerInfo = _customerInfo;
    if (customerInfo == null) return [];

    return _oldProductIdentifiersFromCustomerInfo(customerInfo);
  }

  List<Package> get _availablePackages =>
      _currentOffering?.availablePackages ?? [];

  List<SubscriptionOption> get _availableSubscriptionOptions =>
      _selectedPackage?.storeProduct.subscriptionOptions ?? [];

  Future<void> _refreshData() async {
    setState(() {
      _loading = true;
      _error = null;
      _status = null;
    });

    try {
      await Purchases.invalidateCustomerInfoCache();
      final customerInfo = await Purchases.getCustomerInfo();
      final offerings = await Purchases.getOfferings();
      final currentOffering = offerings.current;

      if (!mounted) return;

      setState(() {
        _customerInfo = customerInfo;
        _currentOffering = currentOffering;
        _selectedOldProductIdentifier =
            _selectExistingOldProductIdentifier(customerInfo);
        _selectedPackage = _selectExistingPackage(currentOffering);
        _selectedSubscriptionOption =
            _selectedPackage?.storeProduct.subscriptionOptions?.firstOrNull;
      });
    } catch (err) {
      if (!mounted) return;

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

  List<String> _oldProductIdentifiersFromCustomerInfo(
    CustomerInfo customerInfo,
  ) {
    return customerInfo.activeSubscriptions
        .map((productIdentifier) => productIdentifier.split(':').first)
        .toSet()
        .toList()
      ..sort();
  }

  String? _selectExistingOldProductIdentifier(CustomerInfo customerInfo) {
    final identifiers = _oldProductIdentifiersFromCustomerInfo(customerInfo);

    if (identifiers.contains(_selectedOldProductIdentifier)) {
      return _selectedOldProductIdentifier;
    }

    return identifiers.firstOrNull;
  }

  Package? _selectExistingPackage(Offering? currentOffering) {
    final packages = currentOffering?.availablePackages ?? [];
    if (packages.contains(_selectedPackage)) {
      return _selectedPackage;
    }

    return packages.firstOrNull;
  }

  void _selectPackage(Package? package) {
    setState(() {
      _selectedPackage = package;
      _selectedSubscriptionOption =
          package?.storeProduct.subscriptionOptions?.firstOrNull;
    });
  }

  Future<void> _purchaseProductChange() async {
    final oldProductIdentifier = _selectedOldProductIdentifier;
    final package = _selectedPackage;
    final subscriptionOption = _selectedSubscriptionOption;

    if (oldProductIdentifier == null || oldProductIdentifier.isEmpty) {
      _showError('Select an old product identifier.');
      return;
    }

    if (package == null) {
      _showError('Select a product from the current offering.');
      return;
    }

    if (_purchaseKind == _ProductChangePurchaseKind.subscriptionOption &&
        subscriptionOption == null) {
      _showError('Select a subscription option.');
      return;
    }

    setState(() {
      _purchasing = true;
      _error = null;
      _status = null;
    });

    final productChangeInfo = StoreProductChangeInfo(
      oldProductIdentifier,
      replacementMode: _selectedReplacementMode,
    );

    try {
      final purchaseResult = await _purchaseWithPurchaseParams(
        package,
        subscriptionOption,
        productChangeInfo,
      );

      if (!mounted) return;

      setState(() {
        _status = 'Purchase succeeded: '
            '${purchaseResult.storeTransaction.productIdentifier}';
        _customerInfo = purchaseResult.customerInfo;
      });
    } on PlatformException catch (err) {
      final errorCode = PurchasesErrorHelper.getErrorCode(err);
      if (!mounted) return;

      setState(() {
        _error = 'Purchase failed: $errorCode ${err.message ?? err.details}';
      });
    } catch (err) {
      if (!mounted) return;

      setState(() {
        _error = 'Purchase failed: $err';
      });
    } finally {
      if (mounted) {
        setState(() {
          _purchasing = false;
        });
      }
    }
  }

  Future<PurchaseResult> _purchaseWithPurchaseParams(
    Package package,
    SubscriptionOption? subscriptionOption,
    StoreProductChangeInfo productChangeInfo,
  ) {
    switch (_purchaseKind) {
      case _ProductChangePurchaseKind.package:
        return Purchases.purchase(
          PurchaseParams.package(
            package,
            productChangeInfo: productChangeInfo,
          ),
        );
      case _ProductChangePurchaseKind.storeProduct:
        return Purchases.purchase(
          PurchaseParams.storeProduct(
            package.storeProduct,
            productChangeInfo: productChangeInfo,
          ),
        );
      case _ProductChangePurchaseKind.subscriptionOption:
        return Purchases.purchase(
          PurchaseParams.subscriptionOption(
            subscriptionOption!,
            productChangeInfo: productChangeInfo,
          ),
        );
    }
  }

  void _showError(String error) {
    setState(() {
      _error = error;
      _status = null;
    });
  }

  Widget _buildOldProductDropdown() {
    final identifiers = _oldProductIdentifiers;
    final selectedOldProductIdentifier =
        identifiers.contains(_selectedOldProductIdentifier)
            ? _selectedOldProductIdentifier
            : null;

    return DropdownButtonFormField<String>(
      isExpanded: true,
      decoration: const InputDecoration(
        labelText: 'Old product identifier',
      ),
      value: selectedOldProductIdentifier,
      items: identifiers
          .map(
            (identifier) => DropdownMenuItem(
              value: identifier,
              child: Text(identifier),
            ),
          )
          .toList(),
      onChanged: identifiers.isEmpty
          ? null
          : (value) {
              setState(() {
                _selectedOldProductIdentifier = value;
              });
            },
    );
  }

  Widget _buildPackageDropdown() {
    return DropdownButtonFormField<Package>(
      isExpanded: true,
      decoration: const InputDecoration(
        labelText: 'Product from current offering',
      ),
      value: _selectedPackage,
      items: _availablePackages
          .map(
            (package) => DropdownMenuItem(
              value: package,
              child: Text(
                '${package.identifier} - ${package.storeProduct.identifier}',
              ),
            ),
          )
          .toList(),
      onChanged: _availablePackages.isEmpty ? null : _selectPackage,
    );
  }

  Widget _buildSubscriptionOptionDropdown() {
    return DropdownButtonFormField<SubscriptionOption>(
      isExpanded: true,
      decoration: const InputDecoration(
        labelText: 'Subscription option',
      ),
      value: _selectedSubscriptionOption,
      items: _availableSubscriptionOptions
          .map(
            (option) => DropdownMenuItem(
              value: option,
              child: Text(option.id),
            ),
          )
          .toList(),
      onChanged: _availableSubscriptionOptions.isEmpty
          ? null
          : (value) {
              setState(() {
                _selectedSubscriptionOption = value;
              });
            },
    );
  }

  Widget _buildReplacementModeDropdown() {
    return DropdownButtonFormField<StoreReplacementMode?>(
      isExpanded: true,
      decoration: const InputDecoration(
        labelText: 'Store replacement mode',
      ),
      value: _selectedReplacementMode,
      items: [
        const DropdownMenuItem<StoreReplacementMode?>(
          value: null,
          child: Text('null'),
        ),
        ...StoreReplacementMode.values.map(
          (mode) => DropdownMenuItem<StoreReplacementMode?>(
            value: mode,
            child: Text(mode.value),
          ),
        ),
      ],
      onChanged: (value) {
        setState(() {
          _selectedReplacementMode = value;
        });
      },
    );
  }

  Widget _buildPurchaseKindSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _ProductChangePurchaseKind.values
          .map(
            (kind) => RadioListTile<_ProductChangePurchaseKind>(
              title: Text(kind.label),
              value: kind,
              groupValue: _purchaseKind,
              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  _purchaseKind = value;
                });
              },
            ),
          )
          .toList(),
    );
  }

  Widget _buildResultMessage() {
    final message = _error ?? _status;
    if (message == null) return const SizedBox.shrink();

    final isError = _error != null;
    final color = isError ? Colors.red : Colors.green;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color[50],
        border: Border.all(color: color[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        message,
        style: TextStyle(color: color[800]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final canPurchase = !_loading &&
        !_purchasing &&
        _selectedOldProductIdentifier != null &&
        _selectedPackage != null &&
        (_purchaseKind != _ProductChangePurchaseKind.subscriptionOption ||
            _selectedSubscriptionOption != null);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Change Testing'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _loading ? null : _refreshData,
              child: Text(
                _loading ? 'Loading...' : 'Invalidate CustomerInfo and Refresh',
              ),
            ),
            const SizedBox(height: 16),
            _buildOldProductDropdown(),
            const SizedBox(height: 16),
            _buildPackageDropdown(),
            if (_purchaseKind ==
                _ProductChangePurchaseKind.subscriptionOption) ...[
              const SizedBox(height: 16),
              _buildSubscriptionOptionDropdown(),
            ],
            const SizedBox(height: 16),
            _buildReplacementModeDropdown(),
            const SizedBox(height: 16),
            const Text('Purchase target'),
            _buildPurchaseKindSelector(),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: canPurchase ? _purchaseProductChange : null,
              child: Text(_purchasing ? 'Purchasing...' : 'Purchase Change'),
            ),
            _buildResultMessage(),
          ],
        ),
      ),
    );
  }
}
