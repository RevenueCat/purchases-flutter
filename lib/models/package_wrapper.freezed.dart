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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Package _$PackageFromJson(Map<String, dynamic> json) {
  return _Package.fromJson(json);
}

/// @nodoc
mixin _$Package {
  /// Unique identifier for this package. Can be one a predefined package type
  /// or a custom one.
  @JsonKey(name: 'identifier')
  String get identifier => throw _privateConstructorUsedError;

  /// Package type for the product. Will be one of [PackageType].
  @JsonKey(name: 'packageType', unknownEnumValue: PackageType.unknown)
  PackageType get packageType => throw _privateConstructorUsedError;

  /// Product assigned to this package.
  @JsonKey(name: 'product')
  Product get product => throw _privateConstructorUsedError;

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
      @JsonKey(name: 'product')
          Product product,
      @JsonKey(name: 'offeringIdentifier')
          String offeringIdentifier});

  $ProductCopyWith<$Res> get product;
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
    Object? product = freezed,
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
      product: product == freezed
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
      offeringIdentifier: offeringIdentifier == freezed
          ? _value.offeringIdentifier
          : offeringIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $ProductCopyWith<$Res> get product {
    return $ProductCopyWith<$Res>(_value.product, (value) {
      return _then(_value.copyWith(product: value));
    });
  }
}

/// @nodoc
abstract class _$$_PackageCopyWith<$Res> implements $PackageCopyWith<$Res> {
  factory _$$_PackageCopyWith(
          _$_Package value, $Res Function(_$_Package) then) =
      __$$_PackageCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'identifier')
          String identifier,
      @JsonKey(name: 'packageType', unknownEnumValue: PackageType.unknown)
          PackageType packageType,
      @JsonKey(name: 'product')
          Product product,
      @JsonKey(name: 'offeringIdentifier')
          String offeringIdentifier});

  @override
  $ProductCopyWith<$Res> get product;
}

/// @nodoc
class __$$_PackageCopyWithImpl<$Res> extends _$PackageCopyWithImpl<$Res>
    implements _$$_PackageCopyWith<$Res> {
  __$$_PackageCopyWithImpl(_$_Package _value, $Res Function(_$_Package) _then)
      : super(_value, (v) => _then(v as _$_Package));

  @override
  _$_Package get _value => super._value as _$_Package;

  @override
  $Res call({
    Object? identifier = freezed,
    Object? packageType = freezed,
    Object? product = freezed,
    Object? offeringIdentifier = freezed,
  }) {
    return _then(_$_Package(
      identifier == freezed
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      packageType == freezed
          ? _value.packageType
          : packageType // ignore: cast_nullable_to_non_nullable
              as PackageType,
      product == freezed
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
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
      @JsonKey(name: 'product')
          this.product,
      @JsonKey(name: 'offeringIdentifier')
          this.offeringIdentifier);

  factory _$_Package.fromJson(Map<String, dynamic> json) =>
      _$$_PackageFromJson(json);

  /// Unique identifier for this package. Can be one a predefined package type
  /// or a custom one.
  @override
  @JsonKey(name: 'identifier')
  final String identifier;

  /// Package type for the product. Will be one of [PackageType].
  @override
  @JsonKey(name: 'packageType', unknownEnumValue: PackageType.unknown)
  final PackageType packageType;

  /// Product assigned to this package.
  @override
  @JsonKey(name: 'product')
  final Product product;

  /// Offering this package belongs to.
  @override
  @JsonKey(name: 'offeringIdentifier')
  final String offeringIdentifier;

  @override
  String toString() {
    return 'Package(identifier: $identifier, packageType: $packageType, product: $product, offeringIdentifier: $offeringIdentifier)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Package &&
            const DeepCollectionEquality()
                .equals(other.identifier, identifier) &&
            const DeepCollectionEquality()
                .equals(other.packageType, packageType) &&
            const DeepCollectionEquality().equals(other.product, product) &&
            const DeepCollectionEquality()
                .equals(other.offeringIdentifier, offeringIdentifier));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(identifier),
      const DeepCollectionEquality().hash(packageType),
      const DeepCollectionEquality().hash(product),
      const DeepCollectionEquality().hash(offeringIdentifier));

  @JsonKey(ignore: true)
  @override
  _$$_PackageCopyWith<_$_Package> get copyWith =>
      __$$_PackageCopyWithImpl<_$_Package>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PackageToJson(this);
  }
}

abstract class _Package implements Package {
  const factory _Package(
      @JsonKey(name: 'identifier')
          final String identifier,
      @JsonKey(name: 'packageType', unknownEnumValue: PackageType.unknown)
          final PackageType packageType,
      @JsonKey(name: 'product')
          final Product product,
      @JsonKey(name: 'offeringIdentifier')
          final String offeringIdentifier) = _$_Package;

  factory _Package.fromJson(Map<String, dynamic> json) = _$_Package.fromJson;

  @override

  /// Unique identifier for this package. Can be one a predefined package type
  /// or a custom one.
  @JsonKey(name: 'identifier')
  String get identifier => throw _privateConstructorUsedError;
  @override

  /// Package type for the product. Will be one of [PackageType].
  @JsonKey(name: 'packageType', unknownEnumValue: PackageType.unknown)
  PackageType get packageType => throw _privateConstructorUsedError;
  @override

  /// Product assigned to this package.
  @JsonKey(name: 'product')
  Product get product => throw _privateConstructorUsedError;
  @override

  /// Offering this package belongs to.
  @JsonKey(name: 'offeringIdentifier')
  String get offeringIdentifier => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_PackageCopyWith<_$_Package> get copyWith =>
      throw _privateConstructorUsedError;
}
