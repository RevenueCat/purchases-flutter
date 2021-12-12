// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'entitlement_infos_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EntitlementInfos _$EntitlementInfosFromJson(Map<String, dynamic> json) {
  return _EntitlementInfos.fromJson(json);
}

/// @nodoc
class _$EntitlementInfosTearOff {
  const _$EntitlementInfosTearOff();

  _EntitlementInfos call(
      Map<String, EntitlementInfo> all, Map<String, EntitlementInfo> active) {
    return _EntitlementInfos(
      all,
      active,
    );
  }

  EntitlementInfos fromJson(Map<String, Object> json) {
    return EntitlementInfos.fromJson(json);
  }
}

/// @nodoc
const $EntitlementInfos = _$EntitlementInfosTearOff();

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
      _$EntitlementInfosCopyWithImpl<$Res>;
  $Res call(
      {Map<String, EntitlementInfo> all, Map<String, EntitlementInfo> active});
}

/// @nodoc
class _$EntitlementInfosCopyWithImpl<$Res>
    implements $EntitlementInfosCopyWith<$Res> {
  _$EntitlementInfosCopyWithImpl(this._value, this._then);

  final EntitlementInfos _value;
  // ignore: unused_field
  final $Res Function(EntitlementInfos) _then;

  @override
  $Res call({
    Object? all = freezed,
    Object? active = freezed,
  }) {
    return _then(_value.copyWith(
      all: all == freezed
          ? _value.all
          : all // ignore: cast_nullable_to_non_nullable
              as Map<String, EntitlementInfo>,
      active: active == freezed
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as Map<String, EntitlementInfo>,
    ));
  }
}

/// @nodoc
abstract class _$EntitlementInfosCopyWith<$Res>
    implements $EntitlementInfosCopyWith<$Res> {
  factory _$EntitlementInfosCopyWith(
          _EntitlementInfos value, $Res Function(_EntitlementInfos) then) =
      __$EntitlementInfosCopyWithImpl<$Res>;
  @override
  $Res call(
      {Map<String, EntitlementInfo> all, Map<String, EntitlementInfo> active});
}

/// @nodoc
class __$EntitlementInfosCopyWithImpl<$Res>
    extends _$EntitlementInfosCopyWithImpl<$Res>
    implements _$EntitlementInfosCopyWith<$Res> {
  __$EntitlementInfosCopyWithImpl(
      _EntitlementInfos _value, $Res Function(_EntitlementInfos) _then)
      : super(_value, (v) => _then(v as _EntitlementInfos));

  @override
  _EntitlementInfos get _value => super._value as _EntitlementInfos;

  @override
  $Res call({
    Object? all = freezed,
    Object? active = freezed,
  }) {
    return _then(_EntitlementInfos(
      all == freezed
          ? _value.all
          : all // ignore: cast_nullable_to_non_nullable
              as Map<String, EntitlementInfo>,
      active == freezed
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as Map<String, EntitlementInfo>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EntitlementInfos implements _EntitlementInfos {
  const _$_EntitlementInfos(this.all, this.active);

  factory _$_EntitlementInfos.fromJson(Map<String, dynamic> json) =>
      _$$_EntitlementInfosFromJson(json);

  @override

  /// Map of all EntitlementInfo (`EntitlementInfo`) objects (active and inactive)
  /// keyed by entitlement identifier.
  final Map<String, EntitlementInfo> all;
  @override

  /// Map of active EntitlementInfo (`EntitlementInfo`) objects keyed by
  /// entitlement identifier.
  final Map<String, EntitlementInfo> active;

  @override
  String toString() {
    return 'EntitlementInfos(all: $all, active: $active)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _EntitlementInfos &&
            (identical(other.all, all) ||
                const DeepCollectionEquality().equals(other.all, all)) &&
            (identical(other.active, active) ||
                const DeepCollectionEquality().equals(other.active, active)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(all) ^
      const DeepCollectionEquality().hash(active);

  @JsonKey(ignore: true)
  @override
  _$EntitlementInfosCopyWith<_EntitlementInfos> get copyWith =>
      __$EntitlementInfosCopyWithImpl<_EntitlementInfos>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EntitlementInfosToJson(this);
  }
}

abstract class _EntitlementInfos implements EntitlementInfos {
  const factory _EntitlementInfos(Map<String, EntitlementInfo> all,
      Map<String, EntitlementInfo> active) = _$_EntitlementInfos;

  factory _EntitlementInfos.fromJson(Map<String, dynamic> json) =
      _$_EntitlementInfos.fromJson;

  @override

  /// Map of all EntitlementInfo (`EntitlementInfo`) objects (active and inactive)
  /// keyed by entitlement identifier.
  Map<String, EntitlementInfo> get all => throw _privateConstructorUsedError;
  @override

  /// Map of active EntitlementInfo (`EntitlementInfo`) objects keyed by
  /// entitlement identifier.
  Map<String, EntitlementInfo> get active => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$EntitlementInfosCopyWith<_EntitlementInfos> get copyWith =>
      throw _privateConstructorUsedError;
}
