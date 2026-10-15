import 'package:equatable/equatable.dart';

import 'customer_info_wrapper.dart';

/// Represents the successful result of a sync purchases operation.
class SyncPurchasesResult extends Equatable {
  /// The updated [CustomerInfo] after the purchases have been synced with
  /// RevenueCat's servers.
  final CustomerInfo customerInfo;

  const SyncPurchasesResult(this.customerInfo);

  @override
  List<Object> get props => [customerInfo];
}
