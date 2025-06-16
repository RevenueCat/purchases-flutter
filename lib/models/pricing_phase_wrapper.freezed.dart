// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pricing_phase_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PricingPhase {
  /// Billing period for which the PricingPhase applies
  Period? get billingPeriod;

  /// Recurrence mode of the PricingPhase
  RecurrenceMode? get recurrenceMode;

  /// Number of cycles for which the pricing phase applies.
  /// Null for infiniteRecurring or finiteRecurring recurrence modes.
  int? get billingCycleCount;

  /// Price of the PricingPhase
  Price get price;

  /// Indicates how the pricing phase is charged for finiteRecurring pricing phases
  OfferPaymentMode? get offerPaymentMode;

  /// Create a copy of PricingPhase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PricingPhaseCopyWith<PricingPhase> get copyWith =>
      _$PricingPhaseCopyWithImpl<PricingPhase>(
          this as PricingPhase, _$identity);

  /// Serializes this PricingPhase to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PricingPhase &&
            (identical(other.billingPeriod, billingPeriod) ||
                other.billingPeriod == billingPeriod) &&
            (identical(other.recurrenceMode, recurrenceMode) ||
                other.recurrenceMode == recurrenceMode) &&
            (identical(other.billingCycleCount, billingCycleCount) ||
                other.billingCycleCount == billingCycleCount) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.offerPaymentMode, offerPaymentMode) ||
                other.offerPaymentMode == offerPaymentMode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, billingPeriod, recurrenceMode,
      billingCycleCount, price, offerPaymentMode);

  @override
  String toString() {
    return 'PricingPhase(billingPeriod: $billingPeriod, recurrenceMode: $recurrenceMode, billingCycleCount: $billingCycleCount, price: $price, offerPaymentMode: $offerPaymentMode)';
  }
}

/// @nodoc
abstract mixin class $PricingPhaseCopyWith<$Res> {
  factory $PricingPhaseCopyWith(
          PricingPhase value, $Res Function(PricingPhase) _then) =
      _$PricingPhaseCopyWithImpl;
  @useResult
  $Res call(
      {Period? billingPeriod,
      RecurrenceMode? recurrenceMode,
      int? billingCycleCount,
      Price price,
      OfferPaymentMode? offerPaymentMode});

  $PeriodCopyWith<$Res>? get billingPeriod;
  $PriceCopyWith<$Res> get price;
}

/// @nodoc
class _$PricingPhaseCopyWithImpl<$Res> implements $PricingPhaseCopyWith<$Res> {
  _$PricingPhaseCopyWithImpl(this._self, this._then);

  final PricingPhase _self;
  final $Res Function(PricingPhase) _then;

  /// Create a copy of PricingPhase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? billingPeriod = freezed,
    Object? recurrenceMode = freezed,
    Object? billingCycleCount = freezed,
    Object? price = null,
    Object? offerPaymentMode = freezed,
  }) {
    return _then(_self.copyWith(
      billingPeriod: freezed == billingPeriod
          ? _self.billingPeriod
          : billingPeriod // ignore: cast_nullable_to_non_nullable
              as Period?,
      recurrenceMode: freezed == recurrenceMode
          ? _self.recurrenceMode
          : recurrenceMode // ignore: cast_nullable_to_non_nullable
              as RecurrenceMode?,
      billingCycleCount: freezed == billingCycleCount
          ? _self.billingCycleCount
          : billingCycleCount // ignore: cast_nullable_to_non_nullable
              as int?,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as Price,
      offerPaymentMode: freezed == offerPaymentMode
          ? _self.offerPaymentMode
          : offerPaymentMode // ignore: cast_nullable_to_non_nullable
              as OfferPaymentMode?,
    ));
  }

  /// Create a copy of PricingPhase
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

  /// Create a copy of PricingPhase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PriceCopyWith<$Res> get price {
    return $PriceCopyWith<$Res>(_self.price, (value) {
      return _then(_self.copyWith(price: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _PricingPhase implements PricingPhase {
  const _PricingPhase(this.billingPeriod, this.recurrenceMode,
      this.billingCycleCount, this.price, this.offerPaymentMode);
  factory _PricingPhase.fromJson(Map<String, dynamic> json) =>
      _$PricingPhaseFromJson(json);

  /// Billing period for which the PricingPhase applies
  @override
  final Period? billingPeriod;

  /// Recurrence mode of the PricingPhase
  @override
  final RecurrenceMode? recurrenceMode;

  /// Number of cycles for which the pricing phase applies.
  /// Null for infiniteRecurring or finiteRecurring recurrence modes.
  @override
  final int? billingCycleCount;

  /// Price of the PricingPhase
  @override
  final Price price;

  /// Indicates how the pricing phase is charged for finiteRecurring pricing phases
  @override
  final OfferPaymentMode? offerPaymentMode;

  /// Create a copy of PricingPhase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PricingPhaseCopyWith<_PricingPhase> get copyWith =>
      __$PricingPhaseCopyWithImpl<_PricingPhase>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PricingPhaseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PricingPhase &&
            (identical(other.billingPeriod, billingPeriod) ||
                other.billingPeriod == billingPeriod) &&
            (identical(other.recurrenceMode, recurrenceMode) ||
                other.recurrenceMode == recurrenceMode) &&
            (identical(other.billingCycleCount, billingCycleCount) ||
                other.billingCycleCount == billingCycleCount) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.offerPaymentMode, offerPaymentMode) ||
                other.offerPaymentMode == offerPaymentMode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, billingPeriod, recurrenceMode,
      billingCycleCount, price, offerPaymentMode);

  @override
  String toString() {
    return 'PricingPhase(billingPeriod: $billingPeriod, recurrenceMode: $recurrenceMode, billingCycleCount: $billingCycleCount, price: $price, offerPaymentMode: $offerPaymentMode)';
  }
}

/// @nodoc
abstract mixin class _$PricingPhaseCopyWith<$Res>
    implements $PricingPhaseCopyWith<$Res> {
  factory _$PricingPhaseCopyWith(
          _PricingPhase value, $Res Function(_PricingPhase) _then) =
      __$PricingPhaseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Period? billingPeriod,
      RecurrenceMode? recurrenceMode,
      int? billingCycleCount,
      Price price,
      OfferPaymentMode? offerPaymentMode});

  @override
  $PeriodCopyWith<$Res>? get billingPeriod;
  @override
  $PriceCopyWith<$Res> get price;
}

/// @nodoc
class __$PricingPhaseCopyWithImpl<$Res>
    implements _$PricingPhaseCopyWith<$Res> {
  __$PricingPhaseCopyWithImpl(this._self, this._then);

  final _PricingPhase _self;
  final $Res Function(_PricingPhase) _then;

  /// Create a copy of PricingPhase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? billingPeriod = freezed,
    Object? recurrenceMode = freezed,
    Object? billingCycleCount = freezed,
    Object? price = null,
    Object? offerPaymentMode = freezed,
  }) {
    return _then(_PricingPhase(
      freezed == billingPeriod
          ? _self.billingPeriod
          : billingPeriod // ignore: cast_nullable_to_non_nullable
              as Period?,
      freezed == recurrenceMode
          ? _self.recurrenceMode
          : recurrenceMode // ignore: cast_nullable_to_non_nullable
              as RecurrenceMode?,
      freezed == billingCycleCount
          ? _self.billingCycleCount
          : billingCycleCount // ignore: cast_nullable_to_non_nullable
              as int?,
      null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as Price,
      freezed == offerPaymentMode
          ? _self.offerPaymentMode
          : offerPaymentMode // ignore: cast_nullable_to_non_nullable
              as OfferPaymentMode?,
    ));
  }

  /// Create a copy of PricingPhase
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

  /// Create a copy of PricingPhase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PriceCopyWith<$Res> get price {
    return $PriceCopyWith<$Res>(_self.price, (value) {
      return _then(_self.copyWith(price: value));
    });
  }
}

// dart format on
