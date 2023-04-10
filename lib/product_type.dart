import 'package:json_annotation/json_annotation.dart';

/// Supported [StoreProduct] types.
enum ProductType {
  /// A type of [StoreProduct] for in-app products.
  @JsonValue('NON_SUBSCRIPTION')
  inapp,

  /// A type of [StoreProduct] for subscriptions.
  @JsonValue('SUBSCRIPTION')
  subs
}

/// Supported SKU types.
@Deprecated('Use ProductType')
enum PurchaseType {
  /// A type of SKU for in-app products.
  inapp,

  /// A type of SKU for subscriptions.
  subs
}
