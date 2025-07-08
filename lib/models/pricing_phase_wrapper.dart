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
        json['billingPeriod'] != null
            ? Period.fromJson(Map<String, dynamic>.from(json['billingPeriod']))
            : null,
        RecurrenceMode.fromJson(json['recurrenceMode']),
        json['billingCycleCount'] as int?,
        Price.fromJson(Map<String, dynamic>.from(json['price'])),
        OfferPaymentMode.fromJson(json['offerPaymentMode']),
      );

  Map<String, dynamic> toJson() => {
        'billingPeriod': billingPeriod?.toJson(),
        'recurrenceMode': recurrenceMode?.toJson(),
        'billingCycleCount': billingCycleCount,
        'price': price.toJson(),
        'offerPaymentMode': offerPaymentMode?.toJson(),
      };

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
  ;

  static RecurrenceMode? fromJson(dynamic value) {
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

  dynamic toJson() {
    switch (this) {
      case RecurrenceMode.infiniteRecurring:
        return 1;
      case RecurrenceMode.finiteRecurring:
        return 2;
      case RecurrenceMode.nonRecurring:
        return 3;
      case RecurrenceMode.unknown:
        return null;
    }
  }
}

enum OfferPaymentMode {
  // Subscribers don't pay until the specified period ends
  freeTrial,

  // Subscribers pay up front for a specified period
  singlePayment,

  // Subscribers pay a discounted amount for a specified number of periods
  discountedRecurringPayment,
  ;

  static OfferPaymentMode? fromJson(dynamic value) {
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

  String toJson() {
    switch (this) {
      case OfferPaymentMode.freeTrial:
        return 'FREE_TRIAL';
      case OfferPaymentMode.singlePayment:
        return 'SINGLE_PAYMENT';
      case OfferPaymentMode.discountedRecurringPayment:
        return 'DISCOUNTED_RECURRING_PAYMENT';
    }
  }
}
