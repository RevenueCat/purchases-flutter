import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_ui_flutter/views/paywall_view_method_handler.dart';

void main() {
  test('onInteraction receives the event map', () async {
    Map<String, dynamic>? received;
    final handler = PaywallViewMethodHandler(
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      onInteraction: (event) => received = event,
    );

    await handler.handleMethodCall(
      const MethodCall('onInteraction', {
        'component_type': 'tab',
        'component_value': 'yearly',
        'paywall_revision': 3,
      }),
    );

    expect(received, {
      'component_type': 'tab',
      'component_value': 'yearly',
      'paywall_revision': 3,
    });
  });
}
