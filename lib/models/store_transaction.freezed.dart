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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StoreTransaction _$StoreTransactionFromJson(Map<String, dynamic> json) {
  return _StoreTransaction.fromJson(json);
}

/// @nodoc
class _$StoreTransactionTearOff {
  const _$StoreTransactionTearOff();

  _StoreTransaction call(
      @JsonKey(name: 'revenueCatIdentifier') String revenueCatIdentifier,
      @JsonKey(name: 'productIdentifier') String productIdentifier,
      @JsonKey(name: 'purchaseDate') String purchaseDate) {
    return _StoreTransaction(
      revenueCatIdentifier,
      productIdentifier,
      purchaseDate,
    );
  }

  StoreTransaction fromJson(Map<String, Object?> json) {
    return StoreTransaction.fromJson(json);
  }
}

/// @nodoc
const $StoreTransaction = _$StoreTransactionTearOff();

/// @nodoc
mixin _$StoreTransaction {
  /// RevenueCat Id associated to the transaction.
  @JsonKey(name: 'revenueCatIdentifier')
  String get revenueCatIdentifier => throw _privateConstructorUsedError;

  /// Product Id associated with the transaction.
  @JsonKey(name: 'productIdentifier')
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
      {@JsonKey(name: 'revenueCatIdentifier') String revenueCatIdentifier,
      @JsonKey(name: 'productIdentifier') String productIdentifier,
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
abstract class _$StoreTransactionCopyWith<$Res>
    implements $StoreTransactionCopyWith<$Res> {
  factory _$StoreTransactionCopyWith(
          _StoreTransaction value, $Res Function(_StoreTransaction) then) =
      __$StoreTransactionCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'revenueCatIdentifier') String revenueCatIdentifier,
      @JsonKey(name: 'productIdentifier') String productIdentifier,
      @JsonKey(name: 'purchaseDate') String purchaseDate});
}

/// @nodoc
class __$StoreTransactionCopyWithImpl<$Res>
    extends _$StoreTransactionCopyWithImpl<$Res>
    implements _$StoreTransactionCopyWith<$Res> {
  __$StoreTransactionCopyWithImpl(
      _StoreTransaction _value, $Res Function(_StoreTransaction) _then)
      : super(_value, (v) => _then(v as _StoreTransaction));

  @override
  _StoreTransaction get _value => super._value as _StoreTransaction;

  @override
  $Res call({
    Object? revenueCatIdentifier = freezed,
    Object? productIdentifier = freezed,
    Object? purchaseDate = freezed,
  }) {
    return _then(_StoreTransaction(
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
      @JsonKey(name: 'revenueCatIdentifier') this.revenueCatIdentifier,
      @JsonKey(name: 'productIdentifier') this.productIdentifier,
      @JsonKey(name: 'purchaseDate') this.purchaseDate);

  factory _$_StoreTransaction.fromJson(Map<String, dynamic> json) =>
      _$$_StoreTransactionFromJson(json);

  @override

  /// RevenueCat Id associated to the transaction.
  @JsonKey(name: 'revenueCatIdentifier')
  final String revenueCatIdentifier;
  @override

  /// Product Id associated with the transaction.
  @JsonKey(name: 'productIdentifier')
  final String productIdentifier;
  @override

  /// Purchase date of the transaction in ISO 8601 format.
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
            other is _StoreTransaction &&
            const DeepCollectionEquality()
                .equals(other.revenueCatIdentifier, revenueCatIdentifier) &&
            const DeepCollectionEquality()
                .equals(other.productIdentifier, productIdentifier) &&
            const DeepCollectionEquality()
                .equals(other.purchaseDate, purchaseDate));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(revenueCatIdentifier),
      const DeepCollectionEquality().hash(productIdentifier),
      const DeepCollectionEquality().hash(purchaseDate));

  @JsonKey(ignore: true)
  @override
  _$StoreTransactionCopyWith<_StoreTransaction> get copyWith =>
      __$StoreTransactionCopyWithImpl<_StoreTransaction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StoreTransactionToJson(this);
  }
}

abstract class _StoreTransaction implements StoreTransaction {
  const factory _StoreTransaction(
      @JsonKey(name: 'revenueCatIdentifier') String revenueCatIdentifier,
      @JsonKey(name: 'productIdentifier') String productIdentifier,
      @JsonKey(name: 'purchaseDate') String purchaseDate) = _$_StoreTransaction;

  factory _StoreTransaction.fromJson(Map<String, dynamic> json) =
      _$_StoreTransaction.fromJson;

  @override

  /// RevenueCat Id associated to the transaction.
  @JsonKey(name: 'revenueCatIdentifier')
  String get revenueCatIdentifier;
  @override

  /// Product Id associated with the transaction.
  @JsonKey(name: 'productIdentifier')
  String get productIdentifier;
  @override

  /// Purchase date of the transaction in ISO 8601 format.
  @JsonKey(name: 'purchaseDate')
  String get purchaseDate;
  @override
  @JsonKey(ignore: true)
  _$StoreTransactionCopyWith<_StoreTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}
