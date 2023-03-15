import 'dart:html';

import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _SubscriptionOptionApiTest {
  void _checkFromJsonFactory(Map<String, dynamic> json) {
    SubscriptionOption product = SubscriptionOption.fromJson(json);
  }

  void _checkToJson(SubscriptionOption subscriptionOption) {
    Map<String, dynamic> json = subscriptionOption.toJson();
  }

  void _checkConstructor(
      String id,
      String storeProductId,
      String productId,
      List<PricingPhase> pricingPhases,
      List<String> tags,
      bool isBasePlan,
      Period? billingPeriod,
      PricingPhase? fullPricePhase,
      PricingPhase? freePhase,
      PricingPhase? introPhase) {
    SubscriptionOption subscriptionOption = SubscriptionOption(
        id,
        storeProductId,
        productId,
        pricingPhases,
        tags,
        isBasePlan,
        billingPeriod,
        fullPricePhase,
        freePhase,
        introPhase);
  }

  void _checkProperties(SubscriptionOption subscriptionOption) {
    String id = subscriptionOption.id;
    String storeProductId = subscriptionOption.storeProductId;
    String productId = subscriptionOption.productId;
    List<PricingPhase> pricingPhases = subscriptionOption.pricingPhases;
    List<String> tags = subscriptionOption.tags;
    bool isBasePlan = subscriptionOption.isBasePlan;
    Period? billingPeriod = subscriptionOption.billingPeriod;
    PricingPhase? fullPricePhase = subscriptionOption.fullPricePhase;
    PricingPhase? freePhase = subscriptionOption.freePhase;
    PricingPhase? introPhase = subscriptionOption.introPhase;
  }
}
