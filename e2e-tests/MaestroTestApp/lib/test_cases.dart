import 'package:flutter/material.dart';
import 'purchase_through_paywall_screen.dart';

typedef TestCase = ({String title, Widget screen});

final List<TestCase> testCases = [
  (
    title: 'Purchase through paywall',
    screen: const PurchaseThroughPaywallScreen(),
  ),
];
