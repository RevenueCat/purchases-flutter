// Minimal fixture that links against purchases_flutter and
// purchases_ui_flutter to force their Android modules to be built.
// Used only to verify the plugins build cleanly under AGP 9.

import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

void main() {
  runApp(const AgpNineTestApp());
}

class AgpNineTestApp extends StatelessWidget {
  const AgpNineTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    final loaded = <Type>[Purchases, RevenueCatUI].length;
    return MaterialApp(
      home: Scaffold(
        body: Center(child: Text('purchases plugins loaded: $loaded')),
      ),
    );
  }
}
