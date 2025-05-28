// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'win_back_offer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WinBackOffer {
  /// Identifier of the discount.
  String get identifier;

  /// Identifier of the discount.
  double get price;

  /// Formatted price, including its currency sign, such as €3.99.
  String get priceString;

  /// Number of subscription billing periods for which the user will be given the discount, such as 3.
  int get cycles;

  /// Billing period of the discount, specified in ISO 8601 format.
  String get period;

  /// Unit for the billing period of the discount, can be DAY, WEEK, MONTH or YEAR.
  String get periodUnit;

  /// Number of units for the billing period of the discount.
  int get periodNumberOfUnits;

  /// Create a copy of WinBackOffer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WinBackOfferCopyWith<WinBackOffer> get copyWith =>
      _$WinBackOfferCopyWithImpl<WinBackOffer>(
          this as WinBackOffer, _$identity);

  /// Serializes this WinBackOffer to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WinBackOffer &&
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

  @override
  String toString() {
    return 'WinBackOffer(identifier: $identifier, price: $price, priceString: $priceString, cycles: $cycles, period: $period, periodUnit: $periodUnit, periodNumberOfUnits: $periodNumberOfUnits)';
  }
}

/// @nodoc
abstract mixin class $WinBackOfferCopyWith<$Res> {
  factory $WinBackOfferCopyWith(
          WinBackOffer value, $Res Function(WinBackOffer) _then) =
      _$WinBackOfferCopyWithImpl;
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
class _$WinBackOfferCopyWithImpl<$Res> implements $WinBackOfferCopyWith<$Res> {
  _$WinBackOfferCopyWithImpl(this._self, this._then);

  final WinBackOffer _self;
  final $Res Function(WinBackOffer) _then;

  /// Create a copy of WinBackOffer
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
    return _then(_self.copyWith(
      identifier: null == identifier
          ? _self.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      priceString: null == priceString
          ? _self.priceString
          : priceString // ignore: cast_nullable_to_non_nullable
              as String,
      cycles: null == cycles
          ? _self.cycles
          : cycles // ignore: cast_nullable_to_non_nullable
              as int,
      period: null == period
          ? _self.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      periodUnit: null == periodUnit
          ? _self.periodUnit
          : periodUnit // ignore: cast_nullable_to_non_nullable
              as String,
      periodNumberOfUnits: null == periodNumberOfUnits
          ? _self.periodNumberOfUnits
          : periodNumberOfUnits // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WinBackOffer implements WinBackOffer {
  const _WinBackOffer(this.identifier, this.price, this.priceString,
      this.cycles, this.period, this.periodUnit, this.periodNumberOfUnits);
  factory _WinBackOffer.fromJson(Map<String, dynamic> json) =>
      _$WinBackOfferFromJson(json);

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

  /// Create a copy of WinBackOffer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WinBackOfferCopyWith<_WinBackOffer> get copyWith =>
      __$WinBackOfferCopyWithImpl<_WinBackOffer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WinBackOfferToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WinBackOffer &&
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

  @override
  String toString() {
    return 'WinBackOffer(identifier: $identifier, price: $price, priceString: $priceString, cycles: $cycles, period: $period, periodUnit: $periodUnit, periodNumberOfUnits: $periodNumberOfUnits)';
  }
}

/// @nodoc
abstract mixin class _$WinBackOfferCopyWith<$Res>
    implements $WinBackOfferCopyWith<$Res> {
  factory _$WinBackOfferCopyWith(
          _WinBackOffer value, $Res Function(_WinBackOffer) _then) =
      __$WinBackOfferCopyWithImpl;
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
class __$WinBackOfferCopyWithImpl<$Res>
    implements _$WinBackOfferCopyWith<$Res> {
  __$WinBackOfferCopyWithImpl(this._self, this._then);

  final _WinBackOffer _self;
  final $Res Function(_WinBackOffer) _then;

  /// Create a copy of WinBackOffer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? identifier = null,
    Object? price = null,
    Object? priceString = null,
    Object? cycles = null,
    Object? period = null,
    Object? periodUnit = null,
    Object? periodNumberOfUnits = null,
  }) {
    return _then(_WinBackOffer(
      null == identifier
          ? _self.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      null == priceString
          ? _self.priceString
          : priceString // ignore: cast_nullable_to_non_nullable
              as String,
      null == cycles
          ? _self.cycles
          : cycles // ignore: cast_nullable_to_non_nullable
              as int,
      null == period
          ? _self.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      null == periodUnit
          ? _self.periodUnit
          : periodUnit // ignore: cast_nullable_to_non_nullable
              as String,
      null == periodNumberOfUnits
          ? _self.periodNumberOfUnits
          : periodNumberOfUnits // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
