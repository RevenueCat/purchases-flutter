// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'installments_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InstallmentsInfo {
  /// Number of payments the customer commits to in order to purchase
  /// the subscription.
  int get commitmentPaymentsCount;

  /// After the commitment payments are complete, the number of payments
  /// the user commits to upon a renewal.
  int get renewalCommitmentPaymentsCount;

  /// Create a copy of InstallmentsInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InstallmentsInfoCopyWith<InstallmentsInfo> get copyWith =>
      _$InstallmentsInfoCopyWithImpl<InstallmentsInfo>(
          this as InstallmentsInfo, _$identity);

  /// Serializes this InstallmentsInfo to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InstallmentsInfo &&
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

  @override
  String toString() {
    return 'InstallmentsInfo(commitmentPaymentsCount: $commitmentPaymentsCount, renewalCommitmentPaymentsCount: $renewalCommitmentPaymentsCount)';
  }
}

/// @nodoc
abstract mixin class $InstallmentsInfoCopyWith<$Res> {
  factory $InstallmentsInfoCopyWith(
          InstallmentsInfo value, $Res Function(InstallmentsInfo) _then) =
      _$InstallmentsInfoCopyWithImpl;
  @useResult
  $Res call({int commitmentPaymentsCount, int renewalCommitmentPaymentsCount});
}

/// @nodoc
class _$InstallmentsInfoCopyWithImpl<$Res>
    implements $InstallmentsInfoCopyWith<$Res> {
  _$InstallmentsInfoCopyWithImpl(this._self, this._then);

  final InstallmentsInfo _self;
  final $Res Function(InstallmentsInfo) _then;

  /// Create a copy of InstallmentsInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? commitmentPaymentsCount = null,
    Object? renewalCommitmentPaymentsCount = null,
  }) {
    return _then(_self.copyWith(
      commitmentPaymentsCount: null == commitmentPaymentsCount
          ? _self.commitmentPaymentsCount
          : commitmentPaymentsCount // ignore: cast_nullable_to_non_nullable
              as int,
      renewalCommitmentPaymentsCount: null == renewalCommitmentPaymentsCount
          ? _self.renewalCommitmentPaymentsCount
          : renewalCommitmentPaymentsCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _InstallmentsInfo implements InstallmentsInfo {
  const _InstallmentsInfo(
      this.commitmentPaymentsCount, this.renewalCommitmentPaymentsCount);
  factory _InstallmentsInfo.fromJson(Map<String, dynamic> json) =>
      _$InstallmentsInfoFromJson(json);

  /// Number of payments the customer commits to in order to purchase
  /// the subscription.
  @override
  final int commitmentPaymentsCount;

  /// After the commitment payments are complete, the number of payments
  /// the user commits to upon a renewal.
  @override
  final int renewalCommitmentPaymentsCount;

  /// Create a copy of InstallmentsInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$InstallmentsInfoCopyWith<_InstallmentsInfo> get copyWith =>
      __$InstallmentsInfoCopyWithImpl<_InstallmentsInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$InstallmentsInfoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _InstallmentsInfo &&
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

  @override
  String toString() {
    return 'InstallmentsInfo(commitmentPaymentsCount: $commitmentPaymentsCount, renewalCommitmentPaymentsCount: $renewalCommitmentPaymentsCount)';
  }
}

/// @nodoc
abstract mixin class _$InstallmentsInfoCopyWith<$Res>
    implements $InstallmentsInfoCopyWith<$Res> {
  factory _$InstallmentsInfoCopyWith(
          _InstallmentsInfo value, $Res Function(_InstallmentsInfo) _then) =
      __$InstallmentsInfoCopyWithImpl;
  @override
  @useResult
  $Res call({int commitmentPaymentsCount, int renewalCommitmentPaymentsCount});
}

/// @nodoc
class __$InstallmentsInfoCopyWithImpl<$Res>
    implements _$InstallmentsInfoCopyWith<$Res> {
  __$InstallmentsInfoCopyWithImpl(this._self, this._then);

  final _InstallmentsInfo _self;
  final $Res Function(_InstallmentsInfo) _then;

  /// Create a copy of InstallmentsInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? commitmentPaymentsCount = null,
    Object? renewalCommitmentPaymentsCount = null,
  }) {
    return _then(_InstallmentsInfo(
      null == commitmentPaymentsCount
          ? _self.commitmentPaymentsCount
          : commitmentPaymentsCount // ignore: cast_nullable_to_non_nullable
              as int,
      null == renewalCommitmentPaymentsCount
          ? _self.renewalCommitmentPaymentsCount
          : renewalCommitmentPaymentsCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
