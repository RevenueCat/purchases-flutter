// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchases_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PurchasesError {
  @PurchasesErrorCodeConverter()
  PurchasesErrorCode get code;
  String get message;
  String
      get underlyingErrorMessage; // iOS can return a readable error code null, because the construction
// of the error doesn't prevent it from being null. To be safe we default
// it to '' instead of making it nullable
// ignore: invalid_annotation_target
  @JsonKey(defaultValue: '')
  String get readableErrorCode;

  /// Create a copy of PurchasesError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PurchasesErrorCopyWith<PurchasesError> get copyWith =>
      _$PurchasesErrorCopyWithImpl<PurchasesError>(
          this as PurchasesError, _$identity);

  /// Serializes this PurchasesError to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PurchasesError &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.underlyingErrorMessage, underlyingErrorMessage) ||
                other.underlyingErrorMessage == underlyingErrorMessage) &&
            (identical(other.readableErrorCode, readableErrorCode) ||
                other.readableErrorCode == readableErrorCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, code, message, underlyingErrorMessage, readableErrorCode);

  @override
  String toString() {
    return 'PurchasesError(code: $code, message: $message, underlyingErrorMessage: $underlyingErrorMessage, readableErrorCode: $readableErrorCode)';
  }
}

/// @nodoc
abstract mixin class $PurchasesErrorCopyWith<$Res> {
  factory $PurchasesErrorCopyWith(
          PurchasesError value, $Res Function(PurchasesError) _then) =
      _$PurchasesErrorCopyWithImpl;
  @useResult
  $Res call(
      {@PurchasesErrorCodeConverter() PurchasesErrorCode code,
      String message,
      String underlyingErrorMessage,
      @JsonKey(defaultValue: '') String readableErrorCode});
}

/// @nodoc
class _$PurchasesErrorCopyWithImpl<$Res>
    implements $PurchasesErrorCopyWith<$Res> {
  _$PurchasesErrorCopyWithImpl(this._self, this._then);

  final PurchasesError _self;
  final $Res Function(PurchasesError) _then;

  /// Create a copy of PurchasesError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? underlyingErrorMessage = null,
    Object? readableErrorCode = null,
  }) {
    return _then(_self.copyWith(
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as PurchasesErrorCode,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      underlyingErrorMessage: null == underlyingErrorMessage
          ? _self.underlyingErrorMessage
          : underlyingErrorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      readableErrorCode: null == readableErrorCode
          ? _self.readableErrorCode
          : readableErrorCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _PurchasesError implements PurchasesError {
  const _PurchasesError(
      @PurchasesErrorCodeConverter() this.code,
      this.message,
      this.underlyingErrorMessage,
      @JsonKey(defaultValue: '') this.readableErrorCode);
  factory _PurchasesError.fromJson(Map<String, dynamic> json) =>
      _$PurchasesErrorFromJson(json);

  @override
  @PurchasesErrorCodeConverter()
  final PurchasesErrorCode code;
  @override
  final String message;
  @override
  final String underlyingErrorMessage;
// iOS can return a readable error code null, because the construction
// of the error doesn't prevent it from being null. To be safe we default
// it to '' instead of making it nullable
// ignore: invalid_annotation_target
  @override
  @JsonKey(defaultValue: '')
  final String readableErrorCode;

  /// Create a copy of PurchasesError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PurchasesErrorCopyWith<_PurchasesError> get copyWith =>
      __$PurchasesErrorCopyWithImpl<_PurchasesError>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PurchasesErrorToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PurchasesError &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.underlyingErrorMessage, underlyingErrorMessage) ||
                other.underlyingErrorMessage == underlyingErrorMessage) &&
            (identical(other.readableErrorCode, readableErrorCode) ||
                other.readableErrorCode == readableErrorCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, code, message, underlyingErrorMessage, readableErrorCode);

  @override
  String toString() {
    return 'PurchasesError(code: $code, message: $message, underlyingErrorMessage: $underlyingErrorMessage, readableErrorCode: $readableErrorCode)';
  }
}

/// @nodoc
abstract mixin class _$PurchasesErrorCopyWith<$Res>
    implements $PurchasesErrorCopyWith<$Res> {
  factory _$PurchasesErrorCopyWith(
          _PurchasesError value, $Res Function(_PurchasesError) _then) =
      __$PurchasesErrorCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@PurchasesErrorCodeConverter() PurchasesErrorCode code,
      String message,
      String underlyingErrorMessage,
      @JsonKey(defaultValue: '') String readableErrorCode});
}

/// @nodoc
class __$PurchasesErrorCopyWithImpl<$Res>
    implements _$PurchasesErrorCopyWith<$Res> {
  __$PurchasesErrorCopyWithImpl(this._self, this._then);

  final _PurchasesError _self;
  final $Res Function(_PurchasesError) _then;

  /// Create a copy of PurchasesError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? underlyingErrorMessage = null,
    Object? readableErrorCode = null,
  }) {
    return _then(_PurchasesError(
      null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as PurchasesErrorCode,
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      null == underlyingErrorMessage
          ? _self.underlyingErrorMessage
          : underlyingErrorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      null == readableErrorCode
          ? _self.readableErrorCode
          : readableErrorCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
