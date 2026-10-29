// ignore_for_file: experimental_member_use

import 'package:flutter/material.dart';
import 'checkpoint_screen.dart';
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
  (
    title: 'Checkpoint',
    flowKey: 'checkpoint_purchase',
    // Presents its paywall to every user, with the monthly package preselected.
    builder: () =>
        const CheckpointScreen(identifier: 'donottouch_sdk_everyone'),
  ),
  (
    title: 'Checkpoint unknown identifier',
    flowKey: 'checkpoint_unknown_identifier',
    // A well-formed identifier that is not configured in the dashboard.
    builder: () =>
        const CheckpointScreen(identifier: 'maestro_unknown_checkpoint'),
  ),
];
