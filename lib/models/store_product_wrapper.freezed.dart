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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StoreProduct _$StoreProductFromJson(Map<String, dynamic> json) {
  return _StoreProduct.fromJson(json);
}

/// @nodoc
mixin _$StoreProduct {
  /// Product Id.
  String get identifier => throw _privateConstructorUsedError;

  /// Description of the product.
  String get description => throw _privateConstructorUsedError;

  /// Title of the product.
  String get title => throw _privateConstructorUsedError;

  /// Price of the product in the local currency.
  double get price => throw _privateConstructorUsedError;

  /// Formatted price of the item, including its currency sign.
  String get priceString => throw _privateConstructorUsedError;

  /// Currency code for price and original price.
  String get currencyCode => throw _privateConstructorUsedError;

  /// Introductory price for product. Can be null.
// ignore: invalid_annotation_target
  @JsonKey(name: 'introPrice')
  IntroductoryPrice? get introductoryPrice =>
      throw _privateConstructorUsedError;

  /// Collection of discount offers for a product. Null for Android.
  List<StoreProductDiscount>? get discounts =>
      throw _privateConstructorUsedError;

  /// Product category.
  ProductCategory? get productCategory => throw _privateConstructorUsedError;

  /// Default subscription option for a product. Google Play only.
  SubscriptionOption? get defaultOption => throw _privateConstructorUsedError;

  /// Collection of subscription options for a product. Google Play only.
  List<SubscriptionOption>? get subscriptionOptions =>
      throw _privateConstructorUsedError;

  /// Offering context this package belongs to.
  /// Null if not using offerings or if fetched directly from store via getProducts
  PresentedOfferingContext? get presentedOfferingContext =>
      throw _privateConstructorUsedError;

  /// Subscription period, specified in ISO 8601 format. For example,
  /// P1W equates to one week, P1M equates to one month,
  /// P3M equates to three months, P6M equates to six months,
  /// and P1Y equates to one year.
  /// Note: Not available for Amazon.
  String? get subscriptionPeriod => throw _privateConstructorUsedError;

  /// Serializes this StoreProduct to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoreProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      {String identifier,
      String description,
      String title,
      double price,
      String priceString,
      String currencyCode,
      @JsonKey(name: 'introPrice') IntroductoryPrice? introductoryPrice,
      List<StoreProductDiscount>? discounts,
      ProductCategory? productCategory,
      SubscriptionOption? defaultOption,
      List<SubscriptionOption>? subscriptionOptions,
      PresentedOfferingContext? presentedOfferingContext,
      String? subscriptionPeriod});

  $IntroductoryPriceCopyWith<$Res>? get introductoryPrice;
  $SubscriptionOptionCopyWith<$Res>? get defaultOption;
  $PresentedOfferingContextCopyWith<$Res>? get presentedOfferingContext;
}

/// @nodoc
class _$StoreProductCopyWithImpl<$Res, $Val extends StoreProduct>
    implements $StoreProductCopyWith<$Res> {
  _$StoreProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoreProduct
  /// with the given fields replaced by the non-null parameter values.
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
    Object? productCategory = freezed,
    Object? defaultOption = freezed,
    Object? subscriptionOptions = freezed,
    Object? presentedOfferingContext = freezed,
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
      productCategory: freezed == productCategory
          ? _value.productCategory
          : productCategory // ignore: cast_nullable_to_non_nullable
              as ProductCategory?,
      defaultOption: freezed == defaultOption
          ? _value.defaultOption
          : defaultOption // ignore: cast_nullable_to_non_nullable
              as SubscriptionOption?,
      subscriptionOptions: freezed == subscriptionOptions
          ? _value.subscriptionOptions
          : subscriptionOptions // ignore: cast_nullable_to_non_nullable
              as List<SubscriptionOption>?,
      presentedOfferingContext: freezed == presentedOfferingContext
          ? _value.presentedOfferingContext
          : presentedOfferingContext // ignore: cast_nullable_to_non_nullable
              as PresentedOfferingContext?,
      subscriptionPeriod: freezed == subscriptionPeriod
          ? _value.subscriptionPeriod
          : subscriptionPeriod // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of StoreProduct
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of StoreProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubscriptionOptionCopyWith<$Res>? get defaultOption {
    if (_value.defaultOption == null) {
      return null;
    }

    return $SubscriptionOptionCopyWith<$Res>(_value.defaultOption!, (value) {
      return _then(_value.copyWith(defaultOption: value) as $Val);
    });
  }

  /// Create a copy of StoreProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PresentedOfferingContextCopyWith<$Res>? get presentedOfferingContext {
    if (_value.presentedOfferingContext == null) {
      return null;
    }

    return $PresentedOfferingContextCopyWith<$Res>(
        _value.presentedOfferingContext!, (value) {
      return _then(_value.copyWith(presentedOfferingContext: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StoreProductImplCopyWith<$Res>
    implements $StoreProductCopyWith<$Res> {
  factory _$$StoreProductImplCopyWith(
          _$StoreProductImpl value, $Res Function(_$StoreProductImpl) then) =
      __$$StoreProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String identifier,
      String description,
      String title,
      double price,
      String priceString,
      String currencyCode,
      @JsonKey(name: 'introPrice') IntroductoryPrice? introductoryPrice,
      List<StoreProductDiscount>? discounts,
      ProductCategory? productCategory,
      SubscriptionOption? defaultOption,
      List<SubscriptionOption>? subscriptionOptions,
      PresentedOfferingContext? presentedOfferingContext,
      String? subscriptionPeriod});

  @override
  $IntroductoryPriceCopyWith<$Res>? get introductoryPrice;
  @override
  $SubscriptionOptionCopyWith<$Res>? get defaultOption;
  @override
  $PresentedOfferingContextCopyWith<$Res>? get presentedOfferingContext;
}

/// @nodoc
class __$$StoreProductImplCopyWithImpl<$Res>
    extends _$StoreProductCopyWithImpl<$Res, _$StoreProductImpl>
    implements _$$StoreProductImplCopyWith<$Res> {
  __$$StoreProductImplCopyWithImpl(
      _$StoreProductImpl _value, $Res Function(_$StoreProductImpl) _then)
      : super(_value, _then);

  /// Create a copy of StoreProduct
  /// with the given fields replaced by the non-null parameter values.
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
    Object? productCategory = freezed,
    Object? defaultOption = freezed,
    Object? subscriptionOptions = freezed,
    Object? presentedOfferingContext = freezed,
    Object? subscriptionPeriod = freezed,
  }) {
    return _then(_$StoreProductImpl(
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
      productCategory: freezed == productCategory
          ? _value.productCategory
          : productCategory // ignore: cast_nullable_to_non_nullable
              as ProductCategory?,
      defaultOption: freezed == defaultOption
          ? _value.defaultOption
          : defaultOption // ignore: cast_nullable_to_non_nullable
              as SubscriptionOption?,
      subscriptionOptions: freezed == subscriptionOptions
          ? _value._subscriptionOptions
          : subscriptionOptions // ignore: cast_nullable_to_non_nullable
              as List<SubscriptionOption>?,
      presentedOfferingContext: freezed == presentedOfferingContext
          ? _value.presentedOfferingContext
          : presentedOfferingContext // ignore: cast_nullable_to_non_nullable
              as PresentedOfferingContext?,
      subscriptionPeriod: freezed == subscriptionPeriod
          ? _value.subscriptionPeriod
          : subscriptionPeriod // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StoreProductImpl implements _StoreProduct {
  const _$StoreProductImpl(this.identifier, this.description, this.title,
      this.price, this.priceString, this.currencyCode,
      {@JsonKey(name: 'introPrice') this.introductoryPrice,
      final List<StoreProductDiscount>? discounts,
      this.productCategory,
      this.defaultOption,
      final List<SubscriptionOption>? subscriptionOptions,
      this.presentedOfferingContext,
      this.subscriptionPeriod})
      : _discounts = discounts,
        _subscriptionOptions = subscriptionOptions;

  factory _$StoreProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoreProductImplFromJson(json);

  /// Product Id.
  @override
  final String identifier;

  /// Description of the product.
  @override
  final String description;

  /// Title of the product.
  @override
  final String title;

  /// Price of the product in the local currency.
  @override
  final double price;

  /// Formatted price of the item, including its currency sign.
  @override
  final String priceString;

  /// Currency code for price and original price.
  @override
  final String currencyCode;

  /// Introductory price for product. Can be null.
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'introPrice')
  final IntroductoryPrice? introductoryPrice;

  /// Collection of discount offers for a product. Null for Android.
  final List<StoreProductDiscount>? _discounts;

  /// Collection of discount offers for a product. Null for Android.
  @override
  List<StoreProductDiscount>? get discounts {
    final value = _discounts;
    if (value == null) return null;
    if (_discounts is EqualUnmodifiableListView) return _discounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Product category.
  @override
  final ProductCategory? productCategory;

  /// Default subscription option for a product. Google Play only.
  @override
  final SubscriptionOption? defaultOption;

  /// Collection of subscription options for a product. Google Play only.
  final List<SubscriptionOption>? _subscriptionOptions;

  /// Collection of subscription options for a product. Google Play only.
  @override
  List<SubscriptionOption>? get subscriptionOptions {
    final value = _subscriptionOptions;
    if (value == null) return null;
    if (_subscriptionOptions is EqualUnmodifiableListView)
      return _subscriptionOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Offering context this package belongs to.
  /// Null if not using offerings or if fetched directly from store via getProducts
  @override
  final PresentedOfferingContext? presentedOfferingContext;

  /// Subscription period, specified in ISO 8601 format. For example,
  /// P1W equates to one week, P1M equates to one month,
  /// P3M equates to three months, P6M equates to six months,
  /// and P1Y equates to one year.
  /// Note: Not available for Amazon.
  @override
  final String? subscriptionPeriod;

  @override
  String toString() {
    return 'StoreProduct(identifier: $identifier, description: $description, title: $title, price: $price, priceString: $priceString, currencyCode: $currencyCode, introductoryPrice: $introductoryPrice, discounts: $discounts, productCategory: $productCategory, defaultOption: $defaultOption, subscriptionOptions: $subscriptionOptions, presentedOfferingContext: $presentedOfferingContext, subscriptionPeriod: $subscriptionPeriod)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoreProductImpl &&
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
            (identical(other.productCategory, productCategory) ||
                other.productCategory == productCategory) &&
            (identical(other.defaultOption, defaultOption) ||
                other.defaultOption == defaultOption) &&
            const DeepCollectionEquality()
                .equals(other._subscriptionOptions, _subscriptionOptions) &&
            (identical(
                    other.presentedOfferingContext, presentedOfferingContext) ||
                other.presentedOfferingContext == presentedOfferingContext) &&
            (identical(other.subscriptionPeriod, subscriptionPeriod) ||
                other.subscriptionPeriod == subscriptionPeriod));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
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
      productCategory,
      defaultOption,
      const DeepCollectionEquality().hash(_subscriptionOptions),
      presentedOfferingContext,
      subscriptionPeriod);

  /// Create a copy of StoreProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoreProductImplCopyWith<_$StoreProductImpl> get copyWith =>
      __$$StoreProductImplCopyWithImpl<_$StoreProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoreProductImplToJson(
      this,
    );
  }
}

abstract class _StoreProduct implements StoreProduct {
  const factory _StoreProduct(
      final String identifier,
      final String description,
      final String title,
      final double price,
      final String priceString,
      final String currencyCode,
      {@JsonKey(name: 'introPrice') final IntroductoryPrice? introductoryPrice,
      final List<StoreProductDiscount>? discounts,
      final ProductCategory? productCategory,
      final SubscriptionOption? defaultOption,
      final List<SubscriptionOption>? subscriptionOptions,
      final PresentedOfferingContext? presentedOfferingContext,
      final String? subscriptionPeriod}) = _$StoreProductImpl;

  factory _StoreProduct.fromJson(Map<String, dynamic> json) =
      _$StoreProductImpl.fromJson;

  /// Product Id.
  @override
  String get identifier;

  /// Description of the product.
  @override
  String get description;

  /// Title of the product.
  @override
  String get title;

  /// Price of the product in the local currency.
  @override
  double get price;

  /// Formatted price of the item, including its currency sign.
  @override
  String get priceString;

  /// Currency code for price and original price.
  @override
  String get currencyCode;

  /// Introductory price for product. Can be null.
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'introPrice')
  IntroductoryPrice? get introductoryPrice;

  /// Collection of discount offers for a product. Null for Android.
  @override
  List<StoreProductDiscount>? get discounts;

  /// Product category.
  @override
  ProductCategory? get productCategory;

  /// Default subscription option for a product. Google Play only.
  @override
  SubscriptionOption? get defaultOption;

  /// Collection of subscription options for a product. Google Play only.
  @override
  List<SubscriptionOption>? get subscriptionOptions;

  /// Offering context this package belongs to.
  /// Null if not using offerings or if fetched directly from store via getProducts
  @override
  PresentedOfferingContext? get presentedOfferingContext;

  /// Subscription period, specified in ISO 8601 format. For example,
  /// P1W equates to one week, P1M equates to one month,
  /// P3M equates to three months, P6M equates to six months,
  /// and P1Y equates to one year.
  /// Note: Not available for Amazon.
  @override
  String? get subscriptionPeriod;

  /// Create a copy of StoreProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoreProductImplCopyWith<_$StoreProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
