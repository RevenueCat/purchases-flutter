// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pricing_phase_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PricingPhase _$PricingPhaseFromJson(Map<String, dynamic> json) {
  return _PricingPhase.fromJson(json);
}

/// @nodoc
mixin _$PricingPhase {
  /// Billing period for which the PricingPhase applies
  Period? get billingPeriod => throw _privateConstructorUsedError;

  /// Recurrence mode of the PricingPhase
  RecurrenceMode? get recurrenceMode => throw _privateConstructorUsedError;

  /// Number of cycles for which the pricing phase applies.
  /// Null for infiniteRecurring or finiteRecurring recurrence modes.
  int? get billingCycleCount => throw _privateConstructorUsedError;

  /// Price of the PricingPhase
  Price get price => throw _privateConstructorUsedError;

  /// Indicates how the pricing phase is charged for finiteRecurring pricing phases
  OfferPaymentMode? get offerPaymentMode => throw _privateConstructorUsedError;

  /// Serializes this PricingPhase to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PricingPhase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PricingPhaseCopyWith<PricingPhase> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PricingPhaseCopyWith<$Res> {
  factory $PricingPhaseCopyWith(
          PricingPhase value, $Res Function(PricingPhase) then) =
      _$PricingPhaseCopyWithImpl<$Res, PricingPhase>;
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
class _$PricingPhaseCopyWithImpl<$Res, $Val extends PricingPhase>
    implements $PricingPhaseCopyWith<$Res> {
  _$PricingPhaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      billingPeriod: freezed == billingPeriod
          ? _value.billingPeriod
          : billingPeriod // ignore: cast_nullable_to_non_nullable
              as Period?,
      recurrenceMode: freezed == recurrenceMode
          ? _value.recurrenceMode
          : recurrenceMode // ignore: cast_nullable_to_non_nullable
              as RecurrenceMode?,
      billingCycleCount: freezed == billingCycleCount
          ? _value.billingCycleCount
          : billingCycleCount // ignore: cast_nullable_to_non_nullable
              as int?,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as Price,
      offerPaymentMode: freezed == offerPaymentMode
          ? _value.offerPaymentMode
          : offerPaymentMode // ignore: cast_nullable_to_non_nullable
              as OfferPaymentMode?,
    ) as $Val);
  }

  /// Create a copy of PricingPhase
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of PricingPhase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PriceCopyWith<$Res> get price {
    return $PriceCopyWith<$Res>(_value.price, (value) {
      return _then(_value.copyWith(price: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PricingPhaseImplCopyWith<$Res>
    implements $PricingPhaseCopyWith<$Res> {
  factory _$$PricingPhaseImplCopyWith(
          _$PricingPhaseImpl value, $Res Function(_$PricingPhaseImpl) then) =
      __$$PricingPhaseImplCopyWithImpl<$Res>;
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
class __$$PricingPhaseImplCopyWithImpl<$Res>
    extends _$PricingPhaseCopyWithImpl<$Res, _$PricingPhaseImpl>
    implements _$$PricingPhaseImplCopyWith<$Res> {
  __$$PricingPhaseImplCopyWithImpl(
      _$PricingPhaseImpl _value, $Res Function(_$PricingPhaseImpl) _then)
      : super(_value, _then);

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
    return _then(_$PricingPhaseImpl(
      freezed == billingPeriod
          ? _value.billingPeriod
          : billingPeriod // ignore: cast_nullable_to_non_nullable
              as Period?,
      freezed == recurrenceMode
          ? _value.recurrenceMode
          : recurrenceMode // ignore: cast_nullable_to_non_nullable
              as RecurrenceMode?,
      freezed == billingCycleCount
          ? _value.billingCycleCount
          : billingCycleCount // ignore: cast_nullable_to_non_nullable
              as int?,
      null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as Price,
      freezed == offerPaymentMode
          ? _value.offerPaymentMode
          : offerPaymentMode // ignore: cast_nullable_to_non_nullable
              as OfferPaymentMode?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PricingPhaseImpl implements _PricingPhase {
  const _$PricingPhaseImpl(this.billingPeriod, this.recurrenceMode,
      this.billingCycleCount, this.price, this.offerPaymentMode);

  factory _$PricingPhaseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PricingPhaseImplFromJson(json);

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

  @override
  String toString() {
    return 'PricingPhase(billingPeriod: $billingPeriod, recurrenceMode: $recurrenceMode, billingCycleCount: $billingCycleCount, price: $price, offerPaymentMode: $offerPaymentMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PricingPhaseImpl &&
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

  /// Create a copy of PricingPhase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PricingPhaseImplCopyWith<_$PricingPhaseImpl> get copyWith =>
      __$$PricingPhaseImplCopyWithImpl<_$PricingPhaseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PricingPhaseImplToJson(
      this,
    );
  }
}

abstract class _PricingPhase implements PricingPhase {
  const factory _PricingPhase(
      final Period? billingPeriod,
      final RecurrenceMode? recurrenceMode,
      final int? billingCycleCount,
      final Price price,
      final OfferPaymentMode? offerPaymentMode) = _$PricingPhaseImpl;

  factory _PricingPhase.fromJson(Map<String, dynamic> json) =
      _$PricingPhaseImpl.fromJson;

  /// Billing period for which the PricingPhase applies
  @override
  Period? get billingPeriod;

  /// Recurrence mode of the PricingPhase
  @override
  RecurrenceMode? get recurrenceMode;

  /// Number of cycles for which the pricing phase applies.
  /// Null for infiniteRecurring or finiteRecurring recurrence modes.
  @override
  int? get billingCycleCount;

  /// Price of the PricingPhase
  @override
  Price get price;

  /// Indicates how the pricing phase is charged for finiteRecurring pricing phases
  @override
  OfferPaymentMode? get offerPaymentMode;

  /// Create a copy of PricingPhase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PricingPhaseImplCopyWith<_$PricingPhaseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
