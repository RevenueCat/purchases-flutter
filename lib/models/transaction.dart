import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

@freezed

/// Represents a purchase transaction
class Transaction with _$Transaction {
  const factory Transaction(
    /// RevenueCat Id associated to the transaction.
    @JsonKey(name: 'revenueCatId') String revenueCatId,

    /// Product Id associated with the transaction.
    @JsonKey(name: 'productId') String productId,

    /// Purchase date of the transaction in ISO 8601 format.
    @JsonKey(name: 'purchaseDate') String purchaseDate,
  ) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
}
