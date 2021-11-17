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
      @JsonKey(name: 'intro_price')
          double introPrice,
      @JsonKey(name: 'intro_price_string')
          String introPriceString,
      @JsonKey(name: 'intro_price_period')
          String introPricePeriod,
      @JsonKey(name: 'intro_price_period_unit')
          String introPricePeriodUnit,
      @JsonKey(name: 'intro_price_period_number_of_units')
          int introPricePeriodNumberOfUnits,
      @JsonKey(name: 'intro_price_cycles')
          int introPriceCycles) {
    return _IntroductoryPrice(
      introPrice,
      introPriceString,
      introPricePeriod,
      introPricePeriodUnit,
      introPricePeriodNumberOfUnits,
      introPriceCycles,
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
  @JsonKey(name: 'intro_price')
  double get introPrice => throw _privateConstructorUsedError;

  /// Formatted introductory price of a subscription, including
  /// its currency sign, such as €3.99.
  @JsonKey(name: 'intro_price_string')
  String get introPriceString => throw _privateConstructorUsedError;

  /// Billing period of the introductory price, specified in
  /// ISO 8601 format.
  @JsonKey(name: 'intro_price_period')
  String get introPricePeriod => throw _privateConstructorUsedError;

  /// Unit for the billing period of the introductory price, can be DAY, WEEK,
  /// MONTH or YEAR.
  @JsonKey(name: 'intro_price_period_unit')
  String get introPricePeriodUnit => throw _privateConstructorUsedError;

  /// Number of units for the billing period of the introductory price.
  @JsonKey(name: 'intro_price_period_number_of_units')
  int get introPricePeriodNumberOfUnits => throw _privateConstructorUsedError;

  /// Number of subscription billing periods for which the
  /// user will be given the introductory price, such as 3.
  @JsonKey(name: 'intro_price_cycles')
  int get introPriceCycles => throw _privateConstructorUsedError;

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
      {@JsonKey(name: 'intro_price')
          double introPrice,
      @JsonKey(name: 'intro_price_string')
          String introPriceString,
      @JsonKey(name: 'intro_price_period')
          String introPricePeriod,
      @JsonKey(name: 'intro_price_period_unit')
          String introPricePeriodUnit,
      @JsonKey(name: 'intro_price_period_number_of_units')
          int introPricePeriodNumberOfUnits,
      @JsonKey(name: 'intro_price_cycles')
          int introPriceCycles});
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
    Object? introPrice = freezed,
    Object? introPriceString = freezed,
    Object? introPricePeriod = freezed,
    Object? introPricePeriodUnit = freezed,
    Object? introPricePeriodNumberOfUnits = freezed,
    Object? introPriceCycles = freezed,
  }) {
    return _then(_value.copyWith(
      introPrice: introPrice == freezed
          ? _value.introPrice
          : introPrice // ignore: cast_nullable_to_non_nullable
              as double,
      introPriceString: introPriceString == freezed
          ? _value.introPriceString
          : introPriceString // ignore: cast_nullable_to_non_nullable
              as String,
      introPricePeriod: introPricePeriod == freezed
          ? _value.introPricePeriod
          : introPricePeriod // ignore: cast_nullable_to_non_nullable
              as String,
      introPricePeriodUnit: introPricePeriodUnit == freezed
          ? _value.introPricePeriodUnit
          : introPricePeriodUnit // ignore: cast_nullable_to_non_nullable
              as String,
      introPricePeriodNumberOfUnits: introPricePeriodNumberOfUnits == freezed
          ? _value.introPricePeriodNumberOfUnits
          : introPricePeriodNumberOfUnits // ignore: cast_nullable_to_non_nullable
              as int,
      introPriceCycles: introPriceCycles == freezed
          ? _value.introPriceCycles
          : introPriceCycles // ignore: cast_nullable_to_non_nullable
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
      {@JsonKey(name: 'intro_price')
          double introPrice,
      @JsonKey(name: 'intro_price_string')
          String introPriceString,
      @JsonKey(name: 'intro_price_period')
          String introPricePeriod,
      @JsonKey(name: 'intro_price_period_unit')
          String introPricePeriodUnit,
      @JsonKey(name: 'intro_price_period_number_of_units')
          int introPricePeriodNumberOfUnits,
      @JsonKey(name: 'intro_price_cycles')
          int introPriceCycles});
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
    Object? introPrice = freezed,
    Object? introPriceString = freezed,
    Object? introPricePeriod = freezed,
    Object? introPricePeriodUnit = freezed,
    Object? introPricePeriodNumberOfUnits = freezed,
    Object? introPriceCycles = freezed,
  }) {
    return _then(_IntroductoryPrice(
      introPrice == freezed
          ? _value.introPrice
          : introPrice // ignore: cast_nullable_to_non_nullable
              as double,
      introPriceString == freezed
          ? _value.introPriceString
          : introPriceString // ignore: cast_nullable_to_non_nullable
              as String,
      introPricePeriod == freezed
          ? _value.introPricePeriod
          : introPricePeriod // ignore: cast_nullable_to_non_nullable
              as String,
      introPricePeriodUnit == freezed
          ? _value.introPricePeriodUnit
          : introPricePeriodUnit // ignore: cast_nullable_to_non_nullable
              as String,
      introPricePeriodNumberOfUnits == freezed
          ? _value.introPricePeriodNumberOfUnits
          : introPricePeriodNumberOfUnits // ignore: cast_nullable_to_non_nullable
              as int,
      introPriceCycles == freezed
          ? _value.introPriceCycles
          : introPriceCycles // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_IntroductoryPrice implements _IntroductoryPrice {
  const _$_IntroductoryPrice(
      @JsonKey(name: 'intro_price')
          this.introPrice,
      @JsonKey(name: 'intro_price_string')
          this.introPriceString,
      @JsonKey(name: 'intro_price_period')
          this.introPricePeriod,
      @JsonKey(name: 'intro_price_period_unit')
          this.introPricePeriodUnit,
      @JsonKey(name: 'intro_price_period_number_of_units')
          this.introPricePeriodNumberOfUnits,
      @JsonKey(name: 'intro_price_cycles')
          this.introPriceCycles);

  factory _$_IntroductoryPrice.fromJson(Map<String, dynamic> json) =>
      _$$_IntroductoryPriceFromJson(json);

  @override

  /// Introductory price of a subscription in the local currency.
  @JsonKey(name: 'intro_price')
  final double introPrice;
  @override

  /// Formatted introductory price of a subscription, including
  /// its currency sign, such as €3.99.
  @JsonKey(name: 'intro_price_string')
  final String introPriceString;
  @override

  /// Billing period of the introductory price, specified in
  /// ISO 8601 format.
  @JsonKey(name: 'intro_price_period')
  final String introPricePeriod;
  @override

  /// Unit for the billing period of the introductory price, can be DAY, WEEK,
  /// MONTH or YEAR.
  @JsonKey(name: 'intro_price_period_unit')
  final String introPricePeriodUnit;
  @override

  /// Number of units for the billing period of the introductory price.
  @JsonKey(name: 'intro_price_period_number_of_units')
  final int introPricePeriodNumberOfUnits;
  @override

  /// Number of subscription billing periods for which the
  /// user will be given the introductory price, such as 3.
  @JsonKey(name: 'intro_price_cycles')
  final int introPriceCycles;

  @override
  String toString() {
    return 'IntroductoryPrice(introPrice: $introPrice, introPriceString: $introPriceString, introPricePeriod: $introPricePeriod, introPricePeriodUnit: $introPricePeriodUnit, introPricePeriodNumberOfUnits: $introPricePeriodNumberOfUnits, introPriceCycles: $introPriceCycles)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _IntroductoryPrice &&
            (identical(other.introPrice, introPrice) ||
                const DeepCollectionEquality()
                    .equals(other.introPrice, introPrice)) &&
            (identical(other.introPriceString, introPriceString) ||
                const DeepCollectionEquality()
                    .equals(other.introPriceString, introPriceString)) &&
            (identical(other.introPricePeriod, introPricePeriod) ||
                const DeepCollectionEquality()
                    .equals(other.introPricePeriod, introPricePeriod)) &&
            (identical(other.introPricePeriodUnit, introPricePeriodUnit) ||
                const DeepCollectionEquality().equals(
                    other.introPricePeriodUnit, introPricePeriodUnit)) &&
            (identical(other.introPricePeriodNumberOfUnits,
                    introPricePeriodNumberOfUnits) ||
                const DeepCollectionEquality().equals(
                    other.introPricePeriodNumberOfUnits,
                    introPricePeriodNumberOfUnits)) &&
            (identical(other.introPriceCycles, introPriceCycles) ||
                const DeepCollectionEquality()
                    .equals(other.introPriceCycles, introPriceCycles)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(introPrice) ^
      const DeepCollectionEquality().hash(introPriceString) ^
      const DeepCollectionEquality().hash(introPricePeriod) ^
      const DeepCollectionEquality().hash(introPricePeriodUnit) ^
      const DeepCollectionEquality().hash(introPricePeriodNumberOfUnits) ^
      const DeepCollectionEquality().hash(introPriceCycles);

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
      @JsonKey(name: 'intro_price')
          double introPrice,
      @JsonKey(name: 'intro_price_string')
          String introPriceString,
      @JsonKey(name: 'intro_price_period')
          String introPricePeriod,
      @JsonKey(name: 'intro_price_period_unit')
          String introPricePeriodUnit,
      @JsonKey(name: 'intro_price_period_number_of_units')
          int introPricePeriodNumberOfUnits,
      @JsonKey(name: 'intro_price_cycles')
          int introPriceCycles) = _$_IntroductoryPrice;

  factory _IntroductoryPrice.fromJson(Map<String, dynamic> json) =
      _$_IntroductoryPrice.fromJson;

  @override

  /// Introductory price of a subscription in the local currency.
  @JsonKey(name: 'intro_price')
  double get introPrice => throw _privateConstructorUsedError;
  @override

  /// Formatted introductory price of a subscription, including
  /// its currency sign, such as €3.99.
  @JsonKey(name: 'intro_price_string')
  String get introPriceString => throw _privateConstructorUsedError;
  @override

  /// Billing period of the introductory price, specified in
  /// ISO 8601 format.
  @JsonKey(name: 'intro_price_period')
  String get introPricePeriod => throw _privateConstructorUsedError;
  @override

  /// Unit for the billing period of the introductory price, can be DAY, WEEK,
  /// MONTH or YEAR.
  @JsonKey(name: 'intro_price_period_unit')
  String get introPricePeriodUnit => throw _privateConstructorUsedError;
  @override

  /// Number of units for the billing period of the introductory price.
  @JsonKey(name: 'intro_price_period_number_of_units')
  int get introPricePeriodNumberOfUnits => throw _privateConstructorUsedError;
  @override

  /// Number of subscription billing periods for which the
  /// user will be given the introductory price, such as 3.
  @JsonKey(name: 'intro_price_cycles')
  int get introPriceCycles => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$IntroductoryPriceCopyWith<_IntroductoryPrice> get copyWith =>
      throw _privateConstructorUsedError;
}
