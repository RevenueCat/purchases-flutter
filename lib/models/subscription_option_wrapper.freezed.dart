// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_option_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubscriptionOption {
  /// Identifier of the subscription option
  /// If this SubscriptionOption represents a base plan, this will be the basePlanId.
  /// If it represents an offer, it will be {basePlanId}:{offerId}
  String get id;

  /// Identifier of the StoreProduct associated with this SubscriptionOption
  /// This will be {subId}:{basePlanId}
  String get storeProductId;

  /// Identifer of the subscription associated with this SubsriptionOption
  /// This will be {subId}
  String get productId;

  /// Pricing phases defining a user's payment plan for the product over time.
  List<PricingPhase> get pricingPhases;

  /// Tags defined on the base plan or offer.
  List<String> get tags;

  /// True if this SubscriptionOption represents a Google subscription base plan (rather than an offer).
  bool get isBasePlan;

  /// The subscription period of fullPricePhase (after free and intro trials).
  Period? get billingPeriod;

  /// True if the subscription is pre-paid.
  bool get isPrepaid;

  /// The full price PricingPhase of the subscription.
  /// Looks for the last price phase of the SubscriptionOption.
  PricingPhase? get fullPricePhase;

  /// The free trial PricingPhase of the subscription.
  /// Looks for the first pricing phase of the SubscriptionOption where amountMicros is 0.
  /// There can be a freeTrialPhase and an introductoryPhase in the same SubscriptionOption.
  PricingPhase? get freePhase;

  /// The intro trial PricingPhase of the subscription.
  /// Looks for the first pricing phase of the SubscriptionOption where amountMicros is greater than 0.
  /// There can be a freeTrialPhase and an introductoryPhase in the same SubscriptionOption.
  PricingPhase? get introPhase;

  /// Offering context this package belongs to.
  /// Null if not using offerings or if fetched directly from store via getProducts
  PresentedOfferingContext? get presentedOfferingContext;

  /// For installment subscriptions, the details of the installment plan the customer commits to.
  /// Null for non-installment subscriptions.
  /// Installment plans are only available for Google Play subscriptions.
  InstallmentsInfo? get installmentsInfo;

  /// Create a copy of SubscriptionOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SubscriptionOptionCopyWith<SubscriptionOption> get copyWith =>
      _$SubscriptionOptionCopyWithImpl<SubscriptionOption>(
          this as SubscriptionOption, _$identity);

  /// Serializes this SubscriptionOption to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SubscriptionOption &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.storeProductId, storeProductId) ||
                other.storeProductId == storeProductId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            const DeepCollectionEquality()
                .equals(other.pricingPhases, pricingPhases) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            (identical(other.isBasePlan, isBasePlan) ||
                other.isBasePlan == isBasePlan) &&
            (identical(other.billingPeriod, billingPeriod) ||
                other.billingPeriod == billingPeriod) &&
            (identical(other.isPrepaid, isPrepaid) ||
                other.isPrepaid == isPrepaid) &&
            (identical(other.fullPricePhase, fullPricePhase) ||
                other.fullPricePhase == fullPricePhase) &&
            (identical(other.freePhase, freePhase) ||
                other.freePhase == freePhase) &&
            (identical(other.introPhase, introPhase) ||
                other.introPhase == introPhase) &&
            (identical(
                    other.presentedOfferingContext, presentedOfferingContext) ||
                other.presentedOfferingContext == presentedOfferingContext) &&
            (identical(other.installmentsInfo, installmentsInfo) ||
                other.installmentsInfo == installmentsInfo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      storeProductId,
      productId,
      const DeepCollectionEquality().hash(pricingPhases),
      const DeepCollectionEquality().hash(tags),
      isBasePlan,
      billingPeriod,
      isPrepaid,
      fullPricePhase,
      freePhase,
      introPhase,
      presentedOfferingContext,
      installmentsInfo);

  @override
  String toString() {
    return 'SubscriptionOption(id: $id, storeProductId: $storeProductId, productId: $productId, pricingPhases: $pricingPhases, tags: $tags, isBasePlan: $isBasePlan, billingPeriod: $billingPeriod, isPrepaid: $isPrepaid, fullPricePhase: $fullPricePhase, freePhase: $freePhase, introPhase: $introPhase, presentedOfferingContext: $presentedOfferingContext, installmentsInfo: $installmentsInfo)';
  }
}

/// @nodoc
abstract mixin class $SubscriptionOptionCopyWith<$Res> {
  factory $SubscriptionOptionCopyWith(
          SubscriptionOption value, $Res Function(SubscriptionOption) _then) =
      _$SubscriptionOptionCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String storeProductId,
      String productId,
      List<PricingPhase> pricingPhases,
      List<String> tags,
      bool isBasePlan,
      Period? billingPeriod,
      bool isPrepaid,
      PricingPhase? fullPricePhase,
      PricingPhase? freePhase,
      PricingPhase? introPhase,
      PresentedOfferingContext? presentedOfferingContext,
      InstallmentsInfo? installmentsInfo});

  $PeriodCopyWith<$Res>? get billingPeriod;
  $PricingPhaseCopyWith<$Res>? get fullPricePhase;
  $PricingPhaseCopyWith<$Res>? get freePhase;
  $PricingPhaseCopyWith<$Res>? get introPhase;
  $PresentedOfferingContextCopyWith<$Res>? get presentedOfferingContext;
  $InstallmentsInfoCopyWith<$Res>? get installmentsInfo;
}

/// @nodoc
class _$SubscriptionOptionCopyWithImpl<$Res>
    implements $SubscriptionOptionCopyWith<$Res> {
  _$SubscriptionOptionCopyWithImpl(this._self, this._then);

  final SubscriptionOption _self;
  final $Res Function(SubscriptionOption) _then;

  /// Create a copy of SubscriptionOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storeProductId = null,
    Object? productId = null,
    Object? pricingPhases = null,
    Object? tags = null,
    Object? isBasePlan = null,
    Object? billingPeriod = freezed,
    Object? isPrepaid = null,
    Object? fullPricePhase = freezed,
    Object? freePhase = freezed,
    Object? introPhase = freezed,
    Object? presentedOfferingContext = freezed,
    Object? installmentsInfo = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      storeProductId: null == storeProductId
          ? _self.storeProductId
          : storeProductId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _self.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      pricingPhases: null == pricingPhases
          ? _self.pricingPhases
          : pricingPhases // ignore: cast_nullable_to_non_nullable
              as List<PricingPhase>,
      tags: null == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isBasePlan: null == isBasePlan
          ? _self.isBasePlan
          : isBasePlan // ignore: cast_nullable_to_non_nullable
              as bool,
      billingPeriod: freezed == billingPeriod
          ? _self.billingPeriod
          : billingPeriod // ignore: cast_nullable_to_non_nullable
              as Period?,
      isPrepaid: null == isPrepaid
          ? _self.isPrepaid
          : isPrepaid // ignore: cast_nullable_to_non_nullable
              as bool,
      fullPricePhase: freezed == fullPricePhase
          ? _self.fullPricePhase
          : fullPricePhase // ignore: cast_nullable_to_non_nullable
              as PricingPhase?,
      freePhase: freezed == freePhase
          ? _self.freePhase
          : freePhase // ignore: cast_nullable_to_non_nullable
              as PricingPhase?,
      introPhase: freezed == introPhase
          ? _self.introPhase
          : introPhase // ignore: cast_nullable_to_non_nullable
              as PricingPhase?,
      presentedOfferingContext: freezed == presentedOfferingContext
          ? _self.presentedOfferingContext
          : presentedOfferingContext // ignore: cast_nullable_to_non_nullable
              as PresentedOfferingContext?,
      installmentsInfo: freezed == installmentsInfo
          ? _self.installmentsInfo
          : installmentsInfo // ignore: cast_nullable_to_non_nullable
              as InstallmentsInfo?,
    ));
  }

  /// Create a copy of SubscriptionOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PeriodCopyWith<$Res>? get billingPeriod {
    if (_self.billingPeriod == null) {
      return null;
    }

    return $PeriodCopyWith<$Res>(_self.billingPeriod!, (value) {
      return _then(_self.copyWith(billingPeriod: value));
    });
  }

  /// Create a copy of SubscriptionOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PricingPhaseCopyWith<$Res>? get fullPricePhase {
    if (_self.fullPricePhase == null) {
      return null;
    }

    return $PricingPhaseCopyWith<$Res>(_self.fullPricePhase!, (value) {
      return _then(_self.copyWith(fullPricePhase: value));
    });
  }

  /// Create a copy of SubscriptionOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PricingPhaseCopyWith<$Res>? get freePhase {
    if (_self.freePhase == null) {
      return null;
    }

    return $PricingPhaseCopyWith<$Res>(_self.freePhase!, (value) {
      return _then(_self.copyWith(freePhase: value));
    });
  }

  /// Create a copy of SubscriptionOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PricingPhaseCopyWith<$Res>? get introPhase {
    if (_self.introPhase == null) {
      return null;
    }

    return $PricingPhaseCopyWith<$Res>(_self.introPhase!, (value) {
      return _then(_self.copyWith(introPhase: value));
    });
  }

  /// Create a copy of SubscriptionOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PresentedOfferingContextCopyWith<$Res>? get presentedOfferingContext {
    if (_self.presentedOfferingContext == null) {
      return null;
    }

    return $PresentedOfferingContextCopyWith<$Res>(
        _self.presentedOfferingContext!, (value) {
      return _then(_self.copyWith(presentedOfferingContext: value));
    });
  }

  /// Create a copy of SubscriptionOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InstallmentsInfoCopyWith<$Res>? get installmentsInfo {
    if (_self.installmentsInfo == null) {
      return null;
    }

    return $InstallmentsInfoCopyWith<$Res>(_self.installmentsInfo!, (value) {
      return _then(_self.copyWith(installmentsInfo: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _SubscriptionOption implements SubscriptionOption {
  const _SubscriptionOption(
      this.id,
      this.storeProductId,
      this.productId,
      final List<PricingPhase> pricingPhases,
      final List<String> tags,
      this.isBasePlan,
      this.billingPeriod,
      this.isPrepaid,
      this.fullPricePhase,
      this.freePhase,
      this.introPhase,
      this.presentedOfferingContext,
      this.installmentsInfo)
      : _pricingPhases = pricingPhases,
        _tags = tags;
  factory _SubscriptionOption.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionOptionFromJson(json);

  /// Identifier of the subscription option
  /// If this SubscriptionOption represents a base plan, this will be the basePlanId.
  /// If it represents an offer, it will be {basePlanId}:{offerId}
  @override
  final String id;

  /// Identifier of the StoreProduct associated with this SubscriptionOption
  /// This will be {subId}:{basePlanId}
  @override
  final String storeProductId;

  /// Identifer of the subscription associated with this SubsriptionOption
  /// This will be {subId}
  @override
  final String productId;

  /// Pricing phases defining a user's payment plan for the product over time.
  final List<PricingPhase> _pricingPhases;

  /// Pricing phases defining a user's payment plan for the product over time.
  @override
  List<PricingPhase> get pricingPhases {
    if (_pricingPhases is EqualUnmodifiableListView) return _pricingPhases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pricingPhases);
  }

  /// Tags defined on the base plan or offer.
  final List<String> _tags;

  /// Tags defined on the base plan or offer.
  @override
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  /// True if this SubscriptionOption represents a Google subscription base plan (rather than an offer).
  @override
  final bool isBasePlan;

  /// The subscription period of fullPricePhase (after free and intro trials).
  @override
  final Period? billingPeriod;

  /// True if the subscription is pre-paid.
  @override
  final bool isPrepaid;

  /// The full price PricingPhase of the subscription.
  /// Looks for the last price phase of the SubscriptionOption.
  @override
  final PricingPhase? fullPricePhase;

  /// The free trial PricingPhase of the subscription.
  /// Looks for the first pricing phase of the SubscriptionOption where amountMicros is 0.
  /// There can be a freeTrialPhase and an introductoryPhase in the same SubscriptionOption.
  @override
  final PricingPhase? freePhase;

  /// The intro trial PricingPhase of the subscription.
  /// Looks for the first pricing phase of the SubscriptionOption where amountMicros is greater than 0.
  /// There can be a freeTrialPhase and an introductoryPhase in the same SubscriptionOption.
  @override
  final PricingPhase? introPhase;

  /// Offering context this package belongs to.
  /// Null if not using offerings or if fetched directly from store via getProducts
  @override
  final PresentedOfferingContext? presentedOfferingContext;

  /// For installment subscriptions, the details of the installment plan the customer commits to.
  /// Null for non-installment subscriptions.
  /// Installment plans are only available for Google Play subscriptions.
  @override
  final InstallmentsInfo? installmentsInfo;

  /// Create a copy of SubscriptionOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SubscriptionOptionCopyWith<_SubscriptionOption> get copyWith =>
      __$SubscriptionOptionCopyWithImpl<_SubscriptionOption>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SubscriptionOptionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SubscriptionOption &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.storeProductId, storeProductId) ||
                other.storeProductId == storeProductId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            const DeepCollectionEquality()
                .equals(other._pricingPhases, _pricingPhases) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.isBasePlan, isBasePlan) ||
                other.isBasePlan == isBasePlan) &&
            (identical(other.billingPeriod, billingPeriod) ||
                other.billingPeriod == billingPeriod) &&
            (identical(other.isPrepaid, isPrepaid) ||
                other.isPrepaid == isPrepaid) &&
            (identical(other.fullPricePhase, fullPricePhase) ||
                other.fullPricePhase == fullPricePhase) &&
            (identical(other.freePhase, freePhase) ||
                other.freePhase == freePhase) &&
            (identical(other.introPhase, introPhase) ||
                other.introPhase == introPhase) &&
            (identical(
                    other.presentedOfferingContext, presentedOfferingContext) ||
                other.presentedOfferingContext == presentedOfferingContext) &&
            (identical(other.installmentsInfo, installmentsInfo) ||
                other.installmentsInfo == installmentsInfo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      storeProductId,
      productId,
      const DeepCollectionEquality().hash(_pricingPhases),
      const DeepCollectionEquality().hash(_tags),
      isBasePlan,
      billingPeriod,
      isPrepaid,
      fullPricePhase,
      freePhase,
      introPhase,
      presentedOfferingContext,
      installmentsInfo);

  @override
  String toString() {
    return 'SubscriptionOption(id: $id, storeProductId: $storeProductId, productId: $productId, pricingPhases: $pricingPhases, tags: $tags, isBasePlan: $isBasePlan, billingPeriod: $billingPeriod, isPrepaid: $isPrepaid, fullPricePhase: $fullPricePhase, freePhase: $freePhase, introPhase: $introPhase, presentedOfferingContext: $presentedOfferingContext, installmentsInfo: $installmentsInfo)';
  }
}

/// @nodoc
abstract mixin class _$SubscriptionOptionCopyWith<$Res>
    implements $SubscriptionOptionCopyWith<$Res> {
  factory _$SubscriptionOptionCopyWith(
          _SubscriptionOption value, $Res Function(_SubscriptionOption) _then) =
      __$SubscriptionOptionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String storeProductId,
      String productId,
      List<PricingPhase> pricingPhases,
      List<String> tags,
      bool isBasePlan,
      Period? billingPeriod,
      bool isPrepaid,
      PricingPhase? fullPricePhase,
      PricingPhase? freePhase,
      PricingPhase? introPhase,
      PresentedOfferingContext? presentedOfferingContext,
      InstallmentsInfo? installmentsInfo});

  @override
  $PeriodCopyWith<$Res>? get billingPeriod;
  @override
  $PricingPhaseCopyWith<$Res>? get fullPricePhase;
  @override
  $PricingPhaseCopyWith<$Res>? get freePhase;
  @override
  $PricingPhaseCopyWith<$Res>? get introPhase;
  @override
  $PresentedOfferingContextCopyWith<$Res>? get presentedOfferingContext;
  @override
  $InstallmentsInfoCopyWith<$Res>? get installmentsInfo;
}

/// @nodoc
class __$SubscriptionOptionCopyWithImpl<$Res>
    implements _$SubscriptionOptionCopyWith<$Res> {
  __$SubscriptionOptionCopyWithImpl(this._self, this._then);

  final _SubscriptionOption _self;
  final $Res Function(_SubscriptionOption) _then;

  /// Create a copy of SubscriptionOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? storeProductId = null,
    Object? productId = null,
    Object? pricingPhases = null,
    Object? tags = null,
    Object? isBasePlan = null,
    Object? billingPeriod = freezed,
    Object? isPrepaid = null,
    Object? fullPricePhase = freezed,
    Object? freePhase = freezed,
    Object? introPhase = freezed,
    Object? presentedOfferingContext = freezed,
    Object? installmentsInfo = freezed,
  }) {
    return _then(_SubscriptionOption(
      null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      null == storeProductId
          ? _self.storeProductId
          : storeProductId // ignore: cast_nullable_to_non_nullable
              as String,
      null == productId
          ? _self.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      null == pricingPhases
          ? _self._pricingPhases
          : pricingPhases // ignore: cast_nullable_to_non_nullable
              as List<PricingPhase>,
      null == tags
          ? _self._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      null == isBasePlan
          ? _self.isBasePlan
          : isBasePlan // ignore: cast_nullable_to_non_nullable
              as bool,
      freezed == billingPeriod
          ? _self.billingPeriod
          : billingPeriod // ignore: cast_nullable_to_non_nullable
              as Period?,
      null == isPrepaid
          ? _self.isPrepaid
          : isPrepaid // ignore: cast_nullable_to_non_nullable
              as bool,
      freezed == fullPricePhase
          ? _self.fullPricePhase
          : fullPricePhase // ignore: cast_nullable_to_non_nullable
              as PricingPhase?,
      freezed == freePhase
          ? _self.freePhase
          : freePhase // ignore: cast_nullable_to_non_nullable
              as PricingPhase?,
      freezed == introPhase
          ? _self.introPhase
          : introPhase // ignore: cast_nullable_to_non_nullable
              as PricingPhase?,
      freezed == presentedOfferingContext
          ? _self.presentedOfferingContext
          : presentedOfferingContext // ignore: cast_nullable_to_non_nullable
              as PresentedOfferingContext?,
      freezed == installmentsInfo
          ? _self.installmentsInfo
          : installmentsInfo // ignore: cast_nullable_to_non_nullable
              as InstallmentsInfo?,
    ));
  }

  /// Create a copy of SubscriptionOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PeriodCopyWith<$Res>? get billingPeriod {
    if (_self.billingPeriod == null) {
      return null;
    }

    return $PeriodCopyWith<$Res>(_self.billingPeriod!, (value) {
      return _then(_self.copyWith(billingPeriod: value));
    });
  }

  /// Create a copy of SubscriptionOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PricingPhaseCopyWith<$Res>? get fullPricePhase {
    if (_self.fullPricePhase == null) {
      return null;
    }

    return $PricingPhaseCopyWith<$Res>(_self.fullPricePhase!, (value) {
      return _then(_self.copyWith(fullPricePhase: value));
    });
  }

  /// Create a copy of SubscriptionOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PricingPhaseCopyWith<$Res>? get freePhase {
    if (_self.freePhase == null) {
      return null;
    }

    return $PricingPhaseCopyWith<$Res>(_self.freePhase!, (value) {
      return _then(_self.copyWith(freePhase: value));
    });
  }

  /// Create a copy of SubscriptionOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PricingPhaseCopyWith<$Res>? get introPhase {
    if (_self.introPhase == null) {
      return null;
    }

    return $PricingPhaseCopyWith<$Res>(_self.introPhase!, (value) {
      return _then(_self.copyWith(introPhase: value));
    });
  }

  /// Create a copy of SubscriptionOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PresentedOfferingContextCopyWith<$Res>? get presentedOfferingContext {
    if (_self.presentedOfferingContext == null) {
      return null;
    }

    return $PresentedOfferingContextCopyWith<$Res>(
        _self.presentedOfferingContext!, (value) {
      return _then(_self.copyWith(presentedOfferingContext: value));
    });
  }

  /// Create a copy of SubscriptionOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InstallmentsInfoCopyWith<$Res>? get installmentsInfo {
    if (_self.installmentsInfo == null) {
      return null;
    }

    return $InstallmentsInfoCopyWith<$Res>(_self.installmentsInfo!, (value) {
      return _then(_self.copyWith(installmentsInfo: value));
    });
  }
}

// dart format on
