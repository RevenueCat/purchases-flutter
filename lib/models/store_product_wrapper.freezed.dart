// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'store_product_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StoreProduct _$StoreProductFromJson(Map<String, dynamic> json) {
  return _StoreProduct.fromJson(json);
}

/// @nodoc
class _$StoreProductTearOff {
  const _$StoreProductTearOff();

  _StoreProduct call(
      @JsonKey(name: 'identifier')
          String identifier,
      @JsonKey(name: 'description')
          String description,
      @JsonKey(name: 'title')
          String title,
      @JsonKey(name: 'price')
          double price,
      @JsonKey(name: 'price_string')
          String priceString,
      @JsonKey(name: 'currency_code')
          String currencyCode,
      {@JsonKey(name: 'introPrice', nullable: true)
          IntroductoryPrice? introductoryPrice,
      @JsonKey(name: 'discounts', nullable: true)
          List<StoreProductDiscount>? discounts}) {
    return _StoreProduct(
      identifier,
      description,
      title,
      price,
      priceString,
      currencyCode,
      introductoryPrice: introductoryPrice,
      discounts: discounts,
    );
  }

  StoreProduct fromJson(Map<String, Object?> json) {
    return StoreProduct.fromJson(json);
  }
}

/// @nodoc
const $StoreProduct = _$StoreProductTearOff();

/// @nodoc
mixin _$StoreProduct {
  /// Product Id.
  @JsonKey(name: 'identifier')
  String get identifier => throw _privateConstructorUsedError;

  /// Description of the product.
  @JsonKey(name: 'description')
  String get description => throw _privateConstructorUsedError;

  /// Title of the product.
  @JsonKey(name: 'title')
  String get title => throw _privateConstructorUsedError;

  /// Price of the product in the local currency.
  @JsonKey(name: 'price')
  double get price => throw _privateConstructorUsedError;

  /// Formatted price of the item, including its currency sign.
  @JsonKey(name: 'price_string')
  String get priceString => throw _privateConstructorUsedError;

  /// Currency code for price and original price.
  @JsonKey(name: 'currency_code')
  String get currencyCode => throw _privateConstructorUsedError;

  /// Introductory price for product. Can be null.
  @JsonKey(name: 'introPrice', nullable: true)
  IntroductoryPrice? get introductoryPrice =>
      throw _privateConstructorUsedError;

  /// Collection of discount offers for a product. Null for Android.
  @JsonKey(name: 'discounts', nullable: true)
  List<StoreProductDiscount>? get discounts =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoreProductCopyWith<StoreProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoreProductCopyWith<$Res> {
  factory $StoreProductCopyWith(
          StoreProduct value, $Res Function(StoreProduct) then) =
      _$StoreProductCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'identifier')
          String identifier,
      @JsonKey(name: 'description')
          String description,
      @JsonKey(name: 'title')
          String title,
      @JsonKey(name: 'price')
          double price,
      @JsonKey(name: 'price_string')
          String priceString,
      @JsonKey(name: 'currency_code')
          String currencyCode,
      @JsonKey(name: 'introPrice', nullable: true)
          IntroductoryPrice? introductoryPrice,
      @JsonKey(name: 'discounts', nullable: true)
          List<StoreProductDiscount>? discounts});

  $IntroductoryPriceCopyWith<$Res>? get introductoryPrice;
}

/// @nodoc
class _$StoreProductCopyWithImpl<$Res> implements $StoreProductCopyWith<$Res> {
  _$StoreProductCopyWithImpl(this._value, this._then);

  final StoreProduct _value;
  // ignore: unused_field
  final $Res Function(StoreProduct) _then;

  @override
  $Res call({
    Object? identifier = freezed,
    Object? description = freezed,
    Object? title = freezed,
    Object? price = freezed,
    Object? priceString = freezed,
    Object? currencyCode = freezed,
    Object? introductoryPrice = freezed,
    Object? discounts = freezed,
  }) {
    return _then(_value.copyWith(
      identifier: identifier == freezed
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      priceString: priceString == freezed
          ? _value.priceString
          : priceString // ignore: cast_nullable_to_non_nullable
              as String,
      currencyCode: currencyCode == freezed
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String,
      introductoryPrice: introductoryPrice == freezed
          ? _value.introductoryPrice
          : introductoryPrice // ignore: cast_nullable_to_non_nullable
              as IntroductoryPrice?,
      discounts: discounts == freezed
          ? _value.discounts
          : discounts // ignore: cast_nullable_to_non_nullable
              as List<StoreProductDiscount>?,
    ));
  }

  @override
  $IntroductoryPriceCopyWith<$Res>? get introductoryPrice {
    if (_value.introductoryPrice == null) {
      return null;
    }

    return $IntroductoryPriceCopyWith<$Res>(_value.introductoryPrice!, (value) {
      return _then(_value.copyWith(introductoryPrice: value));
    });
  }
}

/// @nodoc
abstract class _$StoreProductCopyWith<$Res>
    implements $StoreProductCopyWith<$Res> {
  factory _$StoreProductCopyWith(
          _StoreProduct value, $Res Function(_StoreProduct) then) =
      __$StoreProductCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'identifier')
          String identifier,
      @JsonKey(name: 'description')
          String description,
      @JsonKey(name: 'title')
          String title,
      @JsonKey(name: 'price')
          double price,
      @JsonKey(name: 'price_string')
          String priceString,
      @JsonKey(name: 'currency_code')
          String currencyCode,
      @JsonKey(name: 'introPrice', nullable: true)
          IntroductoryPrice? introductoryPrice,
      @JsonKey(name: 'discounts', nullable: true)
          List<StoreProductDiscount>? discounts});

  @override
  $IntroductoryPriceCopyWith<$Res>? get introductoryPrice;
}

/// @nodoc
class __$StoreProductCopyWithImpl<$Res> extends _$StoreProductCopyWithImpl<$Res>
    implements _$StoreProductCopyWith<$Res> {
  __$StoreProductCopyWithImpl(
      _StoreProduct _value, $Res Function(_StoreProduct) _then)
      : super(_value, (v) => _then(v as _StoreProduct));

  @override
  _StoreProduct get _value => super._value as _StoreProduct;

  @override
  $Res call({
    Object? identifier = freezed,
    Object? description = freezed,
    Object? title = freezed,
    Object? price = freezed,
    Object? priceString = freezed,
    Object? currencyCode = freezed,
    Object? introductoryPrice = freezed,
    Object? discounts = freezed,
  }) {
    return _then(_StoreProduct(
      identifier == freezed
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      priceString == freezed
          ? _value.priceString
          : priceString // ignore: cast_nullable_to_non_nullable
              as String,
      currencyCode == freezed
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String,
      introductoryPrice: introductoryPrice == freezed
          ? _value.introductoryPrice
          : introductoryPrice // ignore: cast_nullable_to_non_nullable
              as IntroductoryPrice?,
      discounts: discounts == freezed
          ? _value.discounts
          : discounts // ignore: cast_nullable_to_non_nullable
              as List<StoreProductDiscount>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_StoreProduct implements _StoreProduct {
  const _$_StoreProduct(
      @JsonKey(name: 'identifier') this.identifier,
      @JsonKey(name: 'description') this.description,
      @JsonKey(name: 'title') this.title,
      @JsonKey(name: 'price') this.price,
      @JsonKey(name: 'price_string') this.priceString,
      @JsonKey(name: 'currency_code') this.currencyCode,
      {@JsonKey(name: 'introPrice', nullable: true) this.introductoryPrice,
      @JsonKey(name: 'discounts', nullable: true) this.discounts});

  factory _$_StoreProduct.fromJson(Map<String, dynamic> json) =>
      _$$_StoreProductFromJson(json);

  @override

  /// Product Id.
  @JsonKey(name: 'identifier')
  final String identifier;
  @override

  /// Description of the product.
  @JsonKey(name: 'description')
  final String description;
  @override

  /// Title of the product.
  @JsonKey(name: 'title')
  final String title;
  @override

  /// Price of the product in the local currency.
  @JsonKey(name: 'price')
  final double price;
  @override

  /// Formatted price of the item, including its currency sign.
  @JsonKey(name: 'price_string')
  final String priceString;
  @override

  /// Currency code for price and original price.
  @JsonKey(name: 'currency_code')
  final String currencyCode;
  @override

  /// Introductory price for product. Can be null.
  @JsonKey(name: 'introPrice', nullable: true)
  final IntroductoryPrice? introductoryPrice;
  @override

  /// Collection of discount offers for a product. Null for Android.
  @JsonKey(name: 'discounts', nullable: true)
  final List<StoreProductDiscount>? discounts;

  @override
  String toString() {
    return 'StoreProduct(identifier: $identifier, description: $description, title: $title, price: $price, priceString: $priceString, currencyCode: $currencyCode, introductoryPrice: $introductoryPrice, discounts: $discounts)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StoreProduct &&
            const DeepCollectionEquality()
                .equals(other.identifier, identifier) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.price, price) &&
            const DeepCollectionEquality()
                .equals(other.priceString, priceString) &&
            const DeepCollectionEquality()
                .equals(other.currencyCode, currencyCode) &&
            const DeepCollectionEquality()
                .equals(other.introductoryPrice, introductoryPrice) &&
            const DeepCollectionEquality().equals(other.discounts, discounts));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(identifier),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(price),
      const DeepCollectionEquality().hash(priceString),
      const DeepCollectionEquality().hash(currencyCode),
      const DeepCollectionEquality().hash(introductoryPrice),
      const DeepCollectionEquality().hash(discounts));

  @JsonKey(ignore: true)
  @override
  _$StoreProductCopyWith<_StoreProduct> get copyWith =>
      __$StoreProductCopyWithImpl<_StoreProduct>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StoreProductToJson(this);
  }
}

abstract class _StoreProduct implements StoreProduct {
  const factory _StoreProduct(
      @JsonKey(name: 'identifier')
          String identifier,
      @JsonKey(name: 'description')
          String description,
      @JsonKey(name: 'title')
          String title,
      @JsonKey(name: 'price')
          double price,
      @JsonKey(name: 'price_string')
          String priceString,
      @JsonKey(name: 'currency_code')
          String currencyCode,
      {@JsonKey(name: 'introPrice', nullable: true)
          IntroductoryPrice? introductoryPrice,
      @JsonKey(name: 'discounts', nullable: true)
          List<StoreProductDiscount>? discounts}) = _$_StoreProduct;

  factory _StoreProduct.fromJson(Map<String, dynamic> json) =
      _$_StoreProduct.fromJson;

  @override

  /// Product Id.
  @JsonKey(name: 'identifier')
  String get identifier;
  @override

  /// Description of the product.
  @JsonKey(name: 'description')
  String get description;
  @override

  /// Title of the product.
  @JsonKey(name: 'title')
  String get title;
  @override

  /// Price of the product in the local currency.
  @JsonKey(name: 'price')
  double get price;
  @override

  /// Formatted price of the item, including its currency sign.
  @JsonKey(name: 'price_string')
  String get priceString;
  @override

  /// Currency code for price and original price.
  @JsonKey(name: 'currency_code')
  String get currencyCode;
  @override

  /// Introductory price for product. Can be null.
  @JsonKey(name: 'introPrice', nullable: true)
  IntroductoryPrice? get introductoryPrice;
  @override

  /// Collection of discount offers for a product. Null for Android.
  @JsonKey(name: 'discounts', nullable: true)
  List<StoreProductDiscount>? get discounts;
  @override
  @JsonKey(ignore: true)
  _$StoreProductCopyWith<_StoreProduct> get copyWith =>
      throw _privateConstructorUsedError;
}
