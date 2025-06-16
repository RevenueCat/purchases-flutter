// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'period_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Period {
  /// The number of period units: day, week, month, year, unknown
  PeriodUnit get unit;

  /// The increment of time that a subscription period is specified in
  int get value;

  /// Specified in ISO 8601 format. For example, P1W equates to one week,
  /// P1M equates to one month, P3M equates to three months, P6M equates to
  /// six months, and P1Y equates to one year
  String get iso8601;

  /// Create a copy of Period
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PeriodCopyWith<Period> get copyWith =>
      _$PeriodCopyWithImpl<Period>(this as Period, _$identity);

  /// Serializes this Period to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Period &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.iso8601, iso8601) || other.iso8601 == iso8601));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, unit, value, iso8601);

  @override
  String toString() {
    return 'Period(unit: $unit, value: $value, iso8601: $iso8601)';
  }
}

/// @nodoc
abstract mixin class $PeriodCopyWith<$Res> {
  factory $PeriodCopyWith(Period value, $Res Function(Period) _then) =
      _$PeriodCopyWithImpl;
  @useResult
  $Res call({PeriodUnit unit, int value, String iso8601});
}

/// @nodoc
class _$PeriodCopyWithImpl<$Res> implements $PeriodCopyWith<$Res> {
  _$PeriodCopyWithImpl(this._self, this._then);

  final Period _self;
  final $Res Function(Period) _then;

  /// Create a copy of Period
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? unit = null,
    Object? value = null,
    Object? iso8601 = null,
  }) {
    return _then(_self.copyWith(
      unit: null == unit
          ? _self.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as PeriodUnit,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      iso8601: null == iso8601
          ? _self.iso8601
          : iso8601 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Period implements Period {
  const _Period(this.unit, this.value, this.iso8601);
  factory _Period.fromJson(Map<String, dynamic> json) => _$PeriodFromJson(json);

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

  /// Create a copy of Period
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PeriodCopyWith<_Period> get copyWith =>
      __$PeriodCopyWithImpl<_Period>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PeriodToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Period &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.iso8601, iso8601) || other.iso8601 == iso8601));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, unit, value, iso8601);

  @override
  String toString() {
    return 'Period(unit: $unit, value: $value, iso8601: $iso8601)';
  }
}

/// @nodoc
abstract mixin class _$PeriodCopyWith<$Res> implements $PeriodCopyWith<$Res> {
  factory _$PeriodCopyWith(_Period value, $Res Function(_Period) _then) =
      __$PeriodCopyWithImpl;
  @override
  @useResult
  $Res call({PeriodUnit unit, int value, String iso8601});
}

/// @nodoc
class __$PeriodCopyWithImpl<$Res> implements _$PeriodCopyWith<$Res> {
  __$PeriodCopyWithImpl(this._self, this._then);

  final _Period _self;
  final $Res Function(_Period) _then;

  /// Create a copy of Period
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? unit = null,
    Object? value = null,
    Object? iso8601 = null,
  }) {
    return _then(_Period(
      null == unit
          ? _self.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as PeriodUnit,
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      null == iso8601
          ? _self.iso8601
          : iso8601 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
