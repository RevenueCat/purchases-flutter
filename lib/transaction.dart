class Transaction {
  /// RevenueCat Id associated to the transaction.
  final String revenuecatId;

  /// Product Id associated with the transaction.
  final String productId;

  /// Purchase date of the transaction in ISO 8601 format.
  final String purchaseDate;

  Transaction.fromJson(Map<dynamic, dynamic> map)
      : revenuecatId = map["revenuecatId"],
        productId = map["productId"],
        purchaseDate = map["purchaseDate"];

  @override
  String toString() {
    return 'Transaction{'
        'revenuecatId: $revenuecatId, '
        'productId: $productId, '
        'purchaseDate: $purchaseDate'
        '}';
  }
}
