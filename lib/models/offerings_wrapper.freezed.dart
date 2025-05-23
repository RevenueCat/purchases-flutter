// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'offerings_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Offerings {
  /// Map of all Offerings [Offering] objects keyed by their identifier.
  Map<String, Offering> get all;

  /// Current offering configured in the RevenueCat dashboard.
  Offering? get current;

  /// Create a copy of Offerings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OfferingsCopyWith<Offerings> get copyWith =>
      _$OfferingsCopyWithImpl<Offerings>(this as Offerings, _$identity);

  /// Serializes this Offerings to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Offerings &&
            const DeepCollectionEquality().equals(other.all, all) &&
            (identical(other.current, current) || other.current == current));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(all), current);

  @override
  String toString() {
    return 'Offerings(all: $all, current: $current)';
  }
}

/// @nodoc
abstract mixin class $OfferingsCopyWith<$Res> {
  factory $OfferingsCopyWith(Offerings value, $Res Function(Offerings) _then) =
      _$OfferingsCopyWithImpl;
  @useResult
  $Res call({Map<String, Offering> all, Offering? current});

  $OfferingCopyWith<$Res>? get current;
}

/// @nodoc
class _$OfferingsCopyWithImpl<$Res> implements $OfferingsCopyWith<$Res> {
  _$OfferingsCopyWithImpl(this._self, this._then);

  final Offerings _self;
  final $Res Function(Offerings) _then;

  /// Create a copy of Offerings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? all = null,
    Object? current = freezed,
  }) {
    return _then(_self.copyWith(
      all: null == all
          ? _self.all
          : all // ignore: cast_nullable_to_non_nullable
              as Map<String, Offering>,
      current: freezed == current
          ? _self.current
          : current // ignore: cast_nullable_to_non_nullable
              as Offering?,
    ));
  }

  /// Create a copy of Offerings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OfferingCopyWith<$Res>? get current {
    if (_self.current == null) {
      return null;
    }

    return $OfferingCopyWith<$Res>(_self.current!, (value) {
      return _then(_self.copyWith(current: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _Offerings extends Offerings {
  const _Offerings(final Map<String, Offering> all, {this.current})
      : _all = all,
        super._();
  factory _Offerings.fromJson(Map<String, dynamic> json) =>
      _$OfferingsFromJson(json);

  /// Map of all Offerings [Offering] objects keyed by their identifier.
  final Map<String, Offering> _all;

  /// Map of all Offerings [Offering] objects keyed by their identifier.
  @override
  Map<String, Offering> get all {
    if (_all is EqualUnmodifiableMapView) return _all;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_all);
  }

  /// Current offering configured in the RevenueCat dashboard.
  @override
  final Offering? current;

  /// Create a copy of Offerings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OfferingsCopyWith<_Offerings> get copyWith =>
      __$OfferingsCopyWithImpl<_Offerings>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OfferingsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Offerings &&
            const DeepCollectionEquality().equals(other._all, _all) &&
            (identical(other.current, current) || other.current == current));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_all), current);

  @override
  String toString() {
    return 'Offerings(all: $all, current: $current)';
  }
}

/// @nodoc
abstract mixin class _$OfferingsCopyWith<$Res>
    implements $OfferingsCopyWith<$Res> {
  factory _$OfferingsCopyWith(
          _Offerings value, $Res Function(_Offerings) _then) =
      __$OfferingsCopyWithImpl;
  @override
  @useResult
  $Res call({Map<String, Offering> all, Offering? current});

  @override
  $OfferingCopyWith<$Res>? get current;
}

/// @nodoc
class __$OfferingsCopyWithImpl<$Res> implements _$OfferingsCopyWith<$Res> {
  __$OfferingsCopyWithImpl(this._self, this._then);

  final _Offerings _self;
  final $Res Function(_Offerings) _then;

  /// Create a copy of Offerings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? all = null,
    Object? current = freezed,
  }) {
    return _then(_Offerings(
      null == all
          ? _self._all
          : all // ignore: cast_nullable_to_non_nullable
              as Map<String, Offering>,
      current: freezed == current
          ? _self.current
          : current // ignore: cast_nullable_to_non_nullable
              as Offering?,
    ));
  }

  /// Create a copy of Offerings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OfferingCopyWith<$Res>? get current {
    if (_self.current == null) {
      return null;
    }

    return $OfferingCopyWith<$Res>(_self.current!, (value) {
      return _then(_self.copyWith(current: value));
    });
  }
}

// dart format on
