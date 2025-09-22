import 'package:flutter/material.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

class CustomerCenterViewModalScreen extends StatelessWidget {
  const CustomerCenterViewModalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: CustomerCenterView(
            onDismiss: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
      ),
    );
  }
}
