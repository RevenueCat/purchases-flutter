// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_option_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SubscriptionOption _$SubscriptionOptionFromJson(Map<String, dynamic> json) {
  return _SubscriptionOption.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionOption {
  /// Identifier of the subscription option
  /// If this SubscriptionOption represents a base plan, this will be the basePlanId.
  /// If it represents an offer, it will be {basePlanId}:{offerId}
  String get id => throw _privateConstructorUsedError;

  /// Identifier of the StoreProduct associated with this SubscriptionOption
  /// This will be {subId}:{basePlanId}
  String get storeProductId => throw _privateConstructorUsedError;

  /// Identifer of the subscription associated with this SubsriptionOption
  /// This will be {subId}
  String get productId => throw _privateConstructorUsedError;

  /// Pricing phases defining a user's payment plan for the product over time.
  List<PricingPhase> get pricingPhases => throw _privateConstructorUsedError;

  /// Tags defined on the base plan or offer.
  List<String> get tags => throw _privateConstructorUsedError;

  /// True if this SubscriptionOption represents a Google subscription base plan (rather than an offer).
  bool get isBasePlan => throw _privateConstructorUsedError;

  /// The subscription period of fullPricePhase (after free and intro trials).
  Period? get billingPeriod => throw _privateConstructorUsedError;

  /// True if the subscription is pre-paid.
  bool get isPrepaid => throw _privateConstructorUsedError;

  /// The full price PricingPhase of the subscription.
  /// Looks for the last price phase of the SubscriptionOption.
  PricingPhase? get fullPricePhase => throw _privateConstructorUsedError;

  /// The free trial PricingPhase of the subscription.
  /// Looks for the first pricing phase of the SubscriptionOption where amountMicros is 0.
  /// There can be a freeTrialPhase and an introductoryPhase in the same SubscriptionOption.
  PricingPhase? get freePhase => throw _privateConstructorUsedError;

  /// The intro trial PricingPhase of the subscription.
  /// Looks for the first pricing phase of the SubscriptionOption where amountMicros is greater than 0.
  /// There can be a freeTrialPhase and an introductoryPhase in the same SubscriptionOption.
  PricingPhase? get introPhase =>
      throw _privateConstructorUsedError; // Offering identifier the subscriptioni option was presented from
  String? get presentedOfferingIdentifier => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubscriptionOptionCopyWith<SubscriptionOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionOptionCopyWith<$Res> {
  factory $SubscriptionOptionCopyWith(
          SubscriptionOption value, $Res Function(SubscriptionOption) then) =
      _$SubscriptionOptionCopyWithImpl<$Res, SubscriptionOption>;
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
      String? presentedOfferingIdentifier});

  $PeriodCopyWith<$Res>? get billingPeriod;
  $PricingPhaseCopyWith<$Res>? get fullPricePhase;
  $PricingPhaseCopyWith<$Res>? get freePhase;
  $PricingPhaseCopyWith<$Res>? get introPhase;
}

/// @nodoc
class _$SubscriptionOptionCopyWithImpl<$Res, $Val extends SubscriptionOption>
    implements $SubscriptionOptionCopyWith<$Res> {
  _$SubscriptionOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    Object? presentedOfferingIdentifier = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      storeProductId: null == storeProductId
          ? _value.storeProductId
          : storeProductId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      pricingPhases: null == pricingPhases
          ? _value.pricingPhases
          : pricingPhases // ignore: cast_nullable_to_non_nullable
              as List<PricingPhase>,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isBasePlan: null == isBasePlan
          ? _value.isBasePlan
          : isBasePlan // ignore: cast_nullable_to_non_nullable
              as bool,
      billingPeriod: freezed == billingPeriod
          ? _value.billingPeriod
          : billingPeriod // ignore: cast_nullable_to_non_nullable
              as Period?,
      isPrepaid: null == isPrepaid
          ? _value.isPrepaid
          : isPrepaid // ignore: cast_nullable_to_non_nullable
              as bool,
      fullPricePhase: freezed == fullPricePhase
          ? _value.fullPricePhase
          : fullPricePhase // ignore: cast_nullable_to_non_nullable
              as PricingPhase?,
      freePhase: freezed == freePhase
          ? _value.freePhase
          : freePhase // ignore: cast_nullable_to_non_nullable
              as PricingPhase?,
      introPhase: freezed == introPhase
          ? _value.introPhase
          : introPhase // ignore: cast_nullable_to_non_nullable
              as PricingPhase?,
      presentedOfferingIdentifier: freezed == presentedOfferingIdentifier
          ? _value.presentedOfferingIdentifier
          : presentedOfferingIdentifier // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PeriodCopyWith<$Res>? get billingPeriod {
    if (_value.billingPeriod == null) {
      return null;
    }

    return $PeriodCopyWith<$Res>(_value.billingPeriod!, (value) {
      return _then(_value.copyWith(billingPeriod: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PricingPhaseCopyWith<$Res>? get fullPricePhase {
    if (_value.fullPricePhase == null) {
      return null;
    }

    return $PricingPhaseCopyWith<$Res>(_value.fullPricePhase!, (value) {
      return _then(_value.copyWith(fullPricePhase: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PricingPhaseCopyWith<$Res>? get freePhase {
    if (_value.freePhase == null) {
      return null;
    }

    return $PricingPhaseCopyWith<$Res>(_value.freePhase!, (value) {
      return _then(_value.copyWith(freePhase: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PricingPhaseCopyWith<$Res>? get introPhase {
    if (_value.introPhase == null) {
      return null;
    }

    return $PricingPhaseCopyWith<$Res>(_value.introPhase!, (value) {
      return _then(_value.copyWith(introPhase: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SubscriptionOptionCopyWith<$Res>
    implements $SubscriptionOptionCopyWith<$Res> {
  factory _$$_SubscriptionOptionCopyWith(_$_SubscriptionOption value,
          $Res Function(_$_SubscriptionOption) then) =
      __$$_SubscriptionOptionCopyWithImpl<$Res>;
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
      String? presentedOfferingIdentifier});

  @override
  $PeriodCopyWith<$Res>? get billingPeriod;
  @override
  $PricingPhaseCopyWith<$Res>? get fullPricePhase;
  @override
  $PricingPhaseCopyWith<$Res>? get freePhase;
  @override
  $PricingPhaseCopyWith<$Res>? get introPhase;
}

/// @nodoc
class __$$_SubscriptionOptionCopyWithImpl<$Res>
    extends _$SubscriptionOptionCopyWithImpl<$Res, _$_SubscriptionOption>
    implements _$$_SubscriptionOptionCopyWith<$Res> {
  __$$_SubscriptionOptionCopyWithImpl(
      _$_SubscriptionOption _value, $Res Function(_$_SubscriptionOption) _then)
      : super(_value, _then);

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
    Object? presentedOfferingIdentifier = freezed,
  }) {
    return _then(_$_SubscriptionOption(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      null == storeProductId
          ? _value.storeProductId
          : storeProductId // ignore: cast_nullable_to_non_nullable
              as String,
      null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      null == pricingPhases
          ? _value._pricingPhases
          : pricingPhases // ignore: cast_nullable_to_non_nullable
              as List<PricingPhase>,
      null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      null == isBasePlan
          ? _value.isBasePlan
          : isBasePlan // ignore: cast_nullable_to_non_nullable
              as bool,
      freezed == billingPeriod
          ? _value.billingPeriod
          : billingPeriod // ignore: cast_nullable_to_non_nullable
              as Period?,
      null == isPrepaid
          ? _value.isPrepaid
          : isPrepaid // ignore: cast_nullable_to_non_nullable
              as bool,
      freezed == fullPricePhase
          ? _value.fullPricePhase
          : fullPricePhase // ignore: cast_nullable_to_non_nullable
              as PricingPhase?,
      freezed == freePhase
          ? _value.freePhase
          : freePhase // ignore: cast_nullable_to_non_nullable
              as PricingPhase?,
      freezed == introPhase
          ? _value.introPhase
          : introPhase // ignore: cast_nullable_to_non_nullable
              as PricingPhase?,
      freezed == presentedOfferingIdentifier
          ? _value.presentedOfferingIdentifier
          : presentedOfferingIdentifier // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SubscriptionOption implements _SubscriptionOption {
  const _$_SubscriptionOption(
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
      this.presentedOfferingIdentifier)
      : _pricingPhases = pricingPhases,
        _tags = tags;

  factory _$_SubscriptionOption.fromJson(Map<String, dynamic> json) =>
      _$$_SubscriptionOptionFromJson(json);

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
// Offering identifier the subscriptioni option was presented from
  @override
  final String? presentedOfferingIdentifier;

  @override
  String toString() {
    return 'SubscriptionOption(id: $id, storeProductId: $storeProductId, productId: $productId, pricingPhases: $pricingPhases, tags: $tags, isBasePlan: $isBasePlan, billingPeriod: $billingPeriod, isPrepaid: $isPrepaid, fullPricePhase: $fullPricePhase, freePhase: $freePhase, introPhase: $introPhase, presentedOfferingIdentifier: $presentedOfferingIdentifier)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SubscriptionOption &&
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
            (identical(other.presentedOfferingIdentifier,
                    presentedOfferingIdentifier) ||
                other.presentedOfferingIdentifier ==
                    presentedOfferingIdentifier));
  }

  @JsonKey(ignore: true)
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
      presentedOfferingIdentifier);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SubscriptionOptionCopyWith<_$_SubscriptionOption> get copyWith =>
      __$$_SubscriptionOptionCopyWithImpl<_$_SubscriptionOption>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SubscriptionOptionToJson(
      this,
    );
  }
}

abstract class _SubscriptionOption implements SubscriptionOption {
  const factory _SubscriptionOption(
      final String id,
      final String storeProductId,
      final String productId,
      final List<PricingPhase> pricingPhases,
      final List<String> tags,
      final bool isBasePlan,
      final Period? billingPeriod,
      final bool isPrepaid,
      final PricingPhase? fullPricePhase,
      final PricingPhase? freePhase,
      final PricingPhase? introPhase,
      final String? presentedOfferingIdentifier) = _$_SubscriptionOption;

  factory _SubscriptionOption.fromJson(Map<String, dynamic> json) =
      _$_SubscriptionOption.fromJson;

  @override

  /// Identifier of the subscription option
  /// If this SubscriptionOption represents a base plan, this will be the basePlanId.
  /// If it represents an offer, it will be {basePlanId}:{offerId}
  String get id;
  @override

  /// Identifier of the StoreProduct associated with this SubscriptionOption
  /// This will be {subId}:{basePlanId}
  String get storeProductId;
  @override

  /// Identifer of the subscription associated with this SubsriptionOption
  /// This will be {subId}
  String get productId;
  @override

  /// Pricing phases defining a user's payment plan for the product over time.
  List<PricingPhase> get pricingPhases;
  @override

  /// Tags defined on the base plan or offer.
  List<String> get tags;
  @override

  /// True if this SubscriptionOption represents a Google subscription base plan (rather than an offer).
  bool get isBasePlan;
  @override

  /// The subscription period of fullPricePhase (after free and intro trials).
  Period? get billingPeriod;
  @override

  /// True if the subscription is pre-paid.
  bool get isPrepaid;
  @override

  /// The full price PricingPhase of the subscription.
  /// Looks for the last price phase of the SubscriptionOption.
  PricingPhase? get fullPricePhase;
  @override

  /// The free trial PricingPhase of the subscription.
  /// Looks for the first pricing phase of the SubscriptionOption where amountMicros is 0.
  /// There can be a freeTrialPhase and an introductoryPhase in the same SubscriptionOption.
  PricingPhase? get freePhase;
  @override

  /// The intro trial PricingPhase of the subscription.
  /// Looks for the first pricing phase of the SubscriptionOption where amountMicros is greater than 0.
  /// There can be a freeTrialPhase and an introductoryPhase in the same SubscriptionOption.
  PricingPhase? get introPhase;
  @override // Offering identifier the subscriptioni option was presented from
  String? get presentedOfferingIdentifier;
  @override
  @JsonKey(ignore: true)
  _$$_SubscriptionOptionCopyWith<_$_SubscriptionOption> get copyWith =>
      throw _privateConstructorUsedError;
}
