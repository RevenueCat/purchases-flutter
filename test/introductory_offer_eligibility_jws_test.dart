import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('purchases_flutter');
  final calls = <MethodCall>[];
  const token = 'header.deny-intro.signature';
  const product = StoreProduct(
    'product',
    'description',
    'title',
    1,
    '\$1',
    'USD',
  );
  const package = Package(
    'monthly',
    PackageType.monthly,
    product,
    PresentedOfferingContext('offering', 'placement', null),
  );
  final result = {
    'productIdentifier': 'product',
    'customerInfo': {
      'originalAppUserId': 'user',
      'entitlements': {
        'all': {},
        'active': {},
        'verification': 'NOT_REQUESTED',
      },
      'activeSubscriptions': [],
      'allExpirationDates': {},
      'allPurchasedProductIdentifiers': [],
      'allPurchaseDates': {},
      'firstSeen': '2021-01-01T00:00:00Z',
      'requestDate': '2021-01-01T00:00:00Z',
      'nonSubscriptionTransactions': [],
    },
    'transaction': {
      'transactionIdentifier': 'transaction',
      'productIdentifier': 'product',
      'purchaseDate': '2021-01-01T00:00:00Z',
    },
  };
  setUp(() {
    calls.clear();
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          calls.add(call);
          return result;
        });
  });
  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });
  for (final isPackage in [false, true]) {
    PurchaseParams params(String? jws) => isPackage
        ? PurchaseParams.package(package, introductoryOfferEligibilityJWS: jws)
        : PurchaseParams.storeProduct(
            product,
            introductoryOfferEligibilityJWS: jws,
          );
    test(
      'forwards exact token for ${isPackage ? "package" : "product"}',
      () async {
        for (final platform in [TargetPlatform.iOS, TargetPlatform.macOS]) {
          debugDefaultTargetPlatformOverride = platform;
          await Purchases.purchase(params(token));
          expect(
            calls.last.method,
            'purchaseWithIntroductoryOfferEligibilityJWS',
          );
          expect(
            calls.last.arguments['introductoryOfferEligibilityJWS'],
            token,
          );
          expect(
            calls.last.arguments[isPackage
                ? 'packageIdentifier'
                : 'productIdentifier'],
            isPackage ? 'monthly' : 'product',
          );
          if (isPackage)
            expect(
              calls
                  .last
                  .arguments['presentedOfferingContext']['placementIdentifier'],
              'placement',
            );
        }
      },
      skip: kIsWeb,
    );
    test(
      'null preserves legacy ${isPackage ? "package" : "product"} path',
      () async {
        await Purchases.purchase(params(null));
        expect(
          calls.single.method,
          isPackage ? 'purchasePackage' : 'purchaseProduct',
        );
        expect(
          calls.single.arguments.containsKey('introductoryOfferEligibilityJWS'),
          isFalse,
        );
      },
      skip: kIsWeb,
    );
    test('rejects empty token before purchase ($isPackage)', () async {
      await expectLater(Purchases.purchase(params('')), throwsArgumentError);
      expect(calls, isEmpty);
    });
    test('rejects unsupported platform before purchase ($isPackage)', () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      await expectLater(
        Purchases.purchase(params(token)),
        throwsA(isA<UnsupportedPlatformException>()),
      );
      expect(calls, isEmpty);
    });
    test('preserves native rejection without retry ($isPackage)', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (call) async {
            calls.add(call);
            throw PlatformException(code: '23', message: 'unsupported');
          });
      await expectLater(
        Purchases.purchase(params(token)),
        throwsA(isA<PlatformException>()),
      );
      expect(
        calls.single.method,
        'purchaseWithIntroductoryOfferEligibilityJWS',
      );
    }, skip: kIsWeb);
    test('rejects token on web even with Apple target ($isPackage)', () async {
      await expectLater(
        Purchases.purchase(params(token)),
        throwsA(isA<UnsupportedPlatformException>()),
      );
      expect(calls, isEmpty);
    }, skip: !kIsWeb);
  }
  test('rejects other offers instead of losing token', () async {
    await expectLater(
      Purchases.purchase(
        const PurchaseParams.package(
          package,
          introductoryOfferEligibilityJWS: token,
          promotionalOffer: PromotionalOffer(
            'offer',
            'key',
            'nonce',
            'signature',
            123,
          ),
        ),
      ),
      throwsArgumentError,
    );
    expect(calls, isEmpty);
  }, skip: kIsWeb);
}
