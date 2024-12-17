// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'web_purchase_redemption_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WebPurchaseRedemptionResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CustomerInfo customerInfo) success,
    required TResult Function(PurchasesError error) error,
    required TResult Function() purchaseBelongsToOtherUser,
    required TResult Function() invalidToken,
    required TResult Function(String obfuscatedEmail) expired,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CustomerInfo customerInfo)? success,
    TResult? Function(PurchasesError error)? error,
    TResult? Function()? purchaseBelongsToOtherUser,
    TResult? Function()? invalidToken,
    TResult? Function(String obfuscatedEmail)? expired,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CustomerInfo customerInfo)? success,
    TResult Function(PurchasesError error)? error,
    TResult Function()? purchaseBelongsToOtherUser,
    TResult Function()? invalidToken,
    TResult Function(String obfuscatedEmail)? expired,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_PurchaseBelongsToOtherUser value)
        purchaseBelongsToOtherUser,
    required TResult Function(_InvalidToken value) invalidToken,
    required TResult Function(_Expired value) expired,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_PurchaseBelongsToOtherUser value)?
        purchaseBelongsToOtherUser,
    TResult? Function(_InvalidToken value)? invalidToken,
    TResult? Function(_Expired value)? expired,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_PurchaseBelongsToOtherUser value)?
        purchaseBelongsToOtherUser,
    TResult Function(_InvalidToken value)? invalidToken,
    TResult Function(_Expired value)? expired,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebPurchaseRedemptionResultCopyWith<$Res> {
  factory $WebPurchaseRedemptionResultCopyWith(
          WebPurchaseRedemptionResult value,
          $Res Function(WebPurchaseRedemptionResult) then) =
      _$WebPurchaseRedemptionResultCopyWithImpl<$Res,
          WebPurchaseRedemptionResult>;
}

/// @nodoc
class _$WebPurchaseRedemptionResultCopyWithImpl<$Res,
        $Val extends WebPurchaseRedemptionResult>
    implements $WebPurchaseRedemptionResultCopyWith<$Res> {
  _$WebPurchaseRedemptionResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WebPurchaseRedemptionResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CustomerInfo customerInfo});

  $CustomerInfoCopyWith<$Res> get customerInfo;
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$WebPurchaseRedemptionResultCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of WebPurchaseRedemptionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerInfo = null,
  }) {
    return _then(_$SuccessImpl(
      customerInfo: null == customerInfo
          ? _value.customerInfo
          : customerInfo // ignore: cast_nullable_to_non_nullable
              as CustomerInfo,
    ));
  }

  /// Create a copy of WebPurchaseRedemptionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomerInfoCopyWith<$Res> get customerInfo {
    return $CustomerInfoCopyWith<$Res>(_value.customerInfo, (value) {
      return _then(_value.copyWith(customerInfo: value));
    });
  }
}

/// @nodoc

class _$SuccessImpl extends _Success {
  const _$SuccessImpl({required this.customerInfo}) : super._();

  @override
  final CustomerInfo customerInfo;

  @override
  String toString() {
    return 'WebPurchaseRedemptionResult.success(customerInfo: $customerInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.customerInfo, customerInfo) ||
                other.customerInfo == customerInfo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, customerInfo);

  /// Create a copy of WebPurchaseRedemptionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CustomerInfo customerInfo) success,
    required TResult Function(PurchasesError error) error,
    required TResult Function() purchaseBelongsToOtherUser,
    required TResult Function() invalidToken,
    required TResult Function(String obfuscatedEmail) expired,
  }) {
    return success(customerInfo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CustomerInfo customerInfo)? success,
    TResult? Function(PurchasesError error)? error,
    TResult? Function()? purchaseBelongsToOtherUser,
    TResult? Function()? invalidToken,
    TResult? Function(String obfuscatedEmail)? expired,
  }) {
    return success?.call(customerInfo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CustomerInfo customerInfo)? success,
    TResult Function(PurchasesError error)? error,
    TResult Function()? purchaseBelongsToOtherUser,
    TResult Function()? invalidToken,
    TResult Function(String obfuscatedEmail)? expired,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(customerInfo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_PurchaseBelongsToOtherUser value)
        purchaseBelongsToOtherUser,
    required TResult Function(_InvalidToken value) invalidToken,
    required TResult Function(_Expired value) expired,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_PurchaseBelongsToOtherUser value)?
        purchaseBelongsToOtherUser,
    TResult? Function(_InvalidToken value)? invalidToken,
    TResult? Function(_Expired value)? expired,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_PurchaseBelongsToOtherUser value)?
        purchaseBelongsToOtherUser,
    TResult Function(_InvalidToken value)? invalidToken,
    TResult Function(_Expired value)? expired,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success extends WebPurchaseRedemptionResult {
  const factory _Success({required final CustomerInfo customerInfo}) =
      _$SuccessImpl;
  const _Success._() : super._();

  CustomerInfo get customerInfo;

  /// Create a copy of WebPurchaseRedemptionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PurchasesError error});

  $PurchasesErrorCopyWith<$Res> get error;
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$WebPurchaseRedemptionResultCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of WebPurchaseRedemptionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$ErrorImpl(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as PurchasesError,
    ));
  }

  /// Create a copy of WebPurchaseRedemptionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PurchasesErrorCopyWith<$Res> get error {
    return $PurchasesErrorCopyWith<$Res>(_value.error, (value) {
      return _then(_value.copyWith(error: value));
    });
  }
}

/// @nodoc

class _$ErrorImpl extends _Error {
  const _$ErrorImpl({required this.error}) : super._();

  @override
  final PurchasesError error;

  @override
  String toString() {
    return 'WebPurchaseRedemptionResult.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of WebPurchaseRedemptionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CustomerInfo customerInfo) success,
    required TResult Function(PurchasesError error) error,
    required TResult Function() purchaseBelongsToOtherUser,
    required TResult Function() invalidToken,
    required TResult Function(String obfuscatedEmail) expired,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CustomerInfo customerInfo)? success,
    TResult? Function(PurchasesError error)? error,
    TResult? Function()? purchaseBelongsToOtherUser,
    TResult? Function()? invalidToken,
    TResult? Function(String obfuscatedEmail)? expired,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CustomerInfo customerInfo)? success,
    TResult Function(PurchasesError error)? error,
    TResult Function()? purchaseBelongsToOtherUser,
    TResult Function()? invalidToken,
    TResult Function(String obfuscatedEmail)? expired,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_PurchaseBelongsToOtherUser value)
        purchaseBelongsToOtherUser,
    required TResult Function(_InvalidToken value) invalidToken,
    required TResult Function(_Expired value) expired,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_PurchaseBelongsToOtherUser value)?
        purchaseBelongsToOtherUser,
    TResult? Function(_InvalidToken value)? invalidToken,
    TResult? Function(_Expired value)? expired,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_PurchaseBelongsToOtherUser value)?
        purchaseBelongsToOtherUser,
    TResult Function(_InvalidToken value)? invalidToken,
    TResult Function(_Expired value)? expired,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error extends WebPurchaseRedemptionResult {
  const factory _Error({required final PurchasesError error}) = _$ErrorImpl;
  const _Error._() : super._();

  PurchasesError get error;

  /// Create a copy of WebPurchaseRedemptionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PurchaseBelongsToOtherUserImplCopyWith<$Res> {
  factory _$$PurchaseBelongsToOtherUserImplCopyWith(
          _$PurchaseBelongsToOtherUserImpl value,
          $Res Function(_$PurchaseBelongsToOtherUserImpl) then) =
      __$$PurchaseBelongsToOtherUserImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PurchaseBelongsToOtherUserImplCopyWithImpl<$Res>
    extends _$WebPurchaseRedemptionResultCopyWithImpl<$Res,
        _$PurchaseBelongsToOtherUserImpl>
    implements _$$PurchaseBelongsToOtherUserImplCopyWith<$Res> {
  __$$PurchaseBelongsToOtherUserImplCopyWithImpl(
      _$PurchaseBelongsToOtherUserImpl _value,
      $Res Function(_$PurchaseBelongsToOtherUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of WebPurchaseRedemptionResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PurchaseBelongsToOtherUserImpl extends _PurchaseBelongsToOtherUser {
  const _$PurchaseBelongsToOtherUserImpl() : super._();

  @override
  String toString() {
    return 'WebPurchaseRedemptionResult.purchaseBelongsToOtherUser()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseBelongsToOtherUserImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CustomerInfo customerInfo) success,
    required TResult Function(PurchasesError error) error,
    required TResult Function() purchaseBelongsToOtherUser,
    required TResult Function() invalidToken,
    required TResult Function(String obfuscatedEmail) expired,
  }) {
    return purchaseBelongsToOtherUser();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CustomerInfo customerInfo)? success,
    TResult? Function(PurchasesError error)? error,
    TResult? Function()? purchaseBelongsToOtherUser,
    TResult? Function()? invalidToken,
    TResult? Function(String obfuscatedEmail)? expired,
  }) {
    return purchaseBelongsToOtherUser?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CustomerInfo customerInfo)? success,
    TResult Function(PurchasesError error)? error,
    TResult Function()? purchaseBelongsToOtherUser,
    TResult Function()? invalidToken,
    TResult Function(String obfuscatedEmail)? expired,
    required TResult orElse(),
  }) {
    if (purchaseBelongsToOtherUser != null) {
      return purchaseBelongsToOtherUser();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_PurchaseBelongsToOtherUser value)
        purchaseBelongsToOtherUser,
    required TResult Function(_InvalidToken value) invalidToken,
    required TResult Function(_Expired value) expired,
  }) {
    return purchaseBelongsToOtherUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_PurchaseBelongsToOtherUser value)?
        purchaseBelongsToOtherUser,
    TResult? Function(_InvalidToken value)? invalidToken,
    TResult? Function(_Expired value)? expired,
  }) {
    return purchaseBelongsToOtherUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_PurchaseBelongsToOtherUser value)?
        purchaseBelongsToOtherUser,
    TResult Function(_InvalidToken value)? invalidToken,
    TResult Function(_Expired value)? expired,
    required TResult orElse(),
  }) {
    if (purchaseBelongsToOtherUser != null) {
      return purchaseBelongsToOtherUser(this);
    }
    return orElse();
  }
}

abstract class _PurchaseBelongsToOtherUser extends WebPurchaseRedemptionResult {
  const factory _PurchaseBelongsToOtherUser() =
      _$PurchaseBelongsToOtherUserImpl;
  const _PurchaseBelongsToOtherUser._() : super._();
}

/// @nodoc
abstract class _$$InvalidTokenImplCopyWith<$Res> {
  factory _$$InvalidTokenImplCopyWith(
          _$InvalidTokenImpl value, $Res Function(_$InvalidTokenImpl) then) =
      __$$InvalidTokenImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InvalidTokenImplCopyWithImpl<$Res>
    extends _$WebPurchaseRedemptionResultCopyWithImpl<$Res, _$InvalidTokenImpl>
    implements _$$InvalidTokenImplCopyWith<$Res> {
  __$$InvalidTokenImplCopyWithImpl(
      _$InvalidTokenImpl _value, $Res Function(_$InvalidTokenImpl) _then)
      : super(_value, _then);

  /// Create a copy of WebPurchaseRedemptionResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InvalidTokenImpl extends _InvalidToken {
  const _$InvalidTokenImpl() : super._();

  @override
  String toString() {
    return 'WebPurchaseRedemptionResult.invalidToken()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InvalidTokenImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CustomerInfo customerInfo) success,
    required TResult Function(PurchasesError error) error,
    required TResult Function() purchaseBelongsToOtherUser,
    required TResult Function() invalidToken,
    required TResult Function(String obfuscatedEmail) expired,
  }) {
    return invalidToken();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CustomerInfo customerInfo)? success,
    TResult? Function(PurchasesError error)? error,
    TResult? Function()? purchaseBelongsToOtherUser,
    TResult? Function()? invalidToken,
    TResult? Function(String obfuscatedEmail)? expired,
  }) {
    return invalidToken?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CustomerInfo customerInfo)? success,
    TResult Function(PurchasesError error)? error,
    TResult Function()? purchaseBelongsToOtherUser,
    TResult Function()? invalidToken,
    TResult Function(String obfuscatedEmail)? expired,
    required TResult orElse(),
  }) {
    if (invalidToken != null) {
      return invalidToken();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_PurchaseBelongsToOtherUser value)
        purchaseBelongsToOtherUser,
    required TResult Function(_InvalidToken value) invalidToken,
    required TResult Function(_Expired value) expired,
  }) {
    return invalidToken(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_PurchaseBelongsToOtherUser value)?
        purchaseBelongsToOtherUser,
    TResult? Function(_InvalidToken value)? invalidToken,
    TResult? Function(_Expired value)? expired,
  }) {
    return invalidToken?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_PurchaseBelongsToOtherUser value)?
        purchaseBelongsToOtherUser,
    TResult Function(_InvalidToken value)? invalidToken,
    TResult Function(_Expired value)? expired,
    required TResult orElse(),
  }) {
    if (invalidToken != null) {
      return invalidToken(this);
    }
    return orElse();
  }
}

abstract class _InvalidToken extends WebPurchaseRedemptionResult {
  const factory _InvalidToken() = _$InvalidTokenImpl;
  const _InvalidToken._() : super._();
}

/// @nodoc
abstract class _$$ExpiredImplCopyWith<$Res> {
  factory _$$ExpiredImplCopyWith(
          _$ExpiredImpl value, $Res Function(_$ExpiredImpl) then) =
      __$$ExpiredImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String obfuscatedEmail});
}

/// @nodoc
class __$$ExpiredImplCopyWithImpl<$Res>
    extends _$WebPurchaseRedemptionResultCopyWithImpl<$Res, _$ExpiredImpl>
    implements _$$ExpiredImplCopyWith<$Res> {
  __$$ExpiredImplCopyWithImpl(
      _$ExpiredImpl _value, $Res Function(_$ExpiredImpl) _then)
      : super(_value, _then);

  /// Create a copy of WebPurchaseRedemptionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? obfuscatedEmail = null,
  }) {
    return _then(_$ExpiredImpl(
      obfuscatedEmail: null == obfuscatedEmail
          ? _value.obfuscatedEmail
          : obfuscatedEmail // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ExpiredImpl extends _Expired {
  const _$ExpiredImpl({required this.obfuscatedEmail}) : super._();

  @override
  final String obfuscatedEmail;

  @override
  String toString() {
    return 'WebPurchaseRedemptionResult.expired(obfuscatedEmail: $obfuscatedEmail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpiredImpl &&
            (identical(other.obfuscatedEmail, obfuscatedEmail) ||
                other.obfuscatedEmail == obfuscatedEmail));
  }

  @override
  int get hashCode => Object.hash(runtimeType, obfuscatedEmail);

  /// Create a copy of WebPurchaseRedemptionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpiredImplCopyWith<_$ExpiredImpl> get copyWith =>
      __$$ExpiredImplCopyWithImpl<_$ExpiredImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CustomerInfo customerInfo) success,
    required TResult Function(PurchasesError error) error,
    required TResult Function() purchaseBelongsToOtherUser,
    required TResult Function() invalidToken,
    required TResult Function(String obfuscatedEmail) expired,
  }) {
    return expired(obfuscatedEmail);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CustomerInfo customerInfo)? success,
    TResult? Function(PurchasesError error)? error,
    TResult? Function()? purchaseBelongsToOtherUser,
    TResult? Function()? invalidToken,
    TResult? Function(String obfuscatedEmail)? expired,
  }) {
    return expired?.call(obfuscatedEmail);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CustomerInfo customerInfo)? success,
    TResult Function(PurchasesError error)? error,
    TResult Function()? purchaseBelongsToOtherUser,
    TResult Function()? invalidToken,
    TResult Function(String obfuscatedEmail)? expired,
    required TResult orElse(),
  }) {
    if (expired != null) {
      return expired(obfuscatedEmail);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_PurchaseBelongsToOtherUser value)
        purchaseBelongsToOtherUser,
    required TResult Function(_InvalidToken value) invalidToken,
    required TResult Function(_Expired value) expired,
  }) {
    return expired(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_PurchaseBelongsToOtherUser value)?
        purchaseBelongsToOtherUser,
    TResult? Function(_InvalidToken value)? invalidToken,
    TResult? Function(_Expired value)? expired,
  }) {
    return expired?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_PurchaseBelongsToOtherUser value)?
        purchaseBelongsToOtherUser,
    TResult Function(_InvalidToken value)? invalidToken,
    TResult Function(_Expired value)? expired,
    required TResult orElse(),
  }) {
    if (expired != null) {
      return expired(this);
    }
    return orElse();
  }
}

abstract class _Expired extends WebPurchaseRedemptionResult {
  const factory _Expired({required final String obfuscatedEmail}) =
      _$ExpiredImpl;
  const _Expired._() : super._();

  String get obfuscatedEmail;

  /// Create a copy of WebPurchaseRedemptionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExpiredImplCopyWith<_$ExpiredImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
