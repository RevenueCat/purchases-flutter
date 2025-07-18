import 'package:equatable/equatable.dart';

import 'customer_info_wrapper.dart';
import 'store_transaction.dart';

/// Represents the successful result of a purchase operation.
class PurchaseResult extends Equatable {
  /// The updated [CustomerInfo] after the purchase has been synced with
  /// RevenueCat's servers.
  final CustomerInfo customerInfo;
  /// The [StoreTransaction] for this purchase.
  final StoreTransaction storeTransaction;

  const PurchaseResult(
    this.customerInfo,
    this.storeTransaction,
  );

  factory PurchaseResult.fromJson(Map<String, dynamic> json) => PurchaseResult(
    CustomerInfo.fromJson(Map<String, dynamic>.from(json['customerInfo'])),
    StoreTransaction.fromJson(Map<String, dynamic>.from(json['transaction'])),
  );

  @override
  List<Object> get props => [
    customerInfo,
    storeTransaction,
  ];
}
