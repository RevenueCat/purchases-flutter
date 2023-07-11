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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StoreTransaction _$StoreTransactionFromJson(Map<String, dynamic> json) {
  return _StoreTransaction.fromJson(json);
}

/// @nodoc
mixin _$StoreTransaction {
  /// RevenueCat Id associated to the transaction.
  String get transactionIdentifier => throw _privateConstructorUsedError;

  /// Deprecated: Use transactionIdentifier instead.
  @Deprecated('Use transactionIdentifier instead.')
  @JsonKey(readValue: _readRevenueCatIdentifier)
  String get revenueCatIdentifier => throw _privateConstructorUsedError;

  /// Product Id associated with the transaction.
  String get productIdentifier => throw _privateConstructorUsedError;

  /// Purchase date of the transaction in ISO 8601 format.
  String get purchaseDate => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String transactionIdentifier,
            @Deprecated('Use transactionIdentifier instead.')
            @JsonKey(readValue: _readRevenueCatIdentifier)
            String revenueCatIdentifier,
            String productIdentifier,
            String purchaseDate)
        create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String transactionIdentifier,
            @Deprecated('Use transactionIdentifier instead.')
            @JsonKey(readValue: _readRevenueCatIdentifier)
            String revenueCatIdentifier,
            String productIdentifier,
            String purchaseDate)?
        create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String transactionIdentifier,
            @Deprecated('Use transactionIdentifier instead.')
            @JsonKey(readValue: _readRevenueCatIdentifier)
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
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
      {String transactionIdentifier,
      @Deprecated('Use transactionIdentifier instead.')
      @JsonKey(readValue: _readRevenueCatIdentifier)
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
abstract class _$$_StoreTransactionCopyWith<$Res>
    implements $StoreTransactionCopyWith<$Res> {
  factory _$$_StoreTransactionCopyWith(
          _$_StoreTransaction value, $Res Function(_$_StoreTransaction) then) =
      __$$_StoreTransactionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String transactionIdentifier,
      @Deprecated('Use transactionIdentifier instead.')
      @JsonKey(readValue: _readRevenueCatIdentifier)
      String revenueCatIdentifier,
      String productIdentifier,
      String purchaseDate});
}

/// @nodoc
class __$$_StoreTransactionCopyWithImpl<$Res>
    extends _$StoreTransactionCopyWithImpl<$Res, _$_StoreTransaction>
    implements _$$_StoreTransactionCopyWith<$Res> {
  __$$_StoreTransactionCopyWithImpl(
      _$_StoreTransaction _value, $Res Function(_$_StoreTransaction) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionIdentifier = null,
    Object? revenueCatIdentifier = null,
    Object? productIdentifier = null,
    Object? purchaseDate = null,
  }) {
    return _then(_$_StoreTransaction(
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
class _$_StoreTransaction implements _StoreTransaction {
  const _$_StoreTransaction(
      this.transactionIdentifier,
      @Deprecated('Use transactionIdentifier instead.')
      @JsonKey(readValue: _readRevenueCatIdentifier)
      this.revenueCatIdentifier,
      this.productIdentifier,
      this.purchaseDate);

  factory _$_StoreTransaction.fromJson(Map<String, dynamic> json) =>
      _$$_StoreTransactionFromJson(json);

  /// RevenueCat Id associated to the transaction.
  @override
  final String transactionIdentifier;

  /// Deprecated: Use transactionIdentifier instead.
  @override
  @Deprecated('Use transactionIdentifier instead.')
  @JsonKey(readValue: _readRevenueCatIdentifier)
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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StoreTransaction &&
            (identical(other.transactionIdentifier, transactionIdentifier) ||
                other.transactionIdentifier == transactionIdentifier) &&
            (identical(other.revenueCatIdentifier, revenueCatIdentifier) ||
                other.revenueCatIdentifier == revenueCatIdentifier) &&
            (identical(other.productIdentifier, productIdentifier) ||
                other.productIdentifier == productIdentifier) &&
            (identical(other.purchaseDate, purchaseDate) ||
                other.purchaseDate == purchaseDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, transactionIdentifier,
      revenueCatIdentifier, productIdentifier, purchaseDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StoreTransactionCopyWith<_$_StoreTransaction> get copyWith =>
      __$$_StoreTransactionCopyWithImpl<_$_StoreTransaction>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String transactionIdentifier,
            @Deprecated('Use transactionIdentifier instead.')
            @JsonKey(readValue: _readRevenueCatIdentifier)
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
            String transactionIdentifier,
            @Deprecated('Use transactionIdentifier instead.')
            @JsonKey(readValue: _readRevenueCatIdentifier)
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
            String transactionIdentifier,
            @Deprecated('Use transactionIdentifier instead.')
            @JsonKey(readValue: _readRevenueCatIdentifier)
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
    return _$$_StoreTransactionToJson(
      this,
    );
  }
}

abstract class _StoreTransaction implements StoreTransaction {
  const factory _StoreTransaction(
      final String transactionIdentifier,
      @Deprecated('Use transactionIdentifier instead.')
      @JsonKey(readValue: _readRevenueCatIdentifier)
      final String revenueCatIdentifier,
      final String productIdentifier,
      final String purchaseDate) = _$_StoreTransaction;

  factory _StoreTransaction.fromJson(Map<String, dynamic> json) =
      _$_StoreTransaction.fromJson;

  @override

  /// RevenueCat Id associated to the transaction.
  String get transactionIdentifier;
  @override

  /// Deprecated: Use transactionIdentifier instead.
  @Deprecated('Use transactionIdentifier instead.')
  @JsonKey(readValue: _readRevenueCatIdentifier)
  String get revenueCatIdentifier;
  @override

  /// Product Id associated with the transaction.
  String get productIdentifier;
  @override

  /// Purchase date of the transaction in ISO 8601 format.
  String get purchaseDate;
  @override
  @JsonKey(ignore: true)
  _$$_StoreTransactionCopyWith<_$_StoreTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}
