import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

class PremiumScreen extends StatefulWidget {
  final String offeringIdentifier;

  const PremiumScreen({
    super.key,
    required this.offeringIdentifier,
  });

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  Offering? offering;
  bool offeringLoaded = false;

  @override
  void initState() {
    super.initState();
    _initOffering();
  }

  Future<void> _initOffering() async {
    try {
      final offerings = await Purchases.getOfferings();
      final offeringForIdentifier = offerings.all[widget.offeringIdentifier];

      setState(() {
        offering = offeringForIdentifier;
        offeringLoaded = true;
      });
    } catch (e) {
      setState(() => offeringLoaded = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!offeringLoaded) {
      return const Center(child: CircularProgressIndicator());
    }

    return PaywallView(
      offering: offering,
      onDismiss: () => Navigator.of(context).pop(),
    );
  }
}
