import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class WinbackTestingScreen extends StatefulWidget {
  const WinbackTestingScreen({Key? key}) : super(key: key);

  @override
  State<WinbackTestingScreen> createState() => _WinbackTestingScreenState();
}

class _WinbackTestingScreenState extends State<WinbackTestingScreen> {
  StoreProduct? _product;
  List<WinBackOffer> _productWinBackOffers = [];
  Package? _package;
  List<WinBackOffer> _packageWinBackOffers = [];
  String? _error;

  Future<void> _fetchProduct() async {
    try {
      final products = await Purchases.getProducts(
          ['com.revenuecat.monthly_4.99.1_week_intro']);
      if (products.isNotEmpty) {
        setState(() {
          _product = products[0];
        });
      } else {
        setState(() {
          _error = 'No products available';
        });
      }
    } catch (err) {
      setState(() {
        _error = 'Failed to fetch products: ${err.toString()}';
      });
    }
  }

  Future<void> _purchaseProduct(StoreProduct product) async {
    try {
      final purchaseResult = await Purchases.purchaseStoreProduct(product);
      print('Purchase successful: $purchaseResult');
    } catch (err) {
      print('Purchase failed: $err');
    }
  }

  Future<void> _fetchEligibleWinBackOffersForProduct(
      StoreProduct product) async {
    try {
      final offers =
          await Purchases.getEligibleWinBackOffersForProduct(product);
      print('Found win-back offers: $offers');
      setState(() {
        _productWinBackOffers = offers;
      });
    } catch (err) {
      print('Error fetching win-back offers: $err');
      setState(() {
        _productWinBackOffers = [];
      });
    }
  }

  Future<void> _fetchEligibleWinBackOffersForPackage(Package package) async {
    try {
      final offers =
          await Purchases.getEligibleWinBackOffersForPackage(package);
      setState(() {
        _packageWinBackOffers = offers;
      });
    } catch (err) {
      print('Error fetching win-back offers: $err');
      setState(() {
        _packageWinBackOffers = [];
      });
    }
  }

  Future<void> _purchaseWinBackOfferForProduct(
      StoreProduct product, WinBackOffer offer) async {
    try {
      final result =
          await Purchases.purchaseProductWithWinBackOffer(product, offer);
      print('Win-Back Offer purchase successful: $result');
    } catch (err) {
      print('Win-Back Offer purchase failed: $err');
    }
  }

  Future<void> _fetchPackage() async {
    final offerings = await Purchases.getOfferings();
    print(offerings.current?.availablePackages);
    final monthlyPackage = offerings.current?.availablePackages
        .where((pkg) => pkg.identifier == '\$rc_monthly')
        .firstOrNull;

    if (monthlyPackage != null) {
      setState(() {
        _package = monthlyPackage;
      });
    }
  }

  Future<void> _purchasePackage(Package package) async {
    try {
      final purchaseResult = await Purchases.purchasePackage(package);
      print('Purchase successful: $purchaseResult');
    } catch (err) {
      print('Purchase failed: $err');
    }
  }

  Future<void> _purchaseWinBackOfferForPackage(
      Package package, WinBackOffer offer) async {
    try {
      final result =
          await Purchases.purchasePackageWithWinBackOffer(package, offer);
      print('Win-Back Offer purchase successful: $result');
    } catch (err) {
      print('Win-Back Offer purchase failed: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Win-Back Testing'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Use this screen to fetch eligible win-back offers, purchase products without a win-back offer, and purchase products with an eligible win-back offer.',
              ),
              const SizedBox(height: 8),
              const Text(
                'This test relies on products and offers defined in the SKConfig file, so be sure to launch the PurchaseTester app from Xcode with the SKConfig file configured.',
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _fetchProduct,
                child: const Text('Fetch Product'),
              ),
              if (_error != null)
                Text(
                  _error!,
                  style: const TextStyle(color: Colors.red),
                ),
              if (_product != null) ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(_product!.title),
                        Text(_product!.description),
                        Text(_product!.priceString),
                        ElevatedButton(
                          onPressed: () => _purchaseProduct(_product!),
                          child: const Text('Purchase'),
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              _fetchEligibleWinBackOffersForProduct(_product!),
                          child: const Text(
                              'Fetch Eligible Win-Back Offers for this Product'),
                        ),
                        if (_productWinBackOffers.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: _productWinBackOffers
                                .map(
                                  (offer) => Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                              'Identifier: ${offer.identifier}'),
                                          Text('Price: ${offer.priceString}'),
                                          Text('Cycles: ${offer.cycles}'),
                                          Text('Period: ${offer.period}'),
                                          Text(
                                              'Period Unit: ${offer.periodUnit}'),
                                          Text(
                                              'Period Number of Units: ${offer.periodNumberOfUnits}'),
                                          ElevatedButton(
                                            onPressed: () =>
                                                _purchaseWinBackOfferForProduct(
                                                    _product!, offer),
                                            child: const Text(
                                                'Purchase Win-Back Offer'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
              ElevatedButton(
                onPressed: _fetchPackage,
                child: const Text('Fetch Package'),
              ),
              if (_package != null)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(_package!.identifier),
                        Text(_package!.storeProduct.description),
                        Text(_package!.storeProduct.priceString),
                        ElevatedButton(
                          onPressed: () => _purchasePackage(_package!),
                          child: const Text('Purchase'),
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              _fetchEligibleWinBackOffersForPackage(_package!),
                          child: const Text(
                              'Fetch Eligible Win-Back Offers for this Package'),
                        ),
                        ..._packageWinBackOffers.map(
                          (offer) => Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text('Identifier: ${offer.identifier}'),
                                  Text('Price: ${offer.priceString}'),
                                  Text('Cycles: ${offer.cycles}'),
                                  Text('Period: ${offer.period}'),
                                  Text('Period Unit: ${offer.periodUnit}'),
                                  Text(
                                      'Period Number of Units: ${offer.periodNumberOfUnits}'),
                                  ElevatedButton(
                                    onPressed: () =>
                                        _purchaseWinBackOfferForPackage(
                                            _package!, offer),
                                    child:
                                        const Text('Purchase Win-Back Offer'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
