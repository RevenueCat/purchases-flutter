import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/offering_wrapper.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';
import 'package:purchases_flutter/models/presented_offering_context_wrapper.dart';
import 'package:purchases_flutter/models/presented_offering_targeting_context_wrapper.dart';
import 'package:purchases_flutter/models/store_product_wrapper.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

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
      )
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
}
