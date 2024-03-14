import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter/material.dart';

class PaywallScreen extends StatefulWidget {
  final Offering? offering;

  const PaywallScreen({Key? key, this.offering}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: PaywallView(
            offering: widget.offering,
            displayCloseButton: true,
            onPurchaseStarted: (Package rcPackage) {
              print('Purchase started for package: ${rcPackage.identifier}');
            },
            onPurchaseCompleted:
                (CustomerInfo customerInfo, StoreTransaction storeTransaction) {
              print('Purchase completed for customerInfo:\n $customerInfo\n '
                  'and storeTransaction:\n $storeTransaction');
            },
            onPurchaseError: (PurchasesError error) {
              print('Purchase error: $error');
            },
            onRestoreCompleted: (CustomerInfo customerInfo) {
              print('Restore completed for customerInfo:\n $customerInfo');
            },
            onRestoreError: (PurchasesError error) {
              print('Restore error: $error');
            },
            onDismiss: () {
              print('Paywall asked to dismiss');
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
