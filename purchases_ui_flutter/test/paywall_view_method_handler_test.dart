import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:purchases_flutter/models/store_transaction.dart';
import 'package:purchases_ui_flutter/views/paywall_view_method_handler.dart';

const _customerInfo = {
  'originalAppUserId': 'test_user',
  'entitlements': {
    'all': {},
    'active': {},
    'verification': 'NOT_REQUESTED',
  },
  'activeSubscriptions': [],
  'latestExpirationDate': null,
  'allExpirationDates': {},
  'allPurchasedProductIdentifiers': [],
  'firstSeen': '2024-01-01T00:00:00Z',
  'requestDate': '2024-01-01T00:00:00Z',
  'allPurchaseDates': {},
  'originalApplicationVersion': null,
  'nonSubscriptionTransactions': [],
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

  group('onPurchaseCompleted', () {
    CustomerInfo? receivedCustomerInfo;
    StoreTransaction? receivedTransaction;
    var callCount = 0;
    final handler = PaywallViewMethodHandler(
      null,
      (customerInfo, storeTransaction) {
        callCount++;
        receivedCustomerInfo = customerInfo;
        receivedTransaction = storeTransaction;
      },
      null,
      null,
      null,
      null,
      null,
    );

    setUp(() {
      callCount = 0;
      receivedCustomerInfo = null;
      receivedTransaction = null;
    });

    test('receives the customer info and transaction', () async {
      await handler.handleMethodCall(
        const MethodCall('onPurchaseCompleted', {
          'customerInfo': _customerInfo,
          'storeTransaction': {
            'transactionIdentifier': 'txn_123',
            'productIdentifier': 'com.test.product',
            'purchaseDate': '2024-01-01T00:00:00Z',
          },
        }),
      );

      expect(callCount, 1);
      expect(receivedCustomerInfo!.originalAppUserId, 'test_user');
      expect(receivedTransaction!.transactionIdentifier, 'txn_123');
    });

    test('is not called when there is no transaction', () async {
      await handler.handleMethodCall(
        const MethodCall('onPurchaseCompleted', {
          'customerInfo': _customerInfo,
          'storeTransaction': null,
        }),
      );

      expect(callCount, 0);
    });
  });
}
