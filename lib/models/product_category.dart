import 'package:json_annotation/json_annotation.dart';

/// Supported [StoreProduct] types.
enum ProductCategory {
  /// A type of [StoreProduct] for in-app products.
  @JsonValue('NON_SUBSCRIPTION')
  nonSubscription,

  /// A type of [StoreProduct] for subscriptions.
  @JsonValue('SUBSCRIPTION')
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
