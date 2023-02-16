import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_transaction.freezed.dart';
part 'store_transaction.g.dart';

@freezed

/// Represents a purchase transaction
class StoreTransaction with _$StoreTransaction {
  const factory StoreTransaction._create(
    /// RevenueCat Id associated to the transaction.
    @JsonKey(name: 'transactionIdentifier') String transactionIdentifier,

    /// Deprecated: Use transactionIdentifier instead.
    @Deprecated('Use transactionIdentifier instead.')
    @JsonKey(name: 'revenueCatId')
        String revenueCatIdentifier,

    /// Product Id associated with the transaction.
    @JsonKey(name: 'productIdentifier') String productIdentifier,

    /// Purchase date of the transaction in ISO 8601 format.
    @JsonKey(name: 'purchaseDate') String purchaseDate,
  ) = _StoreTransaction;

  /// Deprecated: Constructor has become private.
  factory StoreTransaction(
    /// Deprecated: Use transactionIdentifier instead.
    @Deprecated('Use transactionIdentifier instead.')
    @JsonKey(name: 'revenueCatId')
        String revenueCatIdentifier,

    /// Product Id associated with the transaction.
    @JsonKey(name: 'productIdentifier') String productIdentifier,

    /// Purchase date of the transaction in ISO 8601 format.
    @JsonKey(name: 'purchaseDate') String purchaseDate,
  ) =>
      StoreTransaction._create(
        revenueCatIdentifier,
        revenueCatIdentifier,
        productIdentifier,
        purchaseDate,
      );

  factory StoreTransaction.fromJson(Map<String, dynamic> json) =>
      _$StoreTransactionFromJson(json);
}
