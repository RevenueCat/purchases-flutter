// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entitlement_infos_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EntitlementInfos _$EntitlementInfosFromJson(Map<String, dynamic> json) {
  return _EntitlementInfos.fromJson(json);
}

/// @nodoc
mixin _$EntitlementInfos {
  /// Map of all EntitlementInfo (`EntitlementInfo`) objects (active and inactive)
  /// keyed by entitlement identifier.
  Map<String, EntitlementInfo> get all => throw _privateConstructorUsedError;

  /// Map of active EntitlementInfo (`EntitlementInfo`) objects keyed by
  /// entitlement identifier.
  Map<String, EntitlementInfo> get active => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EntitlementInfosCopyWith<EntitlementInfos> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntitlementInfosCopyWith<$Res> {
  factory $EntitlementInfosCopyWith(
          EntitlementInfos value, $Res Function(EntitlementInfos) then) =
      _$EntitlementInfosCopyWithImpl<$Res, EntitlementInfos>;
  @useResult
  $Res call(
      {Map<String, EntitlementInfo> all, Map<String, EntitlementInfo> active});
}

/// @nodoc
class _$EntitlementInfosCopyWithImpl<$Res, $Val extends EntitlementInfos>
    implements $EntitlementInfosCopyWith<$Res> {
  _$EntitlementInfosCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? all = null,
    Object? active = null,
  }) {
    return _then(_value.copyWith(
      all: null == all
          ? _value.all
          : all // ignore: cast_nullable_to_non_nullable
              as Map<String, EntitlementInfo>,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as Map<String, EntitlementInfo>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EntitlementInfosCopyWith<$Res>
    implements $EntitlementInfosCopyWith<$Res> {
  factory _$$_EntitlementInfosCopyWith(
          _$_EntitlementInfos value, $Res Function(_$_EntitlementInfos) then) =
      __$$_EntitlementInfosCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, EntitlementInfo> all, Map<String, EntitlementInfo> active});
}

/// @nodoc
class __$$_EntitlementInfosCopyWithImpl<$Res>
    extends _$EntitlementInfosCopyWithImpl<$Res, _$_EntitlementInfos>
    implements _$$_EntitlementInfosCopyWith<$Res> {
  __$$_EntitlementInfosCopyWithImpl(
      _$_EntitlementInfos _value, $Res Function(_$_EntitlementInfos) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? all = null,
    Object? active = null,
  }) {
    return _then(_$_EntitlementInfos(
      null == all
          ? _value._all
          : all // ignore: cast_nullable_to_non_nullable
              as Map<String, EntitlementInfo>,
      null == active
          ? _value._active
          : active // ignore: cast_nullable_to_non_nullable
              as Map<String, EntitlementInfo>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EntitlementInfos implements _EntitlementInfos {
  const _$_EntitlementInfos(final Map<String, EntitlementInfo> all,
      final Map<String, EntitlementInfo> active)
      : _all = all,
        _active = active;

  factory _$_EntitlementInfos.fromJson(Map<String, dynamic> json) =>
      _$$_EntitlementInfosFromJson(json);

  /// Map of all EntitlementInfo (`EntitlementInfo`) objects (active and inactive)
  /// keyed by entitlement identifier.
  final Map<String, EntitlementInfo> _all;

  /// Map of all EntitlementInfo (`EntitlementInfo`) objects (active and inactive)
  /// keyed by entitlement identifier.
  @override
  Map<String, EntitlementInfo> get all {
    if (_all is EqualUnmodifiableMapView) return _all;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_all);
  }

  /// Map of active EntitlementInfo (`EntitlementInfo`) objects keyed by
  /// entitlement identifier.
  final Map<String, EntitlementInfo> _active;

  /// Map of active EntitlementInfo (`EntitlementInfo`) objects keyed by
  /// entitlement identifier.
  @override
  Map<String, EntitlementInfo> get active {
    if (_active is EqualUnmodifiableMapView) return _active;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_active);
  }

  @override
  String toString() {
    return 'EntitlementInfos(all: $all, active: $active)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EntitlementInfos &&
            const DeepCollectionEquality().equals(other._all, _all) &&
            const DeepCollectionEquality().equals(other._active, _active));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_all),
      const DeepCollectionEquality().hash(_active));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EntitlementInfosCopyWith<_$_EntitlementInfos> get copyWith =>
      __$$_EntitlementInfosCopyWithImpl<_$_EntitlementInfos>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EntitlementInfosToJson(
      this,
    );
  }
}

abstract class _EntitlementInfos implements EntitlementInfos {
  const factory _EntitlementInfos(final Map<String, EntitlementInfo> all,
      final Map<String, EntitlementInfo> active) = _$_EntitlementInfos;

  factory _EntitlementInfos.fromJson(Map<String, dynamic> json) =
      _$_EntitlementInfos.fromJson;

  @override

  /// Map of all EntitlementInfo (`EntitlementInfo`) objects (active and inactive)
  /// keyed by entitlement identifier.
  Map<String, EntitlementInfo> get all;
  @override

  /// Map of active EntitlementInfo (`EntitlementInfo`) objects keyed by
  /// entitlement identifier.
  Map<String, EntitlementInfo> get active;
  @override
  @JsonKey(ignore: true)
  _$$_EntitlementInfosCopyWith<_$_EntitlementInfos> get copyWith =>
      throw _privateConstructorUsedError;
}
