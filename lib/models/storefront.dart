/// Contains the information about the current store account.
class Storefront {
  /// Country code of the current store account.
  String countryCode;

  Storefront({
    required this.countryCode,
  });

  factory Storefront.fromJson(Map<String, dynamic> json) => Storefront(
    countryCode: json['countryCode'] as String,
  );
}
