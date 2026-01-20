/// Supported [StoreProduct] types.
enum ProductCategory {
  /// A type of [StoreProduct] for in-app products.
  nonSubscription,

  /// A type of [StoreProduct] for subscriptions.
  subscription
}

/// Supported SKU types.
@Deprecated('Use ProductType')
enum PurchaseType {
  /// A type of SKU for in-app products.
  inapp,

  /// A type of SKU for subscriptions.
  subs
}
