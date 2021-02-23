/// Represents a purchase transaction
class Transaction {
  /// RevenueCat Id associated to the transaction.
  final String revenueCatId;

  /// Product Id associated with the transaction.
  final String productId;

  /// Purchase date of the transaction in ISO 8601 format.
  final String purchaseDate;

  /// Constructs an Transaction from a JSON object
  Transaction.fromJson(Map<dynamic, dynamic> map)
      : revenueCatId = map["revenueCatId"],
        productId = map["productId"],
        purchaseDate = map["purchaseDate"];

  @override
  String toString() {
    return 'Transaction{'
        'revenueCatId: $revenueCatId, '
        'productId: $productId, '
        'purchaseDate: $purchaseDate'
        '}';
  }
}
