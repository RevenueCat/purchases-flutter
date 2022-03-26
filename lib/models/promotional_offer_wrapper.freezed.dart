// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'promotional_offer_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PromotionalOffer _$PromotionalOfferFromJson(Map<String, dynamic> json) {
  return _PromotionalOffer.fromJson(json);
}

/// @nodoc
class _$PromotionalOfferTearOff {
  const _$PromotionalOfferTearOff();

  _PromotionalOffer call(
      @JsonKey(name: 'productDiscount') StoreProductDiscount productDiscount) {
    return _PromotionalOffer(
      productDiscount,
    );
  }

  PromotionalOffer fromJson(Map<String, Object?> json) {
    return PromotionalOffer.fromJson(json);
  }
}

/// @nodoc
const $PromotionalOffer = _$PromotionalOfferTearOff();

/// @nodoc
mixin _$PromotionalOffer {
  /// The StoreProductDiscount in this offer.
  @JsonKey(name: 'productDiscount')
  StoreProductDiscount get productDiscount =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PromotionalOfferCopyWith<PromotionalOffer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PromotionalOfferCopyWith<$Res> {
  factory $PromotionalOfferCopyWith(
          PromotionalOffer value, $Res Function(PromotionalOffer) then) =
      _$PromotionalOfferCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'productDiscount') StoreProductDiscount productDiscount});

  $StoreProductDiscountCopyWith<$Res> get productDiscount;
}

/// @nodoc
class _$PromotionalOfferCopyWithImpl<$Res>
    implements $PromotionalOfferCopyWith<$Res> {
  _$PromotionalOfferCopyWithImpl(this._value, this._then);

  final PromotionalOffer _value;
  // ignore: unused_field
  final $Res Function(PromotionalOffer) _then;

  @override
  $Res call({
    Object? productDiscount = freezed,
  }) {
    return _then(_value.copyWith(
      productDiscount: productDiscount == freezed
          ? _value.productDiscount
          : productDiscount // ignore: cast_nullable_to_non_nullable
              as StoreProductDiscount,
    ));
  }

  @override
  $StoreProductDiscountCopyWith<$Res> get productDiscount {
    return $StoreProductDiscountCopyWith<$Res>(_value.productDiscount, (value) {
      return _then(_value.copyWith(productDiscount: value));
    });
  }
}

/// @nodoc
abstract class _$PromotionalOfferCopyWith<$Res>
    implements $PromotionalOfferCopyWith<$Res> {
  factory _$PromotionalOfferCopyWith(
          _PromotionalOffer value, $Res Function(_PromotionalOffer) then) =
      __$PromotionalOfferCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'productDiscount') StoreProductDiscount productDiscount});

  @override
  $StoreProductDiscountCopyWith<$Res> get productDiscount;
}

/// @nodoc
class __$PromotionalOfferCopyWithImpl<$Res>
    extends _$PromotionalOfferCopyWithImpl<$Res>
    implements _$PromotionalOfferCopyWith<$Res> {
  __$PromotionalOfferCopyWithImpl(
      _PromotionalOffer _value, $Res Function(_PromotionalOffer) _then)
      : super(_value, (v) => _then(v as _PromotionalOffer));

  @override
  _PromotionalOffer get _value => super._value as _PromotionalOffer;

  @override
  $Res call({
    Object? productDiscount = freezed,
  }) {
    return _then(_PromotionalOffer(
      productDiscount == freezed
          ? _value.productDiscount
          : productDiscount // ignore: cast_nullable_to_non_nullable
              as StoreProductDiscount,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PromotionalOffer implements _PromotionalOffer {
  const _$_PromotionalOffer(
      @JsonKey(name: 'productDiscount') this.productDiscount);

  factory _$_PromotionalOffer.fromJson(Map<String, dynamic> json) =>
      _$$_PromotionalOfferFromJson(json);

  @override

  /// The StoreProductDiscount in this offer.
  @JsonKey(name: 'productDiscount')
  final StoreProductDiscount productDiscount;

  @override
  String toString() {
    return 'PromotionalOffer(productDiscount: $productDiscount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PromotionalOffer &&
            const DeepCollectionEquality()
                .equals(other.productDiscount, productDiscount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(productDiscount));

  @JsonKey(ignore: true)
  @override
  _$PromotionalOfferCopyWith<_PromotionalOffer> get copyWith =>
      __$PromotionalOfferCopyWithImpl<_PromotionalOffer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PromotionalOfferToJson(this);
  }
}

abstract class _PromotionalOffer implements PromotionalOffer {
  const factory _PromotionalOffer(
      @JsonKey(name: 'productDiscount')
          StoreProductDiscount productDiscount) = _$_PromotionalOffer;

  factory _PromotionalOffer.fromJson(Map<String, dynamic> json) =
      _$_PromotionalOffer.fromJson;

  @override

  /// The StoreProductDiscount in this offer.
  @JsonKey(name: 'productDiscount')
  StoreProductDiscount get productDiscount;
  @override
  @JsonKey(ignore: true)
  _$PromotionalOfferCopyWith<_PromotionalOffer> get copyWith =>
      throw _privateConstructorUsedError;
}
