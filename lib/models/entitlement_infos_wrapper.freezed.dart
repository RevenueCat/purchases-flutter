// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entitlement_infos_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EntitlementInfos {
  /// Map of all EntitlementInfo (`EntitlementInfo`) objects (active and inactive)
  /// keyed by entitlement identifier.
  Map<String, EntitlementInfo> get all;

  /// Map of active EntitlementInfo (`EntitlementInfo`) objects keyed by
  /// entitlement identifier.
  Map<String, EntitlementInfo> get active;

  /// If entitlement verification was enabled, the result of that verification.
  /// If not, `VerificationResult.NOT_REQUESTED`.
  VerificationResult get verification;

  /// Create a copy of EntitlementInfos
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EntitlementInfosCopyWith<EntitlementInfos> get copyWith =>
      _$EntitlementInfosCopyWithImpl<EntitlementInfos>(
          this as EntitlementInfos, _$identity);

  /// Serializes this EntitlementInfos to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EntitlementInfos &&
            const DeepCollectionEquality().equals(other.all, all) &&
            const DeepCollectionEquality().equals(other.active, active) &&
            (identical(other.verification, verification) ||
                other.verification == verification));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(all),
      const DeepCollectionEquality().hash(active),
      verification);

  @override
  String toString() {
    return 'EntitlementInfos(all: $all, active: $active, verification: $verification)';
  }
}

/// @nodoc
abstract mixin class $EntitlementInfosCopyWith<$Res> {
  factory $EntitlementInfosCopyWith(
          EntitlementInfos value, $Res Function(EntitlementInfos) _then) =
      _$EntitlementInfosCopyWithImpl;
  @useResult
  $Res call(
      {Map<String, EntitlementInfo> all,
      Map<String, EntitlementInfo> active,
      VerificationResult verification});
}

/// @nodoc
class _$EntitlementInfosCopyWithImpl<$Res>
    implements $EntitlementInfosCopyWith<$Res> {
  _$EntitlementInfosCopyWithImpl(this._self, this._then);

  final EntitlementInfos _self;
  final $Res Function(EntitlementInfos) _then;

  /// Create a copy of EntitlementInfos
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? all = null,
    Object? active = null,
    Object? verification = null,
  }) {
    return _then(_self.copyWith(
      all: null == all
          ? _self.all
          : all // ignore: cast_nullable_to_non_nullable
              as Map<String, EntitlementInfo>,
      active: null == active
          ? _self.active
          : active // ignore: cast_nullable_to_non_nullable
              as Map<String, EntitlementInfo>,
      verification: null == verification
          ? _self.verification
          : verification // ignore: cast_nullable_to_non_nullable
              as VerificationResult,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _EntitlementInfos implements EntitlementInfos {
  const _EntitlementInfos(final Map<String, EntitlementInfo> all,
      final Map<String, EntitlementInfo> active,
      {this.verification = VerificationResult.notRequested})
      : _all = all,
        _active = active;
  factory _EntitlementInfos.fromJson(Map<String, dynamic> json) =>
      _$EntitlementInfosFromJson(json);

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

  /// Create a copy of EntitlementInfos
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EntitlementInfosCopyWith<_EntitlementInfos> get copyWith =>
      __$EntitlementInfosCopyWithImpl<_EntitlementInfos>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EntitlementInfosToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EntitlementInfos &&
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

  @override
  String toString() {
    return 'EntitlementInfos(all: $all, active: $active, verification: $verification)';
  }
}

/// @nodoc
abstract mixin class _$EntitlementInfosCopyWith<$Res>
    implements $EntitlementInfosCopyWith<$Res> {
  factory _$EntitlementInfosCopyWith(
          _EntitlementInfos value, $Res Function(_EntitlementInfos) _then) =
      __$EntitlementInfosCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Map<String, EntitlementInfo> all,
      Map<String, EntitlementInfo> active,
      VerificationResult verification});
}

/// @nodoc
class __$EntitlementInfosCopyWithImpl<$Res>
    implements _$EntitlementInfosCopyWith<$Res> {
  __$EntitlementInfosCopyWithImpl(this._self, this._then);

  final _EntitlementInfos _self;
  final $Res Function(_EntitlementInfos) _then;

  /// Create a copy of EntitlementInfos
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? all = null,
    Object? active = null,
    Object? verification = null,
  }) {
    return _then(_EntitlementInfos(
      null == all
          ? _self._all
          : all // ignore: cast_nullable_to_non_nullable
              as Map<String, EntitlementInfo>,
      null == active
          ? _self._active
          : active // ignore: cast_nullable_to_non_nullable
              as Map<String, EntitlementInfo>,
      verification: null == verification
          ? _self.verification
          : verification // ignore: cast_nullable_to_non_nullable
              as VerificationResult,
    ));
  }
}

// dart format on
