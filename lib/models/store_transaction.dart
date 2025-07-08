import 'package:equatable/equatable.dart';

class StoreTransaction extends Equatable {
  final String transactionIdentifier;
  final String productIdentifier;
  final String purchaseDate;

  const StoreTransaction(
    this.transactionIdentifier,
    this.productIdentifier,
    this.purchaseDate,
  );

  factory StoreTransaction.fromJson(Map<String, dynamic> json) =>
      StoreTransaction(
        json['transactionIdentifier'] as String? ?? '',
        json['productIdentifier'] as String,
        json['purchaseDate'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'transactionIdentifier': transactionIdentifier,
        'productIdentifier': productIdentifier,
        'purchaseDate': purchaseDate,
      };

  @override
  List<Object> get props => [
        transactionIdentifier,
        productIdentifier,
        purchaseDate,
      ];
}
