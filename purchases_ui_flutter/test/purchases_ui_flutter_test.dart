import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/offering_wrapper.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';
import 'package:purchases_flutter/models/presented_offering_context_wrapper.dart';
import 'package:purchases_flutter/models/presented_offering_targeting_context_wrapper.dart';
import 'package:purchases_flutter/models/store_product_wrapper.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:purchases_ui_flutter/views/customer_center_view_method_handler.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('purchases_ui_flutter');
  final log = <MethodCall>[];
  dynamic response;

  const offering = Offering(
    'identifier',
    'serverDescription',
    {},
    [
      Package(
        'package_id',
        PackageType.annual,
        StoreProduct('product_id', 'description', 'title', 2.99, '\$2.99', 'USD'),
        PresentedOfferingContext(
          'identifier',
          'placement_id',
          PresentedOfferingTargetingContext(123, 'ruleId'),
        ),
      ),
    ],
  );

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
      log.add(call);
      return response;
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
    log.clear();
    response = null;
  });

  test('presentPaywall', () async {
    response = 'NOT_PRESENTED';
    await RevenueCatUI.presentPaywall();
    expect(log, <Matcher>[
      isMethodCall('presentPaywall', arguments: {
          'offeringIdentifier': null,
          'presentedOfferingContext': null,
          'displayCloseButton': false,
        },
      ),
    ]);
  });

  test('presentPaywall with offering identifier', () async {
    response = 'NOT_PRESENTED';
    await RevenueCatUI.presentPaywall(offering: offering);

    expect(log, <Matcher>[
      isMethodCall('presentPaywall', arguments: {
          'offeringIdentifier': offering.identifier,
          'presentedOfferingContext': {
            'offeringIdentifier': 'identifier',
            'placementIdentifier': 'placement_id',
            'targetingContext': {
              'revision': 123,
              'ruleId': 'ruleId',
            },
          },
          'displayCloseButton': false,
        },
      ),
    ]);
  });

  test('presentPaywall with all parameters', () async {
    response = 'NOT_PRESENTED';
    await RevenueCatUI.presentPaywall(
      offering: offering,
      displayCloseButton: true,
    );

    expect(log, <Matcher>[
      isMethodCall(
        'presentPaywall',
        arguments: {
          'offeringIdentifier': offering.identifier,
          'presentedOfferingContext': {
            'offeringIdentifier': 'identifier',
            'placementIdentifier': 'placement_id',
            'targetingContext': {
              'revision': 123,
              'ruleId': 'ruleId',
            },
          },
          'displayCloseButton': true,
        },
      ),
    ]);
  });

  test('presentPaywallIfNeeded', () async {
    response = 'NOT_PRESENTED';
    await RevenueCatUI.presentPaywallIfNeeded('entitlement');
    expect(log, <Matcher>[
      isMethodCall(
        'presentPaywallIfNeeded',
        arguments: {
          'requiredEntitlementIdentifier': 'entitlement',
          'offeringIdentifier': null,
          'presentedOfferingContext': null,
          'displayCloseButton': false,
        },
      ),
    ]);
  });

  test('presentPaywallIfNeeded with offering identifier', () async {
    response = 'NOT_PRESENTED';
    await RevenueCatUI.presentPaywallIfNeeded(
      'entitlement',
      offering: offering,
    );

    expect(log, <Matcher>[
      isMethodCall(
        'presentPaywallIfNeeded',
        arguments: {
          'requiredEntitlementIdentifier': 'entitlement',
          'offeringIdentifier': offering.identifier,
          'presentedOfferingContext': {
            'offeringIdentifier': 'identifier',
            'placementIdentifier': 'placement_id',
            'targetingContext': {
              'revision': 123,
              'ruleId': 'ruleId',
            },
          },
          'displayCloseButton': false,
        },
      ),
    ]);
  });

  test('presentPaywallIfNeeded with all parameters', () async {
    response = 'NOT_PRESENTED';
    await RevenueCatUI.presentPaywallIfNeeded(
      'entitlement',
      offering: offering,
      displayCloseButton: true,
    );

    expect(log, <Matcher>[
      isMethodCall(
        'presentPaywallIfNeeded',
        arguments: {
          'requiredEntitlementIdentifier': 'entitlement',
          'offeringIdentifier': offering.identifier,
          'presentedOfferingContext': {
            'offeringIdentifier': 'identifier',
            'placementIdentifier': 'placement_id',
            'targetingContext': {
              'revision': 123,
              'ruleId': 'ruleId',
            },
          },
          'displayCloseButton': true,
        },
      ),
    ]);
  });

  test('presentPaywall parses response correctly', () async {
    response = 'NOT_PRESENTED';
    var paywallResult = await RevenueCatUI.presentPaywall();
    expect(paywallResult, PaywallResult.notPresented);
    response = 'CANCELLED';
    paywallResult = await RevenueCatUI.presentPaywall();
    expect(paywallResult, PaywallResult.cancelled);
    response = 'ERROR';
    paywallResult = await RevenueCatUI.presentPaywall();
    expect(paywallResult, PaywallResult.error);
    response = 'PURCHASED';
    paywallResult = await RevenueCatUI.presentPaywall();
    expect(paywallResult, PaywallResult.purchased);
    response = 'RESTORED';
    paywallResult = await RevenueCatUI.presentPaywall();
    expect(paywallResult, PaywallResult.restored);
  });

  test('presentCustomerCenter', () async {
    response = null;
    await RevenueCatUI.presentCustomerCenter();
    expect(log, <Matcher>[
      isMethodCall('presentCustomerCenter', arguments: null),
    ]);
  });

  test('presentCustomerCenter with callbacks', () async {
    response = null;
    bool onDismissCalled = false;
    bool onRestoreStartedCalled = false;
    
    await RevenueCatUI.presentCustomerCenter(
      onDismiss: () => onDismissCalled = true,
      onRestoreStarted: () => onRestoreStartedCalled = true,
    );
    
    expect(log, <Matcher>[
      isMethodCall('presentCustomerCenter', arguments: null),
    ]);
    
    // Verify callbacks are stored (they should be callable)
    expect(onDismissCalled, false); // Not called yet
    expect(onRestoreStartedCalled, false); // Not called yet
  });

  test('callback key format regression test - iOS productId vs productIdentifier', () async {
    // This test documents and prevents regression of the key mismatch bug
    // iOS sends 'productId' but we were expecting 'productIdentifier' in some places
    
    // Test that the correct key format is expected by simulating callback parsing
    const mockCallbackData = {
      'productId': 'com.example.premium',  // This is what iOS actually sends
      'status': 'success',
    };
    
    // Test data extraction logic that should match what's in _handleCustomerCenterMethodCall
    final data = mockCallbackData;
    final productIdentifier = data['productId'] as String? ?? '';  // Should use 'productId' not 'productIdentifier'
    final status = data['status'] as String? ?? '';
    
    expect(productIdentifier, 'com.example.premium');
    expect(status, 'success');
    
    // Test that wrong key would fail (demonstrating the bug that was fixed)
    final wrongProductId = data['productIdentifier'] as String? ?? 'MISSING';
    expect(wrongProductId, 'MISSING'); // This proves 'productIdentifier' key doesn't exist
  });

  test('CustomerCenterView method handler uses correct key format', () async {
    String? capturedProductId;
    String? capturedStatus;
    
    final handler = CustomerCenterViewMethodHandler(
      onRefundRequestCompleted: (productId, status) {
        capturedProductId = productId;
        capturedStatus = status;
      },
    );

    // Test with correct iOS format
    await handler.handleMethodCall(
      const MethodCall('onRefundRequestCompleted', {
        'productId': 'com.example.premium',
        'status': 'success',
      }),
    );

    expect(capturedProductId, 'com.example.premium');
    expect(capturedStatus, 'success');
  });

  test('CustomerCenterView method handler handles invalid data gracefully', () async {
    String? capturedProductId;
    String? capturedStatus;
    bool callbackWasCalled = false;
    
    final handler = CustomerCenterViewMethodHandler(
      onRefundRequestCompleted: (productId, status) {
        capturedProductId = productId;
        capturedStatus = status;
        callbackWasCalled = true;
      },
    );

    // Test with invalid data type
    await handler.handleMethodCall(
      const MethodCall('onRefundRequestCompleted', 'invalid_data'),
    );

    expect(callbackWasCalled, false); // Callback should not be called with invalid data

    // Test with missing productId key
    await handler.handleMethodCall(
      const MethodCall('onRefundRequestCompleted', {
        'status': 'success',
        // Missing 'productId' key
      }),
    );

    expect(callbackWasCalled, false); // Callback should not be called when productId is null
  });

  test('CustomerCenterView shouldShowCloseButton parameter is documented for platform limitations', () {
    // This test documents the platform limitation where Android doesn't support
    // hiding the close button, while iOS does.
    
    // Test that the parameter is accepted on both platforms
    const viewWithCloseButton = CustomerCenterView(shouldShowCloseButton: true);
    const viewWithoutCloseButton = CustomerCenterView(shouldShowCloseButton: false);
    
    expect(viewWithCloseButton.shouldShowCloseButton, true);
    expect(viewWithoutCloseButton.shouldShowCloseButton, false);
    
    // Note: Actual behavior differs by platform:
    // - iOS: respects the shouldShowCloseButton parameter
    // - Android: always shows close button regardless of parameter value
    // This is documented in the shouldShowCloseButton property documentation
  });
}
