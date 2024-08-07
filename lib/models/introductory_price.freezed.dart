// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'introductory_price.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

IntroductoryPrice _$IntroductoryPriceFromJson(Map<String, dynamic> json) {
  return _IntroductoryPrice.fromJson(json);
}

/// @nodoc
mixin _$IntroductoryPrice {
  /// Introductory price of a subscription in the local currency.
  double get price => throw _privateConstructorUsedError;

  /// Formatted introductory price of a subscription, including
  /// its currency sign, such as €3.99.
  String get priceString => throw _privateConstructorUsedError;

  /// Billing period of the introductory price, specified in
  /// ISO 8601 format.
  String get period => throw _privateConstructorUsedError;

  /// Number of subscription billing periods for which the
  /// user will be given the introductory price, such as 3.
  int get cycles => throw _privateConstructorUsedError;

  /// Unit for the billing period of the introductory price, can be DAY, WEEK,
  /// MONTH or YEAR.
// ignore: invalid_annotation_target
  @JsonKey(name: 'periodUnit', unknownEnumValue: PeriodUnit.unknown)
  PeriodUnit get periodUnit => throw _privateConstructorUsedError;

  /// Number of units for the billing period of the introductory price.
  int get periodNumberOfUnits => throw _privateConstructorUsedError;

  /// Serializes this IntroductoryPrice to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IntroductoryPrice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IntroductoryPriceCopyWith<IntroductoryPrice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntroductoryPriceCopyWith<$Res> {
  factory $IntroductoryPriceCopyWith(
          IntroductoryPrice value, $Res Function(IntroductoryPrice) then) =
      _$IntroductoryPriceCopyWithImpl<$Res, IntroductoryPrice>;
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
class _$IntroductoryPriceCopyWithImpl<$Res, $Val extends IntroductoryPrice>
    implements $IntroductoryPriceCopyWith<$Res> {
  _$IntroductoryPriceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      priceString: null == priceString
          ? _value.priceString
          : priceString // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      cycles: null == cycles
          ? _value.cycles
          : cycles // ignore: cast_nullable_to_non_nullable
              as int,
      periodUnit: null == periodUnit
          ? _value.periodUnit
          : periodUnit // ignore: cast_nullable_to_non_nullable
              as PeriodUnit,
      periodNumberOfUnits: null == periodNumberOfUnits
          ? _value.periodNumberOfUnits
          : periodNumberOfUnits // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IntroductoryPriceImplCopyWith<$Res>
    implements $IntroductoryPriceCopyWith<$Res> {
  factory _$$IntroductoryPriceImplCopyWith(_$IntroductoryPriceImpl value,
          $Res Function(_$IntroductoryPriceImpl) then) =
      __$$IntroductoryPriceImplCopyWithImpl<$Res>;
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
class __$$IntroductoryPriceImplCopyWithImpl<$Res>
    extends _$IntroductoryPriceCopyWithImpl<$Res, _$IntroductoryPriceImpl>
    implements _$$IntroductoryPriceImplCopyWith<$Res> {
  __$$IntroductoryPriceImplCopyWithImpl(_$IntroductoryPriceImpl _value,
      $Res Function(_$IntroductoryPriceImpl) _then)
      : super(_value, _then);

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
    return _then(_$IntroductoryPriceImpl(
      null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      null == priceString
          ? _value.priceString
          : priceString // ignore: cast_nullable_to_non_nullable
              as String,
      null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      null == cycles
          ? _value.cycles
          : cycles // ignore: cast_nullable_to_non_nullable
              as int,
      null == periodUnit
          ? _value.periodUnit
          : periodUnit // ignore: cast_nullable_to_non_nullable
              as PeriodUnit,
      null == periodNumberOfUnits
          ? _value.periodNumberOfUnits
          : periodNumberOfUnits // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IntroductoryPriceImpl implements _IntroductoryPrice {
  const _$IntroductoryPriceImpl(
      this.price,
      this.priceString,
      this.period,
      this.cycles,
      @JsonKey(name: 'periodUnit', unknownEnumValue: PeriodUnit.unknown)
      this.periodUnit,
      this.periodNumberOfUnits);

  factory _$IntroductoryPriceImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntroductoryPriceImplFromJson(json);

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

  @override
  String toString() {
    return 'IntroductoryPrice(price: $price, priceString: $priceString, period: $period, cycles: $cycles, periodUnit: $periodUnit, periodNumberOfUnits: $periodNumberOfUnits)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntroductoryPriceImpl &&
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

  /// Create a copy of IntroductoryPrice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IntroductoryPriceImplCopyWith<_$IntroductoryPriceImpl> get copyWith =>
      __$$IntroductoryPriceImplCopyWithImpl<_$IntroductoryPriceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IntroductoryPriceImplToJson(
      this,
    );
  }
}

abstract class _IntroductoryPrice implements IntroductoryPrice {
  const factory _IntroductoryPrice(
      final double price,
      final String priceString,
      final String period,
      final int cycles,
      @JsonKey(name: 'periodUnit', unknownEnumValue: PeriodUnit.unknown)
      final PeriodUnit periodUnit,
      final int periodNumberOfUnits) = _$IntroductoryPriceImpl;

  factory _IntroductoryPrice.fromJson(Map<String, dynamic> json) =
      _$IntroductoryPriceImpl.fromJson;

  /// Introductory price of a subscription in the local currency.
  @override
  double get price;

  /// Formatted introductory price of a subscription, including
  /// its currency sign, such as €3.99.
  @override
  String get priceString;

  /// Billing period of the introductory price, specified in
  /// ISO 8601 format.
  @override
  String get period;

  /// Number of subscription billing periods for which the
  /// user will be given the introductory price, such as 3.
  @override
  int get cycles;

  /// Unit for the billing period of the introductory price, can be DAY, WEEK,
  /// MONTH or YEAR.
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'periodUnit', unknownEnumValue: PeriodUnit.unknown)
  PeriodUnit get periodUnit;

  /// Number of units for the billing period of the introductory price.
  @override
  int get periodNumberOfUnits;

  /// Create a copy of IntroductoryPrice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IntroductoryPriceImplCopyWith<_$IntroductoryPriceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
