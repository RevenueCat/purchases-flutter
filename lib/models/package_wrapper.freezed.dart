// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'package_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Package _$PackageFromJson(Map<String, dynamic> json) {
  return _Package.fromJson(json);
}

/// @nodoc
mixin _$Package {
  /// Unique identifier for this package. Can be one a predefined package type
  /// or a custom one.
  String get identifier => throw _privateConstructorUsedError;

  /// Package type for the product. Will be one of [PackageType].
// ignore: invalid_annotation_target
  @JsonKey(name: 'packageType', unknownEnumValue: PackageType.unknown)
  PackageType get packageType => throw _privateConstructorUsedError;

  /// StoreProduct assigned to this package.
// ignore: invalid_annotation_target
  @JsonKey(name: 'product')
  StoreProduct get storeProduct => throw _privateConstructorUsedError;

  /// Offering this package belongs to.
  String get offeringIdentifier => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PackageCopyWith<Package> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PackageCopyWith<$Res> {
  factory $PackageCopyWith(Package value, $Res Function(Package) then) =
      _$PackageCopyWithImpl<$Res, Package>;
  @useResult
  $Res call(
      {String identifier,
      @JsonKey(name: 'packageType', unknownEnumValue: PackageType.unknown)
      PackageType packageType,
      @JsonKey(name: 'product') StoreProduct storeProduct,
      String offeringIdentifier});

  $StoreProductCopyWith<$Res> get storeProduct;
}

/// @nodoc
class _$PackageCopyWithImpl<$Res, $Val extends Package>
    implements $PackageCopyWith<$Res> {
  _$PackageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identifier = null,
    Object? packageType = null,
    Object? storeProduct = null,
    Object? offeringIdentifier = null,
  }) {
    return _then(_value.copyWith(
      identifier: null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      packageType: null == packageType
          ? _value.packageType
          : packageType // ignore: cast_nullable_to_non_nullable
              as PackageType,
      storeProduct: null == storeProduct
          ? _value.storeProduct
          : storeProduct // ignore: cast_nullable_to_non_nullable
              as StoreProduct,
      offeringIdentifier: null == offeringIdentifier
          ? _value.offeringIdentifier
          : offeringIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $StoreProductCopyWith<$Res> get storeProduct {
    return $StoreProductCopyWith<$Res>(_value.storeProduct, (value) {
      return _then(_value.copyWith(storeProduct: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PackageCopyWith<$Res> implements $PackageCopyWith<$Res> {
  factory _$$_PackageCopyWith(
          _$_Package value, $Res Function(_$_Package) then) =
      __$$_PackageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String identifier,
      @JsonKey(name: 'packageType', unknownEnumValue: PackageType.unknown)
      PackageType packageType,
      @JsonKey(name: 'product') StoreProduct storeProduct,
      String offeringIdentifier});

  @override
  $StoreProductCopyWith<$Res> get storeProduct;
}

/// @nodoc
class __$$_PackageCopyWithImpl<$Res>
    extends _$PackageCopyWithImpl<$Res, _$_Package>
    implements _$$_PackageCopyWith<$Res> {
  __$$_PackageCopyWithImpl(_$_Package _value, $Res Function(_$_Package) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identifier = null,
    Object? packageType = null,
    Object? storeProduct = null,
    Object? offeringIdentifier = null,
  }) {
    return _then(_$_Package(
      null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      null == packageType
          ? _value.packageType
          : packageType // ignore: cast_nullable_to_non_nullable
              as PackageType,
      null == storeProduct
          ? _value.storeProduct
          : storeProduct // ignore: cast_nullable_to_non_nullable
              as StoreProduct,
      null == offeringIdentifier
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
      this.identifier,
      @JsonKey(name: 'packageType', unknownEnumValue: PackageType.unknown)
      this.packageType,
      @JsonKey(name: 'product') this.storeProduct,
      this.offeringIdentifier);

  factory _$_Package.fromJson(Map<String, dynamic> json) =>
      _$$_PackageFromJson(json);

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

  /// Offering this package belongs to.
  @override
  final String offeringIdentifier;

  @override
  String toString() {
    return 'Package(identifier: $identifier, packageType: $packageType, storeProduct: $storeProduct, offeringIdentifier: $offeringIdentifier)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Package &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            (identical(other.packageType, packageType) ||
                other.packageType == packageType) &&
            (identical(other.storeProduct, storeProduct) ||
                other.storeProduct == storeProduct) &&
            (identical(other.offeringIdentifier, offeringIdentifier) ||
                other.offeringIdentifier == offeringIdentifier));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, identifier, packageType, storeProduct, offeringIdentifier);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PackageCopyWith<_$_Package> get copyWith =>
      __$$_PackageCopyWithImpl<_$_Package>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PackageToJson(
      this,
    );
  }
}

abstract class _Package implements Package {
  const factory _Package(
      final String identifier,
      @JsonKey(name: 'packageType', unknownEnumValue: PackageType.unknown)
      final PackageType packageType,
      @JsonKey(name: 'product') final StoreProduct storeProduct,
      final String offeringIdentifier) = _$_Package;

  factory _Package.fromJson(Map<String, dynamic> json) = _$_Package.fromJson;

  @override

  /// Unique identifier for this package. Can be one a predefined package type
  /// or a custom one.
  String get identifier;
  @override

  /// Package type for the product. Will be one of [PackageType].
// ignore: invalid_annotation_target
  @JsonKey(name: 'packageType', unknownEnumValue: PackageType.unknown)
  PackageType get packageType;
  @override

  /// StoreProduct assigned to this package.
// ignore: invalid_annotation_target
  @JsonKey(name: 'product')
  StoreProduct get storeProduct;
  @override

  /// Offering this package belongs to.
  String get offeringIdentifier;
  @override
  @JsonKey(ignore: true)
  _$$_PackageCopyWith<_$_Package> get copyWith =>
      throw _privateConstructorUsedError;
}
