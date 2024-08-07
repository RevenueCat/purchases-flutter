// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'store_product_discount.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StoreProductDiscount _$StoreProductDiscountFromJson(Map<String, dynamic> json) {
  return _StoreProductDiscount.fromJson(json);
}

/// @nodoc
mixin _$StoreProductDiscount {
  /// Identifier of the discount.
  String get identifier => throw _privateConstructorUsedError;

  /// Identifier of the discount.
  double get price => throw _privateConstructorUsedError;

  /// Formatted price, including its currency sign, such as €3.99.
  String get priceString => throw _privateConstructorUsedError;

  /// Number of subscription billing periods for which the user will be given the discount, such as 3.
  int get cycles => throw _privateConstructorUsedError;

  /// Billing period of the discount, specified in ISO 8601 format.
  String get period => throw _privateConstructorUsedError;

  /// Unit for the billing period of the discount, can be DAY, WEEK, MONTH or YEAR.
  String get periodUnit => throw _privateConstructorUsedError;

  /// Number of units for the billing period of the discount.
  int get periodNumberOfUnits => throw _privateConstructorUsedError;

  /// Serializes this StoreProductDiscount to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoreProductDiscount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoreProductDiscountCopyWith<StoreProductDiscount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoreProductDiscountCopyWith<$Res> {
  factory $StoreProductDiscountCopyWith(StoreProductDiscount value,
          $Res Function(StoreProductDiscount) then) =
      _$StoreProductDiscountCopyWithImpl<$Res, StoreProductDiscount>;
  @useResult
  $Res call(
      {String identifier,
      double price,
      String priceString,
      int cycles,
      String period,
      String periodUnit,
      int periodNumberOfUnits});
}

/// @nodoc
class _$StoreProductDiscountCopyWithImpl<$Res,
        $Val extends StoreProductDiscount>
    implements $StoreProductDiscountCopyWith<$Res> {
  _$StoreProductDiscountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoreProductDiscount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identifier = null,
    Object? price = null,
    Object? priceString = null,
    Object? cycles = null,
    Object? period = null,
    Object? periodUnit = null,
    Object? periodNumberOfUnits = null,
  }) {
    return _then(_value.copyWith(
      identifier: null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      priceString: null == priceString
          ? _value.priceString
          : priceString // ignore: cast_nullable_to_non_nullable
              as String,
      cycles: null == cycles
          ? _value.cycles
          : cycles // ignore: cast_nullable_to_non_nullable
              as int,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      periodUnit: null == periodUnit
          ? _value.periodUnit
          : periodUnit // ignore: cast_nullable_to_non_nullable
              as String,
      periodNumberOfUnits: null == periodNumberOfUnits
          ? _value.periodNumberOfUnits
          : periodNumberOfUnits // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StoreProductDiscountImplCopyWith<$Res>
    implements $StoreProductDiscountCopyWith<$Res> {
  factory _$$StoreProductDiscountImplCopyWith(_$StoreProductDiscountImpl value,
          $Res Function(_$StoreProductDiscountImpl) then) =
      __$$StoreProductDiscountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String identifier,
      double price,
      String priceString,
      int cycles,
      String period,
      String periodUnit,
      int periodNumberOfUnits});
}

/// @nodoc
class __$$StoreProductDiscountImplCopyWithImpl<$Res>
    extends _$StoreProductDiscountCopyWithImpl<$Res, _$StoreProductDiscountImpl>
    implements _$$StoreProductDiscountImplCopyWith<$Res> {
  __$$StoreProductDiscountImplCopyWithImpl(_$StoreProductDiscountImpl _value,
      $Res Function(_$StoreProductDiscountImpl) _then)
      : super(_value, _then);

  /// Create a copy of StoreProductDiscount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identifier = null,
    Object? price = null,
    Object? priceString = null,
    Object? cycles = null,
    Object? period = null,
    Object? periodUnit = null,
    Object? periodNumberOfUnits = null,
  }) {
    return _then(_$StoreProductDiscountImpl(
      null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      null == priceString
          ? _value.priceString
          : priceString // ignore: cast_nullable_to_non_nullable
              as String,
      null == cycles
          ? _value.cycles
          : cycles // ignore: cast_nullable_to_non_nullable
              as int,
      null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      null == periodUnit
          ? _value.periodUnit
          : periodUnit // ignore: cast_nullable_to_non_nullable
              as String,
      null == periodNumberOfUnits
          ? _value.periodNumberOfUnits
          : periodNumberOfUnits // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StoreProductDiscountImpl implements _StoreProductDiscount {
  const _$StoreProductDiscountImpl(
      this.identifier,
      this.price,
      this.priceString,
      this.cycles,
      this.period,
      this.periodUnit,
      this.periodNumberOfUnits);

  factory _$StoreProductDiscountImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoreProductDiscountImplFromJson(json);

  /// Identifier of the discount.
  @override
  final String identifier;

  /// Identifier of the discount.
  @override
  final double price;

  /// Formatted price, including its currency sign, such as €3.99.
  @override
  final String priceString;

  /// Number of subscription billing periods for which the user will be given the discount, such as 3.
  @override
  final int cycles;

  /// Billing period of the discount, specified in ISO 8601 format.
  @override
  final String period;

  /// Unit for the billing period of the discount, can be DAY, WEEK, MONTH or YEAR.
  @override
  final String periodUnit;

  /// Number of units for the billing period of the discount.
  @override
  final int periodNumberOfUnits;

  @override
  String toString() {
    return 'StoreProductDiscount(identifier: $identifier, price: $price, priceString: $priceString, cycles: $cycles, period: $period, periodUnit: $periodUnit, periodNumberOfUnits: $periodNumberOfUnits)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoreProductDiscountImpl &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.priceString, priceString) ||
                other.priceString == priceString) &&
            (identical(other.cycles, cycles) || other.cycles == cycles) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.periodUnit, periodUnit) ||
                other.periodUnit == periodUnit) &&
            (identical(other.periodNumberOfUnits, periodNumberOfUnits) ||
                other.periodNumberOfUnits == periodNumberOfUnits));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, identifier, price, priceString,
      cycles, period, periodUnit, periodNumberOfUnits);

  /// Create a copy of StoreProductDiscount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoreProductDiscountImplCopyWith<_$StoreProductDiscountImpl>
      get copyWith =>
          __$$StoreProductDiscountImplCopyWithImpl<_$StoreProductDiscountImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoreProductDiscountImplToJson(
      this,
    );
  }
}

abstract class _StoreProductDiscount implements StoreProductDiscount {
  const factory _StoreProductDiscount(
      final String identifier,
      final double price,
      final String priceString,
      final int cycles,
      final String period,
      final String periodUnit,
      final int periodNumberOfUnits) = _$StoreProductDiscountImpl;

  factory _StoreProductDiscount.fromJson(Map<String, dynamic> json) =
      _$StoreProductDiscountImpl.fromJson;

  /// Identifier of the discount.
  @override
  String get identifier;

  /// Identifier of the discount.
  @override
  double get price;

  /// Formatted price, including its currency sign, such as €3.99.
  @override
  String get priceString;

  /// Number of subscription billing periods for which the user will be given the discount, such as 3.
  @override
  int get cycles;

  /// Billing period of the discount, specified in ISO 8601 format.
  @override
  String get period;

  /// Unit for the billing period of the discount, can be DAY, WEEK, MONTH or YEAR.
  @override
  String get periodUnit;

  /// Number of units for the billing period of the discount.
  @override
  int get periodNumberOfUnits;

  /// Create a copy of StoreProductDiscount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoreProductDiscountImplCopyWith<_$StoreProductDiscountImpl>
      get copyWith => throw _privateConstructorUsedError;
}
