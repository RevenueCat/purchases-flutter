import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

/// Emits a message as if it came from the native SDKs.
/// Listeners are static, so these tests live in their own file to start
/// with no listeners registered by other tests.
void _performDartSideChannelMethodCall(String methodName, dynamic params) {
  final methodCall = MethodCall(methodName, params);
  ServicesBinding.instance.channelBuffers.push(
    'purchases_flutter',
    const StandardMethodCodec().encodeMethodCall(methodCall),
    (ByteData? data) {},
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('purchases_flutter');

  final mockCustomerInfoResponse = {
    'originalAppUserId': 'pepe',
    'entitlements': {'all': {}, 'active': {}, 'verification': 'NOT_REQUESTED'},
    'activeSubscriptions': [],
    'latestExpirationDate': '2021-04-09T14:48:00.000Z',
    'allExpirationDates': {},
    'allPurchasedProductIdentifiers': [],
    'firstSeen': '2021-01-09T14:48:00.000Z',
    'requestDate': '2021-04-09T14:48:00.000Z',
    'allPurchaseDates': {},
    'originalApplicationVersion': '1.2.3',
    'nonSubscriptionTransactions': [],
  };

  setUp(() async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async => null);
    // Makes sure the Purchases channel has registered its method call handler.
    await Purchases.setLogLevel(LogLevel.debug);
    // Native to Flutter calls must not go through a mocked MethodChannel.
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test(
      'CustomerInfo update notifies remaining listeners when a listener removes itself',
      () async {
    var selfRemovingListenerCallCount = 0;
    var otherListenerCallCount = 0;
    late CustomerInfoUpdateListener selfRemovingListener;
    selfRemovingListener = (customerInfo) {
      selfRemovingListenerCallCount++;
      Purchases.removeCustomerInfoUpdateListener(selfRemovingListener);
    };
    void otherListener(CustomerInfo customerInfo) {
      otherListenerCallCount++;
    }

    Purchases.addCustomerInfoUpdateListener(selfRemovingListener);
    Purchases.addCustomerInfoUpdateListener(otherListener);

    _performDartSideChannelMethodCall(
      'Purchases-CustomerInfoUpdated',
      mockCustomerInfoResponse,
    );
    await Future<void>.delayed(Duration.zero);
    _performDartSideChannelMethodCall(
      'Purchases-CustomerInfoUpdated',
      mockCustomerInfoResponse,
    );
    await Future<void>.delayed(Duration.zero);

    Purchases.removeCustomerInfoUpdateListener(otherListener);
    expect(selfRemovingListenerCallCount, 1);
    expect(otherListenerCallCount, 2);
  });

  test(
      'ReadyForPromotedProductPurchase notifies remaining listeners when a listener removes itself',
      () async {
    var selfRemovingListenerCallCount = 0;
    var otherListenerCallCount = 0;
    late ReadyForPromotedProductPurchaseListener selfRemovingListener;
    selfRemovingListener = (productIdentifier, startPurchase) {
      selfRemovingListenerCallCount++;
      Purchases.removeReadyForPromotedProductPurchaseListener(
        selfRemovingListener,
      );
    };
    void otherListener(
      String productIdentifier,
      Future<PromotedPurchaseResult> Function() startPurchase,
    ) {
      otherListenerCallCount++;
    }

    Purchases.addReadyForPromotedProductPurchaseListener(selfRemovingListener);
    Purchases.addReadyForPromotedProductPurchaseListener(otherListener);

    final promotedPurchaseArgs = {
      'callbackID': 1,
      'productID': 'product_id',
    };
    _performDartSideChannelMethodCall(
      'Purchases-ReadyForPromotedProductPurchase',
      promotedPurchaseArgs,
    );
    await Future<void>.delayed(Duration.zero);
    _performDartSideChannelMethodCall(
      'Purchases-ReadyForPromotedProductPurchase',
      promotedPurchaseArgs,
    );
    await Future<void>.delayed(Duration.zero);

    Purchases.removeReadyForPromotedProductPurchaseListener(otherListener);
    expect(selfRemovingListenerCallCount, 1);
    expect(otherListenerCallCount, 2);
  });
}
