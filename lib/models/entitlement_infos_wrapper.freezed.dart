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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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

  /// If entitlement verification was enabled, the result of that verification.
  /// If not, `VerificationResult.NOT_REQUESTED`.
  VerificationResult get verification => throw _privateConstructorUsedError;

  /// Serializes this EntitlementInfos to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EntitlementInfos
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      {Map<String, EntitlementInfo> all,
      Map<String, EntitlementInfo> active,
      VerificationResult verification});
}

/// @nodoc
class _$EntitlementInfosCopyWithImpl<$Res, $Val extends EntitlementInfos>
    implements $EntitlementInfosCopyWith<$Res> {
  _$EntitlementInfosCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EntitlementInfos
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? all = null,
    Object? active = null,
    Object? verification = null,
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
      verification: null == verification
          ? _value.verification
          : verification // ignore: cast_nullable_to_non_nullable
              as VerificationResult,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EntitlementInfosImplCopyWith<$Res>
    implements $EntitlementInfosCopyWith<$Res> {
  factory _$$EntitlementInfosImplCopyWith(_$EntitlementInfosImpl value,
          $Res Function(_$EntitlementInfosImpl) then) =
      __$$EntitlementInfosImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, EntitlementInfo> all,
      Map<String, EntitlementInfo> active,
      VerificationResult verification});
}

/// @nodoc
class __$$EntitlementInfosImplCopyWithImpl<$Res>
    extends _$EntitlementInfosCopyWithImpl<$Res, _$EntitlementInfosImpl>
    implements _$$EntitlementInfosImplCopyWith<$Res> {
  __$$EntitlementInfosImplCopyWithImpl(_$EntitlementInfosImpl _value,
      $Res Function(_$EntitlementInfosImpl) _then)
      : super(_value, _then);

  /// Create a copy of EntitlementInfos
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? all = null,
    Object? active = null,
    Object? verification = null,
  }) {
    return _then(_$EntitlementInfosImpl(
      null == all
          ? _value._all
          : all // ignore: cast_nullable_to_non_nullable
              as Map<String, EntitlementInfo>,
      null == active
          ? _value._active
          : active // ignore: cast_nullable_to_non_nullable
              as Map<String, EntitlementInfo>,
      verification: null == verification
          ? _value.verification
          : verification // ignore: cast_nullable_to_non_nullable
              as VerificationResult,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EntitlementInfosImpl implements _EntitlementInfos {
  const _$EntitlementInfosImpl(final Map<String, EntitlementInfo> all,
      final Map<String, EntitlementInfo> active,
      {this.verification = VerificationResult.notRequested})
      : _all = all,
        _active = active;

  factory _$EntitlementInfosImpl.fromJson(Map<String, dynamic> json) =>
      _$$EntitlementInfosImplFromJson(json);

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

  /// If entitlement verification was enabled, the result of that verification.
  /// If not, `VerificationResult.NOT_REQUESTED`.
  @override
  @JsonKey()
  final VerificationResult verification;

  @override
  String toString() {
    return 'EntitlementInfos(all: $all, active: $active, verification: $verification)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EntitlementInfosImpl &&
            const DeepCollectionEquality().equals(other._all, _all) &&
            const DeepCollectionEquality().equals(other._active, _active) &&
            (identical(other.verification, verification) ||
                other.verification == verification));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_all),
      const DeepCollectionEquality().hash(_active),
      verification);

  /// Create a copy of EntitlementInfos
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EntitlementInfosImplCopyWith<_$EntitlementInfosImpl> get copyWith =>
      __$$EntitlementInfosImplCopyWithImpl<_$EntitlementInfosImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EntitlementInfosImplToJson(
      this,
    );
  }
}

abstract class _EntitlementInfos implements EntitlementInfos {
  const factory _EntitlementInfos(final Map<String, EntitlementInfo> all,
      final Map<String, EntitlementInfo> active,
      {final VerificationResult verification}) = _$EntitlementInfosImpl;

  factory _EntitlementInfos.fromJson(Map<String, dynamic> json) =
      _$EntitlementInfosImpl.fromJson;

  /// Map of all EntitlementInfo (`EntitlementInfo`) objects (active and inactive)
  /// keyed by entitlement identifier.
  @override
  Map<String, EntitlementInfo> get all;

  /// Map of active EntitlementInfo (`EntitlementInfo`) objects keyed by
  /// entitlement identifier.
  @override
  Map<String, EntitlementInfo> get active;

  /// If entitlement verification was enabled, the result of that verification.
  /// If not, `VerificationResult.NOT_REQUESTED`.
  @override
  VerificationResult get verification;

  /// Create a copy of EntitlementInfos
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EntitlementInfosImplCopyWith<_$EntitlementInfosImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
