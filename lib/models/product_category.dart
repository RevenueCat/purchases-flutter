/// Supported [StoreProduct] types.
enum ProductCategory {
  /// A type of [StoreProduct] for in-app products.
  nonSubscription,

  /// A type of [StoreProduct] for subscriptions.
  subscription,
  ;

  static ProductCategory? fromJson(dynamic value) {
    switch (value) {
      case 'NON_SUBSCRIPTION':
        return ProductCategory.nonSubscription;
      case 'SUBSCRIPTION':
        return ProductCategory.subscription;
      default:
        return null;
    }
  }

  String toJson() {
    switch (this) {
      case ProductCategory.nonSubscription:
        return 'NON_SUBSCRIPTION';
      case ProductCategory.subscription:
        return 'SUBSCRIPTION';
    }
  }
}

/// Supported SKU types.
@Deprecated('Use ProductType')
enum PurchaseType {
  /// A type of SKU for in-app products.
  inapp,

  /// A type of SKU for subscriptions.
  subs
}
