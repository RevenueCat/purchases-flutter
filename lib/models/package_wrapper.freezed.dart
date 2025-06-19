// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'package_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Package {
  /// Unique identifier for this package. Can be one a predefined package type
  /// or a custom one.
  String get identifier;

  /// Package type for the product. Will be one of [PackageType].
// ignore: invalid_annotation_target
  @JsonKey(name: 'packageType', unknownEnumValue: PackageType.unknown)
  PackageType get packageType;

  /// StoreProduct assigned to this package.
// ignore: invalid_annotation_target
  @JsonKey(name: 'product')
  StoreProduct get storeProduct;

  /// Offering context this package belongs to.
  PresentedOfferingContext get presentedOfferingContext;

  /// Create a copy of Package
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PackageCopyWith<Package> get copyWith =>
      _$PackageCopyWithImpl<Package>(this as Package, _$identity);

  /// Serializes this Package to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Package &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            (identical(other.packageType, packageType) ||
                other.packageType == packageType) &&
            (identical(other.storeProduct, storeProduct) ||
                other.storeProduct == storeProduct) &&
            (identical(
                    other.presentedOfferingContext, presentedOfferingContext) ||
                other.presentedOfferingContext == presentedOfferingContext));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, identifier, packageType,
      storeProduct, presentedOfferingContext);

  @override
  String toString() {
    return 'Package(identifier: $identifier, packageType: $packageType, storeProduct: $storeProduct, presentedOfferingContext: $presentedOfferingContext)';
  }
}

/// @nodoc
abstract mixin class $PackageCopyWith<$Res> {
  factory $PackageCopyWith(Package value, $Res Function(Package) _then) =
      _$PackageCopyWithImpl;
  @useResult
  $Res call(
      {String identifier,
      @JsonKey(name: 'packageType', unknownEnumValue: PackageType.unknown)
      PackageType packageType,
      @JsonKey(name: 'product') StoreProduct storeProduct,
      PresentedOfferingContext presentedOfferingContext});

  $StoreProductCopyWith<$Res> get storeProduct;
  $PresentedOfferingContextCopyWith<$Res> get presentedOfferingContext;
}

/// @nodoc
class _$PackageCopyWithImpl<$Res> implements $PackageCopyWith<$Res> {
  _$PackageCopyWithImpl(this._self, this._then);

  final Package _self;
  final $Res Function(Package) _then;

  /// Create a copy of Package
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identifier = null,
    Object? packageType = null,
    Object? storeProduct = null,
    Object? presentedOfferingContext = null,
  }) {
    return _then(_self.copyWith(
      identifier: null == identifier
          ? _self.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      packageType: null == packageType
          ? _self.packageType
          : packageType // ignore: cast_nullable_to_non_nullable
              as PackageType,
      storeProduct: null == storeProduct
          ? _self.storeProduct
          : storeProduct // ignore: cast_nullable_to_non_nullable
              as StoreProduct,
      presentedOfferingContext: null == presentedOfferingContext
          ? _self.presentedOfferingContext
          : presentedOfferingContext // ignore: cast_nullable_to_non_nullable
              as PresentedOfferingContext,
    ));
  }

  /// Create a copy of Package
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StoreProductCopyWith<$Res> get storeProduct {
    return $StoreProductCopyWith<$Res>(_self.storeProduct, (value) {
      return _then(_self.copyWith(storeProduct: value));
    });
  }

  /// Create a copy of Package
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PresentedOfferingContextCopyWith<$Res> get presentedOfferingContext {
    return $PresentedOfferingContextCopyWith<$Res>(
        _self.presentedOfferingContext, (value) {
      return _then(_self.copyWith(presentedOfferingContext: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _Package implements Package {
  const _Package(
      this.identifier,
      @JsonKey(name: 'packageType', unknownEnumValue: PackageType.unknown)
      this.packageType,
      @JsonKey(name: 'product') this.storeProduct,
      this.presentedOfferingContext);
  factory _Package.fromJson(Map<String, dynamic> json) =>
      _$PackageFromJson(json);

  /// Unique identifier for this package. Can be one a predefined package type
  /// or a custom one.
  @override
  final String identifier;

  /// Package type for the product. Will be one of [PackageType].
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'packageType', unknownEnumValue: PackageType.unknown)
  final PackageType packageType;

  /// StoreProduct assigned to this package.
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'product')
  final StoreProduct storeProduct;

  /// Offering context this package belongs to.
  @override
  final PresentedOfferingContext presentedOfferingContext;

  /// Create a copy of Package
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PackageCopyWith<_Package> get copyWith =>
      __$PackageCopyWithImpl<_Package>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PackageToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Package &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            (identical(other.packageType, packageType) ||
                other.packageType == packageType) &&
            (identical(other.storeProduct, storeProduct) ||
                other.storeProduct == storeProduct) &&
            (identical(
                    other.presentedOfferingContext, presentedOfferingContext) ||
                other.presentedOfferingContext == presentedOfferingContext));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, identifier, packageType,
      storeProduct, presentedOfferingContext);

  @override
  String toString() {
    return 'Package(identifier: $identifier, packageType: $packageType, storeProduct: $storeProduct, presentedOfferingContext: $presentedOfferingContext)';
  }
}

/// @nodoc
abstract mixin class _$PackageCopyWith<$Res> implements $PackageCopyWith<$Res> {
  factory _$PackageCopyWith(_Package value, $Res Function(_Package) _then) =
      __$PackageCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String identifier,
      @JsonKey(name: 'packageType', unknownEnumValue: PackageType.unknown)
      PackageType packageType,
      @JsonKey(name: 'product') StoreProduct storeProduct,
      PresentedOfferingContext presentedOfferingContext});

  @override
  $StoreProductCopyWith<$Res> get storeProduct;
  @override
  $PresentedOfferingContextCopyWith<$Res> get presentedOfferingContext;
}

/// @nodoc
class __$PackageCopyWithImpl<$Res> implements _$PackageCopyWith<$Res> {
  __$PackageCopyWithImpl(this._self, this._then);

  final _Package _self;
  final $Res Function(_Package) _then;

  /// Create a copy of Package
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? identifier = null,
    Object? packageType = null,
    Object? storeProduct = null,
    Object? presentedOfferingContext = null,
  }) {
    return _then(_Package(
      null == identifier
          ? _self.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      null == packageType
          ? _self.packageType
          : packageType // ignore: cast_nullable_to_non_nullable
              as PackageType,
      null == storeProduct
          ? _self.storeProduct
          : storeProduct // ignore: cast_nullable_to_non_nullable
              as StoreProduct,
      null == presentedOfferingContext
          ? _self.presentedOfferingContext
          : presentedOfferingContext // ignore: cast_nullable_to_non_nullable
              as PresentedOfferingContext,
    ));
  }

  /// Create a copy of Package
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StoreProductCopyWith<$Res> get storeProduct {
    return $StoreProductCopyWith<$Res>(_self.storeProduct, (value) {
      return _then(_self.copyWith(storeProduct: value));
    });
  }

  /// Create a copy of Package
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PresentedOfferingContextCopyWith<$Res> get presentedOfferingContext {
    return $PresentedOfferingContextCopyWith<$Res>(
        _self.presentedOfferingContext, (value) {
      return _then(_self.copyWith(presentedOfferingContext: value));
    });
  }
}

// dart format on
