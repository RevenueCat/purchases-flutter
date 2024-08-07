// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'price_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Price _$PriceFromJson(Map<String, dynamic> json) {
  return _Price.fromJson(json);
}

/// @nodoc
mixin _$Price {
  /// Formatted price of the item, including its currency sign. For example $3.00
  String get formatted => throw _privateConstructorUsedError;

  /// Price in micro-units, where 1,000,000 micro-units equal one unit of the currency.
  ///
  /// For example, if price is "€7.99", price_amount_micros is 7,990,000. This value represents
  /// the localized, rounded price for a particular currency.
  int get amountMicros => throw _privateConstructorUsedError;

  /// Returns ISO 4217 currency code for price and original price.
  ///
  /// For example, if price is specified in British pounds sterling, price_currency_code is "GBP".
  ///
  /// If currency code cannot be determined, currency symbol is returned.
  String get currencyCode => throw _privateConstructorUsedError;

  /// Serializes this Price to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Price
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PriceCopyWith<Price> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceCopyWith<$Res> {
  factory $PriceCopyWith(Price value, $Res Function(Price) then) =
      _$PriceCopyWithImpl<$Res, Price>;
  @useResult
  $Res call({String formatted, int amountMicros, String currencyCode});
}

/// @nodoc
class _$PriceCopyWithImpl<$Res, $Val extends Price>
    implements $PriceCopyWith<$Res> {
  _$PriceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Price
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? formatted = null,
    Object? amountMicros = null,
    Object? currencyCode = null,
  }) {
    return _then(_value.copyWith(
      formatted: null == formatted
          ? _value.formatted
          : formatted // ignore: cast_nullable_to_non_nullable
              as String,
      amountMicros: null == amountMicros
          ? _value.amountMicros
          : amountMicros // ignore: cast_nullable_to_non_nullable
              as int,
      currencyCode: null == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PriceImplCopyWith<$Res> implements $PriceCopyWith<$Res> {
  factory _$$PriceImplCopyWith(
          _$PriceImpl value, $Res Function(_$PriceImpl) then) =
      __$$PriceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String formatted, int amountMicros, String currencyCode});
}

/// @nodoc
class __$$PriceImplCopyWithImpl<$Res>
    extends _$PriceCopyWithImpl<$Res, _$PriceImpl>
    implements _$$PriceImplCopyWith<$Res> {
  __$$PriceImplCopyWithImpl(
      _$PriceImpl _value, $Res Function(_$PriceImpl) _then)
      : super(_value, _then);

  /// Create a copy of Price
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? formatted = null,
    Object? amountMicros = null,
    Object? currencyCode = null,
  }) {
    return _then(_$PriceImpl(
      null == formatted
          ? _value.formatted
          : formatted // ignore: cast_nullable_to_non_nullable
              as String,
      null == amountMicros
          ? _value.amountMicros
          : amountMicros // ignore: cast_nullable_to_non_nullable
              as int,
      null == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PriceImpl implements _Price {
  const _$PriceImpl(this.formatted, this.amountMicros, this.currencyCode);

  factory _$PriceImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriceImplFromJson(json);

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

  @override
  String toString() {
    return 'Price(formatted: $formatted, amountMicros: $amountMicros, currencyCode: $currencyCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriceImpl &&
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

  /// Create a copy of Price
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceImplCopyWith<_$PriceImpl> get copyWith =>
      __$$PriceImplCopyWithImpl<_$PriceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceImplToJson(
      this,
    );
  }
}

abstract class _Price implements Price {
  const factory _Price(final String formatted, final int amountMicros,
      final String currencyCode) = _$PriceImpl;

  factory _Price.fromJson(Map<String, dynamic> json) = _$PriceImpl.fromJson;

  /// Formatted price of the item, including its currency sign. For example $3.00
  @override
  String get formatted;

  /// Price in micro-units, where 1,000,000 micro-units equal one unit of the currency.
  ///
  /// For example, if price is "€7.99", price_amount_micros is 7,990,000. This value represents
  /// the localized, rounded price for a particular currency.
  @override
  int get amountMicros;

  /// Returns ISO 4217 currency code for price and original price.
  ///
  /// For example, if price is specified in British pounds sterling, price_currency_code is "GBP".
  ///
  /// If currency code cannot be determined, currency symbol is returned.
  @override
  String get currencyCode;

  /// Create a copy of Price
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PriceImplCopyWith<_$PriceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
