import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_transaction.freezed.dart';
part 'store_transaction.g.dart';

// ignore_for_file: deprecated_member_use_from_same_package
@freezed

/// Represents a purchase transaction
class StoreTransaction with _$StoreTransaction {
  /// Experimental. This factory method is subject to changes without
  /// a major release.
  const factory StoreTransaction.create(
    /// RevenueCat Id associated to the transaction. Empty for Amazon.
    // ignore: invalid_annotation_target
    @JsonKey(readValue: _readTransactionIdentifier)
    String transactionIdentifier,

    /// Deprecated: Use transactionIdentifier instead. Empty for Amazon.
    @Deprecated('Use transactionIdentifier instead.')
    // ignore: invalid_annotation_target
    @JsonKey(readValue: _readTransactionIdentifier)
        String revenueCatIdentifier,

    /// Product Id associated with the transaction.
    String productIdentifier,

    /// Purchase date of the transaction in ISO 8601 format.
    String purchaseDate,
  ) = _StoreTransaction;

  @Deprecated('Constructor has become experimental. Keeping old constructor '
      'for backwards compatibility.')
  factory StoreTransaction(
    /// Deprecated: Use transactionIdentifier instead.
    @Deprecated('Use transactionIdentifier instead.')
        String revenueCatIdentifier,

    /// Product Id associated with the transaction.
    String productIdentifier,

    /// Purchase date of the transaction in ISO 8601 format.
    String purchaseDate,
  ) =>
      StoreTransaction.create(
        revenueCatIdentifier,
        revenueCatIdentifier,
        productIdentifier,
        purchaseDate,
      );

  factory StoreTransaction.fromJson(Map<String, dynamic> json) =>
      _$StoreTransactionFromJson(json);
}

// reads json or defaults to '' if not there (Amazon)
Object _readTransactionIdentifier(Map json, String key) =>
    json['transactionIdentifier'] ?? '';
