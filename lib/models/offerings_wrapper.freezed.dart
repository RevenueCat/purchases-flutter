// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'offerings_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Offerings _$OfferingsFromJson(Map<String, dynamic> json) {
  return _Offerings.fromJson(json);
}

/// @nodoc
mixin _$Offerings {
  /// Map of all Offerings [Offering] objects keyed by their identifier.
  Map<String, Offering> get all => throw _privateConstructorUsedError;

  /// Current offering configured in the RevenueCat dashboard.
  Offering? get current => throw _privateConstructorUsedError;

  /// Serializes this Offerings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Offerings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OfferingsCopyWith<Offerings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfferingsCopyWith<$Res> {
  factory $OfferingsCopyWith(Offerings value, $Res Function(Offerings) then) =
      _$OfferingsCopyWithImpl<$Res, Offerings>;
  @useResult
  $Res call({Map<String, Offering> all, Offering? current});

  $OfferingCopyWith<$Res>? get current;
}

/// @nodoc
class _$OfferingsCopyWithImpl<$Res, $Val extends Offerings>
    implements $OfferingsCopyWith<$Res> {
  _$OfferingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Offerings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? all = null,
    Object? current = freezed,
  }) {
    return _then(_value.copyWith(
      all: null == all
          ? _value.all
          : all // ignore: cast_nullable_to_non_nullable
              as Map<String, Offering>,
      current: freezed == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as Offering?,
    ) as $Val);
  }

  /// Create a copy of Offerings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OfferingCopyWith<$Res>? get current {
    if (_value.current == null) {
      return null;
    }

    return $OfferingCopyWith<$Res>(_value.current!, (value) {
      return _then(_value.copyWith(current: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OfferingsImplCopyWith<$Res>
    implements $OfferingsCopyWith<$Res> {
  factory _$$OfferingsImplCopyWith(
          _$OfferingsImpl value, $Res Function(_$OfferingsImpl) then) =
      __$$OfferingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, Offering> all, Offering? current});

  @override
  $OfferingCopyWith<$Res>? get current;
}

/// @nodoc
class __$$OfferingsImplCopyWithImpl<$Res>
    extends _$OfferingsCopyWithImpl<$Res, _$OfferingsImpl>
    implements _$$OfferingsImplCopyWith<$Res> {
  __$$OfferingsImplCopyWithImpl(
      _$OfferingsImpl _value, $Res Function(_$OfferingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of Offerings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? all = null,
    Object? current = freezed,
  }) {
    return _then(_$OfferingsImpl(
      null == all
          ? _value._all
          : all // ignore: cast_nullable_to_non_nullable
              as Map<String, Offering>,
      current: freezed == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as Offering?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OfferingsImpl extends _Offerings {
  const _$OfferingsImpl(final Map<String, Offering> all, {this.current})
      : _all = all,
        super._();

  factory _$OfferingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$OfferingsImplFromJson(json);

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

  @override
  String toString() {
    return 'Offerings(all: $all, current: $current)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfferingsImpl &&
            const DeepCollectionEquality().equals(other._all, _all) &&
            (identical(other.current, current) || other.current == current));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_all), current);

  /// Create a copy of Offerings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OfferingsImplCopyWith<_$OfferingsImpl> get copyWith =>
      __$$OfferingsImplCopyWithImpl<_$OfferingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OfferingsImplToJson(
      this,
    );
  }
}

abstract class _Offerings extends Offerings {
  const factory _Offerings(final Map<String, Offering> all,
      {final Offering? current}) = _$OfferingsImpl;
  const _Offerings._() : super._();

  factory _Offerings.fromJson(Map<String, dynamic> json) =
      _$OfferingsImpl.fromJson;

  /// Map of all Offerings [Offering] objects keyed by their identifier.
  @override
  Map<String, Offering> get all;

  /// Current offering configured in the RevenueCat dashboard.
  @override
  Offering? get current;

  /// Create a copy of Offerings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OfferingsImplCopyWith<_$OfferingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
