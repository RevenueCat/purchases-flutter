// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'period_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Period _$PeriodFromJson(Map<String, dynamic> json) {
  return _Period.fromJson(json);
}

/// @nodoc
mixin _$Period {
  /// The number of period units: day, week, month, year, unknown
  PeriodUnit get unit => throw _privateConstructorUsedError;

  /// The increment of time that a subscription period is specified in
  int get value => throw _privateConstructorUsedError;

  /// Specified in ISO 8601 format. For example, P1W equates to one week,
  /// P1M equates to one month, P3M equates to three months, P6M equates to
  /// six months, and P1Y equates to one year
  String get iso8601 => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PeriodCopyWith<Period> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PeriodCopyWith<$Res> {
  factory $PeriodCopyWith(Period value, $Res Function(Period) then) =
      _$PeriodCopyWithImpl<$Res, Period>;
  @useResult
  $Res call({PeriodUnit unit, int value, String iso8601});
}

/// @nodoc
class _$PeriodCopyWithImpl<$Res, $Val extends Period>
    implements $PeriodCopyWith<$Res> {
  _$PeriodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? unit = null,
    Object? value = null,
    Object? iso8601 = null,
  }) {
    return _then(_value.copyWith(
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as PeriodUnit,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      iso8601: null == iso8601
          ? _value.iso8601
          : iso8601 // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PeriodCopyWith<$Res> implements $PeriodCopyWith<$Res> {
  factory _$$_PeriodCopyWith(_$_Period value, $Res Function(_$_Period) then) =
      __$$_PeriodCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PeriodUnit unit, int value, String iso8601});
}

/// @nodoc
class __$$_PeriodCopyWithImpl<$Res>
    extends _$PeriodCopyWithImpl<$Res, _$_Period>
    implements _$$_PeriodCopyWith<$Res> {
  __$$_PeriodCopyWithImpl(_$_Period _value, $Res Function(_$_Period) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? unit = null,
    Object? value = null,
    Object? iso8601 = null,
  }) {
    return _then(_$_Period(
      null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as PeriodUnit,
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      null == iso8601
          ? _value.iso8601
          : iso8601 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Period implements _Period {
  const _$_Period(this.unit, this.value, this.iso8601);

  factory _$_Period.fromJson(Map<String, dynamic> json) =>
      _$$_PeriodFromJson(json);

  /// The number of period units: day, week, month, year, unknown
  @override
  final PeriodUnit unit;

  /// The increment of time that a subscription period is specified in
  @override
  final int value;

  /// Specified in ISO 8601 format. For example, P1W equates to one week,
  /// P1M equates to one month, P3M equates to three months, P6M equates to
  /// six months, and P1Y equates to one year
  @override
  final String iso8601;

  @override
  String toString() {
    return 'Period(unit: $unit, value: $value, iso8601: $iso8601)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Period &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.iso8601, iso8601) || other.iso8601 == iso8601));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, unit, value, iso8601);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PeriodCopyWith<_$_Period> get copyWith =>
      __$$_PeriodCopyWithImpl<_$_Period>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PeriodToJson(
      this,
    );
  }
}

abstract class _Period implements Period {
  const factory _Period(
      final PeriodUnit unit, final int value, final String iso8601) = _$_Period;

  factory _Period.fromJson(Map<String, dynamic> json) = _$_Period.fromJson;

  @override

  /// The number of period units: day, week, month, year, unknown
  PeriodUnit get unit;
  @override

  /// The increment of time that a subscription period is specified in
  int get value;
  @override

  /// Specified in ISO 8601 format. For example, P1W equates to one week,
  /// P1M equates to one month, P3M equates to three months, P6M equates to
  /// six months, and P1Y equates to one year
  String get iso8601;
  @override
  @JsonKey(ignore: true)
  _$$_PeriodCopyWith<_$_Period> get copyWith =>
      throw _privateConstructorUsedError;
}
