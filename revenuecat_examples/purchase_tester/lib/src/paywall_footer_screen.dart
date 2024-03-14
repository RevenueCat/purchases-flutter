import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter/material.dart';

class PaywallFooterScreen extends StatefulWidget {
  final Offering? offering;

  const PaywallFooterScreen({Key? key, this.offering}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PaywallFooterScreenState();
}

class _PaywallFooterScreenState extends State<PaywallFooterScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( // Wrap your body content with SafeArea
        child: Center(
          child: PaywallFooterView(
            offering: widget.offering,
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
            contentCreator: (bottomPadding) => Container(
              color: Colors.blue.withAlpha(80),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: bottomPadding),
                child: Column(
                  children: [
                    for (var i in Iterable<int>.generate(50).toList()) Text('Testing footer view $i')
                  ],
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}
