// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'web_purchase_redemption_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WebPurchaseRedemptionResult {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WebPurchaseRedemptionResult);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'WebPurchaseRedemptionResult()';
  }
}

/// @nodoc
class $WebPurchaseRedemptionResultCopyWith<$Res> {
  $WebPurchaseRedemptionResultCopyWith(WebPurchaseRedemptionResult _,
      $Res Function(WebPurchaseRedemptionResult) __);
}

/// @nodoc

class Success extends WebPurchaseRedemptionResult {
  const Success({required this.customerInfo}) : super._();

  final CustomerInfo customerInfo;

  /// Create a copy of WebPurchaseRedemptionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SuccessCopyWith<Success> get copyWith =>
      _$SuccessCopyWithImpl<Success>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Success &&
            (identical(other.customerInfo, customerInfo) ||
                other.customerInfo == customerInfo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, customerInfo);

  @override
  String toString() {
    return 'WebPurchaseRedemptionResult.success(customerInfo: $customerInfo)';
  }
}

/// @nodoc
abstract mixin class $SuccessCopyWith<$Res>
    implements $WebPurchaseRedemptionResultCopyWith<$Res> {
  factory $SuccessCopyWith(Success value, $Res Function(Success) _then) =
      _$SuccessCopyWithImpl;
  @useResult
  $Res call({CustomerInfo customerInfo});

  $CustomerInfoCopyWith<$Res> get customerInfo;
}

/// @nodoc
class _$SuccessCopyWithImpl<$Res> implements $SuccessCopyWith<$Res> {
  _$SuccessCopyWithImpl(this._self, this._then);

  final Success _self;
  final $Res Function(Success) _then;

  /// Create a copy of WebPurchaseRedemptionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? customerInfo = null,
  }) {
    return _then(Success(
      customerInfo: null == customerInfo
          ? _self.customerInfo
          : customerInfo // ignore: cast_nullable_to_non_nullable
              as CustomerInfo,
    ));
  }

  /// Create a copy of WebPurchaseRedemptionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomerInfoCopyWith<$Res> get customerInfo {
    return $CustomerInfoCopyWith<$Res>(_self.customerInfo, (value) {
      return _then(_self.copyWith(customerInfo: value));
    });
  }
}

/// @nodoc

class Error extends WebPurchaseRedemptionResult {
  const Error({required this.error}) : super._();

  final PurchasesError error;

  /// Create a copy of WebPurchaseRedemptionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ErrorCopyWith<Error> get copyWith =>
      _$ErrorCopyWithImpl<Error>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Error &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @override
  String toString() {
    return 'WebPurchaseRedemptionResult.error(error: $error)';
  }
}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res>
    implements $WebPurchaseRedemptionResultCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) _then) =
      _$ErrorCopyWithImpl;
  @useResult
  $Res call({PurchasesError error});

  $PurchasesErrorCopyWith<$Res> get error;
}

/// @nodoc
class _$ErrorCopyWithImpl<$Res> implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(this._self, this._then);

  final Error _self;
  final $Res Function(Error) _then;

  /// Create a copy of WebPurchaseRedemptionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? error = null,
  }) {
    return _then(Error(
      error: null == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as PurchasesError,
    ));
  }

  /// Create a copy of WebPurchaseRedemptionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PurchasesErrorCopyWith<$Res> get error {
    return $PurchasesErrorCopyWith<$Res>(_self.error, (value) {
      return _then(_self.copyWith(error: value));
    });
  }
}

/// @nodoc

class PurchaseBelongsToOtherUser extends WebPurchaseRedemptionResult {
  const PurchaseBelongsToOtherUser() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PurchaseBelongsToOtherUser);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'WebPurchaseRedemptionResult.purchaseBelongsToOtherUser()';
  }
}

/// @nodoc

class InvalidToken extends WebPurchaseRedemptionResult {
  const InvalidToken() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is InvalidToken);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'WebPurchaseRedemptionResult.invalidToken()';
  }
}

/// @nodoc

class Expired extends WebPurchaseRedemptionResult {
  const Expired({required this.obfuscatedEmail}) : super._();

  final String obfuscatedEmail;

  /// Create a copy of WebPurchaseRedemptionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExpiredCopyWith<Expired> get copyWith =>
      _$ExpiredCopyWithImpl<Expired>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Expired &&
            (identical(other.obfuscatedEmail, obfuscatedEmail) ||
                other.obfuscatedEmail == obfuscatedEmail));
  }

  @override
  int get hashCode => Object.hash(runtimeType, obfuscatedEmail);

  @override
  String toString() {
    return 'WebPurchaseRedemptionResult.expired(obfuscatedEmail: $obfuscatedEmail)';
  }
}

/// @nodoc
abstract mixin class $ExpiredCopyWith<$Res>
    implements $WebPurchaseRedemptionResultCopyWith<$Res> {
  factory $ExpiredCopyWith(Expired value, $Res Function(Expired) _then) =
      _$ExpiredCopyWithImpl;
  @useResult
  $Res call({String obfuscatedEmail});
}

/// @nodoc
class _$ExpiredCopyWithImpl<$Res> implements $ExpiredCopyWith<$Res> {
  _$ExpiredCopyWithImpl(this._self, this._then);

  final Expired _self;
  final $Res Function(Expired) _then;

  /// Create a copy of WebPurchaseRedemptionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? obfuscatedEmail = null,
  }) {
    return _then(Expired(
      obfuscatedEmail: null == obfuscatedEmail
          ? _self.obfuscatedEmail
          : obfuscatedEmail // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
