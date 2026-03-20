import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter/material.dart';

class SamplePurchaseLogic implements PaywallPurchaseLogic {
  @override
  Future<PurchaseLogicResult> performPurchase(Package packageToPurchase) async {
    print('[SamplePurchaseLogic] performPurchase called for: '
        '${packageToPurchase.identifier}');
    await Future.delayed(const Duration(seconds: 2));
    print('[SamplePurchaseLogic] performPurchase returning success');
    return PurchaseLogicResult.success;
  }

  @override
  Future<PurchaseLogicResult> performRestore() async {
    print('[SamplePurchaseLogic] performRestore called');
    await Future.delayed(const Duration(seconds: 2));
    print('[SamplePurchaseLogic] performRestore returning success');
    return PurchaseLogicResult.success;
  }
}

class PaywallScreen extends StatefulWidget {
  final Offering? offering;
  final Map<String, CustomVariableValue>? customVariables;
  final PaywallPurchaseLogic? purchaseLogic;

  const PaywallScreen({
    Key? key,
    this.offering,
    this.customVariables,
    this.purchaseLogic,
  }) : super(key: key);

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
      body: PaywallView(
        offering: widget.offering,
        displayCloseButton: true,
        customVariables: widget.customVariables,
        purchaseLogic: widget.purchaseLogic,
        onPurchaseStarted: (Package rcPackage) {
          print('Purchase started for package: ${rcPackage.identifier}');
        },
        onPurchaseCompleted:
            (CustomerInfo customerInfo, StoreTransaction storeTransaction) {
          print('Purchase completed for customerInfo:\n $customerInfo\n '
              'and storeTransaction:\n $storeTransaction');
        },
        onPurchaseCancelled: () {
          print('Purchase cancelled');
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
    );
  }
}
