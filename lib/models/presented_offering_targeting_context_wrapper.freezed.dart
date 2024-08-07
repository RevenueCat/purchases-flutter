// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'presented_offering_targeting_context_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PresentedOfferingTargetingContext _$PresentedOfferingTargetingContextFromJson(
    Map<String, dynamic> json) {
  return _PresentedOfferingTargetingContext.fromJson(json);
}

/// @nodoc
mixin _$PresentedOfferingTargetingContext {
  /// The revision of the targeting used to obtain this object
  int get revision => throw _privateConstructorUsedError;

  /// The rule id from the targeting used to obtain this object
  String get ruleId => throw _privateConstructorUsedError;

  /// Serializes this PresentedOfferingTargetingContext to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PresentedOfferingTargetingContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PresentedOfferingTargetingContextCopyWith<PresentedOfferingTargetingContext>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PresentedOfferingTargetingContextCopyWith<$Res> {
  factory $PresentedOfferingTargetingContextCopyWith(
          PresentedOfferingTargetingContext value,
          $Res Function(PresentedOfferingTargetingContext) then) =
      _$PresentedOfferingTargetingContextCopyWithImpl<$Res,
          PresentedOfferingTargetingContext>;
  @useResult
  $Res call({int revision, String ruleId});
}

/// @nodoc
class _$PresentedOfferingTargetingContextCopyWithImpl<$Res,
        $Val extends PresentedOfferingTargetingContext>
    implements $PresentedOfferingTargetingContextCopyWith<$Res> {
  _$PresentedOfferingTargetingContextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PresentedOfferingTargetingContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? revision = null,
    Object? ruleId = null,
  }) {
    return _then(_value.copyWith(
      revision: null == revision
          ? _value.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as int,
      ruleId: null == ruleId
          ? _value.ruleId
          : ruleId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PresentedOfferingTargetingContextImplCopyWith<$Res>
    implements $PresentedOfferingTargetingContextCopyWith<$Res> {
  factory _$$PresentedOfferingTargetingContextImplCopyWith(
          _$PresentedOfferingTargetingContextImpl value,
          $Res Function(_$PresentedOfferingTargetingContextImpl) then) =
      __$$PresentedOfferingTargetingContextImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int revision, String ruleId});
}

/// @nodoc
class __$$PresentedOfferingTargetingContextImplCopyWithImpl<$Res>
    extends _$PresentedOfferingTargetingContextCopyWithImpl<$Res,
        _$PresentedOfferingTargetingContextImpl>
    implements _$$PresentedOfferingTargetingContextImplCopyWith<$Res> {
  __$$PresentedOfferingTargetingContextImplCopyWithImpl(
      _$PresentedOfferingTargetingContextImpl _value,
      $Res Function(_$PresentedOfferingTargetingContextImpl) _then)
      : super(_value, _then);

  /// Create a copy of PresentedOfferingTargetingContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? revision = null,
    Object? ruleId = null,
  }) {
    return _then(_$PresentedOfferingTargetingContextImpl(
      null == revision
          ? _value.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as int,
      null == ruleId
          ? _value.ruleId
          : ruleId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PresentedOfferingTargetingContextImpl
    implements _PresentedOfferingTargetingContext {
  const _$PresentedOfferingTargetingContextImpl(this.revision, this.ruleId);

  factory _$PresentedOfferingTargetingContextImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$PresentedOfferingTargetingContextImplFromJson(json);

  /// The revision of the targeting used to obtain this object
  @override
  final int revision;

  /// The rule id from the targeting used to obtain this object
  @override
  final String ruleId;

  @override
  String toString() {
    return 'PresentedOfferingTargetingContext(revision: $revision, ruleId: $ruleId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PresentedOfferingTargetingContextImpl &&
            (identical(other.revision, revision) ||
                other.revision == revision) &&
            (identical(other.ruleId, ruleId) || other.ruleId == ruleId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, revision, ruleId);

  /// Create a copy of PresentedOfferingTargetingContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PresentedOfferingTargetingContextImplCopyWith<
          _$PresentedOfferingTargetingContextImpl>
      get copyWith => __$$PresentedOfferingTargetingContextImplCopyWithImpl<
          _$PresentedOfferingTargetingContextImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PresentedOfferingTargetingContextImplToJson(
      this,
    );
  }
}

abstract class _PresentedOfferingTargetingContext
    implements PresentedOfferingTargetingContext {
  const factory _PresentedOfferingTargetingContext(
          final int revision, final String ruleId) =
      _$PresentedOfferingTargetingContextImpl;

  factory _PresentedOfferingTargetingContext.fromJson(
          Map<String, dynamic> json) =
      _$PresentedOfferingTargetingContextImpl.fromJson;

  /// The revision of the targeting used to obtain this object
  @override
  int get revision;

  /// The rule id from the targeting used to obtain this object
  @override
  String get ruleId;

  /// Create a copy of PresentedOfferingTargetingContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PresentedOfferingTargetingContextImplCopyWith<
          _$PresentedOfferingTargetingContextImpl>
      get copyWith => throw _privateConstructorUsedError;
}
