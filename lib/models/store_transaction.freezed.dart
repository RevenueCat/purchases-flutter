// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'store_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StoreTransaction _$StoreTransactionFromJson(Map<String, dynamic> json) {
  return _StoreTransaction.fromJson(json);
}

/// @nodoc
mixin _$StoreTransaction {
  /// RevenueCat Id associated to the transaction. Empty for Amazon.
// ignore: invalid_annotation_target
  @JsonKey(readValue: _readTransactionIdentifier)
  String get transactionIdentifier => throw _privateConstructorUsedError;

  /// Deprecated: Use transactionIdentifier instead. Empty for Amazon.
  @Deprecated('Use transactionIdentifier instead.')
  @JsonKey(readValue: _readTransactionIdentifier)
  String get revenueCatIdentifier => throw _privateConstructorUsedError;

  /// Product Id associated with the transaction.
  String get productIdentifier => throw _privateConstructorUsedError;

  /// Purchase date of the transaction in ISO 8601 format.
  String get purchaseDate => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(readValue: _readTransactionIdentifier)
            String transactionIdentifier,
            @Deprecated('Use transactionIdentifier instead.')
            @JsonKey(readValue: _readTransactionIdentifier)
            String revenueCatIdentifier,
            String productIdentifier,
            String purchaseDate)
        create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(readValue: _readTransactionIdentifier)
            String transactionIdentifier,
            @Deprecated('Use transactionIdentifier instead.')
            @JsonKey(readValue: _readTransactionIdentifier)
            String revenueCatIdentifier,
            String productIdentifier,
            String purchaseDate)?
        create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(readValue: _readTransactionIdentifier)
            String transactionIdentifier,
            @Deprecated('Use transactionIdentifier instead.')
            @JsonKey(readValue: _readTransactionIdentifier)
            String revenueCatIdentifier,
            String productIdentifier,
            String purchaseDate)?
        create,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StoreTransaction value) create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StoreTransaction value)? create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StoreTransaction value)? create,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this StoreTransaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoreTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoreTransactionCopyWith<StoreTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoreTransactionCopyWith<$Res> {
  factory $StoreTransactionCopyWith(
          StoreTransaction value, $Res Function(StoreTransaction) then) =
      _$StoreTransactionCopyWithImpl<$Res, StoreTransaction>;
  @useResult
  $Res call(
      {@JsonKey(readValue: _readTransactionIdentifier)
      String transactionIdentifier,
      @Deprecated('Use transactionIdentifier instead.')
      @JsonKey(readValue: _readTransactionIdentifier)
      String revenueCatIdentifier,
      String productIdentifier,
      String purchaseDate});
}

/// @nodoc
class _$StoreTransactionCopyWithImpl<$Res, $Val extends StoreTransaction>
    implements $StoreTransactionCopyWith<$Res> {
  _$StoreTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoreTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionIdentifier = null,
    Object? revenueCatIdentifier = null,
    Object? productIdentifier = null,
    Object? purchaseDate = null,
  }) {
    return _then(_value.copyWith(
      transactionIdentifier: null == transactionIdentifier
          ? _value.transactionIdentifier
          : transactionIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      revenueCatIdentifier: null == revenueCatIdentifier
          ? _value.revenueCatIdentifier
          : revenueCatIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      productIdentifier: null == productIdentifier
          ? _value.productIdentifier
          : productIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseDate: null == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StoreTransactionImplCopyWith<$Res>
    implements $StoreTransactionCopyWith<$Res> {
  factory _$$StoreTransactionImplCopyWith(_$StoreTransactionImpl value,
          $Res Function(_$StoreTransactionImpl) then) =
      __$$StoreTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(readValue: _readTransactionIdentifier)
      String transactionIdentifier,
      @Deprecated('Use transactionIdentifier instead.')
      @JsonKey(readValue: _readTransactionIdentifier)
      String revenueCatIdentifier,
      String productIdentifier,
      String purchaseDate});
}

/// @nodoc
class __$$StoreTransactionImplCopyWithImpl<$Res>
    extends _$StoreTransactionCopyWithImpl<$Res, _$StoreTransactionImpl>
    implements _$$StoreTransactionImplCopyWith<$Res> {
  __$$StoreTransactionImplCopyWithImpl(_$StoreTransactionImpl _value,
      $Res Function(_$StoreTransactionImpl) _then)
      : super(_value, _then);

  /// Create a copy of StoreTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionIdentifier = null,
    Object? revenueCatIdentifier = null,
    Object? productIdentifier = null,
    Object? purchaseDate = null,
  }) {
    return _then(_$StoreTransactionImpl(
      null == transactionIdentifier
          ? _value.transactionIdentifier
          : transactionIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      null == revenueCatIdentifier
          ? _value.revenueCatIdentifier
          : revenueCatIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      null == productIdentifier
          ? _value.productIdentifier
          : productIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      null == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StoreTransactionImpl implements _StoreTransaction {
  const _$StoreTransactionImpl(
      @JsonKey(readValue: _readTransactionIdentifier)
      this.transactionIdentifier,
      @Deprecated('Use transactionIdentifier instead.')
      @JsonKey(readValue: _readTransactionIdentifier)
      this.revenueCatIdentifier,
      this.productIdentifier,
      this.purchaseDate);

  factory _$StoreTransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoreTransactionImplFromJson(json);

  /// RevenueCat Id associated to the transaction. Empty for Amazon.
// ignore: invalid_annotation_target
  @override
  @JsonKey(readValue: _readTransactionIdentifier)
  final String transactionIdentifier;

  /// Deprecated: Use transactionIdentifier instead. Empty for Amazon.
  @override
  @Deprecated('Use transactionIdentifier instead.')
  @JsonKey(readValue: _readTransactionIdentifier)
  final String revenueCatIdentifier;

  /// Product Id associated with the transaction.
  @override
  final String productIdentifier;

  /// Purchase date of the transaction in ISO 8601 format.
  @override
  final String purchaseDate;

  @override
  String toString() {
    return 'StoreTransaction.create(transactionIdentifier: $transactionIdentifier, revenueCatIdentifier: $revenueCatIdentifier, productIdentifier: $productIdentifier, purchaseDate: $purchaseDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoreTransactionImpl &&
            (identical(other.transactionIdentifier, transactionIdentifier) ||
                other.transactionIdentifier == transactionIdentifier) &&
            (identical(other.revenueCatIdentifier, revenueCatIdentifier) ||
                other.revenueCatIdentifier == revenueCatIdentifier) &&
            (identical(other.productIdentifier, productIdentifier) ||
                other.productIdentifier == productIdentifier) &&
            (identical(other.purchaseDate, purchaseDate) ||
                other.purchaseDate == purchaseDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, transactionIdentifier,
      revenueCatIdentifier, productIdentifier, purchaseDate);

  /// Create a copy of StoreTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoreTransactionImplCopyWith<_$StoreTransactionImpl> get copyWith =>
      __$$StoreTransactionImplCopyWithImpl<_$StoreTransactionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(readValue: _readTransactionIdentifier)
            String transactionIdentifier,
            @Deprecated('Use transactionIdentifier instead.')
            @JsonKey(readValue: _readTransactionIdentifier)
            String revenueCatIdentifier,
            String productIdentifier,
            String purchaseDate)
        create,
  }) {
    return create(transactionIdentifier, revenueCatIdentifier,
        productIdentifier, purchaseDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(readValue: _readTransactionIdentifier)
            String transactionIdentifier,
            @Deprecated('Use transactionIdentifier instead.')
            @JsonKey(readValue: _readTransactionIdentifier)
            String revenueCatIdentifier,
            String productIdentifier,
            String purchaseDate)?
        create,
  }) {
    return create?.call(transactionIdentifier, revenueCatIdentifier,
        productIdentifier, purchaseDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(readValue: _readTransactionIdentifier)
            String transactionIdentifier,
            @Deprecated('Use transactionIdentifier instead.')
            @JsonKey(readValue: _readTransactionIdentifier)
            String revenueCatIdentifier,
            String productIdentifier,
            String purchaseDate)?
        create,
    required TResult orElse(),
  }) {
    if (create != null) {
      return create(transactionIdentifier, revenueCatIdentifier,
          productIdentifier, purchaseDate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StoreTransaction value) create,
  }) {
    return create(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StoreTransaction value)? create,
  }) {
    return create?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StoreTransaction value)? create,
    required TResult orElse(),
  }) {
    if (create != null) {
      return create(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$StoreTransactionImplToJson(
      this,
    );
  }
}

abstract class _StoreTransaction implements StoreTransaction {
  const factory _StoreTransaction(
      @JsonKey(readValue: _readTransactionIdentifier)
      final String transactionIdentifier,
      @Deprecated('Use transactionIdentifier instead.')
      @JsonKey(readValue: _readTransactionIdentifier)
      final String revenueCatIdentifier,
      final String productIdentifier,
      final String purchaseDate) = _$StoreTransactionImpl;

  factory _StoreTransaction.fromJson(Map<String, dynamic> json) =
      _$StoreTransactionImpl.fromJson;

  /// RevenueCat Id associated to the transaction. Empty for Amazon.
// ignore: invalid_annotation_target
  @override
  @JsonKey(readValue: _readTransactionIdentifier)
  String get transactionIdentifier;

  /// Deprecated: Use transactionIdentifier instead. Empty for Amazon.
  @override
  @Deprecated('Use transactionIdentifier instead.')
  @JsonKey(readValue: _readTransactionIdentifier)
  String get revenueCatIdentifier;

  /// Product Id associated with the transaction.
  @override
  String get productIdentifier;

  /// Purchase date of the transaction in ISO 8601 format.
  @override
  String get purchaseDate;

  /// Create a copy of StoreTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoreTransactionImplCopyWith<_$StoreTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
