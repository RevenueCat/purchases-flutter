import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const productName = 'monthly_intro_pricing_one_week';
  const channel = MethodChannel('purchases_flutter');
  final log = <MethodCall>[];
  dynamic response;

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, (call) async {
      log.add(call);
      return response;
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
    log.clear();
    response = null;
  });

  test('checkTrialOrIntroductoryPriceEligibility returns eligibility map',
      () async {
    response = {
      productName: {'status': 0, 'description': 'Unknown status'},
    };
    final list = await Purchases.checkTrialOrIntroductoryPriceEligibility(
      [productName],
    );
    expect(list.length, 1);
  });

  test('introEligibilityStatusUnknown is returned', () async {
    response = {
      productName: {'status': 0, 'description': 'Unknown status'},
    };
    final list = await Purchases.checkTrialOrIntroductoryPriceEligibility(
      [productName],
    );
    expect(
      list[productName]?.status,
      IntroEligibilityStatus.introEligibilityStatusUnknown,
    );
  });

  test('introEligibilityStatusIneligible is returned', () async {
    response = {
      productName: {
        'status': 1,
        'description': 'Not eligible for trial or introductory price.',
      },
    };
    final list = await Purchases.checkTrialOrIntroductoryPriceEligibility(
      [productName],
    );
    expect(
      list[productName]?.status,
      IntroEligibilityStatus.introEligibilityStatusIneligible,
    );
  });

  test('introEligibilityStatusEligible is returned', () async {
    response = {
      productName: {
        'status': 2,
        'description': 'Eligible for trial or introductory price.',
      },
    };
    final list = await Purchases.checkTrialOrIntroductoryPriceEligibility(
      [productName],
    );
    expect(
      list[productName]?.status,
      IntroEligibilityStatus.introEligibilityStatusEligible,
    );
  });

  test('introEligibilityStatusNoIntroOfferExists is returned', () async {
    response = {
      productName: {
        'status': 3,
        'description': 'Product does not have trial or introductory price.',
      },
    };
    final list = await Purchases.checkTrialOrIntroductoryPriceEligibility(
      [productName],
    );
    expect(
      list[productName]?.status,
      IntroEligibilityStatus.introEligibilityStatusNoIntroOfferExists,
    );
  });
}
