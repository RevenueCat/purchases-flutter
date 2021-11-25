// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'product_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
class _$ProductTearOff {
  const _$ProductTearOff();

  _Product call(
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
          List<Discount>? discounts}) {
    return _Product(
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

  Product fromJson(Map<String, Object> json) {
    return Product.fromJson(json);
  }
}

/// @nodoc
const $Product = _$ProductTearOff();

/// @nodoc
mixin _$Product {
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
  List<Discount>? get discounts => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res>;
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
          List<Discount>? discounts});

  $IntroductoryPriceCopyWith<$Res>? get introductoryPrice;
}

/// @nodoc
class _$ProductCopyWithImpl<$Res> implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  final Product _value;
  // ignore: unused_field
  final $Res Function(Product) _then;

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
              as List<Discount>?,
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
abstract class _$ProductCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$ProductCopyWith(_Product value, $Res Function(_Product) then) =
      __$ProductCopyWithImpl<$Res>;
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
          List<Discount>? discounts});

  @override
  $IntroductoryPriceCopyWith<$Res>? get introductoryPrice;
}

/// @nodoc
class __$ProductCopyWithImpl<$Res> extends _$ProductCopyWithImpl<$Res>
    implements _$ProductCopyWith<$Res> {
  __$ProductCopyWithImpl(_Product _value, $Res Function(_Product) _then)
      : super(_value, (v) => _then(v as _Product));

  @override
  _Product get _value => super._value as _Product;

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
    return _then(_Product(
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
              as List<Discount>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Product implements _Product {
  const _$_Product(
      @JsonKey(name: 'identifier') this.identifier,
      @JsonKey(name: 'description') this.description,
      @JsonKey(name: 'title') this.title,
      @JsonKey(name: 'price') this.price,
      @JsonKey(name: 'price_string') this.priceString,
      @JsonKey(name: 'currency_code') this.currencyCode,
      {@JsonKey(name: 'introPrice', nullable: true) this.introductoryPrice,
      @JsonKey(name: 'discounts', nullable: true) this.discounts});

  factory _$_Product.fromJson(Map<String, dynamic> json) =>
      _$$_ProductFromJson(json);

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
  final List<Discount>? discounts;

  @override
  String toString() {
    return 'Product(identifier: $identifier, description: $description, title: $title, price: $price, priceString: $priceString, currencyCode: $currencyCode, introductoryPrice: $introductoryPrice, discounts: $discounts)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Product &&
            (identical(other.identifier, identifier) ||
                const DeepCollectionEquality()
                    .equals(other.identifier, identifier)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.priceString, priceString) ||
                const DeepCollectionEquality()
                    .equals(other.priceString, priceString)) &&
            (identical(other.currencyCode, currencyCode) ||
                const DeepCollectionEquality()
                    .equals(other.currencyCode, currencyCode)) &&
            (identical(other.introductoryPrice, introductoryPrice) ||
                const DeepCollectionEquality()
                    .equals(other.introductoryPrice, introductoryPrice)) &&
            (identical(other.discounts, discounts) ||
                const DeepCollectionEquality()
                    .equals(other.discounts, discounts)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(identifier) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(priceString) ^
      const DeepCollectionEquality().hash(currencyCode) ^
      const DeepCollectionEquality().hash(introductoryPrice) ^
      const DeepCollectionEquality().hash(discounts);

  @JsonKey(ignore: true)
  @override
  _$ProductCopyWith<_Product> get copyWith =>
      __$ProductCopyWithImpl<_Product>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProductToJson(this);
  }
}

abstract class _Product implements Product {
  const factory _Product(
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
          List<Discount>? discounts}) = _$_Product;

  factory _Product.fromJson(Map<String, dynamic> json) = _$_Product.fromJson;

  @override

  /// Product Id.
  @JsonKey(name: 'identifier')
  String get identifier => throw _privateConstructorUsedError;
  @override

  /// Description of the product.
  @JsonKey(name: 'description')
  String get description => throw _privateConstructorUsedError;
  @override

  /// Title of the product.
  @JsonKey(name: 'title')
  String get title => throw _privateConstructorUsedError;
  @override

  /// Price of the product in the local currency.
  @JsonKey(name: 'price')
  double get price => throw _privateConstructorUsedError;
  @override

  /// Formatted price of the item, including its currency sign.
  @JsonKey(name: 'price_string')
  String get priceString => throw _privateConstructorUsedError;
  @override

  /// Currency code for price and original price.
  @JsonKey(name: 'currency_code')
  String get currencyCode => throw _privateConstructorUsedError;
  @override

  /// Introductory price for product. Can be null.
  @JsonKey(name: 'introPrice', nullable: true)
  IntroductoryPrice? get introductoryPrice =>
      throw _privateConstructorUsedError;
  @override

  /// Collection of discount offers for a product. Null for Android.
  @JsonKey(name: 'discounts', nullable: true)
  List<Discount>? get discounts => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ProductCopyWith<_Product> get copyWith =>
      throw _privateConstructorUsedError;
}
