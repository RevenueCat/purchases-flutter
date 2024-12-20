// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'web_purchase_redemption.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WebPurchaseRedemption _$WebPurchaseRedemptionFromJson(
    Map<String, dynamic> json) {
  return _WebPurchaseRedemption.fromJson(json);
}

/// @nodoc
mixin _$WebPurchaseRedemption {
  /// The redemption link to be redeemed.
  String get redemptionLink => throw _privateConstructorUsedError;

  /// Serializes this WebPurchaseRedemption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WebPurchaseRedemption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WebPurchaseRedemptionCopyWith<WebPurchaseRedemption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebPurchaseRedemptionCopyWith<$Res> {
  factory $WebPurchaseRedemptionCopyWith(WebPurchaseRedemption value,
          $Res Function(WebPurchaseRedemption) then) =
      _$WebPurchaseRedemptionCopyWithImpl<$Res, WebPurchaseRedemption>;
  @useResult
  $Res call({String redemptionLink});
}

/// @nodoc
class _$WebPurchaseRedemptionCopyWithImpl<$Res,
        $Val extends WebPurchaseRedemption>
    implements $WebPurchaseRedemptionCopyWith<$Res> {
  _$WebPurchaseRedemptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WebPurchaseRedemption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? redemptionLink = null,
  }) {
    return _then(_value.copyWith(
      redemptionLink: null == redemptionLink
          ? _value.redemptionLink
          : redemptionLink // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WebPurchaseRedemptionImplCopyWith<$Res>
    implements $WebPurchaseRedemptionCopyWith<$Res> {
  factory _$$WebPurchaseRedemptionImplCopyWith(
          _$WebPurchaseRedemptionImpl value,
          $Res Function(_$WebPurchaseRedemptionImpl) then) =
      __$$WebPurchaseRedemptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String redemptionLink});
}

/// @nodoc
class __$$WebPurchaseRedemptionImplCopyWithImpl<$Res>
    extends _$WebPurchaseRedemptionCopyWithImpl<$Res,
        _$WebPurchaseRedemptionImpl>
    implements _$$WebPurchaseRedemptionImplCopyWith<$Res> {
  __$$WebPurchaseRedemptionImplCopyWithImpl(_$WebPurchaseRedemptionImpl _value,
      $Res Function(_$WebPurchaseRedemptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of WebPurchaseRedemption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? redemptionLink = null,
  }) {
    return _then(_$WebPurchaseRedemptionImpl(
      null == redemptionLink
          ? _value.redemptionLink
          : redemptionLink // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WebPurchaseRedemptionImpl implements _WebPurchaseRedemption {
  const _$WebPurchaseRedemptionImpl(this.redemptionLink);

  factory _$WebPurchaseRedemptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$WebPurchaseRedemptionImplFromJson(json);

  /// The redemption link to be redeemed.
  @override
  final String redemptionLink;

  @override
  String toString() {
    return 'WebPurchaseRedemption(redemptionLink: $redemptionLink)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebPurchaseRedemptionImpl &&
            (identical(other.redemptionLink, redemptionLink) ||
                other.redemptionLink == redemptionLink));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, redemptionLink);

  /// Create a copy of WebPurchaseRedemption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebPurchaseRedemptionImplCopyWith<_$WebPurchaseRedemptionImpl>
      get copyWith => __$$WebPurchaseRedemptionImplCopyWithImpl<
          _$WebPurchaseRedemptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WebPurchaseRedemptionImplToJson(
      this,
    );
  }
}

abstract class _WebPurchaseRedemption implements WebPurchaseRedemption {
  const factory _WebPurchaseRedemption(final String redemptionLink) =
      _$WebPurchaseRedemptionImpl;

  factory _WebPurchaseRedemption.fromJson(Map<String, dynamic> json) =
      _$WebPurchaseRedemptionImpl.fromJson;

  /// The redemption link to be redeemed.
  @override
  String get redemptionLink;

  /// Create a copy of WebPurchaseRedemption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WebPurchaseRedemptionImplCopyWith<_$WebPurchaseRedemptionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
