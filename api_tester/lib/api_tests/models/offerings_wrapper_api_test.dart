import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _OfferingsApiTest {
  void _checkFromJsonFactory(Map<String, dynamic> json) {
    Offerings offerings = Offerings.fromJson(json);
  }

  void _checkToJson(Offerings offerings) {
    Map<String, dynamic> json = offerings.toJson();
  }

  void _checkConstructor(Map<String, Offering> all, Offering? current) {
    Offerings offerings = Offerings(all);
    offerings = Offerings(all, current: current);
  }

  void _checkProperties(Offerings offerings) {
    Map<String, Offering> all = offerings.all;
    Offering? current = offerings.current;
  }

  void _checkGetOffering(Offerings offerings) {
    String offeringId = "fakeOfferingId";
    Offering? offering = offerings.getOffering(offeringId);
  }
}
