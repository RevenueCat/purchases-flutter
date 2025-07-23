import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class VirtualCurrencyTestingScreen extends StatefulWidget {
  const VirtualCurrencyTestingScreen({Key? key}) : super(key: key);

  @override
  State<VirtualCurrencyTestingScreen> createState() =>
      _VirtualCurrencyTestingScreenState();
}

class _VirtualCurrencyTestingScreenState
    extends State<VirtualCurrencyTestingScreen> {
  VirtualCurrencies? _virtualCurrencies;
  bool _loading = false;
  String? _error;

  Future<void> _fetchVirtualCurrencies() async {
    setState(() {
      _loading = true;
    });
    _clearVirtualCurrencies();

    try {
      final virtualCurrencies = await Purchases.getVirtualCurrencies();
      setState(() {
        _virtualCurrencies = virtualCurrencies;
      });
    } catch (err) {
      final errorMessage = err.toString();
      setState(() {
        _error = errorMessage;
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _invalidateVirtualCurrenciesCache() async {
    setState(() {
      _loading = true;
    });
    _clearVirtualCurrencies();

    try {
      await Purchases.invalidateVirtualCurrenciesCache();
    } catch (err) {
      final errorMessage = err.toString();
      print('Error invalidating virtual currencies cache: $err');
      setState(() {
        _error = errorMessage;
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _fetchCachedVirtualCurrencies() async {
    setState(() {
      _loading = true;
    });
    _clearVirtualCurrencies();

    try {
      final cachedVirtualCurrencies =
          await Purchases.getCachedVirtualCurrencies();
      setState(() {
        _virtualCurrencies = cachedVirtualCurrencies;
      });
    } catch (err) {
      final errorMessage = err.toString();
      print('Error fetching cached virtual currencies: $err');
      setState(() {
        _error = errorMessage;
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _clearVirtualCurrencies() {
    setState(() {
      _virtualCurrencies = null;
      _error = null;
    });
  }

  Widget _displayVirtualCurrencies() {
    if (_virtualCurrencies == null && _error == null) {
      return const SizedBox.shrink();
    }

    if (_error != null) {
      return Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.red[300]!),
        ),
        child: Text(
          'Error: $_error',
          style: TextStyle(color: Colors.red[800], fontSize: 14),
        ),
      );
    }

    if (_virtualCurrencies != null && _virtualCurrencies!.all.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[400]!),
        ),
        child: const Text('Virtual currencies are empty.'),
      );
    }

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[400]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Virtual Currencies:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                const JsonEncoder.withIndent('  ').convert(
                    _virtualCurrencies!.all.map((key, value) => MapEntry(key, {
                          'name': value.name,
                          'code': value.code,
                          'serverDescription': value.serverDescription,
                          'balance': value.balance,
                        }))),
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Virtual Currency Testing'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Virtual Currency Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Use this screen to fetch and display virtual currencies from RevenueCat.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : _fetchVirtualCurrencies,
              child: Text(_loading ? 'Loading...' : 'Fetch Virtual Currencies'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _loading ? null : _invalidateVirtualCurrenciesCache,
              child: const Text('Invalidate Virtual Currencies Cache'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _loading ? null : _fetchCachedVirtualCurrencies,
              child: const Text('Fetch Cached Virtual Currencies'),
            ),
            _displayVirtualCurrencies(),
            if (_virtualCurrencies != null || _error != null) ...[
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _clearVirtualCurrencies,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[400],
                  foregroundColor: Colors.white,
                ),
                child: const Text('Clear'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
