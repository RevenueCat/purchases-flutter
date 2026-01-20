import 'package:equatable/equatable.dart';

/// Represents a web purchase redemption
class WebPurchaseRedemption extends Equatable {
  /// The redemption link to be redeemed.
  final String redemptionLink;

  const WebPurchaseRedemption(
    this.redemptionLink,
  );

  factory WebPurchaseRedemption.fromJson(Map<String, dynamic> json) => WebPurchaseRedemption(
    json['redemptionLink'] as String,
  );

  @override
  List<Object> get props => [
    redemptionLink,
  ];
}
