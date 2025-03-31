// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'virtual_currency_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VirtualCurrencyInfo _$VirtualCurrencyInfoFromJson(Map<String, dynamic> json) {
  return _VirtualCurrencyInfo.fromJson(json);
}

/// @nodoc
mixin _$VirtualCurrencyInfo {
  /// The user's balance of the virtual currency.
  int get balance => throw _privateConstructorUsedError;

  /// Serializes this VirtualCurrencyInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VirtualCurrencyInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VirtualCurrencyInfoCopyWith<VirtualCurrencyInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VirtualCurrencyInfoCopyWith<$Res> {
  factory $VirtualCurrencyInfoCopyWith(
          VirtualCurrencyInfo value, $Res Function(VirtualCurrencyInfo) then) =
      _$VirtualCurrencyInfoCopyWithImpl<$Res, VirtualCurrencyInfo>;
  @useResult
  $Res call({int balance});
}

/// @nodoc
class _$VirtualCurrencyInfoCopyWithImpl<$Res, $Val extends VirtualCurrencyInfo>
    implements $VirtualCurrencyInfoCopyWith<$Res> {
  _$VirtualCurrencyInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VirtualCurrencyInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? balance = null,
  }) {
    return _then(_value.copyWith(
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VirtualCurrencyInfoImplCopyWith<$Res>
    implements $VirtualCurrencyInfoCopyWith<$Res> {
  factory _$$VirtualCurrencyInfoImplCopyWith(_$VirtualCurrencyInfoImpl value,
          $Res Function(_$VirtualCurrencyInfoImpl) then) =
      __$$VirtualCurrencyInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int balance});
}

/// @nodoc
class __$$VirtualCurrencyInfoImplCopyWithImpl<$Res>
    extends _$VirtualCurrencyInfoCopyWithImpl<$Res, _$VirtualCurrencyInfoImpl>
    implements _$$VirtualCurrencyInfoImplCopyWith<$Res> {
  __$$VirtualCurrencyInfoImplCopyWithImpl(_$VirtualCurrencyInfoImpl _value,
      $Res Function(_$VirtualCurrencyInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of VirtualCurrencyInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? balance = null,
  }) {
    return _then(_$VirtualCurrencyInfoImpl(
      null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VirtualCurrencyInfoImpl implements _VirtualCurrencyInfo {
  const _$VirtualCurrencyInfoImpl(this.balance);

  factory _$VirtualCurrencyInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$VirtualCurrencyInfoImplFromJson(json);

  /// The user's balance of the virtual currency.
  @override
  final int balance;

  @override
  String toString() {
    return 'VirtualCurrencyInfo(balance: $balance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VirtualCurrencyInfoImpl &&
            (identical(other.balance, balance) || other.balance == balance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, balance);

  /// Create a copy of VirtualCurrencyInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VirtualCurrencyInfoImplCopyWith<_$VirtualCurrencyInfoImpl> get copyWith =>
      __$$VirtualCurrencyInfoImplCopyWithImpl<_$VirtualCurrencyInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VirtualCurrencyInfoImplToJson(
      this,
    );
  }
}

abstract class _VirtualCurrencyInfo implements VirtualCurrencyInfo {
  const factory _VirtualCurrencyInfo(final int balance) =
      _$VirtualCurrencyInfoImpl;

  factory _VirtualCurrencyInfo.fromJson(Map<String, dynamic> json) =
      _$VirtualCurrencyInfoImpl.fromJson;

  /// The user's balance of the virtual currency.
  @override
  int get balance;

  /// Create a copy of VirtualCurrencyInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VirtualCurrencyInfoImplCopyWith<_$VirtualCurrencyInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
