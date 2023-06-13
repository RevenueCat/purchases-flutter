import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _PricingPhaseApiTest {
  void _checkFromJsonFactory(Map<String, dynamic> json) {
    PricingPhase pricingPhase = PricingPhase.fromJson(json);
  }

  void _checkToJson(PricingPhase pricingPhase) {
    Map<String, dynamic> json = pricingPhase.toJson();
  }

  void _checkConstructor(
    Period billingPeriod,
    RecurrenceMode? recurrenceMode,
    int? billingCycleCount,
    Price price,
    OfferPaymentMode? offerPaymentMode,
  ) {
    PricingPhase pricingPhase = PricingPhase(billingPeriod, recurrenceMode,
        billingCycleCount, price, offerPaymentMode);
  }

  void _checkProperties(PricingPhase pricingPhase) {
    Period? billingPeriod = pricingPhase.billingPeriod;
    RecurrenceMode? recurrenceMode = pricingPhase.recurrenceMode;
    int? billingCycleCount = pricingPhase.billingCycleCount;
    Price price = pricingPhase.price;
    OfferPaymentMode? offerPaymentMode = pricingPhase.offerPaymentMode;
  }
}
