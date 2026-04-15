import 'package:flutter/material.dart';
import 'purchase_through_paywall_screen.dart';

typedef TestCase = ({String title, Widget Function() builder});

final List<TestCase> testCases = [
  (
    title: 'Purchase through paywall',
    builder: () => const PurchaseThroughPaywallScreen(),
  ),
];
