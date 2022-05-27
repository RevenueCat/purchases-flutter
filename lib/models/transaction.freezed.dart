// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return _Transaction.fromJson(json);
}

/// @nodoc
mixin _$Transaction {
  /// RevenueCat Id associated to the transaction.
  @JsonKey(name: 'revenueCatId')
  String get revenueCatId => throw _privateConstructorUsedError;

  /// Product Id associated with the transaction.
  @JsonKey(name: 'productId')
  String get productId => throw _privateConstructorUsedError;

  /// Purchase date of the transaction in ISO 8601 format.
  @JsonKey(name: 'purchaseDate')
  String get purchaseDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionCopyWith<Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionCopyWith<$Res> {
  factory $TransactionCopyWith(
          Transaction value, $Res Function(Transaction) then) =
      _$TransactionCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'revenueCatId') String revenueCatId,
      @JsonKey(name: 'productId') String productId,
      @JsonKey(name: 'purchaseDate') String purchaseDate});
}

/// @nodoc
class _$TransactionCopyWithImpl<$Res> implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._value, this._then);

  final Transaction _value;
  // ignore: unused_field
  final $Res Function(Transaction) _then;

  @override
  $Res call({
    Object? revenueCatId = freezed,
    Object? productId = freezed,
    Object? purchaseDate = freezed,
  }) {
    return _then(_value.copyWith(
      revenueCatId: revenueCatId == freezed
          ? _value.revenueCatId
          : revenueCatId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: productId == freezed
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseDate: purchaseDate == freezed
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_TransactionCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory _$$_TransactionCopyWith(
          _$_Transaction value, $Res Function(_$_Transaction) then) =
      __$$_TransactionCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'revenueCatId') String revenueCatId,
      @JsonKey(name: 'productId') String productId,
      @JsonKey(name: 'purchaseDate') String purchaseDate});
}

/// @nodoc
class __$$_TransactionCopyWithImpl<$Res> extends _$TransactionCopyWithImpl<$Res>
    implements _$$_TransactionCopyWith<$Res> {
  __$$_TransactionCopyWithImpl(
      _$_Transaction _value, $Res Function(_$_Transaction) _then)
      : super(_value, (v) => _then(v as _$_Transaction));

  @override
  _$_Transaction get _value => super._value as _$_Transaction;

  @override
  $Res call({
    Object? revenueCatId = freezed,
    Object? productId = freezed,
    Object? purchaseDate = freezed,
  }) {
    return _then(_$_Transaction(
      revenueCatId == freezed
          ? _value.revenueCatId
          : revenueCatId // ignore: cast_nullable_to_non_nullable
              as String,
      productId == freezed
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
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
class _$_Transaction implements _Transaction {
  const _$_Transaction(
      @JsonKey(name: 'revenueCatId') this.revenueCatId,
      @JsonKey(name: 'productId') this.productId,
      @JsonKey(name: 'purchaseDate') this.purchaseDate);

  factory _$_Transaction.fromJson(Map<String, dynamic> json) =>
      _$$_TransactionFromJson(json);

  /// RevenueCat Id associated to the transaction.
  @override
  @JsonKey(name: 'revenueCatId')
  final String revenueCatId;

  /// Product Id associated with the transaction.
  @override
  @JsonKey(name: 'productId')
  final String productId;

  /// Purchase date of the transaction in ISO 8601 format.
  @override
  @JsonKey(name: 'purchaseDate')
  final String purchaseDate;

  @override
  String toString() {
    return 'Transaction(revenueCatId: $revenueCatId, productId: $productId, purchaseDate: $purchaseDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Transaction &&
            const DeepCollectionEquality()
                .equals(other.revenueCatId, revenueCatId) &&
            const DeepCollectionEquality().equals(other.productId, productId) &&
            const DeepCollectionEquality()
                .equals(other.purchaseDate, purchaseDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(revenueCatId),
      const DeepCollectionEquality().hash(productId),
      const DeepCollectionEquality().hash(purchaseDate));

  @JsonKey(ignore: true)
  @override
  _$$_TransactionCopyWith<_$_Transaction> get copyWith =>
      __$$_TransactionCopyWithImpl<_$_Transaction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TransactionToJson(this);
  }
}

abstract class _Transaction implements Transaction {
  const factory _Transaction(
          @JsonKey(name: 'revenueCatId') final String revenueCatId,
          @JsonKey(name: 'productId') final String productId,
          @JsonKey(name: 'purchaseDate') final String purchaseDate) =
      _$_Transaction;

  factory _Transaction.fromJson(Map<String, dynamic> json) =
      _$_Transaction.fromJson;

  @override

  /// RevenueCat Id associated to the transaction.
  @JsonKey(name: 'revenueCatId')
  String get revenueCatId => throw _privateConstructorUsedError;
  @override

  /// Product Id associated with the transaction.
  @JsonKey(name: 'productId')
  String get productId => throw _privateConstructorUsedError;
  @override

  /// Purchase date of the transaction in ISO 8601 format.
  @JsonKey(name: 'purchaseDate')
  String get purchaseDate => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_TransactionCopyWith<_$_Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}
