import 'package:flutter/material.dart';
import 'present_customer_center_screen.dart';
import 'purchase_through_paywall_screen.dart';

typedef TestCase = ({String title, String flowKey, Widget Function() builder});

final List<TestCase> testCases = [
  (
    title: 'Purchase through paywall',
    flowKey: 'purchase_through_paywall',
    builder: () => const PurchaseThroughPaywallScreen(),
  ),
  (
    title: 'Present Customer Center',
    flowKey: 'present_customer_center',
    builder: () => const PresentCustomerCenterScreen(),
  ),
];
