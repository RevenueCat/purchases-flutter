// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'web_purchase_redemption.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WebPurchaseRedemption {
  /// The redemption link to be redeemed.
  String get redemptionLink;

  /// Create a copy of WebPurchaseRedemption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WebPurchaseRedemptionCopyWith<WebPurchaseRedemption> get copyWith =>
      _$WebPurchaseRedemptionCopyWithImpl<WebPurchaseRedemption>(
          this as WebPurchaseRedemption, _$identity);

  /// Serializes this WebPurchaseRedemption to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WebPurchaseRedemption &&
            (identical(other.redemptionLink, redemptionLink) ||
                other.redemptionLink == redemptionLink));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, redemptionLink);

  @override
  String toString() {
    return 'WebPurchaseRedemption(redemptionLink: $redemptionLink)';
  }
}

/// @nodoc
abstract mixin class $WebPurchaseRedemptionCopyWith<$Res> {
  factory $WebPurchaseRedemptionCopyWith(WebPurchaseRedemption value,
          $Res Function(WebPurchaseRedemption) _then) =
      _$WebPurchaseRedemptionCopyWithImpl;
  @useResult
  $Res call({String redemptionLink});
}

/// @nodoc
class _$WebPurchaseRedemptionCopyWithImpl<$Res>
    implements $WebPurchaseRedemptionCopyWith<$Res> {
  _$WebPurchaseRedemptionCopyWithImpl(this._self, this._then);

  final WebPurchaseRedemption _self;
  final $Res Function(WebPurchaseRedemption) _then;

  /// Create a copy of WebPurchaseRedemption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? redemptionLink = null,
  }) {
    return _then(_self.copyWith(
      redemptionLink: null == redemptionLink
          ? _self.redemptionLink
          : redemptionLink // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WebPurchaseRedemption implements WebPurchaseRedemption {
  const _WebPurchaseRedemption(this.redemptionLink);
  factory _WebPurchaseRedemption.fromJson(Map<String, dynamic> json) =>
      _$WebPurchaseRedemptionFromJson(json);

  /// The redemption link to be redeemed.
  @override
  final String redemptionLink;

  /// Create a copy of WebPurchaseRedemption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WebPurchaseRedemptionCopyWith<_WebPurchaseRedemption> get copyWith =>
      __$WebPurchaseRedemptionCopyWithImpl<_WebPurchaseRedemption>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WebPurchaseRedemptionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WebPurchaseRedemption &&
            (identical(other.redemptionLink, redemptionLink) ||
                other.redemptionLink == redemptionLink));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, redemptionLink);

  @override
  String toString() {
    return 'WebPurchaseRedemption(redemptionLink: $redemptionLink)';
  }
}

/// @nodoc
abstract mixin class _$WebPurchaseRedemptionCopyWith<$Res>
    implements $WebPurchaseRedemptionCopyWith<$Res> {
  factory _$WebPurchaseRedemptionCopyWith(_WebPurchaseRedemption value,
          $Res Function(_WebPurchaseRedemption) _then) =
      __$WebPurchaseRedemptionCopyWithImpl;
  @override
  @useResult
  $Res call({String redemptionLink});
}

/// @nodoc
class __$WebPurchaseRedemptionCopyWithImpl<$Res>
    implements _$WebPurchaseRedemptionCopyWith<$Res> {
  __$WebPurchaseRedemptionCopyWithImpl(this._self, this._then);

  final _WebPurchaseRedemption _self;
  final $Res Function(_WebPurchaseRedemption) _then;

  /// Create a copy of WebPurchaseRedemption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? redemptionLink = null,
  }) {
    return _then(_WebPurchaseRedemption(
      null == redemptionLink
          ? _self.redemptionLink
          : redemptionLink // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
