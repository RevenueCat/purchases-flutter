import 'package:equatable/equatable.dart';

/// The VirtualCurrency object represents information about a virtual
/// currency in the app. Use this object to access information about
/// a virtual currency, such as its current balance.
class VirtualCurrency extends Equatable {
  /// The virtual currency's balance.
  final int balance;

  /// The virtual currency's name.
  final String name;

  /// The virtual currency's code.
  final String code;

  /// The virtual currency's description defined in the RevenueCat dashboard.
  final String? serverDescription;

  const VirtualCurrency(
    this.balance,
    this.name,
    this.code,
    this.serverDescription,
  );

  factory VirtualCurrency.fromJson(Map<String, dynamic> json) =>
      VirtualCurrency(
        (json['balance'] as num).toInt(),
        json['name'] as String,
        json['code'] as String,
        json['serverDescription'] as String?,
      );

  @override
  List<Object?> get props => [
        balance,
        name,
        code,
        serverDescription,
      ];
}
