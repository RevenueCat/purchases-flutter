// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'discount.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Discount _$DiscountFromJson(Map<String, dynamic> json) {
  return _Discount.fromJson(json);
}

/// @nodoc
mixin _$Discount {
  /// Identifier of the discount.
  @JsonKey(name: 'identifier')
  String get identifier => throw _privateConstructorUsedError;

  /// Identifier of the discount.
  @JsonKey(name: 'price')
  double get price => throw _privateConstructorUsedError;

  /// Formatted price, including its currency sign, such as €3.99.
  @JsonKey(name: 'priceString')
  String get priceString => throw _privateConstructorUsedError;

  /// Number of subscription billing periods for which the user will be given the discount, such as 3.
  @JsonKey(name: 'cycles')
  int get cycles => throw _privateConstructorUsedError;

  /// Billing period of the discount, specified in ISO 8601 format.
  @JsonKey(name: 'period')
  String get period => throw _privateConstructorUsedError;

  /// Unit for the billing period of the discount, can be DAY, WEEK, MONTH or YEAR.
  @JsonKey(name: 'periodUnit')
  String get periodUnit => throw _privateConstructorUsedError;

  /// Number of units for the billing period of the discount.
  @JsonKey(name: 'periodNumberOfUnits')
  int get periodNumberOfUnits => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DiscountCopyWith<Discount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscountCopyWith<$Res> {
  factory $DiscountCopyWith(Discount value, $Res Function(Discount) then) =
      _$DiscountCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'identifier') String identifier,
      @JsonKey(name: 'price') double price,
      @JsonKey(name: 'priceString') String priceString,
      @JsonKey(name: 'cycles') int cycles,
      @JsonKey(name: 'period') String period,
      @JsonKey(name: 'periodUnit') String periodUnit,
      @JsonKey(name: 'periodNumberOfUnits') int periodNumberOfUnits});
}

/// @nodoc
class _$DiscountCopyWithImpl<$Res> implements $DiscountCopyWith<$Res> {
  _$DiscountCopyWithImpl(this._value, this._then);

  final Discount _value;
  // ignore: unused_field
  final $Res Function(Discount) _then;

  @override
  $Res call({
    Object? identifier = freezed,
    Object? price = freezed,
    Object? priceString = freezed,
    Object? cycles = freezed,
    Object? period = freezed,
    Object? periodUnit = freezed,
    Object? periodNumberOfUnits = freezed,
  }) {
    return _then(_value.copyWith(
      identifier: identifier == freezed
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      priceString: priceString == freezed
          ? _value.priceString
          : priceString // ignore: cast_nullable_to_non_nullable
              as String,
      cycles: cycles == freezed
          ? _value.cycles
          : cycles // ignore: cast_nullable_to_non_nullable
              as int,
      period: period == freezed
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      periodUnit: periodUnit == freezed
          ? _value.periodUnit
          : periodUnit // ignore: cast_nullable_to_non_nullable
              as String,
      periodNumberOfUnits: periodNumberOfUnits == freezed
          ? _value.periodNumberOfUnits
          : periodNumberOfUnits // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_DiscountCopyWith<$Res> implements $DiscountCopyWith<$Res> {
  factory _$$_DiscountCopyWith(
          _$_Discount value, $Res Function(_$_Discount) then) =
      __$$_DiscountCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'identifier') String identifier,
      @JsonKey(name: 'price') double price,
      @JsonKey(name: 'priceString') String priceString,
      @JsonKey(name: 'cycles') int cycles,
      @JsonKey(name: 'period') String period,
      @JsonKey(name: 'periodUnit') String periodUnit,
      @JsonKey(name: 'periodNumberOfUnits') int periodNumberOfUnits});
}

/// @nodoc
class __$$_DiscountCopyWithImpl<$Res> extends _$DiscountCopyWithImpl<$Res>
    implements _$$_DiscountCopyWith<$Res> {
  __$$_DiscountCopyWithImpl(
      _$_Discount _value, $Res Function(_$_Discount) _then)
      : super(_value, (v) => _then(v as _$_Discount));

  @override
  _$_Discount get _value => super._value as _$_Discount;

  @override
  $Res call({
    Object? identifier = freezed,
    Object? price = freezed,
    Object? priceString = freezed,
    Object? cycles = freezed,
    Object? period = freezed,
    Object? periodUnit = freezed,
    Object? periodNumberOfUnits = freezed,
  }) {
    return _then(_$_Discount(
      identifier == freezed
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      priceString == freezed
          ? _value.priceString
          : priceString // ignore: cast_nullable_to_non_nullable
              as String,
      cycles == freezed
          ? _value.cycles
          : cycles // ignore: cast_nullable_to_non_nullable
              as int,
      period == freezed
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      periodUnit == freezed
          ? _value.periodUnit
          : periodUnit // ignore: cast_nullable_to_non_nullable
              as String,
      periodNumberOfUnits == freezed
          ? _value.periodNumberOfUnits
          : periodNumberOfUnits // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Discount implements _Discount {
  const _$_Discount(
      @JsonKey(name: 'identifier') this.identifier,
      @JsonKey(name: 'price') this.price,
      @JsonKey(name: 'priceString') this.priceString,
      @JsonKey(name: 'cycles') this.cycles,
      @JsonKey(name: 'period') this.period,
      @JsonKey(name: 'periodUnit') this.periodUnit,
      @JsonKey(name: 'periodNumberOfUnits') this.periodNumberOfUnits);

  factory _$_Discount.fromJson(Map<String, dynamic> json) =>
      _$$_DiscountFromJson(json);

  /// Identifier of the discount.
  @override
  @JsonKey(name: 'identifier')
  final String identifier;

  /// Identifier of the discount.
  @override
  @JsonKey(name: 'price')
  final double price;

  /// Formatted price, including its currency sign, such as €3.99.
  @override
  @JsonKey(name: 'priceString')
  final String priceString;

  /// Number of subscription billing periods for which the user will be given the discount, such as 3.
  @override
  @JsonKey(name: 'cycles')
  final int cycles;

  /// Billing period of the discount, specified in ISO 8601 format.
  @override
  @JsonKey(name: 'period')
  final String period;

  /// Unit for the billing period of the discount, can be DAY, WEEK, MONTH or YEAR.
  @override
  @JsonKey(name: 'periodUnit')
  final String periodUnit;

  /// Number of units for the billing period of the discount.
  @override
  @JsonKey(name: 'periodNumberOfUnits')
  final int periodNumberOfUnits;

  @override
  String toString() {
    return 'Discount(identifier: $identifier, price: $price, priceString: $priceString, cycles: $cycles, period: $period, periodUnit: $periodUnit, periodNumberOfUnits: $periodNumberOfUnits)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Discount &&
            const DeepCollectionEquality()
                .equals(other.identifier, identifier) &&
            const DeepCollectionEquality().equals(other.price, price) &&
            const DeepCollectionEquality()
                .equals(other.priceString, priceString) &&
            const DeepCollectionEquality().equals(other.cycles, cycles) &&
            const DeepCollectionEquality().equals(other.period, period) &&
            const DeepCollectionEquality()
                .equals(other.periodUnit, periodUnit) &&
            const DeepCollectionEquality()
                .equals(other.periodNumberOfUnits, periodNumberOfUnits));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(identifier),
      const DeepCollectionEquality().hash(price),
      const DeepCollectionEquality().hash(priceString),
      const DeepCollectionEquality().hash(cycles),
      const DeepCollectionEquality().hash(period),
      const DeepCollectionEquality().hash(periodUnit),
      const DeepCollectionEquality().hash(periodNumberOfUnits));

  @JsonKey(ignore: true)
  @override
  _$$_DiscountCopyWith<_$_Discount> get copyWith =>
      __$$_DiscountCopyWithImpl<_$_Discount>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DiscountToJson(this);
  }
}

abstract class _Discount implements Discount {
  const factory _Discount(
          @JsonKey(name: 'identifier') final String identifier,
          @JsonKey(name: 'price') final double price,
          @JsonKey(name: 'priceString') final String priceString,
          @JsonKey(name: 'cycles') final int cycles,
          @JsonKey(name: 'period') final String period,
          @JsonKey(name: 'periodUnit') final String periodUnit,
          @JsonKey(name: 'periodNumberOfUnits') final int periodNumberOfUnits) =
      _$_Discount;

  factory _Discount.fromJson(Map<String, dynamic> json) = _$_Discount.fromJson;

  @override

  /// Identifier of the discount.
  @JsonKey(name: 'identifier')
  String get identifier => throw _privateConstructorUsedError;
  @override

  /// Identifier of the discount.
  @JsonKey(name: 'price')
  double get price => throw _privateConstructorUsedError;
  @override

  /// Formatted price, including its currency sign, such as €3.99.
  @JsonKey(name: 'priceString')
  String get priceString => throw _privateConstructorUsedError;
  @override

  /// Number of subscription billing periods for which the user will be given the discount, such as 3.
  @JsonKey(name: 'cycles')
  int get cycles => throw _privateConstructorUsedError;
  @override

  /// Billing period of the discount, specified in ISO 8601 format.
  @JsonKey(name: 'period')
  String get period => throw _privateConstructorUsedError;
  @override

  /// Unit for the billing period of the discount, can be DAY, WEEK, MONTH or YEAR.
  @JsonKey(name: 'periodUnit')
  String get periodUnit => throw _privateConstructorUsedError;
  @override

  /// Number of units for the billing period of the discount.
  @JsonKey(name: 'periodNumberOfUnits')
  int get periodNumberOfUnits => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_DiscountCopyWith<_$_Discount> get copyWith =>
      throw _privateConstructorUsedError;
}
