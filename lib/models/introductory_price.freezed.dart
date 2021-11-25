// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'introductory_price.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

IntroductoryPrice _$IntroductoryPriceFromJson(Map<String, dynamic> json) {
  return _IntroductoryPrice.fromJson(json);
}

/// @nodoc
class _$IntroductoryPriceTearOff {
  const _$IntroductoryPriceTearOff();

  _IntroductoryPrice call(
      @JsonKey(name: 'price')
          double price,
      @JsonKey(name: 'priceString')
          String priceString,
      @JsonKey(name: 'period')
          String period,
      @JsonKey(name: 'cycles')
          int cycles,
      @JsonKey(name: 'periodUnit', unknownEnumValue: PeriodUnit.unknown)
          PeriodUnit periodUnit,
      @JsonKey(name: 'periodNumberOfUnits')
          int periodNumberOfUnits) {
    return _IntroductoryPrice(
      price,
      priceString,
      period,
      cycles,
      periodUnit,
      periodNumberOfUnits,
    );
  }

  IntroductoryPrice fromJson(Map<String, Object> json) {
    return IntroductoryPrice.fromJson(json);
  }
}

/// @nodoc
const $IntroductoryPrice = _$IntroductoryPriceTearOff();

/// @nodoc
mixin _$IntroductoryPrice {
  /// Introductory price of a subscription in the local currency.
  @JsonKey(name: 'price')
  double get price => throw _privateConstructorUsedError;

  /// Formatted introductory price of a subscription, including
  /// its currency sign, such as €3.99.
  @JsonKey(name: 'priceString')
  String get priceString => throw _privateConstructorUsedError;

  /// Billing period of the introductory price, specified in
  /// ISO 8601 format.
  @JsonKey(name: 'period')
  String get period => throw _privateConstructorUsedError;

  /// Number of subscription billing periods for which the
  /// user will be given the introductory price, such as 3.
  @JsonKey(name: 'cycles')
  int get cycles => throw _privateConstructorUsedError;

  /// Unit for the billing period of the introductory price, can be DAY, WEEK,
  /// MONTH or YEAR.
  @JsonKey(name: 'periodUnit', unknownEnumValue: PeriodUnit.unknown)
  PeriodUnit get periodUnit => throw _privateConstructorUsedError;

  /// Number of units for the billing period of the introductory price.
  @JsonKey(name: 'periodNumberOfUnits')
  int get periodNumberOfUnits => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IntroductoryPriceCopyWith<IntroductoryPrice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntroductoryPriceCopyWith<$Res> {
  factory $IntroductoryPriceCopyWith(
          IntroductoryPrice value, $Res Function(IntroductoryPrice) then) =
      _$IntroductoryPriceCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'price')
          double price,
      @JsonKey(name: 'priceString')
          String priceString,
      @JsonKey(name: 'period')
          String period,
      @JsonKey(name: 'cycles')
          int cycles,
      @JsonKey(name: 'periodUnit', unknownEnumValue: PeriodUnit.unknown)
          PeriodUnit periodUnit,
      @JsonKey(name: 'periodNumberOfUnits')
          int periodNumberOfUnits});
}

/// @nodoc
class _$IntroductoryPriceCopyWithImpl<$Res>
    implements $IntroductoryPriceCopyWith<$Res> {
  _$IntroductoryPriceCopyWithImpl(this._value, this._then);

  final IntroductoryPrice _value;
  // ignore: unused_field
  final $Res Function(IntroductoryPrice) _then;

  @override
  $Res call({
    Object? price = freezed,
    Object? priceString = freezed,
    Object? period = freezed,
    Object? cycles = freezed,
    Object? periodUnit = freezed,
    Object? periodNumberOfUnits = freezed,
  }) {
    return _then(_value.copyWith(
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      priceString: priceString == freezed
          ? _value.priceString
          : priceString // ignore: cast_nullable_to_non_nullable
              as String,
      period: period == freezed
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      cycles: cycles == freezed
          ? _value.cycles
          : cycles // ignore: cast_nullable_to_non_nullable
              as int,
      periodUnit: periodUnit == freezed
          ? _value.periodUnit
          : periodUnit // ignore: cast_nullable_to_non_nullable
              as PeriodUnit,
      periodNumberOfUnits: periodNumberOfUnits == freezed
          ? _value.periodNumberOfUnits
          : periodNumberOfUnits // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$IntroductoryPriceCopyWith<$Res>
    implements $IntroductoryPriceCopyWith<$Res> {
  factory _$IntroductoryPriceCopyWith(
          _IntroductoryPrice value, $Res Function(_IntroductoryPrice) then) =
      __$IntroductoryPriceCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'price')
          double price,
      @JsonKey(name: 'priceString')
          String priceString,
      @JsonKey(name: 'period')
          String period,
      @JsonKey(name: 'cycles')
          int cycles,
      @JsonKey(name: 'periodUnit', unknownEnumValue: PeriodUnit.unknown)
          PeriodUnit periodUnit,
      @JsonKey(name: 'periodNumberOfUnits')
          int periodNumberOfUnits});
}

/// @nodoc
class __$IntroductoryPriceCopyWithImpl<$Res>
    extends _$IntroductoryPriceCopyWithImpl<$Res>
    implements _$IntroductoryPriceCopyWith<$Res> {
  __$IntroductoryPriceCopyWithImpl(
      _IntroductoryPrice _value, $Res Function(_IntroductoryPrice) _then)
      : super(_value, (v) => _then(v as _IntroductoryPrice));

  @override
  _IntroductoryPrice get _value => super._value as _IntroductoryPrice;

  @override
  $Res call({
    Object? price = freezed,
    Object? priceString = freezed,
    Object? period = freezed,
    Object? cycles = freezed,
    Object? periodUnit = freezed,
    Object? periodNumberOfUnits = freezed,
  }) {
    return _then(_IntroductoryPrice(
      price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      priceString == freezed
          ? _value.priceString
          : priceString // ignore: cast_nullable_to_non_nullable
              as String,
      period == freezed
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      cycles == freezed
          ? _value.cycles
          : cycles // ignore: cast_nullable_to_non_nullable
              as int,
      periodUnit == freezed
          ? _value.periodUnit
          : periodUnit // ignore: cast_nullable_to_non_nullable
              as PeriodUnit,
      periodNumberOfUnits == freezed
          ? _value.periodNumberOfUnits
          : periodNumberOfUnits // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_IntroductoryPrice implements _IntroductoryPrice {
  const _$_IntroductoryPrice(
      @JsonKey(name: 'price')
          this.price,
      @JsonKey(name: 'priceString')
          this.priceString,
      @JsonKey(name: 'period')
          this.period,
      @JsonKey(name: 'cycles')
          this.cycles,
      @JsonKey(name: 'periodUnit', unknownEnumValue: PeriodUnit.unknown)
          this.periodUnit,
      @JsonKey(name: 'periodNumberOfUnits')
          this.periodNumberOfUnits);

  factory _$_IntroductoryPrice.fromJson(Map<String, dynamic> json) =>
      _$$_IntroductoryPriceFromJson(json);

  @override

  /// Introductory price of a subscription in the local currency.
  @JsonKey(name: 'price')
  final double price;
  @override

  /// Formatted introductory price of a subscription, including
  /// its currency sign, such as €3.99.
  @JsonKey(name: 'priceString')
  final String priceString;
  @override

  /// Billing period of the introductory price, specified in
  /// ISO 8601 format.
  @JsonKey(name: 'period')
  final String period;
  @override

  /// Number of subscription billing periods for which the
  /// user will be given the introductory price, such as 3.
  @JsonKey(name: 'cycles')
  final int cycles;
  @override

  /// Unit for the billing period of the introductory price, can be DAY, WEEK,
  /// MONTH or YEAR.
  @JsonKey(name: 'periodUnit', unknownEnumValue: PeriodUnit.unknown)
  final PeriodUnit periodUnit;
  @override

  /// Number of units for the billing period of the introductory price.
  @JsonKey(name: 'periodNumberOfUnits')
  final int periodNumberOfUnits;

  @override
  String toString() {
    return 'IntroductoryPrice(price: $price, priceString: $priceString, period: $period, cycles: $cycles, periodUnit: $periodUnit, periodNumberOfUnits: $periodNumberOfUnits)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _IntroductoryPrice &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.priceString, priceString) ||
                const DeepCollectionEquality()
                    .equals(other.priceString, priceString)) &&
            (identical(other.period, period) ||
                const DeepCollectionEquality().equals(other.period, period)) &&
            (identical(other.cycles, cycles) ||
                const DeepCollectionEquality().equals(other.cycles, cycles)) &&
            (identical(other.periodUnit, periodUnit) ||
                const DeepCollectionEquality()
                    .equals(other.periodUnit, periodUnit)) &&
            (identical(other.periodNumberOfUnits, periodNumberOfUnits) ||
                const DeepCollectionEquality()
                    .equals(other.periodNumberOfUnits, periodNumberOfUnits)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(priceString) ^
      const DeepCollectionEquality().hash(period) ^
      const DeepCollectionEquality().hash(cycles) ^
      const DeepCollectionEquality().hash(periodUnit) ^
      const DeepCollectionEquality().hash(periodNumberOfUnits);

  @JsonKey(ignore: true)
  @override
  _$IntroductoryPriceCopyWith<_IntroductoryPrice> get copyWith =>
      __$IntroductoryPriceCopyWithImpl<_IntroductoryPrice>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_IntroductoryPriceToJson(this);
  }
}

abstract class _IntroductoryPrice implements IntroductoryPrice {
  const factory _IntroductoryPrice(
      @JsonKey(name: 'price')
          double price,
      @JsonKey(name: 'priceString')
          String priceString,
      @JsonKey(name: 'period')
          String period,
      @JsonKey(name: 'cycles')
          int cycles,
      @JsonKey(name: 'periodUnit', unknownEnumValue: PeriodUnit.unknown)
          PeriodUnit periodUnit,
      @JsonKey(name: 'periodNumberOfUnits')
          int periodNumberOfUnits) = _$_IntroductoryPrice;

  factory _IntroductoryPrice.fromJson(Map<String, dynamic> json) =
      _$_IntroductoryPrice.fromJson;

  @override

  /// Introductory price of a subscription in the local currency.
  @JsonKey(name: 'price')
  double get price => throw _privateConstructorUsedError;
  @override

  /// Formatted introductory price of a subscription, including
  /// its currency sign, such as €3.99.
  @JsonKey(name: 'priceString')
  String get priceString => throw _privateConstructorUsedError;
  @override

  /// Billing period of the introductory price, specified in
  /// ISO 8601 format.
  @JsonKey(name: 'period')
  String get period => throw _privateConstructorUsedError;
  @override

  /// Number of subscription billing periods for which the
  /// user will be given the introductory price, such as 3.
  @JsonKey(name: 'cycles')
  int get cycles => throw _privateConstructorUsedError;
  @override

  /// Unit for the billing period of the introductory price, can be DAY, WEEK,
  /// MONTH or YEAR.
  @JsonKey(name: 'periodUnit', unknownEnumValue: PeriodUnit.unknown)
  PeriodUnit get periodUnit => throw _privateConstructorUsedError;
  @override

  /// Number of units for the billing period of the introductory price.
  @JsonKey(name: 'periodNumberOfUnits')
  int get periodNumberOfUnits => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$IntroductoryPriceCopyWith<_IntroductoryPrice> get copyWith =>
      throw _privateConstructorUsedError;
}
