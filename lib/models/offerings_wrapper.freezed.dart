// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'offerings_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Offerings _$OfferingsFromJson(Map<String, dynamic> json) {
  return _Offerings.fromJson(json);
}

/// @nodoc
class _$OfferingsTearOff {
  const _$OfferingsTearOff();

  _Offerings call(@JsonKey(name: 'all') Map<String, Offering> all,
      {@JsonKey(name: 'current', nullable: true) Offering? current}) {
    return _Offerings(
      all,
      current: current,
    );
  }

  Offerings fromJson(Map<String, Object> json) {
    return Offerings.fromJson(json);
  }
}

/// @nodoc
const $Offerings = _$OfferingsTearOff();

/// @nodoc
mixin _$Offerings {
  /// Map of all Offerings [Offering] objects keyed by their identifier.
  @JsonKey(name: 'all')
  Map<String, Offering> get all => throw _privateConstructorUsedError;

  /// Current offering configured in the RevenueCat dashboard.
  @JsonKey(name: 'current', nullable: true)
  Offering? get current => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OfferingsCopyWith<Offerings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfferingsCopyWith<$Res> {
  factory $OfferingsCopyWith(Offerings value, $Res Function(Offerings) then) =
      _$OfferingsCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'all') Map<String, Offering> all,
      @JsonKey(name: 'current', nullable: true) Offering? current});

  $OfferingCopyWith<$Res>? get current;
}

/// @nodoc
class _$OfferingsCopyWithImpl<$Res> implements $OfferingsCopyWith<$Res> {
  _$OfferingsCopyWithImpl(this._value, this._then);

  final Offerings _value;
  // ignore: unused_field
  final $Res Function(Offerings) _then;

  @override
  $Res call({
    Object? all = freezed,
    Object? current = freezed,
  }) {
    return _then(_value.copyWith(
      all: all == freezed
          ? _value.all
          : all // ignore: cast_nullable_to_non_nullable
              as Map<String, Offering>,
      current: current == freezed
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as Offering?,
    ));
  }

  @override
  $OfferingCopyWith<$Res>? get current {
    if (_value.current == null) {
      return null;
    }

    return $OfferingCopyWith<$Res>(_value.current!, (value) {
      return _then(_value.copyWith(current: value));
    });
  }
}

/// @nodoc
abstract class _$OfferingsCopyWith<$Res> implements $OfferingsCopyWith<$Res> {
  factory _$OfferingsCopyWith(
          _Offerings value, $Res Function(_Offerings) then) =
      __$OfferingsCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'all') Map<String, Offering> all,
      @JsonKey(name: 'current', nullable: true) Offering? current});

  @override
  $OfferingCopyWith<$Res>? get current;
}

/// @nodoc
class __$OfferingsCopyWithImpl<$Res> extends _$OfferingsCopyWithImpl<$Res>
    implements _$OfferingsCopyWith<$Res> {
  __$OfferingsCopyWithImpl(_Offerings _value, $Res Function(_Offerings) _then)
      : super(_value, (v) => _then(v as _Offerings));

  @override
  _Offerings get _value => super._value as _Offerings;

  @override
  $Res call({
    Object? all = freezed,
    Object? current = freezed,
  }) {
    return _then(_Offerings(
      all == freezed
          ? _value.all
          : all // ignore: cast_nullable_to_non_nullable
              as Map<String, Offering>,
      current: current == freezed
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as Offering?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Offerings extends _Offerings {
  const _$_Offerings(@JsonKey(name: 'all') this.all,
      {@JsonKey(name: 'current', nullable: true) this.current})
      : super._();

  factory _$_Offerings.fromJson(Map<String, dynamic> json) =>
      _$$_OfferingsFromJson(json);

  @override

  /// Map of all Offerings [Offering] objects keyed by their identifier.
  @JsonKey(name: 'all')
  final Map<String, Offering> all;
  @override

  /// Current offering configured in the RevenueCat dashboard.
  @JsonKey(name: 'current', nullable: true)
  final Offering? current;

  @override
  String toString() {
    return 'Offerings(all: $all, current: $current)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Offerings &&
            (identical(other.all, all) ||
                const DeepCollectionEquality().equals(other.all, all)) &&
            (identical(other.current, current) ||
                const DeepCollectionEquality().equals(other.current, current)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(all) ^
      const DeepCollectionEquality().hash(current);

  @JsonKey(ignore: true)
  @override
  _$OfferingsCopyWith<_Offerings> get copyWith =>
      __$OfferingsCopyWithImpl<_Offerings>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OfferingsToJson(this);
  }
}

abstract class _Offerings extends Offerings {
  const factory _Offerings(@JsonKey(name: 'all') Map<String, Offering> all,
          {@JsonKey(name: 'current', nullable: true) Offering? current}) =
      _$_Offerings;
  const _Offerings._() : super._();

  factory _Offerings.fromJson(Map<String, dynamic> json) =
      _$_Offerings.fromJson;

  @override

  /// Map of all Offerings [Offering] objects keyed by their identifier.
  @JsonKey(name: 'all')
  Map<String, Offering> get all => throw _privateConstructorUsedError;
  @override

  /// Current offering configured in the RevenueCat dashboard.
  @JsonKey(name: 'current', nullable: true)
  Offering? get current => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$OfferingsCopyWith<_Offerings> get copyWith =>
      throw _privateConstructorUsedError;
}
