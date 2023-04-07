import 'package:json_annotation/json_annotation.dart';

/// Supported SKU types.
enum PurchaseType {
  /// A type of SKU for in-app products.
  @JsonValue('NON_SUBSCRIPTION')
  inapp,

  /// A type of SKU for subscriptions.
  @JsonValue('SUBSCRIPTION')
  subs
}
