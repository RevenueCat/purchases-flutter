// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
  @JsonKey(name: 'revenueCatId')
  String get revenueCatIdentifier => throw _privateConstructorUsedError;

  /// Product Id associated with the transaction.
  @JsonKey(name: 'productId')
  String get productIdentifier => throw _privateConstructorUsedError;

  /// Purchase date of the transaction in ISO 8601 format.
  @JsonKey(name: 'purchaseDate')
  String get purchaseDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoreTransactionCopyWith<StoreTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoreTransactionCopyWith<$Res> {
  factory $StoreTransactionCopyWith(
          StoreTransaction value, $Res Function(StoreTransaction) then) =
      _$StoreTransactionCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'revenueCatId') String revenueCatIdentifier,
      @JsonKey(name: 'productId') String productIdentifier,
      @JsonKey(name: 'purchaseDate') String purchaseDate});
}

/// @nodoc
class _$StoreTransactionCopyWithImpl<$Res>
    implements $StoreTransactionCopyWith<$Res> {
  _$StoreTransactionCopyWithImpl(this._value, this._then);

  final StoreTransaction _value;
  // ignore: unused_field
  final $Res Function(StoreTransaction) _then;

  @override
  $Res call({
    Object? revenueCatIdentifier = freezed,
    Object? productIdentifier = freezed,
    Object? purchaseDate = freezed,
  }) {
    return _then(_value.copyWith(
      revenueCatIdentifier: revenueCatIdentifier == freezed
          ? _value.revenueCatIdentifier
          : revenueCatIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      productIdentifier: productIdentifier == freezed
          ? _value.productIdentifier
          : productIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseDate: purchaseDate == freezed
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_StoreTransactionCopyWith<$Res>
    implements $StoreTransactionCopyWith<$Res> {
  factory _$$_StoreTransactionCopyWith(
          _$_StoreTransaction value, $Res Function(_$_StoreTransaction) then) =
      __$$_StoreTransactionCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'revenueCatId') String revenueCatIdentifier,
      @JsonKey(name: 'productId') String productIdentifier,
      @JsonKey(name: 'purchaseDate') String purchaseDate});
}

/// @nodoc
class __$$_StoreTransactionCopyWithImpl<$Res>
    extends _$StoreTransactionCopyWithImpl<$Res>
    implements _$$_StoreTransactionCopyWith<$Res> {
  __$$_StoreTransactionCopyWithImpl(
      _$_StoreTransaction _value, $Res Function(_$_StoreTransaction) _then)
      : super(_value, (v) => _then(v as _$_StoreTransaction));

  @override
  _$_StoreTransaction get _value => super._value as _$_StoreTransaction;

  @override
  $Res call({
    Object? revenueCatIdentifier = freezed,
    Object? productIdentifier = freezed,
    Object? purchaseDate = freezed,
  }) {
    return _then(_$_StoreTransaction(
      revenueCatIdentifier == freezed
          ? _value.revenueCatIdentifier
          : revenueCatIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      productIdentifier == freezed
          ? _value.productIdentifier
          : productIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseDate == freezed
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
      @JsonKey(name: 'revenueCatId') this.revenueCatIdentifier,
      @JsonKey(name: 'productId') this.productIdentifier,
      @JsonKey(name: 'purchaseDate') this.purchaseDate);

  factory _$_StoreTransaction.fromJson(Map<String, dynamic> json) =>
      _$$_StoreTransactionFromJson(json);

  /// RevenueCat Id associated to the transaction.
  @override
  @JsonKey(name: 'revenueCatId')
  final String revenueCatIdentifier;

  /// Product Id associated with the transaction.
  @override
  @JsonKey(name: 'productId')
  final String productIdentifier;

  /// Purchase date of the transaction in ISO 8601 format.
  @override
  @JsonKey(name: 'purchaseDate')
  final String purchaseDate;

  @override
  String toString() {
    return 'StoreTransaction(revenueCatIdentifier: $revenueCatIdentifier, productIdentifier: $productIdentifier, purchaseDate: $purchaseDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StoreTransaction &&
            const DeepCollectionEquality()
                .equals(other.revenueCatIdentifier, revenueCatIdentifier) &&
            const DeepCollectionEquality()
                .equals(other.productIdentifier, productIdentifier) &&
            const DeepCollectionEquality()
                .equals(other.purchaseDate, purchaseDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(revenueCatIdentifier),
      const DeepCollectionEquality().hash(productIdentifier),
      const DeepCollectionEquality().hash(purchaseDate));

  @JsonKey(ignore: true)
  @override
  _$$_StoreTransactionCopyWith<_$_StoreTransaction> get copyWith =>
      __$$_StoreTransactionCopyWithImpl<_$_StoreTransaction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StoreTransactionToJson(this);
  }
}

abstract class _StoreTransaction implements StoreTransaction {
  const factory _StoreTransaction(
          @JsonKey(name: 'revenueCatId') final String revenueCatIdentifier,
          @JsonKey(name: 'productId') final String productIdentifier,
          @JsonKey(name: 'purchaseDate') final String purchaseDate) =
      _$_StoreTransaction;

  factory _StoreTransaction.fromJson(Map<String, dynamic> json) =
      _$_StoreTransaction.fromJson;

  @override

  /// RevenueCat Id associated to the transaction.
  @JsonKey(name: 'revenueCatId')
  String get revenueCatIdentifier => throw _privateConstructorUsedError;
  @override

  /// Product Id associated with the transaction.
  @JsonKey(name: 'productId')
  String get productIdentifier => throw _privateConstructorUsedError;
  @override

  /// Purchase date of the transaction in ISO 8601 format.
  @JsonKey(name: 'purchaseDate')
  String get purchaseDate => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_StoreTransactionCopyWith<_$_StoreTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}
