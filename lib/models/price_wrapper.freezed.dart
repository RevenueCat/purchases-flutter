// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'price_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Price {
  /// Formatted price of the item, including its currency sign. For example $3.00
  String get formatted;

  /// Price in micro-units, where 1,000,000 micro-units equal one unit of the currency.
  ///
  /// For example, if price is "€7.99", price_amount_micros is 7,990,000. This value represents
  /// the localized, rounded price for a particular currency.
  int get amountMicros;

  /// Returns ISO 4217 currency code for price and original price.
  ///
  /// For example, if price is specified in British pounds sterling, price_currency_code is "GBP".
  ///
  /// If currency code cannot be determined, currency symbol is returned.
  String get currencyCode;

  /// Create a copy of Price
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PriceCopyWith<Price> get copyWith =>
      _$PriceCopyWithImpl<Price>(this as Price, _$identity);

  /// Serializes this Price to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Price &&
            (identical(other.formatted, formatted) ||
                other.formatted == formatted) &&
            (identical(other.amountMicros, amountMicros) ||
                other.amountMicros == amountMicros) &&
            (identical(other.currencyCode, currencyCode) ||
                other.currencyCode == currencyCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, formatted, amountMicros, currencyCode);

  @override
  String toString() {
    return 'Price(formatted: $formatted, amountMicros: $amountMicros, currencyCode: $currencyCode)';
  }
}

/// @nodoc
abstract mixin class $PriceCopyWith<$Res> {
  factory $PriceCopyWith(Price value, $Res Function(Price) _then) =
      _$PriceCopyWithImpl;
  @useResult
  $Res call({String formatted, int amountMicros, String currencyCode});
}

/// @nodoc
class _$PriceCopyWithImpl<$Res> implements $PriceCopyWith<$Res> {
  _$PriceCopyWithImpl(this._self, this._then);

  final Price _self;
  final $Res Function(Price) _then;

  /// Create a copy of Price
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? formatted = null,
    Object? amountMicros = null,
    Object? currencyCode = null,
  }) {
    return _then(_self.copyWith(
      formatted: null == formatted
          ? _self.formatted
          : formatted // ignore: cast_nullable_to_non_nullable
              as String,
      amountMicros: null == amountMicros
          ? _self.amountMicros
          : amountMicros // ignore: cast_nullable_to_non_nullable
              as int,
      currencyCode: null == currencyCode
          ? _self.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Price implements Price {
  const _Price(this.formatted, this.amountMicros, this.currencyCode);
  factory _Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);

  /// Formatted price of the item, including its currency sign. For example $3.00
  @override
  final String formatted;

  /// Price in micro-units, where 1,000,000 micro-units equal one unit of the currency.
  ///
  /// For example, if price is "€7.99", price_amount_micros is 7,990,000. This value represents
  /// the localized, rounded price for a particular currency.
  @override
  final int amountMicros;

  /// Returns ISO 4217 currency code for price and original price.
  ///
  /// For example, if price is specified in British pounds sterling, price_currency_code is "GBP".
  ///
  /// If currency code cannot be determined, currency symbol is returned.
  @override
  final String currencyCode;

  /// Create a copy of Price
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PriceCopyWith<_Price> get copyWith =>
      __$PriceCopyWithImpl<_Price>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PriceToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Price &&
            (identical(other.formatted, formatted) ||
                other.formatted == formatted) &&
            (identical(other.amountMicros, amountMicros) ||
                other.amountMicros == amountMicros) &&
            (identical(other.currencyCode, currencyCode) ||
                other.currencyCode == currencyCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, formatted, amountMicros, currencyCode);

  @override
  String toString() {
    return 'Price(formatted: $formatted, amountMicros: $amountMicros, currencyCode: $currencyCode)';
  }
}

/// @nodoc
abstract mixin class _$PriceCopyWith<$Res> implements $PriceCopyWith<$Res> {
  factory _$PriceCopyWith(_Price value, $Res Function(_Price) _then) =
      __$PriceCopyWithImpl;
  @override
  @useResult
  $Res call({String formatted, int amountMicros, String currencyCode});
}

/// @nodoc
class __$PriceCopyWithImpl<$Res> implements _$PriceCopyWith<$Res> {
  __$PriceCopyWithImpl(this._self, this._then);

  final _Price _self;
  final $Res Function(_Price) _then;

  /// Create a copy of Price
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? formatted = null,
    Object? amountMicros = null,
    Object? currencyCode = null,
  }) {
    return _then(_Price(
      null == formatted
          ? _self.formatted
          : formatted // ignore: cast_nullable_to_non_nullable
              as String,
      null == amountMicros
          ? _self.amountMicros
          : amountMicros // ignore: cast_nullable_to_non_nullable
              as int,
      null == currencyCode
          ? _self.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
