import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _PromotionalOfferApiTest {
  void _checkFromJsonFactory(Map<String, dynamic> json) {
    PromotionalOffer offer = PromotionalOffer.fromJson(json);
  }

  void _checkToJson(PromotionalOffer offer) {
    Map<String, dynamic> json = offer.toJson();
  }

  void _checkConstructor(String identifier, String keyIdentifier, String nonce,
      String signature, int timestamp) {
    PromotionalOffer offer = PromotionalOffer(
        identifier, keyIdentifier, nonce, signature, timestamp);
  }

  void _checkProperties(PromotionalOffer offer) {
    String identifier = offer.identifier;
    String keyIdentifier = offer.keyIdentifier;
    String nonce = offer.nonce;
    String signature = offer.signature;
    int timestamp = offer.timestamp;
  }
}
