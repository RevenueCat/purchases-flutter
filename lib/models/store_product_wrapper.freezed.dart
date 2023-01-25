// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'store_product_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StoreProduct _$StoreProductFromJson(Map<String, dynamic> json) {
  return _StoreProduct.fromJson(json);
}

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
  @JsonKey(name: 'priceString')
  String get priceString => throw _privateConstructorUsedError;

  /// Currency code for price and original price.
  @JsonKey(name: 'currencyCode')
  String get currencyCode => throw _privateConstructorUsedError;

  /// Introductory price for product. Can be null.
  @JsonKey(name: 'introPrice', nullable: true)
  IntroductoryPrice? get introductoryPrice =>
      throw _privateConstructorUsedError;

  /// Collection of discount offers for a product. Null for Android.
  @JsonKey(name: 'discounts', nullable: true)
  List<StoreProductDiscount>? get discounts =>
      throw _privateConstructorUsedError;

  /// Subscription period, specified in ISO 8601 format. For example,
  /// P1W equates to one week, P1M equates to one month,
  /// P3M equates to three months, P6M equates to six months,
  /// and P1Y equates to one year.
  /// Note: Not available for Amazon.
  @JsonKey(name: 'subscriptionPeriod', nullable: true)
  String? get subscriptionPeriod => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoreProductCopyWith<StoreProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoreProductCopyWith<$Res> {
  factory $StoreProductCopyWith(
          StoreProduct value, $Res Function(StoreProduct) then) =
      _$StoreProductCopyWithImpl<$Res, StoreProduct>;
  @useResult
  $Res call(
      {@JsonKey(name: 'identifier')
          String identifier,
      @JsonKey(name: 'description')
          String description,
      @JsonKey(name: 'title')
          String title,
      @JsonKey(name: 'price')
          double price,
      @JsonKey(name: 'priceString')
          String priceString,
      @JsonKey(name: 'currencyCode')
          String currencyCode,
      @JsonKey(name: 'introPrice', nullable: true)
          IntroductoryPrice? introductoryPrice,
      @JsonKey(name: 'discounts', nullable: true)
          List<StoreProductDiscount>? discounts,
      @JsonKey(name: 'subscriptionPeriod', nullable: true)
          String? subscriptionPeriod});

  $IntroductoryPriceCopyWith<$Res>? get introductoryPrice;
}

/// @nodoc
class _$StoreProductCopyWithImpl<$Res, $Val extends StoreProduct>
    implements $StoreProductCopyWith<$Res> {
  _$StoreProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identifier = null,
    Object? description = null,
    Object? title = null,
    Object? price = null,
    Object? priceString = null,
    Object? currencyCode = null,
    Object? introductoryPrice = freezed,
    Object? discounts = freezed,
    Object? subscriptionPeriod = freezed,
  }) {
    return _then(_value.copyWith(
      identifier: null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      priceString: null == priceString
          ? _value.priceString
          : priceString // ignore: cast_nullable_to_non_nullable
              as String,
      currencyCode: null == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String,
      introductoryPrice: freezed == introductoryPrice
          ? _value.introductoryPrice
          : introductoryPrice // ignore: cast_nullable_to_non_nullable
              as IntroductoryPrice?,
      discounts: freezed == discounts
          ? _value.discounts
          : discounts // ignore: cast_nullable_to_non_nullable
              as List<StoreProductDiscount>?,
      subscriptionPeriod: freezed == subscriptionPeriod
          ? _value.subscriptionPeriod
          : subscriptionPeriod // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $IntroductoryPriceCopyWith<$Res>? get introductoryPrice {
    if (_value.introductoryPrice == null) {
      return null;
    }

    return $IntroductoryPriceCopyWith<$Res>(_value.introductoryPrice!, (value) {
      return _then(_value.copyWith(introductoryPrice: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_StoreProductCopyWith<$Res>
    implements $StoreProductCopyWith<$Res> {
  factory _$$_StoreProductCopyWith(
          _$_StoreProduct value, $Res Function(_$_StoreProduct) then) =
      __$$_StoreProductCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'identifier')
          String identifier,
      @JsonKey(name: 'description')
          String description,
      @JsonKey(name: 'title')
          String title,
      @JsonKey(name: 'price')
          double price,
      @JsonKey(name: 'priceString')
          String priceString,
      @JsonKey(name: 'currencyCode')
          String currencyCode,
      @JsonKey(name: 'introPrice', nullable: true)
          IntroductoryPrice? introductoryPrice,
      @JsonKey(name: 'discounts', nullable: true)
          List<StoreProductDiscount>? discounts,
      @JsonKey(name: 'subscriptionPeriod', nullable: true)
          String? subscriptionPeriod});

  @override
  $IntroductoryPriceCopyWith<$Res>? get introductoryPrice;
}

/// @nodoc
class __$$_StoreProductCopyWithImpl<$Res>
    extends _$StoreProductCopyWithImpl<$Res, _$_StoreProduct>
    implements _$$_StoreProductCopyWith<$Res> {
  __$$_StoreProductCopyWithImpl(
      _$_StoreProduct _value, $Res Function(_$_StoreProduct) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identifier = null,
    Object? description = null,
    Object? title = null,
    Object? price = null,
    Object? priceString = null,
    Object? currencyCode = null,
    Object? introductoryPrice = freezed,
    Object? discounts = freezed,
    Object? subscriptionPeriod = freezed,
  }) {
    return _then(_$_StoreProduct(
      null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      null == priceString
          ? _value.priceString
          : priceString // ignore: cast_nullable_to_non_nullable
              as String,
      null == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String,
      introductoryPrice: freezed == introductoryPrice
          ? _value.introductoryPrice
          : introductoryPrice // ignore: cast_nullable_to_non_nullable
              as IntroductoryPrice?,
      discounts: freezed == discounts
          ? _value._discounts
          : discounts // ignore: cast_nullable_to_non_nullable
              as List<StoreProductDiscount>?,
      subscriptionPeriod: freezed == subscriptionPeriod
          ? _value.subscriptionPeriod
          : subscriptionPeriod // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_StoreProduct implements _StoreProduct {
  const _$_StoreProduct(
      @JsonKey(name: 'identifier')
          this.identifier,
      @JsonKey(name: 'description')
          this.description,
      @JsonKey(name: 'title')
          this.title,
      @JsonKey(name: 'price')
          this.price,
      @JsonKey(name: 'priceString')
          this.priceString,
      @JsonKey(name: 'currencyCode')
          this.currencyCode,
      {@JsonKey(name: 'introPrice', nullable: true)
          this.introductoryPrice,
      @JsonKey(name: 'discounts', nullable: true)
          final List<StoreProductDiscount>? discounts,
      @JsonKey(name: 'subscriptionPeriod', nullable: true)
          this.subscriptionPeriod})
      : _discounts = discounts;

  factory _$_StoreProduct.fromJson(Map<String, dynamic> json) =>
      _$$_StoreProductFromJson(json);

  /// Product Id.
  @override
  @JsonKey(name: 'identifier')
  final String identifier;

  /// Description of the product.
  @override
  @JsonKey(name: 'description')
  final String description;

  /// Title of the product.
  @override
  @JsonKey(name: 'title')
  final String title;

  /// Price of the product in the local currency.
  @override
  @JsonKey(name: 'price')
  final double price;

  /// Formatted price of the item, including its currency sign.
  @override
  @JsonKey(name: 'priceString')
  final String priceString;

  /// Currency code for price and original price.
  @override
  @JsonKey(name: 'currencyCode')
  final String currencyCode;

  /// Introductory price for product. Can be null.
  @override
  @JsonKey(name: 'introPrice', nullable: true)
  final IntroductoryPrice? introductoryPrice;

  /// Collection of discount offers for a product. Null for Android.
  final List<StoreProductDiscount>? _discounts;

  /// Collection of discount offers for a product. Null for Android.
  @override
  @JsonKey(name: 'discounts', nullable: true)
  List<StoreProductDiscount>? get discounts {
    final value = _discounts;
    if (value == null) return null;
    if (_discounts is EqualUnmodifiableListView) return _discounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Subscription period, specified in ISO 8601 format. For example,
  /// P1W equates to one week, P1M equates to one month,
  /// P3M equates to three months, P6M equates to six months,
  /// and P1Y equates to one year.
  /// Note: Not available for Amazon.
  @override
  @JsonKey(name: 'subscriptionPeriod', nullable: true)
  final String? subscriptionPeriod;

  @override
  String toString() {
    return 'StoreProduct(identifier: $identifier, description: $description, title: $title, price: $price, priceString: $priceString, currencyCode: $currencyCode, introductoryPrice: $introductoryPrice, discounts: $discounts, subscriptionPeriod: $subscriptionPeriod)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StoreProduct &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.priceString, priceString) ||
                other.priceString == priceString) &&
            (identical(other.currencyCode, currencyCode) ||
                other.currencyCode == currencyCode) &&
            (identical(other.introductoryPrice, introductoryPrice) ||
                other.introductoryPrice == introductoryPrice) &&
            const DeepCollectionEquality()
                .equals(other._discounts, _discounts) &&
            (identical(other.subscriptionPeriod, subscriptionPeriod) ||
                other.subscriptionPeriod == subscriptionPeriod));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      identifier,
      description,
      title,
      price,
      priceString,
      currencyCode,
      introductoryPrice,
      const DeepCollectionEquality().hash(_discounts),
      subscriptionPeriod);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StoreProductCopyWith<_$_StoreProduct> get copyWith =>
      __$$_StoreProductCopyWithImpl<_$_StoreProduct>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StoreProductToJson(
      this,
    );
  }
}

abstract class _StoreProduct implements StoreProduct {
  const factory _StoreProduct(
      @JsonKey(name: 'identifier')
          final String identifier,
      @JsonKey(name: 'description')
          final String description,
      @JsonKey(name: 'title')
          final String title,
      @JsonKey(name: 'price')
          final double price,
      @JsonKey(name: 'priceString')
          final String priceString,
      @JsonKey(name: 'currencyCode')
          final String currencyCode,
      {@JsonKey(name: 'introPrice', nullable: true)
          final IntroductoryPrice? introductoryPrice,
      @JsonKey(name: 'discounts', nullable: true)
          final List<StoreProductDiscount>? discounts,
      @JsonKey(name: 'subscriptionPeriod', nullable: true)
          final String? subscriptionPeriod}) = _$_StoreProduct;

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
  @JsonKey(name: 'priceString')
  String get priceString;
  @override

  /// Currency code for price and original price.
  @JsonKey(name: 'currencyCode')
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

  /// Subscription period, specified in ISO 8601 format. For example,
  /// P1W equates to one week, P1M equates to one month,
  /// P3M equates to three months, P6M equates to six months,
  /// and P1Y equates to one year.
  /// Note: Not available for Amazon.
  @JsonKey(name: 'subscriptionPeriod', nullable: true)
  String? get subscriptionPeriod;
  @override
  @JsonKey(ignore: true)
  _$$_StoreProductCopyWith<_$_StoreProduct> get copyWith =>
      throw _privateConstructorUsedError;
}
