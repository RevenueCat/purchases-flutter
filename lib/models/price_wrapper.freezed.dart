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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Price _$PriceFromJson(Map<String, dynamic> json) {
  return _Price.fromJson(json);
}

/// @nodoc
mixin _$Price {
  @JsonKey(name: 'formatted')
  String get formatted => throw _privateConstructorUsedError;
  @JsonKey(name: 'amountMicros')
  int get amountMicros => throw _privateConstructorUsedError;
  @JsonKey(name: 'currencyCode')
  String get currencyCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PriceCopyWith<Price> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceCopyWith<$Res> {
  factory $PriceCopyWith(Price value, $Res Function(Price) then) =
      _$PriceCopyWithImpl<$Res, Price>;
  @useResult
  $Res call(
      {@JsonKey(name: 'formatted') String formatted,
      @JsonKey(name: 'amountMicros') int amountMicros,
      @JsonKey(name: 'currencyCode') String currencyCode});
}

/// @nodoc
class _$PriceCopyWithImpl<$Res, $Val extends Price>
    implements $PriceCopyWith<$Res> {
  _$PriceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
abstract class _$$_PriceCopyWith<$Res> implements $PriceCopyWith<$Res> {
  factory _$$_PriceCopyWith(_$_Price value, $Res Function(_$_Price) then) =
      __$$_PriceCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'formatted') String formatted,
      @JsonKey(name: 'amountMicros') int amountMicros,
      @JsonKey(name: 'currencyCode') String currencyCode});
}

/// @nodoc
class __$$_PriceCopyWithImpl<$Res> extends _$PriceCopyWithImpl<$Res, _$_Price>
    implements _$$_PriceCopyWith<$Res> {
  __$$_PriceCopyWithImpl(_$_Price _value, $Res Function(_$_Price) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? formatted = null,
    Object? amountMicros = null,
    Object? currencyCode = null,
  }) {
    return _then(_$_Price(
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
class _$_Price implements _Price {
  const _$_Price(
      @JsonKey(name: 'formatted') this.formatted,
      @JsonKey(name: 'amountMicros') this.amountMicros,
      @JsonKey(name: 'currencyCode') this.currencyCode);

  factory _$_Price.fromJson(Map<String, dynamic> json) =>
      _$$_PriceFromJson(json);

  @override
  @JsonKey(name: 'formatted')
  final String formatted;
  @override
  @JsonKey(name: 'amountMicros')
  final int amountMicros;
  @override
  @JsonKey(name: 'currencyCode')
  final String currencyCode;

  @override
  String toString() {
    return 'Price(formatted: $formatted, amountMicros: $amountMicros, currencyCode: $currencyCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Price &&
            (identical(other.formatted, formatted) ||
                other.formatted == formatted) &&
            (identical(other.amountMicros, amountMicros) ||
                other.amountMicros == amountMicros) &&
            (identical(other.currencyCode, currencyCode) ||
                other.currencyCode == currencyCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, formatted, amountMicros, currencyCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PriceCopyWith<_$_Price> get copyWith =>
      __$$_PriceCopyWithImpl<_$_Price>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PriceToJson(
      this,
    );
  }
}

abstract class _Price implements Price {
  const factory _Price(
      @JsonKey(name: 'formatted') final String formatted,
      @JsonKey(name: 'amountMicros') final int amountMicros,
      @JsonKey(name: 'currencyCode') final String currencyCode) = _$_Price;

  factory _Price.fromJson(Map<String, dynamic> json) = _$_Price.fromJson;

  @override
  @JsonKey(name: 'formatted')
  String get formatted;
  @override
  @JsonKey(name: 'amountMicros')
  int get amountMicros;
  @override
  @JsonKey(name: 'currencyCode')
  String get currencyCode;
  @override
  @JsonKey(ignore: true)
  _$$_PriceCopyWith<_$_Price> get copyWith =>
      throw _privateConstructorUsedError;
}
