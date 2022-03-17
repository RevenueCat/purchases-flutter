// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'package_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Package _$PackageFromJson(Map<String, dynamic> json) {
  return _Package.fromJson(json);
}

/// @nodoc
class _$PackageTearOff {
  const _$PackageTearOff();

  _Package call(
      @JsonKey(name: 'identifier')
          String identifier,
      @JsonKey(name: 'packageType', unknownEnumValue: PackageType.unknown)
          PackageType packageType,
      @JsonKey(name: 'storeProduct')
          StoreProduct storeProduct,
      @JsonKey(name: 'offeringIdentifier')
          String offeringIdentifier) {
    return _Package(
      identifier,
      packageType,
      storeProduct,
      offeringIdentifier,
    );
  }

  Package fromJson(Map<String, Object?> json) {
    return Package.fromJson(json);
  }
}

/// @nodoc
const $Package = _$PackageTearOff();

/// @nodoc
mixin _$Package {
  /// Unique identifier for this package. Can be one a predefined package type
  /// or a custom one.
  @JsonKey(name: 'identifier')
  String get identifier => throw _privateConstructorUsedError;

  /// Package type for the product. Will be one of [PackageType].
  @JsonKey(name: 'packageType', unknownEnumValue: PackageType.unknown)
  PackageType get packageType => throw _privateConstructorUsedError;

  /// StoreProduct assigned to this package.
  @JsonKey(name: 'storeProduct')
  StoreProduct get storeProduct => throw _privateConstructorUsedError;

  /// Offering this package belongs to.
  @JsonKey(name: 'offeringIdentifier')
  String get offeringIdentifier => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PackageCopyWith<Package> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PackageCopyWith<$Res> {
  factory $PackageCopyWith(Package value, $Res Function(Package) then) =
      _$PackageCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'identifier')
          String identifier,
      @JsonKey(name: 'packageType', unknownEnumValue: PackageType.unknown)
          PackageType packageType,
      @JsonKey(name: 'storeProduct')
          StoreProduct storeProduct,
      @JsonKey(name: 'offeringIdentifier')
          String offeringIdentifier});

  $StoreProductCopyWith<$Res> get storeProduct;
}

/// @nodoc
class _$PackageCopyWithImpl<$Res> implements $PackageCopyWith<$Res> {
  _$PackageCopyWithImpl(this._value, this._then);

  final Package _value;
  // ignore: unused_field
  final $Res Function(Package) _then;

  @override
  $Res call({
    Object? identifier = freezed,
    Object? packageType = freezed,
    Object? storeProduct = freezed,
    Object? offeringIdentifier = freezed,
  }) {
    return _then(_value.copyWith(
      identifier: identifier == freezed
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      packageType: packageType == freezed
          ? _value.packageType
          : packageType // ignore: cast_nullable_to_non_nullable
              as PackageType,
      storeProduct: storeProduct == freezed
          ? _value.storeProduct
          : storeProduct // ignore: cast_nullable_to_non_nullable
              as StoreProduct,
      offeringIdentifier: offeringIdentifier == freezed
          ? _value.offeringIdentifier
          : offeringIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $StoreProductCopyWith<$Res> get storeProduct {
    return $StoreProductCopyWith<$Res>(_value.storeProduct, (value) {
      return _then(_value.copyWith(storeProduct: value));
    });
  }
}

/// @nodoc
abstract class _$PackageCopyWith<$Res> implements $PackageCopyWith<$Res> {
  factory _$PackageCopyWith(_Package value, $Res Function(_Package) then) =
      __$PackageCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'identifier')
          String identifier,
      @JsonKey(name: 'packageType', unknownEnumValue: PackageType.unknown)
          PackageType packageType,
      @JsonKey(name: 'storeProduct')
          StoreProduct storeProduct,
      @JsonKey(name: 'offeringIdentifier')
          String offeringIdentifier});

  @override
  $StoreProductCopyWith<$Res> get storeProduct;
}

/// @nodoc
class __$PackageCopyWithImpl<$Res> extends _$PackageCopyWithImpl<$Res>
    implements _$PackageCopyWith<$Res> {
  __$PackageCopyWithImpl(_Package _value, $Res Function(_Package) _then)
      : super(_value, (v) => _then(v as _Package));

  @override
  _Package get _value => super._value as _Package;

  @override
  $Res call({
    Object? identifier = freezed,
    Object? packageType = freezed,
    Object? storeProduct = freezed,
    Object? offeringIdentifier = freezed,
  }) {
    return _then(_Package(
      identifier == freezed
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      packageType == freezed
          ? _value.packageType
          : packageType // ignore: cast_nullable_to_non_nullable
              as PackageType,
      storeProduct == freezed
          ? _value.storeProduct
          : storeProduct // ignore: cast_nullable_to_non_nullable
              as StoreProduct,
      offeringIdentifier == freezed
          ? _value.offeringIdentifier
          : offeringIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Package implements _Package {
  const _$_Package(
      @JsonKey(name: 'identifier')
          this.identifier,
      @JsonKey(name: 'packageType', unknownEnumValue: PackageType.unknown)
          this.packageType,
      @JsonKey(name: 'storeProduct')
          this.storeProduct,
      @JsonKey(name: 'offeringIdentifier')
          this.offeringIdentifier);

  factory _$_Package.fromJson(Map<String, dynamic> json) =>
      _$$_PackageFromJson(json);

  @override

  /// Unique identifier for this package. Can be one a predefined package type
  /// or a custom one.
  @JsonKey(name: 'identifier')
  final String identifier;
  @override

  /// Package type for the product. Will be one of [PackageType].
  @JsonKey(name: 'packageType', unknownEnumValue: PackageType.unknown)
  final PackageType packageType;
  @override

  /// StoreProduct assigned to this package.
  @JsonKey(name: 'storeProduct')
  final StoreProduct storeProduct;
  @override

  /// Offering this package belongs to.
  @JsonKey(name: 'offeringIdentifier')
  final String offeringIdentifier;

  @override
  String toString() {
    return 'Package(identifier: $identifier, packageType: $packageType, storeProduct: $storeProduct, offeringIdentifier: $offeringIdentifier)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Package &&
            const DeepCollectionEquality()
                .equals(other.identifier, identifier) &&
            const DeepCollectionEquality()
                .equals(other.packageType, packageType) &&
            const DeepCollectionEquality()
                .equals(other.storeProduct, storeProduct) &&
            const DeepCollectionEquality()
                .equals(other.offeringIdentifier, offeringIdentifier));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(identifier),
      const DeepCollectionEquality().hash(packageType),
      const DeepCollectionEquality().hash(storeProduct),
      const DeepCollectionEquality().hash(offeringIdentifier));

  @JsonKey(ignore: true)
  @override
  _$PackageCopyWith<_Package> get copyWith =>
      __$PackageCopyWithImpl<_Package>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PackageToJson(this);
  }
}

abstract class _Package implements Package {
  const factory _Package(
      @JsonKey(name: 'identifier')
          String identifier,
      @JsonKey(name: 'packageType', unknownEnumValue: PackageType.unknown)
          PackageType packageType,
      @JsonKey(name: 'storeProduct')
          StoreProduct storeProduct,
      @JsonKey(name: 'offeringIdentifier')
          String offeringIdentifier) = _$_Package;

  factory _Package.fromJson(Map<String, dynamic> json) = _$_Package.fromJson;

  @override

  /// Unique identifier for this package. Can be one a predefined package type
  /// or a custom one.
  @JsonKey(name: 'identifier')
  String get identifier;
  @override

  /// Package type for the product. Will be one of [PackageType].
  @JsonKey(name: 'packageType', unknownEnumValue: PackageType.unknown)
  PackageType get packageType;
  @override

  /// StoreProduct assigned to this package.
  @JsonKey(name: 'storeProduct')
  StoreProduct get storeProduct;
  @override

  /// Offering this package belongs to.
  @JsonKey(name: 'offeringIdentifier')
  String get offeringIdentifier;
  @override
  @JsonKey(ignore: true)
  _$PackageCopyWith<_Package> get copyWith =>
      throw _privateConstructorUsedError;
}
