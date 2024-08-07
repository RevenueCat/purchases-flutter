// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'installments_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InstallmentsInfo _$InstallmentsInfoFromJson(Map<String, dynamic> json) {
  return _InstallmentsInfo.fromJson(json);
}

/// @nodoc
mixin _$InstallmentsInfo {
  /// Number of payments the customer commits to in order to purchase
  /// the subscription.
  int get commitmentPaymentsCount => throw _privateConstructorUsedError;

  /// After the commitment payments are complete, the number of payments
  /// the user commits to upon a renewal.
  int get renewalCommitmentPaymentsCount => throw _privateConstructorUsedError;

  /// Serializes this InstallmentsInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InstallmentsInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InstallmentsInfoCopyWith<InstallmentsInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InstallmentsInfoCopyWith<$Res> {
  factory $InstallmentsInfoCopyWith(
          InstallmentsInfo value, $Res Function(InstallmentsInfo) then) =
      _$InstallmentsInfoCopyWithImpl<$Res, InstallmentsInfo>;
  @useResult
  $Res call({int commitmentPaymentsCount, int renewalCommitmentPaymentsCount});
}

/// @nodoc
class _$InstallmentsInfoCopyWithImpl<$Res, $Val extends InstallmentsInfo>
    implements $InstallmentsInfoCopyWith<$Res> {
  _$InstallmentsInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InstallmentsInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? commitmentPaymentsCount = null,
    Object? renewalCommitmentPaymentsCount = null,
  }) {
    return _then(_value.copyWith(
      commitmentPaymentsCount: null == commitmentPaymentsCount
          ? _value.commitmentPaymentsCount
          : commitmentPaymentsCount // ignore: cast_nullable_to_non_nullable
              as int,
      renewalCommitmentPaymentsCount: null == renewalCommitmentPaymentsCount
          ? _value.renewalCommitmentPaymentsCount
          : renewalCommitmentPaymentsCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InstallmentsInfoImplCopyWith<$Res>
    implements $InstallmentsInfoCopyWith<$Res> {
  factory _$$InstallmentsInfoImplCopyWith(_$InstallmentsInfoImpl value,
          $Res Function(_$InstallmentsInfoImpl) then) =
      __$$InstallmentsInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int commitmentPaymentsCount, int renewalCommitmentPaymentsCount});
}

/// @nodoc
class __$$InstallmentsInfoImplCopyWithImpl<$Res>
    extends _$InstallmentsInfoCopyWithImpl<$Res, _$InstallmentsInfoImpl>
    implements _$$InstallmentsInfoImplCopyWith<$Res> {
  __$$InstallmentsInfoImplCopyWithImpl(_$InstallmentsInfoImpl _value,
      $Res Function(_$InstallmentsInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of InstallmentsInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? commitmentPaymentsCount = null,
    Object? renewalCommitmentPaymentsCount = null,
  }) {
    return _then(_$InstallmentsInfoImpl(
      null == commitmentPaymentsCount
          ? _value.commitmentPaymentsCount
          : commitmentPaymentsCount // ignore: cast_nullable_to_non_nullable
              as int,
      null == renewalCommitmentPaymentsCount
          ? _value.renewalCommitmentPaymentsCount
          : renewalCommitmentPaymentsCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InstallmentsInfoImpl implements _InstallmentsInfo {
  const _$InstallmentsInfoImpl(
      this.commitmentPaymentsCount, this.renewalCommitmentPaymentsCount);

  factory _$InstallmentsInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$InstallmentsInfoImplFromJson(json);

  /// Number of payments the customer commits to in order to purchase
  /// the subscription.
  @override
  final int commitmentPaymentsCount;

  /// After the commitment payments are complete, the number of payments
  /// the user commits to upon a renewal.
  @override
  final int renewalCommitmentPaymentsCount;

  @override
  String toString() {
    return 'InstallmentsInfo(commitmentPaymentsCount: $commitmentPaymentsCount, renewalCommitmentPaymentsCount: $renewalCommitmentPaymentsCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InstallmentsInfoImpl &&
            (identical(
                    other.commitmentPaymentsCount, commitmentPaymentsCount) ||
                other.commitmentPaymentsCount == commitmentPaymentsCount) &&
            (identical(other.renewalCommitmentPaymentsCount,
                    renewalCommitmentPaymentsCount) ||
                other.renewalCommitmentPaymentsCount ==
                    renewalCommitmentPaymentsCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, commitmentPaymentsCount, renewalCommitmentPaymentsCount);

  /// Create a copy of InstallmentsInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InstallmentsInfoImplCopyWith<_$InstallmentsInfoImpl> get copyWith =>
      __$$InstallmentsInfoImplCopyWithImpl<_$InstallmentsInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InstallmentsInfoImplToJson(
      this,
    );
  }
}

abstract class _InstallmentsInfo implements InstallmentsInfo {
  const factory _InstallmentsInfo(final int commitmentPaymentsCount,
      final int renewalCommitmentPaymentsCount) = _$InstallmentsInfoImpl;

  factory _InstallmentsInfo.fromJson(Map<String, dynamic> json) =
      _$InstallmentsInfoImpl.fromJson;

  /// Number of payments the customer commits to in order to purchase
  /// the subscription.
  @override
  int get commitmentPaymentsCount;

  /// After the commitment payments are complete, the number of payments
  /// the user commits to upon a renewal.
  @override
  int get renewalCommitmentPaymentsCount;

  /// Create a copy of InstallmentsInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InstallmentsInfoImplCopyWith<_$InstallmentsInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
