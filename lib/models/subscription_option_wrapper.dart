import 'package:equatable/equatable.dart';

import 'installments_info.dart';
import 'period_wrapper.dart';
import 'presented_offering_context_wrapper.dart';
import 'pricing_phase_wrapper.dart';

class SubscriptionOption extends Equatable {
  final String id;
  final String storeProductId;
  final String productId;
  final List<PricingPhase> pricingPhases;
  final List<String> tags;
  final bool isBasePlan;
  final Period? billingPeriod;
  final bool isPrepaid;
  final PricingPhase? fullPricePhase;
  final PricingPhase? freePhase;
  final PricingPhase? introPhase;
  final PresentedOfferingContext? presentedOfferingContext;
  final InstallmentsInfo? installmentsInfo;

  const SubscriptionOption(
    this.id,
    this.storeProductId,
    this.productId,
    this.pricingPhases,
    this.tags,
    this.isBasePlan,
    this.billingPeriod,
    this.isPrepaid,
    this.fullPricePhase,
    this.freePhase,
    this.introPhase,
    this.presentedOfferingContext,
    this.installmentsInfo,
  );

  factory SubscriptionOption.fromJson(Map<String, dynamic> json) => SubscriptionOption(
    json['id'] as String,
    json['storeProductId'] as String,
    json['productId'] as String,
    (json['pricingPhases'] as List)
        .map((e) => PricingPhase.fromJson(Map<String, dynamic>.from(e)))
        .toList(),
    (json['tags'] as List).map((e) => e as String).toList(),
    json['isBasePlan'] as bool,
    json['billingPeriod'] != null ? Period.fromJson(Map<String, dynamic>.from(json['billingPeriod'])) : null,
    json['isPrepaid'] as bool,
    json['fullPricePhase'] != null ? PricingPhase.fromJson(Map<String, dynamic>.from(json['fullPricePhase'])) : null,
    json['freePhase'] != null ? PricingPhase.fromJson(Map<String, dynamic>.from(json['freePhase'])) : null,
    json['introPhase'] != null ? PricingPhase.fromJson(Map<String, dynamic>.from(json['introPhase'])) : null,
    json['presentedOfferingContext'] != null ? PresentedOfferingContext.fromJson(Map<String, dynamic>.from(json['presentedOfferingContext'])) : null,
    json['installmentsInfo'] != null ? InstallmentsInfo.fromJson(Map<String, dynamic>.from(json['installmentsInfo'])) : null,
  );

  @override
  List<Object?> get props => [
    id,
    storeProductId,
    productId,
    pricingPhases,
    tags,
    isBasePlan,
    billingPeriod,
    isPrepaid,
    fullPricePhase,
    freePhase,
    introPhase,
    presentedOfferingContext,
    installmentsInfo,
  ];
}

extension ExtendedSubscriptionOption on SubscriptionOption {
  /// Offering this package belongs to.
  /// Null if not using offerings or if fetched directly from store via getProducts
  @Deprecated('use presentedOfferingContext')
  String? get presentedOfferingIdentifier =>
      presentedOfferingContext?.offeringIdentifier;
}
