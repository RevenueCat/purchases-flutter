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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
abstract class _$$_StoreProductDiscountCopyWith<$Res>
    implements $StoreProductDiscountCopyWith<$Res> {
  factory _$$_StoreProductDiscountCopyWith(_$_StoreProductDiscount value,
          $Res Function(_$_StoreProductDiscount) then) =
      __$$_StoreProductDiscountCopyWithImpl<$Res>;
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
class __$$_StoreProductDiscountCopyWithImpl<$Res>
    extends _$StoreProductDiscountCopyWithImpl<$Res, _$_StoreProductDiscount>
    implements _$$_StoreProductDiscountCopyWith<$Res> {
  __$$_StoreProductDiscountCopyWithImpl(_$_StoreProductDiscount _value,
      $Res Function(_$_StoreProductDiscount) _then)
      : super(_value, _then);

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
    return _then(_$_StoreProductDiscount(
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
class _$_StoreProductDiscount implements _StoreProductDiscount {
  const _$_StoreProductDiscount(this.identifier, this.price, this.priceString,
      this.cycles, this.period, this.periodUnit, this.periodNumberOfUnits);

  factory _$_StoreProductDiscount.fromJson(Map<String, dynamic> json) =>
      _$$_StoreProductDiscountFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StoreProductDiscount &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, identifier, price, priceString,
      cycles, period, periodUnit, periodNumberOfUnits);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StoreProductDiscountCopyWith<_$_StoreProductDiscount> get copyWith =>
      __$$_StoreProductDiscountCopyWithImpl<_$_StoreProductDiscount>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StoreProductDiscountToJson(
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
      final int periodNumberOfUnits) = _$_StoreProductDiscount;

  factory _StoreProductDiscount.fromJson(Map<String, dynamic> json) =
      _$_StoreProductDiscount.fromJson;

  @override

  /// Identifier of the discount.
  String get identifier;
  @override

  /// Identifier of the discount.
  double get price;
  @override

  /// Formatted price, including its currency sign, such as €3.99.
  String get priceString;
  @override

  /// Number of subscription billing periods for which the user will be given the discount, such as 3.
  int get cycles;
  @override

  /// Billing period of the discount, specified in ISO 8601 format.
  String get period;
  @override

  /// Unit for the billing period of the discount, can be DAY, WEEK, MONTH or YEAR.
  String get periodUnit;
  @override

  /// Number of units for the billing period of the discount.
  int get periodNumberOfUnits;
  @override
  @JsonKey(ignore: true)
  _$$_StoreProductDiscountCopyWith<_$_StoreProductDiscount> get copyWith =>
      throw _privateConstructorUsedError;
}
