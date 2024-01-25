import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'constant.dart';
import 'initial.dart';

class CatsScreen extends StatelessWidget {
  const CatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Cats Screen')),
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('User is pro'),
            ElevatedButton(
              onPressed: () async {
                try {
                  final customerInfo = await Purchases.getCustomerInfo();
                  final refundStatus =
                      await Purchases.beginRefundRequestForEntitlement(
                          customerInfo.entitlements.active[entitlementKey]!);
                  print('Refund request successful with status: $refundStatus');
                } catch (e) {
                  print('Refund request exception: $e');
                }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InitialScreen()),
                );
              },
              child: const Text('Begin refund for pro entitlement'),
            ),
            ElevatedButton(
              onPressed: () async {
                // In order to defer in-app messages so they're only shown when this button is pressed, you must configure
                // the SDK with `configuration.shouldShowInAppMessagesAutomatically = false;`
                Purchases.showInAppMessages(types: {
                  InAppMessageType.billingIssue,
                  InAppMessageType.priceIncreaseConsent,
                  InAppMessageType.generic
                });
              },
              child: const Text('Show In-App Messages'),
            ),
          ],
        )),
      );
}
