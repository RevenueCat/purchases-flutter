// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'store_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StoreTransaction {
  /// RevenueCat Id associated to the transaction. Empty for Amazon.
// ignore: invalid_annotation_target
  @JsonKey(readValue: _readTransactionIdentifier)
  String get transactionIdentifier;

  /// Deprecated: Use transactionIdentifier instead. Empty for Amazon.
  @Deprecated('Use transactionIdentifier instead.')
  @JsonKey(readValue: _readTransactionIdentifier)
  String get revenueCatIdentifier;

  /// Product Id associated with the transaction.
  String get productIdentifier;

  /// Purchase date of the transaction in ISO 8601 format.
  String get purchaseDate;

  /// Create a copy of StoreTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StoreTransactionCopyWith<StoreTransaction> get copyWith =>
      _$StoreTransactionCopyWithImpl<StoreTransaction>(
          this as StoreTransaction, _$identity);

  /// Serializes this StoreTransaction to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StoreTransaction &&
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

  @override
  String toString() {
    return 'StoreTransaction(transactionIdentifier: $transactionIdentifier, revenueCatIdentifier: $revenueCatIdentifier, productIdentifier: $productIdentifier, purchaseDate: $purchaseDate)';
  }
}

/// @nodoc
abstract mixin class $StoreTransactionCopyWith<$Res> {
  factory $StoreTransactionCopyWith(
          StoreTransaction value, $Res Function(StoreTransaction) _then) =
      _$StoreTransactionCopyWithImpl;
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
class _$StoreTransactionCopyWithImpl<$Res>
    implements $StoreTransactionCopyWith<$Res> {
  _$StoreTransactionCopyWithImpl(this._self, this._then);

  final StoreTransaction _self;
  final $Res Function(StoreTransaction) _then;

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
    return _then(_self.copyWith(
      transactionIdentifier: null == transactionIdentifier
          ? _self.transactionIdentifier
          : transactionIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      revenueCatIdentifier: null == revenueCatIdentifier
          ? _self.revenueCatIdentifier
          : revenueCatIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      productIdentifier: null == productIdentifier
          ? _self.productIdentifier
          : productIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseDate: null == purchaseDate
          ? _self.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _StoreTransaction implements StoreTransaction {
  const _StoreTransaction(
      @JsonKey(readValue: _readTransactionIdentifier)
      this.transactionIdentifier,
      @Deprecated('Use transactionIdentifier instead.')
      @JsonKey(readValue: _readTransactionIdentifier)
      this.revenueCatIdentifier,
      this.productIdentifier,
      this.purchaseDate);
  factory _StoreTransaction.fromJson(Map<String, dynamic> json) =>
      _$StoreTransactionFromJson(json);

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

  /// Create a copy of StoreTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StoreTransactionCopyWith<_StoreTransaction> get copyWith =>
      __$StoreTransactionCopyWithImpl<_StoreTransaction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StoreTransactionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StoreTransaction &&
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

  @override
  String toString() {
    return 'StoreTransaction.create(transactionIdentifier: $transactionIdentifier, revenueCatIdentifier: $revenueCatIdentifier, productIdentifier: $productIdentifier, purchaseDate: $purchaseDate)';
  }
}

/// @nodoc
abstract mixin class _$StoreTransactionCopyWith<$Res>
    implements $StoreTransactionCopyWith<$Res> {
  factory _$StoreTransactionCopyWith(
          _StoreTransaction value, $Res Function(_StoreTransaction) _then) =
      __$StoreTransactionCopyWithImpl;
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
class __$StoreTransactionCopyWithImpl<$Res>
    implements _$StoreTransactionCopyWith<$Res> {
  __$StoreTransactionCopyWithImpl(this._self, this._then);

  final _StoreTransaction _self;
  final $Res Function(_StoreTransaction) _then;

  /// Create a copy of StoreTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? transactionIdentifier = null,
    Object? revenueCatIdentifier = null,
    Object? productIdentifier = null,
    Object? purchaseDate = null,
  }) {
    return _then(_StoreTransaction(
      null == transactionIdentifier
          ? _self.transactionIdentifier
          : transactionIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      null == revenueCatIdentifier
          ? _self.revenueCatIdentifier
          : revenueCatIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      null == productIdentifier
          ? _self.productIdentifier
          : productIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      null == purchaseDate
          ? _self.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
