import 'package:equatable/equatable.dart';

import 'period_wrapper.dart';
import 'price_wrapper.dart';

class PricingPhase extends Equatable {
  /// Billing period for which the PricingPhase applies
  final Period? billingPeriod;

  /// Recurrence mode of the PricingPhase
  final RecurrenceMode? recurrenceMode;

  /// Number of cycles for which the pricing phase applies.
  /// Null for infiniteRecurring or finiteRecurring recurrence modes.
  final int? billingCycleCount;

  /// Price of the PricingPhase
  final Price price;

  /// Indicates how the pricing phase is charged for finiteRecurring pricing phases
  final OfferPaymentMode? offerPaymentMode;

  const PricingPhase(
    this.billingPeriod,
    this.recurrenceMode,
    this.billingCycleCount,
    this.price,
    this.offerPaymentMode,
  );

  factory PricingPhase.fromJson(Map<String, dynamic> json) => PricingPhase(
    json['billingPeriod'] != null ? Period.fromJson(Map<String, dynamic>.from(json['billingPeriod'])) : null,
    _recurrenceModeFromJson(json['recurrenceMode']),
    (json['billingCycleCount'] as num?)?.round(),
    Price.fromJson(Map<String, dynamic>.from(json['price'])),
    _offerPaymentModeFromJson(json['offerPaymentMode']),
  );

  @override
  List<Object?> get props => [
    billingPeriod,
    recurrenceMode,
    billingCycleCount,
    price,
    offerPaymentMode,
  ];
}

enum RecurrenceMode {
  infiniteRecurring,
  finiteRecurring,
  nonRecurring,
  unknown,
}

enum OfferPaymentMode {
  // Subscribers don't pay until the specified period ends
  freeTrial,

  // Subscribers pay up front for a specified period
  singlePayment,

  // Subscribers pay a discounted amount for a specified number of periods
  discountedRecurringPayment,
}

RecurrenceMode? _recurrenceModeFromJson(dynamic value) {
  switch (value) {
    case 1:
      return RecurrenceMode.infiniteRecurring;
    case 2:
      return RecurrenceMode.finiteRecurring;
    case 3:
      return RecurrenceMode.nonRecurring;
    case null:
      return null;
    default:
      return RecurrenceMode.unknown;
  }
}

OfferPaymentMode? _offerPaymentModeFromJson(dynamic value) {
  switch (value) {
    case 'FREE_TRIAL':
      return OfferPaymentMode.freeTrial;
    case 'SINGLE_PAYMENT':
      return OfferPaymentMode.singlePayment;
    case 'DISCOUNTED_RECURRING_PAYMENT':
      return OfferPaymentMode.discountedRecurringPayment;
    case null:
      return null;
    default:
      return null;
  }
}
