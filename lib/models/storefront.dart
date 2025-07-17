import 'package:equatable/equatable.dart';

/// Contains the information about the current store account.
class Storefront extends Equatable {
  /// Country code of the current store account.
  final String countryCode;

  const Storefront({
    required this.countryCode,
  });

  factory Storefront.fromJson(Map<String, dynamic> json) => Storefront(
    countryCode: json['countryCode'] as String,
  );

  @override
  List<Object> get props => [
    countryCode,
  ];
}
