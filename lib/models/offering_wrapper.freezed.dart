// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'offering_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Offering _$OfferingFromJson(Map<String, dynamic> json) {
  return _Offering.fromJson(json);
}

/// @nodoc
mixin _$Offering {
  /// Unique identifier defined in RevenueCat dashboard.
  String get identifier => throw _privateConstructorUsedError;

  /// Offering description defined in RevenueCat dashboard.
  String get serverDescription => throw _privateConstructorUsedError;

  /// Offering metadata defined in RevenueCat dashboard.
  Map<String, Object> get metadata => throw _privateConstructorUsedError;

  /// Array of [Package] objects available for purchase.
  List<Package> get availablePackages => throw _privateConstructorUsedError;

  /// Lifetime package type configured in the RevenueCat dashboard, if available.
  Package? get lifetime => throw _privateConstructorUsedError;

  /// Annual package type configured in the RevenueCat dashboard, if available.
  Package? get annual => throw _privateConstructorUsedError;

  /// Six month package type configured in the RevenueCat dashboard, if available.
  Package? get sixMonth => throw _privateConstructorUsedError;

  /// Three month package type configured in the RevenueCat dashboard, if available.
  Package? get threeMonth => throw _privateConstructorUsedError;

  /// Two month package type configured in the RevenueCat dashboard, if available.
  Package? get twoMonth => throw _privateConstructorUsedError;

  /// Monthly package type configured in the RevenueCat dashboard, if available.
  Package? get monthly => throw _privateConstructorUsedError;

  /// Weekly package type configured in the RevenueCat dashboard, if available.
  Package? get weekly => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OfferingCopyWith<Offering> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfferingCopyWith<$Res> {
  factory $OfferingCopyWith(Offering value, $Res Function(Offering) then) =
      _$OfferingCopyWithImpl<$Res, Offering>;
  @useResult
  $Res call(
      {String identifier,
      String serverDescription,
      Map<String, Object> metadata,
      List<Package> availablePackages,
      Package? lifetime,
      Package? annual,
      Package? sixMonth,
      Package? threeMonth,
      Package? twoMonth,
      Package? monthly,
      Package? weekly});

  $PackageCopyWith<$Res>? get lifetime;
  $PackageCopyWith<$Res>? get annual;
  $PackageCopyWith<$Res>? get sixMonth;
  $PackageCopyWith<$Res>? get threeMonth;
  $PackageCopyWith<$Res>? get twoMonth;
  $PackageCopyWith<$Res>? get monthly;
  $PackageCopyWith<$Res>? get weekly;
}

/// @nodoc
class _$OfferingCopyWithImpl<$Res, $Val extends Offering>
    implements $OfferingCopyWith<$Res> {
  _$OfferingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identifier = null,
    Object? serverDescription = null,
    Object? metadata = null,
    Object? availablePackages = null,
    Object? lifetime = freezed,
    Object? annual = freezed,
    Object? sixMonth = freezed,
    Object? threeMonth = freezed,
    Object? twoMonth = freezed,
    Object? monthly = freezed,
    Object? weekly = freezed,
  }) {
    return _then(_value.copyWith(
      identifier: null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      serverDescription: null == serverDescription
          ? _value.serverDescription
          : serverDescription // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, Object>,
      availablePackages: null == availablePackages
          ? _value.availablePackages
          : availablePackages // ignore: cast_nullable_to_non_nullable
              as List<Package>,
      lifetime: freezed == lifetime
          ? _value.lifetime
          : lifetime // ignore: cast_nullable_to_non_nullable
              as Package?,
      annual: freezed == annual
          ? _value.annual
          : annual // ignore: cast_nullable_to_non_nullable
              as Package?,
      sixMonth: freezed == sixMonth
          ? _value.sixMonth
          : sixMonth // ignore: cast_nullable_to_non_nullable
              as Package?,
      threeMonth: freezed == threeMonth
          ? _value.threeMonth
          : threeMonth // ignore: cast_nullable_to_non_nullable
              as Package?,
      twoMonth: freezed == twoMonth
          ? _value.twoMonth
          : twoMonth // ignore: cast_nullable_to_non_nullable
              as Package?,
      monthly: freezed == monthly
          ? _value.monthly
          : monthly // ignore: cast_nullable_to_non_nullable
              as Package?,
      weekly: freezed == weekly
          ? _value.weekly
          : weekly // ignore: cast_nullable_to_non_nullable
              as Package?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PackageCopyWith<$Res>? get lifetime {
    if (_value.lifetime == null) {
      return null;
    }

    return $PackageCopyWith<$Res>(_value.lifetime!, (value) {
      return _then(_value.copyWith(lifetime: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PackageCopyWith<$Res>? get annual {
    if (_value.annual == null) {
      return null;
    }

    return $PackageCopyWith<$Res>(_value.annual!, (value) {
      return _then(_value.copyWith(annual: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PackageCopyWith<$Res>? get sixMonth {
    if (_value.sixMonth == null) {
      return null;
    }

    return $PackageCopyWith<$Res>(_value.sixMonth!, (value) {
      return _then(_value.copyWith(sixMonth: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PackageCopyWith<$Res>? get threeMonth {
    if (_value.threeMonth == null) {
      return null;
    }

    return $PackageCopyWith<$Res>(_value.threeMonth!, (value) {
      return _then(_value.copyWith(threeMonth: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PackageCopyWith<$Res>? get twoMonth {
    if (_value.twoMonth == null) {
      return null;
    }

    return $PackageCopyWith<$Res>(_value.twoMonth!, (value) {
      return _then(_value.copyWith(twoMonth: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PackageCopyWith<$Res>? get monthly {
    if (_value.monthly == null) {
      return null;
    }

    return $PackageCopyWith<$Res>(_value.monthly!, (value) {
      return _then(_value.copyWith(monthly: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PackageCopyWith<$Res>? get weekly {
    if (_value.weekly == null) {
      return null;
    }

    return $PackageCopyWith<$Res>(_value.weekly!, (value) {
      return _then(_value.copyWith(weekly: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_OfferingCopyWith<$Res> implements $OfferingCopyWith<$Res> {
  factory _$$_OfferingCopyWith(
          _$_Offering value, $Res Function(_$_Offering) then) =
      __$$_OfferingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String identifier,
      String serverDescription,
      Map<String, Object> metadata,
      List<Package> availablePackages,
      Package? lifetime,
      Package? annual,
      Package? sixMonth,
      Package? threeMonth,
      Package? twoMonth,
      Package? monthly,
      Package? weekly});

  @override
  $PackageCopyWith<$Res>? get lifetime;
  @override
  $PackageCopyWith<$Res>? get annual;
  @override
  $PackageCopyWith<$Res>? get sixMonth;
  @override
  $PackageCopyWith<$Res>? get threeMonth;
  @override
  $PackageCopyWith<$Res>? get twoMonth;
  @override
  $PackageCopyWith<$Res>? get monthly;
  @override
  $PackageCopyWith<$Res>? get weekly;
}

/// @nodoc
class __$$_OfferingCopyWithImpl<$Res>
    extends _$OfferingCopyWithImpl<$Res, _$_Offering>
    implements _$$_OfferingCopyWith<$Res> {
  __$$_OfferingCopyWithImpl(
      _$_Offering _value, $Res Function(_$_Offering) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identifier = null,
    Object? serverDescription = null,
    Object? metadata = null,
    Object? availablePackages = null,
    Object? lifetime = freezed,
    Object? annual = freezed,
    Object? sixMonth = freezed,
    Object? threeMonth = freezed,
    Object? twoMonth = freezed,
    Object? monthly = freezed,
    Object? weekly = freezed,
  }) {
    return _then(_$_Offering(
      null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      null == serverDescription
          ? _value.serverDescription
          : serverDescription // ignore: cast_nullable_to_non_nullable
              as String,
      null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, Object>,
      null == availablePackages
          ? _value._availablePackages
          : availablePackages // ignore: cast_nullable_to_non_nullable
              as List<Package>,
      lifetime: freezed == lifetime
          ? _value.lifetime
          : lifetime // ignore: cast_nullable_to_non_nullable
              as Package?,
      annual: freezed == annual
          ? _value.annual
          : annual // ignore: cast_nullable_to_non_nullable
              as Package?,
      sixMonth: freezed == sixMonth
          ? _value.sixMonth
          : sixMonth // ignore: cast_nullable_to_non_nullable
              as Package?,
      threeMonth: freezed == threeMonth
          ? _value.threeMonth
          : threeMonth // ignore: cast_nullable_to_non_nullable
              as Package?,
      twoMonth: freezed == twoMonth
          ? _value.twoMonth
          : twoMonth // ignore: cast_nullable_to_non_nullable
              as Package?,
      monthly: freezed == monthly
          ? _value.monthly
          : monthly // ignore: cast_nullable_to_non_nullable
              as Package?,
      weekly: freezed == weekly
          ? _value.weekly
          : weekly // ignore: cast_nullable_to_non_nullable
              as Package?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Offering extends _Offering {
  const _$_Offering(this.identifier, this.serverDescription,
      final Map<String, Object> metadata, final List<Package> availablePackages,
      {this.lifetime,
      this.annual,
      this.sixMonth,
      this.threeMonth,
      this.twoMonth,
      this.monthly,
      this.weekly})
      : _metadata = metadata,
        _availablePackages = availablePackages,
        super._();

  factory _$_Offering.fromJson(Map<String, dynamic> json) =>
      _$$_OfferingFromJson(json);

  /// Unique identifier defined in RevenueCat dashboard.
  @override
  final String identifier;

  /// Offering description defined in RevenueCat dashboard.
  @override
  final String serverDescription;

  /// Offering metadata defined in RevenueCat dashboard.
  final Map<String, Object> _metadata;

  /// Offering metadata defined in RevenueCat dashboard.
  @override
  Map<String, Object> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  /// Array of [Package] objects available for purchase.
  final List<Package> _availablePackages;

  /// Array of [Package] objects available for purchase.
  @override
  List<Package> get availablePackages {
    if (_availablePackages is EqualUnmodifiableListView)
      return _availablePackages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availablePackages);
  }

  /// Lifetime package type configured in the RevenueCat dashboard, if available.
  @override
  final Package? lifetime;

  /// Annual package type configured in the RevenueCat dashboard, if available.
  @override
  final Package? annual;

  /// Six month package type configured in the RevenueCat dashboard, if available.
  @override
  final Package? sixMonth;

  /// Three month package type configured in the RevenueCat dashboard, if available.
  @override
  final Package? threeMonth;

  /// Two month package type configured in the RevenueCat dashboard, if available.
  @override
  final Package? twoMonth;

  /// Monthly package type configured in the RevenueCat dashboard, if available.
  @override
  final Package? monthly;

  /// Weekly package type configured in the RevenueCat dashboard, if available.
  @override
  final Package? weekly;

  @override
  String toString() {
    return 'Offering(identifier: $identifier, serverDescription: $serverDescription, metadata: $metadata, availablePackages: $availablePackages, lifetime: $lifetime, annual: $annual, sixMonth: $sixMonth, threeMonth: $threeMonth, twoMonth: $twoMonth, monthly: $monthly, weekly: $weekly)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Offering &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            (identical(other.serverDescription, serverDescription) ||
                other.serverDescription == serverDescription) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            const DeepCollectionEquality()
                .equals(other._availablePackages, _availablePackages) &&
            (identical(other.lifetime, lifetime) ||
                other.lifetime == lifetime) &&
            (identical(other.annual, annual) || other.annual == annual) &&
            (identical(other.sixMonth, sixMonth) ||
                other.sixMonth == sixMonth) &&
            (identical(other.threeMonth, threeMonth) ||
                other.threeMonth == threeMonth) &&
            (identical(other.twoMonth, twoMonth) ||
                other.twoMonth == twoMonth) &&
            (identical(other.monthly, monthly) || other.monthly == monthly) &&
            (identical(other.weekly, weekly) || other.weekly == weekly));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      identifier,
      serverDescription,
      const DeepCollectionEquality().hash(_metadata),
      const DeepCollectionEquality().hash(_availablePackages),
      lifetime,
      annual,
      sixMonth,
      threeMonth,
      twoMonth,
      monthly,
      weekly);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OfferingCopyWith<_$_Offering> get copyWith =>
      __$$_OfferingCopyWithImpl<_$_Offering>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OfferingToJson(
      this,
    );
  }
}

abstract class _Offering extends Offering {
  const factory _Offering(
      final String identifier,
      final String serverDescription,
      final Map<String, Object> metadata,
      final List<Package> availablePackages,
      {final Package? lifetime,
      final Package? annual,
      final Package? sixMonth,
      final Package? threeMonth,
      final Package? twoMonth,
      final Package? monthly,
      final Package? weekly}) = _$_Offering;
  const _Offering._() : super._();

  factory _Offering.fromJson(Map<String, dynamic> json) = _$_Offering.fromJson;

  @override

  /// Unique identifier defined in RevenueCat dashboard.
  String get identifier;
  @override

  /// Offering description defined in RevenueCat dashboard.
  String get serverDescription;
  @override

  /// Offering metadata defined in RevenueCat dashboard.
  Map<String, Object> get metadata;
  @override

  /// Array of [Package] objects available for purchase.
  List<Package> get availablePackages;
  @override

  /// Lifetime package type configured in the RevenueCat dashboard, if available.
  Package? get lifetime;
  @override

  /// Annual package type configured in the RevenueCat dashboard, if available.
  Package? get annual;
  @override

  /// Six month package type configured in the RevenueCat dashboard, if available.
  Package? get sixMonth;
  @override

  /// Three month package type configured in the RevenueCat dashboard, if available.
  Package? get threeMonth;
  @override

  /// Two month package type configured in the RevenueCat dashboard, if available.
  Package? get twoMonth;
  @override

  /// Monthly package type configured in the RevenueCat dashboard, if available.
  Package? get monthly;
  @override

  /// Weekly package type configured in the RevenueCat dashboard, if available.
  Package? get weekly;
  @override
  @JsonKey(ignore: true)
  _$$_OfferingCopyWith<_$_Offering> get copyWith =>
      throw _privateConstructorUsedError;
}
