// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'offering_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Offering {
  /// Unique identifier defined in RevenueCat dashboard.
  String get identifier;

  /// Offering description defined in RevenueCat dashboard.
  String get serverDescription;

  /// Offering metadata defined in RevenueCat dashboard.
  Map<String, Object> get metadata;

  /// Array of [Package] objects available for purchase.
  List<Package> get availablePackages;

  /// Lifetime package type configured in the RevenueCat dashboard, if available.
  Package? get lifetime;

  /// Annual package type configured in the RevenueCat dashboard, if available.
  Package? get annual;

  /// Six month package type configured in the RevenueCat dashboard, if available.
  Package? get sixMonth;

  /// Three month package type configured in the RevenueCat dashboard, if available.
  Package? get threeMonth;

  /// Two month package type configured in the RevenueCat dashboard, if available.
  Package? get twoMonth;

  /// Monthly package type configured in the RevenueCat dashboard, if available.
  Package? get monthly;

  /// Weekly package type configured in the RevenueCat dashboard, if available.
  Package? get weekly;

  /// Create a copy of Offering
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OfferingCopyWith<Offering> get copyWith =>
      _$OfferingCopyWithImpl<Offering>(this as Offering, _$identity);

  /// Serializes this Offering to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Offering &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            (identical(other.serverDescription, serverDescription) ||
                other.serverDescription == serverDescription) &&
            const DeepCollectionEquality().equals(other.metadata, metadata) &&
            const DeepCollectionEquality()
                .equals(other.availablePackages, availablePackages) &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      identifier,
      serverDescription,
      const DeepCollectionEquality().hash(metadata),
      const DeepCollectionEquality().hash(availablePackages),
      lifetime,
      annual,
      sixMonth,
      threeMonth,
      twoMonth,
      monthly,
      weekly);

  @override
  String toString() {
    return 'Offering(identifier: $identifier, serverDescription: $serverDescription, metadata: $metadata, availablePackages: $availablePackages, lifetime: $lifetime, annual: $annual, sixMonth: $sixMonth, threeMonth: $threeMonth, twoMonth: $twoMonth, monthly: $monthly, weekly: $weekly)';
  }
}

/// @nodoc
abstract mixin class $OfferingCopyWith<$Res> {
  factory $OfferingCopyWith(Offering value, $Res Function(Offering) _then) =
      _$OfferingCopyWithImpl;
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
class _$OfferingCopyWithImpl<$Res> implements $OfferingCopyWith<$Res> {
  _$OfferingCopyWithImpl(this._self, this._then);

  final Offering _self;
  final $Res Function(Offering) _then;

  /// Create a copy of Offering
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      identifier: null == identifier
          ? _self.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      serverDescription: null == serverDescription
          ? _self.serverDescription
          : serverDescription // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: null == metadata
          ? _self.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, Object>,
      availablePackages: null == availablePackages
          ? _self.availablePackages
          : availablePackages // ignore: cast_nullable_to_non_nullable
              as List<Package>,
      lifetime: freezed == lifetime
          ? _self.lifetime
          : lifetime // ignore: cast_nullable_to_non_nullable
              as Package?,
      annual: freezed == annual
          ? _self.annual
          : annual // ignore: cast_nullable_to_non_nullable
              as Package?,
      sixMonth: freezed == sixMonth
          ? _self.sixMonth
          : sixMonth // ignore: cast_nullable_to_non_nullable
              as Package?,
      threeMonth: freezed == threeMonth
          ? _self.threeMonth
          : threeMonth // ignore: cast_nullable_to_non_nullable
              as Package?,
      twoMonth: freezed == twoMonth
          ? _self.twoMonth
          : twoMonth // ignore: cast_nullable_to_non_nullable
              as Package?,
      monthly: freezed == monthly
          ? _self.monthly
          : monthly // ignore: cast_nullable_to_non_nullable
              as Package?,
      weekly: freezed == weekly
          ? _self.weekly
          : weekly // ignore: cast_nullable_to_non_nullable
              as Package?,
    ));
  }

  /// Create a copy of Offering
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PackageCopyWith<$Res>? get lifetime {
    if (_self.lifetime == null) {
      return null;
    }

    return $PackageCopyWith<$Res>(_self.lifetime!, (value) {
      return _then(_self.copyWith(lifetime: value));
    });
  }

  /// Create a copy of Offering
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PackageCopyWith<$Res>? get annual {
    if (_self.annual == null) {
      return null;
    }

    return $PackageCopyWith<$Res>(_self.annual!, (value) {
      return _then(_self.copyWith(annual: value));
    });
  }

  /// Create a copy of Offering
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PackageCopyWith<$Res>? get sixMonth {
    if (_self.sixMonth == null) {
      return null;
    }

    return $PackageCopyWith<$Res>(_self.sixMonth!, (value) {
      return _then(_self.copyWith(sixMonth: value));
    });
  }

  /// Create a copy of Offering
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PackageCopyWith<$Res>? get threeMonth {
    if (_self.threeMonth == null) {
      return null;
    }

    return $PackageCopyWith<$Res>(_self.threeMonth!, (value) {
      return _then(_self.copyWith(threeMonth: value));
    });
  }

  /// Create a copy of Offering
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PackageCopyWith<$Res>? get twoMonth {
    if (_self.twoMonth == null) {
      return null;
    }

    return $PackageCopyWith<$Res>(_self.twoMonth!, (value) {
      return _then(_self.copyWith(twoMonth: value));
    });
  }

  /// Create a copy of Offering
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PackageCopyWith<$Res>? get monthly {
    if (_self.monthly == null) {
      return null;
    }

    return $PackageCopyWith<$Res>(_self.monthly!, (value) {
      return _then(_self.copyWith(monthly: value));
    });
  }

  /// Create a copy of Offering
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PackageCopyWith<$Res>? get weekly {
    if (_self.weekly == null) {
      return null;
    }

    return $PackageCopyWith<$Res>(_self.weekly!, (value) {
      return _then(_self.copyWith(weekly: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _Offering extends Offering {
  const _Offering(this.identifier, this.serverDescription,
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
  factory _Offering.fromJson(Map<String, dynamic> json) =>
      _$OfferingFromJson(json);

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

  /// Create a copy of Offering
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OfferingCopyWith<_Offering> get copyWith =>
      __$OfferingCopyWithImpl<_Offering>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OfferingToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Offering &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  String toString() {
    return 'Offering(identifier: $identifier, serverDescription: $serverDescription, metadata: $metadata, availablePackages: $availablePackages, lifetime: $lifetime, annual: $annual, sixMonth: $sixMonth, threeMonth: $threeMonth, twoMonth: $twoMonth, monthly: $monthly, weekly: $weekly)';
  }
}

/// @nodoc
abstract mixin class _$OfferingCopyWith<$Res>
    implements $OfferingCopyWith<$Res> {
  factory _$OfferingCopyWith(_Offering value, $Res Function(_Offering) _then) =
      __$OfferingCopyWithImpl;
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
class __$OfferingCopyWithImpl<$Res> implements _$OfferingCopyWith<$Res> {
  __$OfferingCopyWithImpl(this._self, this._then);

  final _Offering _self;
  final $Res Function(_Offering) _then;

  /// Create a copy of Offering
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_Offering(
      null == identifier
          ? _self.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      null == serverDescription
          ? _self.serverDescription
          : serverDescription // ignore: cast_nullable_to_non_nullable
              as String,
      null == metadata
          ? _self._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, Object>,
      null == availablePackages
          ? _self._availablePackages
          : availablePackages // ignore: cast_nullable_to_non_nullable
              as List<Package>,
      lifetime: freezed == lifetime
          ? _self.lifetime
          : lifetime // ignore: cast_nullable_to_non_nullable
              as Package?,
      annual: freezed == annual
          ? _self.annual
          : annual // ignore: cast_nullable_to_non_nullable
              as Package?,
      sixMonth: freezed == sixMonth
          ? _self.sixMonth
          : sixMonth // ignore: cast_nullable_to_non_nullable
              as Package?,
      threeMonth: freezed == threeMonth
          ? _self.threeMonth
          : threeMonth // ignore: cast_nullable_to_non_nullable
              as Package?,
      twoMonth: freezed == twoMonth
          ? _self.twoMonth
          : twoMonth // ignore: cast_nullable_to_non_nullable
              as Package?,
      monthly: freezed == monthly
          ? _self.monthly
          : monthly // ignore: cast_nullable_to_non_nullable
              as Package?,
      weekly: freezed == weekly
          ? _self.weekly
          : weekly // ignore: cast_nullable_to_non_nullable
              as Package?,
    ));
  }

  /// Create a copy of Offering
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PackageCopyWith<$Res>? get lifetime {
    if (_self.lifetime == null) {
      return null;
    }

    return $PackageCopyWith<$Res>(_self.lifetime!, (value) {
      return _then(_self.copyWith(lifetime: value));
    });
  }

  /// Create a copy of Offering
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PackageCopyWith<$Res>? get annual {
    if (_self.annual == null) {
      return null;
    }

    return $PackageCopyWith<$Res>(_self.annual!, (value) {
      return _then(_self.copyWith(annual: value));
    });
  }

  /// Create a copy of Offering
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PackageCopyWith<$Res>? get sixMonth {
    if (_self.sixMonth == null) {
      return null;
    }

    return $PackageCopyWith<$Res>(_self.sixMonth!, (value) {
      return _then(_self.copyWith(sixMonth: value));
    });
  }

  /// Create a copy of Offering
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PackageCopyWith<$Res>? get threeMonth {
    if (_self.threeMonth == null) {
      return null;
    }

    return $PackageCopyWith<$Res>(_self.threeMonth!, (value) {
      return _then(_self.copyWith(threeMonth: value));
    });
  }

  /// Create a copy of Offering
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PackageCopyWith<$Res>? get twoMonth {
    if (_self.twoMonth == null) {
      return null;
    }

    return $PackageCopyWith<$Res>(_self.twoMonth!, (value) {
      return _then(_self.copyWith(twoMonth: value));
    });
  }

  /// Create a copy of Offering
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PackageCopyWith<$Res>? get monthly {
    if (_self.monthly == null) {
      return null;
    }

    return $PackageCopyWith<$Res>(_self.monthly!, (value) {
      return _then(_self.copyWith(monthly: value));
    });
  }

  /// Create a copy of Offering
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PackageCopyWith<$Res>? get weekly {
    if (_self.weekly == null) {
      return null;
    }

    return $PackageCopyWith<$Res>(_self.weekly!, (value) {
      return _then(_self.copyWith(weekly: value));
    });
  }
}

// dart format on
