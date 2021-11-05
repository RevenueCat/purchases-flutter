/// The signed discount applied to a payment
class PaymentDiscount {
  /// Identifier agreed upon with the App Store for a discount of your choosing.
  final String identifier;

  /// The identifier of the public/private key pair agreed upon with the
  /// App Store when the keys were generated.
  final String keyIdentifier;

  /// One-time use random entropy-adding value for security.
  final String nonce;

  /// The cryptographic signature generated by your private key.
  final String signature;

  /// Timestamp of when the signature is created.
  final int timestamp;

  // ignore: public_member_api_docs
  PaymentDiscount(
    this.identifier,
    this.keyIdentifier,
    this.nonce,
    this.signature,
    this.timestamp,
  );

  // ignore: public_member_api_docs
  PaymentDiscount.fromJson(Map<String, dynamic> json)
      : identifier = json['identifier'],
        keyIdentifier = json['keyIdentifier'],
        nonce = json['nonce'],
        signature = json['signature'],
        timestamp = json['timestamp'];

  @override
  String toString() => 'PaymentDiscount{'
      'identifier: $identifier, '
      'keyIdentifier: $keyIdentifier, '
      'nonce: $nonce, '
      'signature: $signature, '
      'timestamp: $timestamp}';
}
