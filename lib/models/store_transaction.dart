import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_transaction.freezed.dart';
part 'store_transaction.g.dart';

@freezed

/// Represents a purchase transaction
class StoreTransaction with _$StoreTransaction {
  const factory StoreTransaction(
    /// RevenueCat Id associated to the transaction.
    @JsonKey(name: 'revenueCatId') String revenueCatIdentifier,

    /// Product Id associated with the transaction.
    @JsonKey(name: 'productId') String productIdentifier,

    /// Purchase date of the transaction in ISO 8601 format.
    @JsonKey(name: 'purchaseDate') String purchaseDate,
  ) = _StoreTransaction;

  factory StoreTransaction.fromJson(Map<String, dynamic> json) =>
      _$StoreTransactionFromJson(json);
}
