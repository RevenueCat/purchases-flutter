// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'introductory_price.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntroductoryPrice {
  /// Introductory price of a subscription in the local currency.
  double get price;

  /// Formatted introductory price of a subscription, including
  /// its currency sign, such as €3.99.
  String get priceString;

  /// Billing period of the introductory price, specified in
  /// ISO 8601 format.
  String get period;

  /// Number of subscription billing periods for which the
  /// user will be given the introductory price, such as 3.
  int get cycles;

  /// Unit for the billing period of the introductory price, can be DAY, WEEK,
  /// MONTH or YEAR.
// ignore: invalid_annotation_target
  @JsonKey(name: 'periodUnit', unknownEnumValue: PeriodUnit.unknown)
  PeriodUnit get periodUnit;

  /// Number of units for the billing period of the introductory price.
  int get periodNumberOfUnits;

  /// Create a copy of IntroductoryPrice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $IntroductoryPriceCopyWith<IntroductoryPrice> get copyWith =>
      _$IntroductoryPriceCopyWithImpl<IntroductoryPrice>(
          this as IntroductoryPrice, _$identity);

  /// Serializes this IntroductoryPrice to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is IntroductoryPrice &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.priceString, priceString) ||
                other.priceString == priceString) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.cycles, cycles) || other.cycles == cycles) &&
            (identical(other.periodUnit, periodUnit) ||
                other.periodUnit == periodUnit) &&
            (identical(other.periodNumberOfUnits, periodNumberOfUnits) ||
                other.periodNumberOfUnits == periodNumberOfUnits));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, price, priceString, period,
      cycles, periodUnit, periodNumberOfUnits);

  @override
  String toString() {
    return 'IntroductoryPrice(price: $price, priceString: $priceString, period: $period, cycles: $cycles, periodUnit: $periodUnit, periodNumberOfUnits: $periodNumberOfUnits)';
  }
}

/// @nodoc
abstract mixin class $IntroductoryPriceCopyWith<$Res> {
  factory $IntroductoryPriceCopyWith(
          IntroductoryPrice value, $Res Function(IntroductoryPrice) _then) =
      _$IntroductoryPriceCopyWithImpl;
  @useResult
  $Res call(
      {double price,
      String priceString,
      String period,
      int cycles,
      @JsonKey(name: 'periodUnit', unknownEnumValue: PeriodUnit.unknown)
      PeriodUnit periodUnit,
      int periodNumberOfUnits});
}

/// @nodoc
class _$IntroductoryPriceCopyWithImpl<$Res>
    implements $IntroductoryPriceCopyWith<$Res> {
  _$IntroductoryPriceCopyWithImpl(this._self, this._then);

  final IntroductoryPrice _self;
  final $Res Function(IntroductoryPrice) _then;

  /// Create a copy of IntroductoryPrice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? price = null,
    Object? priceString = null,
    Object? period = null,
    Object? cycles = null,
    Object? periodUnit = null,
    Object? periodNumberOfUnits = null,
  }) {
    return _then(_self.copyWith(
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      priceString: null == priceString
          ? _self.priceString
          : priceString // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _self.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      cycles: null == cycles
          ? _self.cycles
          : cycles // ignore: cast_nullable_to_non_nullable
              as int,
      periodUnit: null == periodUnit
          ? _self.periodUnit
          : periodUnit // ignore: cast_nullable_to_non_nullable
              as PeriodUnit,
      periodNumberOfUnits: null == periodNumberOfUnits
          ? _self.periodNumberOfUnits
          : periodNumberOfUnits // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _IntroductoryPrice implements IntroductoryPrice {
  const _IntroductoryPrice(
      this.price,
      this.priceString,
      this.period,
      this.cycles,
      @JsonKey(name: 'periodUnit', unknownEnumValue: PeriodUnit.unknown)
      this.periodUnit,
      this.periodNumberOfUnits);
  factory _IntroductoryPrice.fromJson(Map<String, dynamic> json) =>
      _$IntroductoryPriceFromJson(json);

  /// Introductory price of a subscription in the local currency.
  @override
  final double price;

  /// Formatted introductory price of a subscription, including
  /// its currency sign, such as €3.99.
  @override
  final String priceString;

  /// Billing period of the introductory price, specified in
  /// ISO 8601 format.
  @override
  final String period;

  /// Number of subscription billing periods for which the
  /// user will be given the introductory price, such as 3.
  @override
  final int cycles;

  /// Unit for the billing period of the introductory price, can be DAY, WEEK,
  /// MONTH or YEAR.
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'periodUnit', unknownEnumValue: PeriodUnit.unknown)
  final PeriodUnit periodUnit;

  /// Number of units for the billing period of the introductory price.
  @override
  final int periodNumberOfUnits;

  /// Create a copy of IntroductoryPrice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$IntroductoryPriceCopyWith<_IntroductoryPrice> get copyWith =>
      __$IntroductoryPriceCopyWithImpl<_IntroductoryPrice>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$IntroductoryPriceToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _IntroductoryPrice &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.priceString, priceString) ||
                other.priceString == priceString) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.cycles, cycles) || other.cycles == cycles) &&
            (identical(other.periodUnit, periodUnit) ||
                other.periodUnit == periodUnit) &&
            (identical(other.periodNumberOfUnits, periodNumberOfUnits) ||
                other.periodNumberOfUnits == periodNumberOfUnits));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, price, priceString, period,
      cycles, periodUnit, periodNumberOfUnits);

  @override
  String toString() {
    return 'IntroductoryPrice(price: $price, priceString: $priceString, period: $period, cycles: $cycles, periodUnit: $periodUnit, periodNumberOfUnits: $periodNumberOfUnits)';
  }
}

/// @nodoc
abstract mixin class _$IntroductoryPriceCopyWith<$Res>
    implements $IntroductoryPriceCopyWith<$Res> {
  factory _$IntroductoryPriceCopyWith(
          _IntroductoryPrice value, $Res Function(_IntroductoryPrice) _then) =
      __$IntroductoryPriceCopyWithImpl;
  @override
  @useResult
  $Res call(
      {double price,
      String priceString,
      String period,
      int cycles,
      @JsonKey(name: 'periodUnit', unknownEnumValue: PeriodUnit.unknown)
      PeriodUnit periodUnit,
      int periodNumberOfUnits});
}

/// @nodoc
class __$IntroductoryPriceCopyWithImpl<$Res>
    implements _$IntroductoryPriceCopyWith<$Res> {
  __$IntroductoryPriceCopyWithImpl(this._self, this._then);

  final _IntroductoryPrice _self;
  final $Res Function(_IntroductoryPrice) _then;

  /// Create a copy of IntroductoryPrice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? price = null,
    Object? priceString = null,
    Object? period = null,
    Object? cycles = null,
    Object? periodUnit = null,
    Object? periodNumberOfUnits = null,
  }) {
    return _then(_IntroductoryPrice(
      null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      null == priceString
          ? _self.priceString
          : priceString // ignore: cast_nullable_to_non_nullable
              as String,
      null == period
          ? _self.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      null == cycles
          ? _self.cycles
          : cycles // ignore: cast_nullable_to_non_nullable
              as int,
      null == periodUnit
          ? _self.periodUnit
          : periodUnit // ignore: cast_nullable_to_non_nullable
              as PeriodUnit,
      null == periodNumberOfUnits
          ? _self.periodNumberOfUnits
          : periodNumberOfUnits // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
