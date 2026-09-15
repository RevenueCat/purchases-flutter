import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:purchases_flutter/models/store_transaction.dart';
import 'package:purchases_ui_flutter/views/paywall_view_method_handler.dart';

const _customerInfo = {
  'entitlements': {'all': {}, 'active': {}},
  'allPurchaseDates': {},
  'allExpirationDates': {},
  'activeSubscriptions': <String>[],
  'allPurchasedProductIdentifiers': <String>[],
  'nonSubscriptionTransactions': <dynamic>[],
  'firstSeen': '2026-01-01T00:00:00Z',
  'originalAppUserId': 'user',
  'requestDate': '2026-01-01T00:00:00Z',
  'managementURL': null,
  'originalPurchaseDate': null,
  'latestExpirationDate': null,
  'originalApplicationVersion': null,
};

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

  test('onPurchaseCompleted fires when there is no store transaction', () async {
    CustomerInfo? receivedCustomerInfo;
    StoreTransaction? receivedTransaction;
    final handler = PaywallViewMethodHandler(
      null,
      (customerInfo, storeTransaction) {
        receivedCustomerInfo = customerInfo;
        receivedTransaction = storeTransaction;
      },
      null,
      null,
      null,
      null,
      null,
    );

    await handler.handleMethodCall(
      const MethodCall('onPurchaseCompleted', {
        'customerInfo': _customerInfo,
        'storeTransaction': null,
      }),
    );

    expect(receivedCustomerInfo?.originalAppUserId, 'user');
    expect(receivedTransaction, const StoreTransaction('', '', ''));
  });
}
