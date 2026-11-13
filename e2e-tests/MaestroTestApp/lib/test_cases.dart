import 'package:flutter/material.dart';
import 'checkpoint_screen.dart';
import 'custom_checkpoint_presenter_screen.dart';
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
  for (final flow in ['purchase', 'back', 'unmount'])
    (
      title: 'Custom checkpoint presenter $flow',
      flowKey: 'checkpoint_custom_presenter_$flow',
      builder: () => const CustomCheckpointPresenterScreen(),
    ),
  (
    title: 'Checkpoint custom error dialog',
    flowKey: 'checkpoint_custom_error_dialog',
    builder: () =>
        const CheckpointScreen(identifier: '!', customErrorDialog: true),
  ),
];
