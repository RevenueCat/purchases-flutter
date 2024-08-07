// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchases_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PurchasesError _$PurchasesErrorFromJson(Map<String, dynamic> json) {
  return _PurchasesError.fromJson(json);
}

/// @nodoc
mixin _$PurchasesError {
  @PurchasesErrorCodeConverter()
  PurchasesErrorCode get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get underlyingErrorMessage =>
      throw _privateConstructorUsedError; // iOS can return a readable error code null, because the construction
// of the error doesn't prevent it from being null. To be safe we default
// it to '' instead of making it nullable
// ignore: invalid_annotation_target
  @JsonKey(defaultValue: '')
  String get readableErrorCode => throw _privateConstructorUsedError;

  /// Serializes this PurchasesError to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PurchasesError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PurchasesErrorCopyWith<PurchasesError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchasesErrorCopyWith<$Res> {
  factory $PurchasesErrorCopyWith(
          PurchasesError value, $Res Function(PurchasesError) then) =
      _$PurchasesErrorCopyWithImpl<$Res, PurchasesError>;
  @useResult
  $Res call(
      {@PurchasesErrorCodeConverter() PurchasesErrorCode code,
      String message,
      String underlyingErrorMessage,
      @JsonKey(defaultValue: '') String readableErrorCode});
}

/// @nodoc
class _$PurchasesErrorCopyWithImpl<$Res, $Val extends PurchasesError>
    implements $PurchasesErrorCopyWith<$Res> {
  _$PurchasesErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as PurchasesErrorCode,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      underlyingErrorMessage: null == underlyingErrorMessage
          ? _value.underlyingErrorMessage
          : underlyingErrorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      readableErrorCode: null == readableErrorCode
          ? _value.readableErrorCode
          : readableErrorCode // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PurchasesErrorImplCopyWith<$Res>
    implements $PurchasesErrorCopyWith<$Res> {
  factory _$$PurchasesErrorImplCopyWith(_$PurchasesErrorImpl value,
          $Res Function(_$PurchasesErrorImpl) then) =
      __$$PurchasesErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@PurchasesErrorCodeConverter() PurchasesErrorCode code,
      String message,
      String underlyingErrorMessage,
      @JsonKey(defaultValue: '') String readableErrorCode});
}

/// @nodoc
class __$$PurchasesErrorImplCopyWithImpl<$Res>
    extends _$PurchasesErrorCopyWithImpl<$Res, _$PurchasesErrorImpl>
    implements _$$PurchasesErrorImplCopyWith<$Res> {
  __$$PurchasesErrorImplCopyWithImpl(
      _$PurchasesErrorImpl _value, $Res Function(_$PurchasesErrorImpl) _then)
      : super(_value, _then);

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
    return _then(_$PurchasesErrorImpl(
      null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as PurchasesErrorCode,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      null == underlyingErrorMessage
          ? _value.underlyingErrorMessage
          : underlyingErrorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      null == readableErrorCode
          ? _value.readableErrorCode
          : readableErrorCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PurchasesErrorImpl implements _PurchasesError {
  const _$PurchasesErrorImpl(
      @PurchasesErrorCodeConverter() this.code,
      this.message,
      this.underlyingErrorMessage,
      @JsonKey(defaultValue: '') this.readableErrorCode);

  factory _$PurchasesErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$PurchasesErrorImplFromJson(json);

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

  @override
  String toString() {
    return 'PurchasesError(code: $code, message: $message, underlyingErrorMessage: $underlyingErrorMessage, readableErrorCode: $readableErrorCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchasesErrorImpl &&
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

  /// Create a copy of PurchasesError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchasesErrorImplCopyWith<_$PurchasesErrorImpl> get copyWith =>
      __$$PurchasesErrorImplCopyWithImpl<_$PurchasesErrorImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PurchasesErrorImplToJson(
      this,
    );
  }
}

abstract class _PurchasesError implements PurchasesError {
  const factory _PurchasesError(
          @PurchasesErrorCodeConverter() final PurchasesErrorCode code,
          final String message,
          final String underlyingErrorMessage,
          @JsonKey(defaultValue: '') final String readableErrorCode) =
      _$PurchasesErrorImpl;

  factory _PurchasesError.fromJson(Map<String, dynamic> json) =
      _$PurchasesErrorImpl.fromJson;

  @override
  @PurchasesErrorCodeConverter()
  PurchasesErrorCode get code;
  @override
  String get message;
  @override
  String
      get underlyingErrorMessage; // iOS can return a readable error code null, because the construction
// of the error doesn't prevent it from being null. To be safe we default
// it to '' instead of making it nullable
// ignore: invalid_annotation_target
  @override
  @JsonKey(defaultValue: '')
  String get readableErrorCode;

  /// Create a copy of PurchasesError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchasesErrorImplCopyWith<_$PurchasesErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
