import 'package:flutter/material.dart';

import 'initial.dart';

class PurchaseTester extends StatelessWidget {
  const PurchaseTester({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'RevenueCat Sample',
      home: InitialScreen(),
    );
  }
}
